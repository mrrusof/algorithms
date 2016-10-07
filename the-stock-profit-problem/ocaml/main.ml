open Printf;;

let alg_g a = 
  let rec do_et profit max = function
    | [] -> profit
    | a_i :: a ->
      if a_i > max then
        do_et profit a_i a
      else if max - a_i > profit then
        do_et (max - a_i) max a
      else
        do_et profit max a
  in
  match a with
    | [] -> 0
    | a_last :: a' -> do_et 0 a_last a'

let rec read_input acc =
  let l =
    try Some (int_of_string (read_line ()))
    with _ -> None
  in
  match l with
    | None -> acc
    | Some i -> 
      read_input (i :: acc)

let main () = 
  let a = read_input [] in
  printf "%d\n" (alg_g a)

let _ = main ()