#!/usr/bin/env ocaml

module IntSet = Set.Make(struct type t = int let compare = compare end)

let g = 
  [(1,2);
   (2,3);
   (3,1);
   (3,4);
   (1,4);
   (4,5);
   (1,5);
   (2,5);
   (2,10);
   (5,6);
   (6,7);
   (4,6);
   (4,7);
   (6,8);
   (8,9);
   (5,8);
   (8,10);
   (9,10);
   (7,9);
   (7,8);
   (5,10)];;
let t =
  [(1,2);
   (1,3);
   (3,4);
   (4,5);
   (5,6);
   (5,10);
   (6,7);
   (6,8);
   (8,9)];;

let rec path a b g =
  List.mem (a,b) g ||
  List.mem (b,a) g ||
  List.exists (fun (x, y) -> x=a && path y b (List.filter ((<>) (a, y)) g) ||
                             y=a && path x b (List.filter ((<>) (x, a)) g)   ) g
let vertices g =
  let rec vs = function
    | (x,y) :: g -> IntSet.add y (IntSet.add x (vs g))
    | [] -> IntSet.empty
  in IntSet.elements (vs g)
let tree g = not (List.exists (fun n -> 
                                Printf.printf "searching for simple cycle for %n..." n;
                                (path n n g && (Printf.printf "yes\n"; true)) || (Printf.printf "no\n"; false))
                              (vertices g))
let mst t g = tree t && vertices t = vertices g
    
let _ = if mst t g then Printf.printf "T is a mst of G!\n"
