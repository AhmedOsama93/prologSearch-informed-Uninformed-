
path([A,B,C],[H|[]],[[A,B,H],[A,H,C],[H,B,C]]):-!.
path([A,B,C],[H|T],States):-
    path([A,B,C],T,ReturnStates),!,
    ( (\+member(H,[A,B,C]),
       append(ReturnStates,[[H,B,C],[A,H,C],[A,B,H]],NewStates))

    ; NewStates = ReturnStates),
    States = NewStates.

getHeuristic([A,B,C],Goal,H):-
    H is abs(Goal-(A+B+C)).

sortList([],[]).
sortList([H|T],Result):-
    sort(0,@=<,H,Hsorted),
    sortList(T,Result2),
    Result = [Hsorted|Result2].

%separateList([H|[]],[]).
separateList([H|T],Item):-
    separateList(T,Item);
    Item = H.

threeSum(AllNumList,Goal,Output):-
    nth0(0,AllNumList,V1),
    nth0(1,AllNumList,V2),
    nth0(2,AllNumList,V3),
    move([[V1,V2,V3]],[],AllNumList,Goal,Output1),
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


move([],_,_,_,[]):-!.
move([H|T] ,Closed,AllNumList,Goal,Return):-
    delete([H|T] ,H,NewOpen1),
    path(H,AllNumList,AllChiledState),!,
    sortList(AllChiledState,AllChiledStateSorted),
    checkCildrin(AllChiledStateSorted,[H|T] ,Closed,AllChiledStateFilterd),

    append(NewOpen1,AllChiledStateFilterd,NewOpen),
    move(NewOpen,[H|Closed],AllNumList,Goal,List),
    addToList(H,List,Goal,Return) .

addToList(BestState,List,Goal,Return):-
    getHeuristic(BestState,Goal,H),H=:=0,Return= [BestState|List],!.
addToList(_,List,_,List).
