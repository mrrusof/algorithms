Public Function IntToText(adjective As Boolean, n As Long) As String

  Dim Upto29ToText, Tens, Hundreds
  Upto29ToText = Array("", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez", "once", "doce", "trece", "catorce", "quince", "dieciséis", "diecisiete", "dieciocho", "diecinueve", "veinte", "veintiuno", "veintidós", "veintitrés", "veinticuatro", "veinticinco", "veintiséis", "veintisiete", "veintiocho", "veintinueve")
  Tens = Array("", "diez", "veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa")
  Hundreds = Array("", "ciento", "doscientos", "trescientos", "cuatrocientos", "quinientos", "seiscientos", "setecientos", "ochocientos", "novecientos")

  If n = 0 Then
    IntToText = "cero"
  ElseIf n = 1 And adjective Then
    IntToText = "un"
  ElseIf n < 30 Then
    IntToText = Upto29ToText(n)
  ElseIf n < 100 Then
    IntToText = _
      Tens(n \ 10) & _
      IIf(n Mod 10 > 0, " y " & IntToText(adjective, n Mod 10), "")
  ElseIf n = 100 Then
    IntToText = "cien"
  ElseIf n < 1000 Then
    IntToText = _
      Hundreds(n \ 100) _
      & IIf(n Mod 100 > 0, " " & IntToText(adjective, n Mod 100), "")
  ElseIf n < 1000000 Then
    IntToText = _
      IIf(n \ 1000 = 1, "mil", IntToText(True, n \ 1000) & " mil") _
      & IIf(n Mod 1000 > 0, " " & IntToText(adjective, n Mod 1000), "")
  ElseIf n < 1000000000 Then
    IntToText = _
      IIf(n \ 1000000 = 1, "un millón", _
          IntToText(True, n \ 1000000) & " millones") _
      & IIf(n Mod 1000000 > 0, " " & IntToText(adjective, n Mod 1000000), "")
  Else
    IntToText = "ERROR: intToText(" & adjective & ", " & n & ")"
  End If
End Function
