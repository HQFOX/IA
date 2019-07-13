% Condições: obstruida(X,Y), visitadas(X,Y), esta(X,Y), saída(X,Y)

% Percepções: brisa(na casa saida) , obstruídas(n)- n casas obstruidas
% Ações: mover(X,Y) , desistir , sair

labirinto(6,6).
saida(1,4).

h(estar(6,1),s0).

obstruida(1,1).
obstruida(1,2).
obstruida(2,1).
obstruida(2,2).
obstruida(2,4).
obstruida(2,5).
obstruida(3,2).
obstruida(3,5).
obstruida(4,1).
obstruida(4,2).
obstruida(4,5).
obstruida(5,5).
obstruida(5,6).

brisa :- estar(1,4).


%% Consequencias

% mover(X,Y)
h(esta(X,Y),r(mover(X,Y),S)):-h(esta(K,W),S),(K=X+1; W=Y+1;K is X-1; W=Y-1; K=X; W=Y), K>0, K<7, W>0, W<7.
% desistir
h(perdeu,r(desistir,S)) :- h(esta(_X,_Y,S).
% sair
h(ganhou, r(sair,S)) :- h(esta(X,Y),S), h(saida(X,Y),r(sair,S)).
h(estar(X,Y),r(sair,S)):- h(estar(X,Y),S), h(saida(X,Y),S).



%% Inercia
h(desistiu, r(_,S)) :- h(desistiu,S).
h(esta(X,Y),r(sair,S)) :- h(esta(X,Y),S).
h(ganhou,r(_,S)) :- h(ganhou,S).
h(saida(X,Y),r(_,S)):- h(saida(X,Y),S).


%% Percepções
% brisa
h(saida(X,Y),r(_,S)):- h(brisa,S), h(esta(X,Y),S).
% obstruidas
h(estar(X,Y),r(_,S)):- h(obstruidas,S), h(esta(X,Y),S).


h(visitadas(X,Y),S):-
	nonvar(S), 
	h(estar(X,Y),S).

h(visitadas(X,Y),S1):- nonvar(S1), S1 = r(_,S), 
	h(visitadas(X,Y),S). 


% casa segura
h(segura(X,Y),S):-
	h(visitadas(X,Y),S).

h(segura(X,Y),S):-
	h(visitadas(K,W),S),
	(K=X+1; W=Y+1;K is X-1; W=Y-1; K=X; W=Y), K>0, K<7, W>0, W<7.

