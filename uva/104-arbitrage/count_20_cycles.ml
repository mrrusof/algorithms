#!/usr/bin/env ocaml

include Int64

let rec pow b e =
  if e = 0 then one
  else mul b (pow b (e - 1))

let pow b e = pow (of_int b) e

let rec c i n l =
  if l < 2 then zero
  else sub (pow (n - i) (l - 1)) (c i n (l - 1))

let rec iter n f acc =
  if n = 0 then acc
  else iter (n - 1) f (f n acc)

let c n l =
  iter n (fun i acc -> add acc (c i n l)) zero

let c n =
  iter n (fun l acc -> add acc (c n l)) zero

let rec upto m n f =
  if m = n then f m
  else begin f m; upto (m + 1) n f end

let _ =
  upto 3 20 (fun n -> Printf.printf "K%2d %40s\n" n (to_string (c n)))