dominio([1,2,3,4,5,6,7,8,9]).

estado_inicial( e([v(n(1,1),D,_Num),
           v(n(1,2),D,_Num),
           v(n(1,3),D,_Num),
           v(n(2,1),D,_Num),
           v(n(2,2),D,_Num),
           v(n(2,3),D,_Num),
           v(n(3,1),D,_Num),
           v(n(3,2),D,_Num),
           v(n(3,3),D,_Num)],[]) ):- dominio(D).
 
%Restricoes:
%-todos os algarismos de todas as linhas e colunas diferentes.
%-todas as somas de linhas e colunas iguais.
restricoes(e(LstNAfect,LstAfect)):- 
	diferentes(LstAfect), 
	somas_iguais(LstAfect).
 
 
diferentes([]).
diferentes([v(_,_,V)|LstAfect]):- member(v(_,_,V),LstAfect),!,fail.
diferentes([_|LstAfect]):- diferentes(LstAfect).




%Verifica a igualdade das somas
somas_iguais(L):- % linhas 
                  findall(V,member(v(n(1,_),_,V), L),L1), somatorio(L1),
                  findall(V,member(v(n(2,_),_,V), L),L2), somatorio(L2),
                  findall(V,member(v(n(3,_),_,V), L),L3), somatorio(L3),

                  %colunas
                  findall(V,member(v(n(_,1),_,V), L),B1), somatorio(B1),
                  findall(V,member(v(n(_,2),_,V), L),B2), somatorio(B2),
                  findall(V,member(v(n(_,3),_,V), L),B3), somatorio(B3),
                  
                  % diagonal Principal
                  findall(V,member(v(n(1,1),_,V),L),D1),
                  findall(V,member(v(n(2,2),_,V), L),D2),
                  findall(V,member(v(n(3,3),_,V), L),D3),append(D1,D2,M),append(M,D3,X),somatorio(X),

                  % diagonal Secundaria
                  findall(V,member(v(n(3,1),_,V),L),D4),
                  findall(V,member(v(n(2,2),_,V), L),D5),
                  findall(V,member(v(n(1,3),_,V), L),D6),append(D4,D5,P),append(P,D6,J),somatorio(J).
 
somatorio( [Num1,Num2,Num3] ):-!, 
  15 is  Num1+Num2+Num3.
somatorio(_).

tamanho_tab(3). %Quadrado3x3

%% escreve
%esc(_).
esc(L):-sort(L, L1), esc_a(L1),nl.

esc_a(L):- tamanho_tab(S), esc_l(L, 1, S).

esc_l([H], S, S):- H = v(_,_,X), write(X),nl.

esc_l([H|T], S, S):- H = v(_,_,X), write(X), nl,esc_l(T, 1, S).

esc_l([H|T], I, S):- I<S, I2 is I+1,
                    H = v(_,_,X), write(X),write(' . '),
                     esc_l(T, I2, S).
