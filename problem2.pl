count([],_,0).
count([X|T],X,Y):-
    count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):-
    X1\=X, count(T,X,Z).

addToList(H,G,S,Answer,NewAnswer):-
    G>S,!,
    append([H],Answer,Nlist),
    NewAnswer= Nlist.

addToList(_,_,_,Answer,Answer).
heuristic(H,T,Goal,Answer,NewAnswer):-
    count(T,H,S),
    count(Goal,H,G),!,
    addToList(H,G,S,Answer,NewAnswer).


greedySearch([],_,[]).

greedySearch([H|T],Goal,Answer):-
    greedySearch(T,Goal,NewAnswer),
    heuristic(H,T,Goal,NewAnswer,Answer).

compare([], []).

compare([H1|R1], [H2|R2]):-
    H1 = H2,
    compare(R1, R2).

do(L1,L2):-
	compare(L1,L2),!,
	write("True").
do(L1,L2):-
	write("False").
deletiveEditing(Input,Goal):-
    greedySearch(Input,Goal,Result),
    compare(Result,Goal).





