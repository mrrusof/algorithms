alg_g([], 0).
alg_g([A_LAST|Ap], P) :-
    do_et(0, A_LAST, Ap, P).
do_et(P, _, [], P).
do_et(Pp, M, [Ai|A], P) :-
    Ai @> M ->
      do_et(Pp, Ai, A, P) ;
    (Ppp is M - Ai, Ppp @> Pp) ->
      do_et(Ppp, Ai, A, P) ;
    do_et(Pp, M, A, P).

read_input(A) :- read_input([], A).
read_input(Acc, A) :-
    read_line_to_codes(user_input, L),
    L \== end_of_file,
    number_codes(N, L),
    read_input([N|Acc], A).
read_input(A, A).

main :-
    prompt(_, ''),
    read_input(A),
    alg_g(A, P),
    print(P),
    nl,
    halt.
