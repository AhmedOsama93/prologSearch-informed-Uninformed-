
hpath([A,B,C],[H|[]],[[A,B,H],[A,H,C],[H,B,C]]):-!.
hpath([A,B,C],[H|T],States):-
    hpath([A,B,C],T,ReturnStates),!,
    ( (\+member(H,[A,B,C]),
       append(ReturnStates,[[H,B,C],[A,H,C],[A,B,H]],NewStates))

    ; NewStates = ReturnStates),
    States = NewStates.

%hgetHeuristic([A,B,C],Goal,H):-
%    H is abs(Goal-(A+B+C)).
%
hgetHeuristic([A,B,C],Goal,H):-
    H is(Goal-(A+B+C)),!, Goal >= 0.
hgetHeuristic(_,_,99).

hgetBest([H|[]],_,H).
hgetBest([H|T],G,BestState):-

    hgetBest(T,G,BestState2),

    hgetHeuristic(BestState2,G,H2),
    hgetHeuristic(H,G,H1),!,
    (( H1=<H2 , BestState = H) ; BestState = BestState2 ).
sortList([],[]).
sortList([H|T],Result):-
    sort(0,@=<,H,Hsorted),
    sortList(T,Result2),
    Result = [Hsorted|Result2].

%separateList([H|[]],[]).
separateList([H|T],Item):-
    separateList(T,Item);
    Item = H.

threeSum2(AllNumList,Goal,Output):-
    nth0(0,AllNumList,V1),
    nth0(1,AllNumList,V2),
    nth0(2,AllNumList,V3),
    hmove([[V1,V2,V3]],[],AllNumList,Goal,Output1),
    reverse(Output1,Output1Reversed),
separateList(Output1Reversed,Output).


checkCildrin([],_,_,[]):-!.
checkCildrin([H|T],Open,Closed,Return):-
    checkCildrin(T,Open,Closed,Return1),
    addIt(H,Open,Closed,Return1,Return).

addIt(H,Open,Closed,Return1,Return):-
       \+member(H,Closed),
       \+member(H,Open),!,
       append([H],Return1,Return) .

addIt(_,_,_,Return1,Return):-
       Return = Return1.


hmove([],_,_,_,[]):-!.
hmove(Open,Closed,AllNumList,Goal,Return):-
    hgetBest(Open,Goal,BestState),
    delete(Open,BestState,NewOpen1),
    hpath(BestState,AllNumList,AllChiledState),!,
    sortList(AllChiledState,AllChiledStateSorted),
    checkCildrin(AllChiledStateSorted,Open,Closed,AllChiledStateFilterd),
    append(NewOpen1,AllChiledStateFilterd,NewOpen),
   hmove(NewOpen,[BestState|Closed],AllNumList,Goal,List),
    addToList(BestState,List,Goal,Return) .

addToList(BestState,List,Goal,Return):-
    hgetHeuristic(BestState,Goal,H),H=:=0,Return= [BestState|List],!.
addToList(_,List,_,List).
