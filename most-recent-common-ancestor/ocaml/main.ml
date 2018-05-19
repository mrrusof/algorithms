open Printf;;

let rec move_up n steps p =
  if steps > 0 then
    let n = Hashtbl.find p n in
    move_up n (steps - 1) p
  else
    n
;;

let depth n p =
  let rec d n i =
    if Hashtbl.mem p n then
      let n = Hashtbl.find p n in
      d n (i + 1)
    else
      i
  in
  d n 0
;;

let most_recent_common_ancestor a b p =
  let da = depth a p in
  let db = depth b p in
  let a = if da < db then a else move_up a (da - db) p in
  let b = if db < da then b else move_up b (db - da) p in
  let rec loop a b =
    if a != b then
      let a = Hashtbl.find p a in
      let b = Hashtbl.find p b in
      loop a b
    else
      a
  in
  loop a b
;;

let main () =
  let l = read_line () in
  let [x; y] = List.map int_of_string (Str.split (Str.regexp " ") l) in
  let n = read_int () in
  let p = Hashtbl.create 1000000 in
  let rec loop n =
    if n > 0 then
      let l = read_line () in
      let [a; b] = List.map int_of_string (Str.split (Str.regexp " ") l) in
      let _ = Hashtbl.add p b a in
      loop (n - 1)
  in
  let _ = loop n in
  printf "%d\n" (most_recent_common_ancestor x y p)
;;

main ();;
