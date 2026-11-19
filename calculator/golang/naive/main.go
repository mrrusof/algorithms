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

func tokenize(expr string) []Token {
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
    default:
      continue
    }

    tokens = append(tokens, token)
  }

  return tokens
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
  Type     int
  IntValue int
  Arg1     *Ast
  Arg2     *Ast
}

func parensAreBalanced(tokens []Token) bool {
  nestingLevel := 0

  for _, token := range tokens {
    if token.Type == TokenLeftParen {
      nestingLevel++
    } else if token.Type == TokenRightParen {
      if nestingLevel == 0 {
        return false
      }
      nestingLevel--
    }
  }

  return nestingLevel == 0
}

func lastBinaryOp(tokens []Token, sumSub bool) (string, []Token, []Token, error)  {
  op := ""
  op_index := 0
  nestingLevel := 0

  for i, token := range tokens {
    if token.Type == TokenLeftParen {
      nestingLevel++
    } else if token.Type == TokenRightParen {
      if nestingLevel == 0 {
        return "", nil, nil, errors.New("lastBinaryOp: unbalanced parens")
      }
      nestingLevel--
    }

    if nestingLevel > 0 {
      continue
    }

    if sumSub {
      if token.Type == TokenPlus {
        op = "+"
        op_index = i
      } else if token.Type == TokenMinus {
        op = "-"
        op_index = i
      }
    } else {
      if token.Type == TokenMult {
        op = "*"
        op_index = i
      } else if token.Type == TokenDiv {
        op = "/"
        op_index = i
      }
    }
  }

  return op, tokens[:op_index], tokens[op_index+1:], nil
}

func lastMultByParens(tokens []Token) (bool, []Token, []Token) {
  var tokens1 []Token
  var tokens2 []Token

  if tokens[len(tokens)-1].Type != TokenRightParen {
    return false, nil, nil
  }

  nestingLevel := 1

  for i := len(tokens) - 2; i >= 0; i-- {
    if tokens[i].Type == TokenRightParen {
      nestingLevel++
    } else if tokens[i].Type == TokenLeftParen {
      nestingLevel--

      if nestingLevel == 0 {
        tokens1 = tokens[:i]
        tokens2 = tokens[i:]
        return true, tokens1, tokens2
      }
    }
  }

  return false, nil, nil
}

func doParse(tokens []Token, rejectUnaryMinus bool) (Ast, error) {
  var ast Ast

  if len(tokens) == 1 && tokens[0].Type == TokenInt {
    ast.Type = AstInt
    ast.IntValue, _ = strconv.Atoi(tokens[0].Value)

    return ast, nil

  } else if !rejectUnaryMinus &&
     len(tokens) == 2 &&
     tokens[0].Type == TokenMinus &&
     tokens[1].Type == TokenInt {

    intAst, err := doParse(tokens[1:], false)

    if err != nil {
      return Ast{}, err
    }

    ast.Type = AstUnaryMinus
    ast.Arg1 = &intAst

    return ast, nil

  } else if !rejectUnaryMinus &&
     tokens[0].Type == TokenMinus &&
     tokens[1].Type == TokenLeftParen &&
     tokens[len(tokens)-1].Type == TokenRightParen &&
     parensAreBalanced(tokens[2:len(tokens)-1]) {

    argAst, err := doParse(tokens[2:len(tokens)-1], false)

    if err != nil {
      return Ast{}, err
    }

    ast.Type = AstUnaryMinus
    ast.Arg1 = &argAst

    return ast, nil

  } else if tokens[0].Type == TokenLeftParen &&
     tokens[len(tokens)-1].Type == TokenRightParen &&
     parensAreBalanced(tokens[1:len(tokens)-1]) {

    return doParse(tokens[1:len(tokens)-1], false)

  } else {
    if op, tokens1, tokens2, err := lastBinaryOp(tokens, true); op != "" || err != nil {
      if err != nil {
        return Ast{}, err
      }

      if op == "+" {
        ast.Type = AstPlus
      } else {
        ast.Type = AstMinus
      }

      if len(tokens1) == 0 || len(tokens2) == 0 {
        return Ast{}, errors.New(fmt.Sprintf("doParse: Syntax error for tokens %s\n", prettyTokens(tokens)))
      }

      arg1Ast, err1 := doParse(tokens1, false)

      if err1 != nil {
        return Ast{}, err1
      }

      var arg2Ast Ast
      var err2 error

      if tokens2[0].Type == TokenLeftParen {
        arg2Ast, err2 = doParse(tokens2, false)
      } else {
        arg2Ast, err2 = doParse(tokens2, true)
      }

      if err2 != nil {
        return Ast{}, err2
      }

      ast.Arg1 = &arg1Ast
      ast.Arg2 = &arg2Ast

      return ast, nil
    }

    if op, tokens1, tokens2, err := lastBinaryOp(tokens, false); op != "" || err != nil {
      if err != nil {
        return Ast{}, err
      }

      if op == "*" {
        ast.Type = AstMult
      } else {
        ast.Type = AstDiv
      }

      if len(tokens1) == 0 || len(tokens2) == 0 {
        return Ast{}, errors.New(fmt.Sprintf("parse: Syntax error for tokens %s\n", prettyTokens(tokens)))
      }

      arg1Ast, err1 := doParse(tokens1, false)

      if err1 != nil {
        return Ast{}, err1
      }

      var arg2Ast Ast
      var err2 error

      if tokens2[0].Type == TokenLeftParen {
        arg2Ast, err2 = doParse(tokens2, false)
      } else {
        arg2Ast, err2 = doParse(tokens2, true)
      }

      if err2 != nil {
        return Ast{}, err2
      }

      ast.Arg1 = &arg1Ast
      ast.Arg2 = &arg2Ast

      return ast, nil
    }

    if found, tokens1, tokens2 := lastMultByParens(tokens); found {
      arg1Ast, err1 := doParse(tokens1, false)
      arg2Ast, err2 := doParse(tokens2, false)

      if err1 != nil {
        return Ast{}, err1
      }

      if err2 != nil {
        return Ast{}, err2
      }

      ast.Type = AstMult
      ast.Arg1 = &arg1Ast
      ast.Arg2 = &arg2Ast

      return ast, nil
    }
  }

  return ast, errors.New(fmt.Sprintf("parse: Could not parse tokens: %s", prettyTokens(tokens)))
}

func parse(tokens []Token) (Ast, error)  {
  return doParse(tokens, false)
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
  tokens := tokenize(expr)
  Dprintf("tokens = %s\n", prettyTokens(tokens))
  ast, err := parse(tokens)

  if err != nil {
    return 0, err
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
