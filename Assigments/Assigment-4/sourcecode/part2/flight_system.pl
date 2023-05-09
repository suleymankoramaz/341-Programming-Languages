% knowledge base ---------------------------------
:- style_check(-singleton).

schedule(canakkale,erzincan,6).

schedule(erzincan,canakkale,6).
schedule(erzincan,antalya,3).

schedule(antalya,erzincan,3).
schedule(antalya,diyarbakir,4).
schedule(antalya,izmir,2).
schedule(antalya,isparta,1).
schedule(antalya,hatay,4).

schedule(diyarbakir,ankara,8).
schedule(diyarbakir,antalya,4).
schedule(diyarbakir,hatay,2).

schedule(izmir,istanbul,2).
schedule(izmir,ankara,6).
schedule(izmir,antalya,2).
schedule(izmir,isparta,2).

schedule(ankara,istanbul,1).
schedule(ankara,izmir,6).
schedule(ankara,rize,5).
schedule(ankara,van,4).
schedule(ankara,diyarbakir,8).
schedule(ankara,isparta,3).

schedule(istanbul,izmir,2).
schedule(istanbul,rize,4).
schedule(istanbul,ankara,1).
schedule(istanbul,hatay,6).

schedule(van,gaziantep,3).
schedule(van,ankara,4).
schedule(van,artvin,3).

schedule(rize,istanbul,4).
schedule(rize,ankara,5).
schedule(rize,artvin,1).

schedule(gaziantep,van,3).

schedule(isparta,antalya,1).
schedule(isparta,izmir,2).
schedule(isparta,ankara,3).

schedule(hatay,antalya,4).
schedule(hatay,diyarbakir,2).
schedule(hatay,istanbul,6).

schedule(artvin,rize,1).
schedule(artvin,van,3).

%-------------------------------------------------


% rules-------------------------------------------
% Symmetry
connection_base(X,Y,Z) :- schedule(X,Y,Z).

connection(X, Y, Cost):-
        check_route(X, Y, [Y|Rest],Cost).

check_route(X, Y,Routes,Cost) :- 
        search_route(X, Y,[X],Routes,Cost).

search_route(X, Y, P, [Y|P],Cost) :- 
        connection_base(X,Y,Cost).

search_route(X, Y, Routes, A, Cost) :-
    connection_base(X, Z, Cost1),
    not(Z == X),not(Z == Y),
    not(in(Z, Routes)),           
    search_route(Z, Y, [Z|Routes],A,Cost2),
    Cost is Cost1+Cost2.

%To check whether an element is in array
in(E, [E|Rest]).
in(E, [I|Rest]):- in(E, Rest).