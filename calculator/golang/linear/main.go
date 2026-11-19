package main

import (
  "bufio"
  "errors"
  "fmt"
  "os"
  "strconv"
  "strings"
)

////////////////////////////////////////////////////////////
// Verbose

var verboseParsingErrors = false


////////////////////////////////////////////////////////////
// Debug

var debug = false

func Dprintf(format string, a ...any) (n int, err error) {
  if !debug {
    return 0, nil
  }

  return fmt.Printf(format, a...)
}

////////////////////////////////////////////////////////////
// Input reading

func readInput() []string {
  scanner := bufio.NewScanner(os.Stdin)

  scanner.Scan()
  n, _ := strconv.Atoi(scanner.Text())

  lines := make([]string, n)

  i := 0
  for scanner.Scan() {
    line := scanner.Text()
    lines[i] = line
    i++
  }

  return lines
}

////////////////////////////////////////////////////////////
// Tokenizing

const (
  TokenInt = iota
  TokenPlus
  TokenMinus
  TokenMult
  TokenDiv
  TokenLeftParen
  TokenRightParen
)

type Token struct {
  Type   int
  Value  string
}

func tokenize(expr string) ([]Token, error) {
  tokens := make([]Token, 0)

  runes := []rune(expr)

  for i := 0; i < len(runes); i++ {
    var token Token

    switch runes[i] {
    case '+':
      token.Type = TokenPlus
    case '-':
      token.Type = TokenMinus
    case '*':
      token.Type = TokenMult
    case '/':
      token.Type = TokenDiv
    case '(':
      token.Type = TokenLeftParen
    case ')':
      token.Type = TokenRightParen
    case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
      var value strings.Builder

      IntTokenLoop: for ; i < len(runes); {
        switch runes[i] {
        case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
          value.WriteRune(runes[i])
          i++
        default:
          i--
          break IntTokenLoop
        }
      }

      token.Type = TokenInt
      token.Value = value.String()
    case ' ':
      continue

    default:
      return nil, errors.New(
        fmt.Sprintf(
          "tokenize: Unexpected character found: %s --> %c <--",
          prettyTokens(tokens),
          runes[i]))
    }

    tokens = append(tokens, token)
  }

  return tokens, nil
}


////////////////////////////////////////////////////////////
// Pretty printing tokens

func prettyTokens(tokens []Token) string {
  var out strings.Builder

  for _, token := range tokens {
    switch token.Type {
    case TokenInt:
      out.WriteString(token.Value)
    case TokenPlus:
      out.WriteString("+")
    case TokenMinus:
      out.WriteString("-")
    case TokenMult:
      out.WriteString("*")
    case TokenDiv:
      out.WriteString("/")
    case TokenLeftParen:
      out.WriteString("(")
    case TokenRightParen:
      out.WriteString(")")
    }
    out.WriteString(" ")
  }

  return out.String()
}


////////////////////////////////////////////////////////////
// Construction of AST (parsing)

const (
  AstInt = iota
  AstPlus
  AstMinus
  AstMult
  AstDiv
  AstUnaryMinus
)

type Ast struct {
  Type       int
  IntValue   int
  Arg1       *Ast
  Arg2       *Ast
  TokenStart int
  TokenEnd   int
}

func makePartialAsts(tokens []Token, startIndex int) ([]Ast, int, error) {
  // Tokens to
  // 1. complete ASTs for operator arguments and
  // 2. partial ASTs for operators.

  if startIndex >= len(tokens) {
    return nil, 0, errors.New(
      fmt.Sprintf(
        "makePartialAsts: Expected a sub-expression but reached the end of the input: %s <HERE>",
        prettyTokens(tokens)))
  }

  var asts []Ast
  i := startIndex

  if tokens[i].Type == TokenMinus {
    ast := Ast {
      Type: AstUnaryMinus,
      TokenStart: i,
      TokenEnd: i + 1,
    }
    asts = append(asts, ast)

    i++
  }

  for ; i < len(tokens); i++ {
    switch tokens[i].Type {

    case TokenInt:
      intValue, _ := strconv.Atoi(tokens[i].Value)

      ast := Ast {
        Type: AstInt,
        IntValue: intValue,
        TokenStart: i,
        TokenEnd: i + 1,
      }

      asts = append(asts, ast)

    case TokenPlus, TokenMinus, TokenMult, TokenDiv:
      var tokenType int

      switch tokens[i].Type {
      case TokenPlus:
        tokenType = AstPlus
      case TokenMinus:
        tokenType = AstMinus
      case TokenMult:
        tokenType = AstMult
      case TokenDiv:
        tokenType = AstDiv
      }

      ast := Ast {
        Type: tokenType,
        TokenStart: i,
        TokenEnd: i + 1,
      }

      asts = append(asts, ast)

    case TokenLeftParen:

      if i > 0 {
        switch tokens[i - 1].Type {
        case TokenInt, TokenRightParen:
          astMult := Ast {
            Type: AstMult,
            TokenStart: i,
            TokenEnd: i + 1,
          }

          asts = append(asts, astMult)
        }
      }

      i++

      astSubExpr, endIndex, err := doParse(tokens, i)

      if err != nil {
        return nil, 0, err
      }

      i = endIndex

      if i >= len(tokens) {
        return nil, 0, errors.New(
          fmt.Sprintf(
            "makePartialAsts: Expected closing parenthesis at end of expression: %s <HERE>",
            prettyTokens(tokens)))
      }

      if tokens[i].Type != TokenRightParen {
        return nil, 0, errors.New(
          fmt.Sprintf(
            "makePartialAsts: Expected closing parenthesis: %s <HERE> %s",
            prettyTokens(tokens[:i]),
            prettyTokens(tokens[i:])))
      }

      asts = append(asts, astSubExpr)

    case TokenRightParen:
      return asts, i, nil
    }
  }



  return asts, i, nil
}

func makeUnaryMinusAst(asts []Ast) []Ast {
  if len(asts) < 2 {
    return asts
  }

  if asts[0].Type != AstUnaryMinus || asts[0].Arg1 != nil {
    return asts
  }

  var unaryMinusPass []Ast

  unaryMinusAst := Ast {
    Type: AstUnaryMinus,
    Arg1: &asts[1],
    TokenStart: asts[0].TokenStart,
    TokenEnd: asts[1].TokenEnd,
  }

  unaryMinusPass = append(unaryMinusPass, unaryMinusAst)

  for i := 2; i < len(asts); i++ {
    unaryMinusPass = append(unaryMinusPass, asts[i])
  }

  return unaryMinusPass
}

func makeMultDivAsts(asts []Ast, tokens []Token) ([]Ast, error) {
  var multDivPass []Ast

  for i := 0; i < len(asts); i++ {
    switch asts[i].Type {

    case AstMult, AstDiv:
      if asts[i].Arg1 != nil {
        multDivPass = append(multDivPass, asts[i])
        continue
      }

      if i == 0 {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected first argument for multiplication or division: %s <HERE> %s",
            prettyTokens(tokens[:asts[i].TokenStart]),
            prettyTokens(tokens[asts[i].TokenStart:])))
      }

      if i + 1 == len(asts) {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected second argument for multiplication or division: %s <HERE> %s",
            prettyTokens(tokens[:asts[i].TokenEnd]),
            prettyTokens(tokens[asts[i].TokenEnd:])))
      }

      if asts[i - 1].Type != AstInt && asts[i - 1].Arg1 == nil {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected well-formed expression as first parameter of multiplication or division: %s --> %s <-- %s",
            prettyTokens(tokens[:asts[i - 1].TokenStart]),
            prettyTokens(tokens[asts[i - 1].TokenStart:asts[i - 1].TokenEnd]),
            prettyTokens(tokens[asts[i - 1].TokenEnd:])))
      }

      if asts[i + 1].Type != AstInt && asts[i + 1].Arg1 == nil {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected well-formed expression as second parameter of multiplication or division: %s --> %s <-- %s",
            prettyTokens(tokens[:asts[i + 1].TokenStart]),
            prettyTokens(tokens[asts[i + 1].TokenStart:asts[i + 1].TokenEnd]),
            prettyTokens(tokens[asts[i + 1].TokenEnd:])))
      }

      multDivAst := asts[i]
      arg1 := multDivPass[len(multDivPass) - 1]
      arg2 := asts[i + 1]
      multDivAst.Arg1 = &arg1
      multDivAst.Arg2 = &arg2
      multDivAst.TokenStart = arg1.TokenStart
      multDivAst.TokenEnd = arg2.TokenEnd

      multDivPass[len(multDivPass) - 1] = multDivAst

      i++

    default:
      multDivPass = append(multDivPass, asts[i])
    }
  }

  return multDivPass, nil
}

func makeSumSubAsts(asts []Ast, tokens []Token) ([]Ast, error) {
  var sumSubPass []Ast

  for i := 0; i < len(asts); i++ {
    switch asts[i].Type {

    case AstPlus, AstMinus:
      if asts[i].Arg1 != nil {
        sumSubPass = append(sumSubPass, asts[i])
        continue
      }

      if i == 0 {
        return nil, errors.New(
          fmt.Sprintf(
            "makeSumSubAsts: Expected first argument for sum or subtraction: %s <HERE> %s",
            prettyTokens(tokens[:asts[i].TokenStart]),
            prettyTokens(tokens[asts[i].TokenStart:])))            
      }
      
      if i + 1 == len(asts) {
        return nil, errors.New(
          fmt.Sprintf(
            "makeSumSubAsts: Expected second argument for sum or subtraction: %s <HERE> %s",
            prettyTokens(tokens[:asts[i].TokenEnd]),
            prettyTokens(tokens[asts[i].TokenEnd:])))
      }

      if asts[i - 1].Type != AstInt && asts[i - 1].Arg1 == nil {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected well-formed expression as first parameter of multiplication or division: %s --> %s <-- %s",
            prettyTokens(tokens[:asts[i - 1].TokenStart]),
            prettyTokens(tokens[asts[i - 1].TokenStart:asts[i - 1].TokenEnd]),
            prettyTokens(tokens[asts[i - 1].TokenEnd:])))
      }

      if asts[i + 1].Type != AstInt && asts[i + 1].Arg1 == nil {
        return nil, errors.New(
          fmt.Sprintf(
            "makeMultDivAsts: Expected well-formed expression as second parameter of multiplication or division: %s --> %s <-- %s",
            prettyTokens(tokens[:asts[i + 1].TokenStart]),
            prettyTokens(tokens[asts[i + 1].TokenStart:asts[i + 1].TokenEnd]),
            prettyTokens(tokens[asts[i + 1].TokenEnd:])))
      }

      sumSubAst := asts[i]
      arg1 := sumSubPass[len(sumSubPass) - 1]
      arg2 := asts[i + 1]
      sumSubAst.Arg1 = &arg1
      sumSubAst.Arg2 = &arg2
      sumSubAst.TokenStart = arg1.TokenStart
      sumSubAst.TokenEnd = arg2.TokenEnd

      sumSubPass[len(sumSubPass) - 1] = sumSubAst

      i++

    default:
      sumSubPass = append(sumSubPass, asts[i])
    }
  }

  return sumSubPass, nil
}

func doParse(tokens []Token, startIndex int) (Ast, int, error) {
  partialAsts, endIndex, errPartial := makePartialAsts(tokens, startIndex)

  if errPartial != nil {
    return Ast{}, 0, errPartial
  }

  unaryMinusPass := makeUnaryMinusAst(partialAsts)
  multDivPass, errMult := makeMultDivAsts(unaryMinusPass, tokens)

  if errMult != nil {
    return Ast{}, 0, errMult
  }

  sumSubPass, errSum := makeSumSubAsts(multDivPass, tokens)

  if errSum != nil {
    return Ast{}, 0, errSum
  }

  if len(sumSubPass) != 1 {
    return Ast{}, 0, errors.New(
      fmt.Sprintf(
        "doParse: Expected exactly one AST for tokens: %s --> %s <-- %s",
        prettyTokens(tokens[:startIndex]),
        prettyTokens(tokens[startIndex:endIndex]),
        prettyTokens(tokens[endIndex:])))
  }

  ast := sumSubPass[0]

  return ast, endIndex, nil
}

func parse(tokens []Token) (Ast, error) {
  ast, tokenCount, err := doParse(tokens, 0)

  if err != nil {
    return Ast{}, err
  }

  if tokenCount < len(tokens) {
    return Ast{}, errors.New(
      fmt.Sprintf(
        "parse: Tokens left unparsed: %s --> %s\n",
        prettyTokens(tokens[:tokenCount]),
        prettyTokens(tokens[tokenCount:])))
  }

  return ast, nil
}


////////////////////////////////////////////////////////////
// Pretty printing AST

func doPrettyAst(ast Ast, out *strings.Builder) {
  switch ast.Type {
  case AstInt:
    out.WriteString(strconv.Itoa(ast.IntValue))
  case AstPlus, AstMinus, AstMult, AstDiv:
    out.WriteString("(")
    doPrettyAst(*ast.Arg1, out)
    out.WriteString(") ")

    switch ast.Type {
    case AstPlus:
      out.WriteString("+")
    case AstMinus:
      out.WriteString("-")
    case AstMult:
      out.WriteString("*")
    case AstDiv:
      out.WriteString("/")
    }
    
    out.WriteString(" (")
    doPrettyAst(*ast.Arg2, out)
    out.WriteString(")")
  case AstUnaryMinus:
    out.WriteString("-(")
    doPrettyAst(*ast.Arg1, out)
    out.WriteString(")")
  }
}

func prettyAst(ast Ast) string {
  var out strings.Builder
  
  doPrettyAst(ast, &out)

  return out.String()
}


////////////////////////////////////////////////////////////
// Evaluation of AST

func evaluate(ast Ast) int {
  var value int

  switch ast.Type {
  case AstInt:
    value = ast.IntValue
  case AstUnaryMinus:
    value = - evaluate(*ast.Arg1)
  case AstPlus:
    value = evaluate(*ast.Arg1) + evaluate(*ast.Arg2)
  case AstMinus:
    value = evaluate(*ast.Arg1) - evaluate(*ast.Arg2)
  case AstMult:
    value = evaluate(*ast.Arg1) * evaluate(*ast.Arg2)
  case AstDiv:
    value = evaluate(*ast.Arg1) / evaluate(*ast.Arg2)
  }

  return value
}


////////////////////////////////////////////////////////////
// Parsing + evaluation workflow

func calculate(expr string) (int, error) {
  tokens, errTokens := tokenize(expr)

  if errTokens != nil {
    return 0, errTokens
  }

  Dprintf("tokens = %s\n", prettyTokens(tokens))

  ast, errAst := parse(tokens)

  if errAst != nil {
    return 0, errAst
  }

  Dprintf("ast = %s\n", prettyAst(ast))

  return evaluate(ast), nil
}

func main() {
  lines := readInput()

  for _, line := range lines {
    Dprintf("line = %s\n", line)

    value, err := calculate(line)

    if err != nil {
      if verboseParsingErrors {
        fmt.Println(err)
      } else {
        fmt.Println("parsing error")
      }
    } else {
      if debug {
        Dprintf("value = %d\n", value)
      } else {
        fmt.Printf("%d\n", value)
      }
    }
  }
}
