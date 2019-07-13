

decidir_jogada(Ei,terminou):- 
  terminal(Ei,_).

decidir_jogada(Ei, Opf):-
  alphabeta(Ei, -99999,99999,Er,_, 0,NosVisitados), 
  calcula_op(Ei,Er,Opf). 


alphabeta( Ei,_,_,_, Val,P,1) :- 
	  terminal(Ei,Res),
	  valor(Res, Val, P).
	  
alphabeta( Ei,_,_,_, Val,P,1) :- 
  profundidade_limite(P1),
  P1 = P,!, 
  f_avalia(Ei,Val,P).
  
alphabeta( Ei, Alpha, Beta, GoodPos, Val,P,NosVisitados) :-
	findall(Es, op1(Ei, _, Es), L),
	boundedbest( L, Alpha, Beta, GoodPos, Val,P,NosVisitados). 
	

boundedbest( [E | Poslist], Alpha, Beta, GoodPos, GoodVal,P,NosVisitados) :- 
	P1 is P +1,
	alphabeta( E, Alpha, Beta, _, Val,P1,NosVisitados1),          % 
	goodenough( Poslist, Alpha, Beta, E, Val, GoodPos, GoodVal,P,NosVisitados2),
	NosVisitados is NosVisitados1+NosVisitados2.



goodenough( [], _, _, Pos, Val, Pos, Val,_,0) :- !. 
goodenough( _, Alpha, Beta, E, Val, E, Val,P,0) :-
	impar( P), Val > Beta,!;
	par( P), Val < Alpha, !.
	 
goodenough( Poslist, Alpha, Beta, Pos, Val, GoodPos, GoodVal,P,NosVisitados) :-
	newbounds( Alpha, Beta, Pos, Val, NewAlpha, NewBeta,P),
	boundedbest( Poslist, NewAlpha, NewBeta, Pos1, Val1,P,NosVisitados),
	betterof( Pos, Val, Pos1, Val1, GoodPos, GoodVal,P).

	
newbounds( Alpha, Beta, _, Val, Val, Beta,P) :-
	impar(P), Val > Alpha, !.

newbounds( Alpha, Beta, _, Val, Alpha, Val,P) :-
	par( P), Val < Beta, !. 

newbounds( Alpha, Beta, _, _, Alpha, Beta,_).


betterof( Pos, Val, _, Val1, Pos, Val,P) :-
	impar( P), Val > Val1, !.
betterof( Pos, Val, _, Val1, Pos, Val,P) :-
	par( P), Val < Val1, !.

betterof( _, _, Pos1, Val1, Pos1, Val1,_).

impar(P):-
	X is P mod 2,
	X = 0.
	
par(P):-
	X is P mod 2,
	X \= 0.
	
escolhe_max([A|R],Val):- escolhe_max(R,A,Val).

escolhe_max([],_-Op,Op):-!.
escolhe_max([A-_|R],X-Op,Val):- A < X,!, escolhe_max(R,X-Op,Val),!.
escolhe_max([A|R],_,Val):-  escolhe_max(R,A,Val),!.



calcula_op(Ei,Er,Opf):-
	calcula_dif(Ei,Er,Linha,Pecas),
	Opf = retiraLinha(Linha-Pecas).
	
calcula_dif([A|Ri],[A|Rs],Linha,Pecas):-
	calcula_dif(Ri,Rs,Linha1,Pecas),
	Linha is Linha1 +1 .

calcula_dif([A|_],[B|_],1,Pecas):-
	A \= B,
	Pecas is A - B.