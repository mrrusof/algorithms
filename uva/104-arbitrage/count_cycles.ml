#!/usr/bin/env ocaml

#load "nums.cma"

include Big_int

let rec pow b e =
  if e = 0 then unit_big_int
  else mult_big_int (big_int_of_int b) (pow b (e - 1))

let rec c i n l =
  if l < 2 then zero_big_int
  else sub_big_int (pow (n - i) (l - 1)) (c i n (l - 1))

let rec iter n f acc =
  if n = 0 then acc
  else iter (n - 1) f (f n acc)

let c n l =
  iter n (fun i acc -> add_big_int acc (c i n l)) zero_big_int

let c n =
  iter n (fun l acc -> add_big_int acc (c n l)) zero_big_int

let rec upto m n f =
  if m == n then f m
  else begin f m; upto (m + 1) n f end

let rec format_number s =
  let l = String.length s in
  if l <= 3 then s
  else
    let prefix = String.sub s 0 (l - 3) in
    let suffix = String.sub s (l - 3) 3 in
      Printf.sprintf "%s,%s" (format_number prefix) suffix

let (>>) x f = f x

let _ =
  upto 2 20 (fun n -> Printf.printf "K%2d %40s\n" n (c n >> string_of_big_int >> format_number))
