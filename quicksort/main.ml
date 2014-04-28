#!/usr/bin/env ocaml

#load "str.cma";;

let rec quicksort = function
  | [] -> []
  | [x] -> [x]
  | h :: t ->
    quicksort(List.filter (fun n -> n <= h) t) @ [h] @ quicksort (List.filter (fun n -> n > h) t)

let main () =
  print_endline "Input a sequence of numbers separated by comma: ";
  let raw = input_line stdin in
  let nums = Str.split (Str.regexp ",") raw in
  if List.exists (fun s -> not (Str.string_match (Str.regexp "-?[0-9]+") s 0)) nums then begin
    print_endline "ERROR: input is not a sequence of numbers\n";
    exit 0
  end;
  List.iter (fun n -> Printf.printf "%s, " n) (quicksort nums);
  print_endline "";;

main ();;
