let concat = function
  | "", s2 -> s2
  | s1, "" -> s1
  | s1, s2 -> s1 ^ " " ^ s2
    
let units un = function
  | 0 -> ""
  | 1 -> if un then "un" else "uno"
  | 2 -> "dos"
  | 3 -> "tres"
  | 4 -> "cuatro"
  | 5 -> "cinco"
  | 6 -> "seis"
  | 7 -> "siete"
  | 8 -> "ocho"
  | 9 -> "nueve"
  | u -> Printf.sprintf "ERROR: units %d" u
    
let tens = function
  | 3 -> "treinta"
  | 4 -> "cuarenta"
  | 5 -> "cincuenta"
  | 6 -> "sesenta"
  | 7 -> "setenta"
  | 8 -> "ochenta"
  | 9 -> "noventa"
  | d -> Printf.sprintf "ERROR: tens %d" d

let hundreds = function
  | 0 -> ""
  | 1 -> "ciento"
  | 2 -> "doscientos"
  | 3 -> "trescientos"
  | 4 -> "cuatrocientos"
  | 5 -> "quinientos"
  | 6 -> "seiscientos"
  | 7 -> "setecientos"
  | 8 -> "ochocientos"
  | 9 -> "novecientos"
  | c -> Printf.sprintf "ERROR: hundreds %d" c

let upto29ToText un n =
  if n < 10 then units un n
  else match n with
    | 10 -> "diez"
    | 11 -> "once"
    | 12 -> "doce"
    | 13 -> "trece"
    | 14 -> "catorce"
    | 15 -> "quince"
    | 16 -> "dieciséis"
    | 17 -> "diecisiete"
    | 18 -> "dieciocho"
    | 19 -> "diecinueve"
    | 20 -> "veinte"
    | 21 -> "veintiuno"
    | 22 -> "veintidós"
    | 23 -> "veintitrés"
    | 24 -> "veinticuatro"
    | 25 -> "veinticinco"
    | 26 -> "veintiséis"
    | 27 -> "veintisiete"
    | 28 -> "veintiocho"
    | 29 -> "veintinueve"
    | _ -> Printf.sprintf "ERROR: upto29ToText %d" n

let upto99ToText un n =
  if n < 30 then upto29ToText un n
  else tens (n / 10) ^ if n mod 10 > 0 then " y " ^ units un (n mod 10) else ""
    
let upto999ToText un n =
  if n = 100 then "cien"
  else concat (hundreds (n / 100), upto99ToText un (n mod 100))

let upto999999ToText n =
  match upto999ToText true (n / 1000) with
    | "" -> upto999ToText false (n mod 1000)
    | "un" -> concat ("mil", upto999ToText false (n mod 1000))
    | t -> concat (t ^ " mil", upto999ToText false (n mod 1000))

let upto999999999ToText n =
  match upto999ToText true (n / 1000000) with
    | "" -> upto999999ToText (n mod 1000000)
    | "un" -> concat ("un millón", upto999999ToText (n mod 1000000))
    | t -> concat (t ^ " millones", upto999999ToText (n mod 1000000))
      
let intToText n =
  if n = 0 then "cero"
  else if n < 1000000000 then upto999999999ToText n
  else Printf.sprintf "ERROR: intToText %d" n

let tests = [(0, "cero");
             (1, "uno");
             (2, "dos");
             (3, "tres");
             (4, "cuatro");
             (5, "cinco");
             (6, "seis");
             (7, "siete");
             (8, "ocho");
             (9, "nueve");
             (10, "diez");
             (11, "once");
             (12, "doce");
             (13, "trece");
             (14, "catorce");
             (15, "quince");
             (16, "dieciséis");
             (17, "diecisiete");
             (18, "dieciocho");
             (19, "diecinueve");
             (20, "veinte");
             (21, "veintiuno");
             (22, "veintidós");
             (23, "veintitrés");
             (24, "veinticuatro");
             (25, "veinticinco");
             (26, "veintiséis");
             (27, "veintisiete");
             (28, "veintiocho");
             (29, "veintinueve");
             (30, "treinta");
             (31, "treinta y uno");
             (45, "cuarenta y cinco");
             (57, "cincuenta y siete");
             (62, "sesenta y dos");
             (78, "setenta y ocho");
             (89, "ochenta y nueve");
             (91, "noventa y uno");
             (100, "cien");
             (101, "ciento uno");
             (102, "ciento dos");
             (103, "ciento tres");
             (104, "ciento cuatro");
             (105, "ciento cinco");
             (106, "ciento seis");
             (107, "ciento siete");
             (108, "ciento ocho");
             (109, "ciento nueve");
             (110, "ciento diez");
             (111, "ciento once");
             (112, "ciento doce");
             (113, "ciento trece");
             (114, "ciento catorce");
             (115, "ciento quince");
             (116, "ciento dieciséis");
             (117, "ciento diecisiete");
             (118, "ciento dieciocho");
             (119, "ciento diecinueve");
             (120, "ciento veinte");
             (121, "ciento veintiuno");
             (122, "ciento veintidós");
             (123, "ciento veintitrés");
             (124, "ciento veinticuatro");
             (125, "ciento veinticinco");
             (126, "ciento veintiséis");
             (127, "ciento veintisiete");
             (128, "ciento veintiocho");
             (129, "ciento veintinueve");
             (130, "ciento treinta");
             (200, "doscientos");
             (300, "trescientos");
             (400, "cuatrocientos");
             (500, "quinientos");
             (600, "seiscientos");
             (700, "setecientos");
             (800, "ochocientos");
             (900, "novecientos");
             (1000, "mil");
             (1001, "mil uno");
             (1002, "mil dos");
             (1003, "mil tres");
             (1004, "mil cuatro");
             (1005, "mil cinco");
             (1006, "mil seis");
             (1007, "mil siete");
             (1008, "mil ocho");
             (1009, "mil nueve");
             (1010, "mil diez");
             (1011, "mil once");
             (1012, "mil doce");
             (1013, "mil trece");
             (1014, "mil catorce");
             (1015, "mil quince");
             (1016, "mil dieciséis");
             (1017, "mil diecisiete");
             (1018, "mil dieciocho");
             (1019, "mil diecinueve");
             (1020, "mil veinte");
             (1021, "mil veintiuno");
             (1022, "mil veintidós");
             (1023, "mil veintitrés");
             (1024, "mil veinticuatro");
             (1025, "mil veinticinco");
             (1026, "mil veintiséis");
             (1027, "mil veintisiete");
             (1028, "mil veintiocho");
             (1029, "mil veintinueve");
             (1030, "mil treinta");
             (2000, "dos mil");
             (3000, "tres mil");
             (4000, "cuatro mil");
             (5000, "cinco mil");
             (6000, "seis mil");
             (7000, "siete mil");
             (8000, "ocho mil");
             (9000, "nueve mil");
             (10000, "diez mil");
             (11000, "once mil");
             (12000, "doce mil");
             (13000, "trece mil");
             (14000, "catorce mil");
             (15000, "quince mil");
             (16000, "dieciséis mil");
             (17000, "diecisiete mil");
             (18000, "dieciocho mil");
             (19000, "diecinueve mil");
             (20000, "veinte mil");
             (21000, "veintiuno mil");
             (22000, "veintidós mil");
             (23000, "veintitrés mil");
             (24000, "veinticuatro mil");
             (25000, "veinticinco mil");
             (26000, "veintiséis mil");
             (27000, "veintisiete mil");
             (28000, "veintiocho mil");
             (29000, "veintinueve mil");
             (30000, "treinta mil");
             (31000, "treinta y un mil");
             (40000, "cuarenta mil");
             (41000, "cuarenta y un mil");
             (50000, "cincuenta mil");
             (52000, "cincuenta y dos mil");
             (100000, "cien mil");
             (1000000, "un millón");
             (2000000, "dos millones");
             (3000000, "tres millones");
             (4000000, "cuatro millones");
             (5000000, "cinco millones");
             (6000000, "seis millones");
             (7000000, "siete millones");
             (8000000, "ocho millones");
             (9000000, "nueve millones");
             (10000000, "diez millones");
             (11000000, "once millones");
             (12000000, "doce millones");
             (13000000, "trece millones");
             (14000000, "catorce millones");
             (15000000, "quince millones");
             (16000000, "dieciséis millones");
             (17000000, "diecisiete millones");
             (18000000, "dieciocho millones");
             (19000000, "diecinueve millones");
             (20000000, "veinte millones");
             (21000000, "veintiuno millones");
             (22000000, "veintidós millones");
             (23000000, "veintitrés millones");
             (24000000, "veinticuatro millones");
             (25000000, "veinticinco millones");
             (26000000, "veintiséis millones");
             (27000000, "veintisiete millones");
             (28000000, "veintiocho millones");
             (29000000, "veintinueve millones");
             (30000000, "treinta millones")]
             
let test () =
  List.iter
    (fun (n, s) ->
      let r = intToText n in
      if r <> s then Printf.printf "FAILED: %d -> %s\n" n r)
    tests

let _ = test ()
