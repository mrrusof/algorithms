#!/usr/bin/env ocaml

let rec pow b e =
  if e = 0 then 1
  else b * pow b (e - 1)

let rec c i n l =
  if l < 2 then 0
  else pow (n - i) (l - 1) - c i n (l - 1)

let rec iter n f acc =
  if n = 0 then acc
  else iter (n - 1) f (f n acc)

let c n l =
  iter n (fun i acc -> acc + c i n l) 0

let c n =
  iter n (fun l acc -> acc + c n l) 0

let rec upto m n f =
  if m = n then f m
  else begin f m; upto (m + 1) n f end

let _ =
  upto 2 16 (fun n -> Printf.printf "K%2d %40d\n" n (c n))
