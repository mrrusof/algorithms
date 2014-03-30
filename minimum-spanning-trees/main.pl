#!/usr/bin/env swipl

:- use_module(library(ordsets)).
% :- use_module(library(sets)). % uncomment for sicstus

graph(N, G) :- g1(N, G1), list_to_ord_set(G1, G).
g1(1,[(1,2),
      (2,3),
      (3,1),
      (3,4),
      (1,4),
      (4,5),
      (1,5),
      (2,5),
      (2,10),
      (5,6),
      (6,7),
      (4,6),
      (4,7),
      (6,8),
      (8,9),
      (5,8),
      (8,10),
      (9,10),
      (7,9),
      (7,8),
      (5,10)]).
g1(2, [(1,2),
       (1,3),
       (3,4),
       (5,6),
       (6,7),
       (6,8),
       (8,9),
       (5,10)]).

mst(T, G) :-
        tree(T),
        vertices(T, V),
        vertices(G, V).

tree(G) :-
         vertices(G, V),
         member(N, V),
         format('searching for simple cycle for ~p...', [N]),
         ( path(N, N, G) ; print(no), nl, false ),
         !,
         print(yes),
         nl,
         false.
tree(_).

vertices([(X,Y)|G], V) :- vertices(G, V1), ord_union([[X], [Y], V1], V).
vertices([], []).

path(A, B, G) :- ( member((A,B), G), member((B,A), G) ).
path(A, C, G) :- member((A,B), G), ord_del_element(G, (A,B), G1), path(B, C, G1).
path(A, C, G) :- member((B,A), G), ord_del_element(G, (B,A), G1), path(B, C, G1).

pp_graph(G) :-
        print('graph G {\n'),
        pp_edges(G),
        print('}\n').
pp_edges([(X,Y)|G]) :-
        !,
        format('  ~p -- ~p;\n', [X,Y]),
        pp_edges(G).
pp_edges([]).

:- graph(1, G), graph(2, T), mst(T, G), print('T is a mst of G!\n'), halt.
