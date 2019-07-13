:- dynamic(visited/1).
visited((18, 18)).

%largura(Y)
largura(30).

%profundidade(X)
profundidade(30).

%estado_inicial((agente, sala inicial))
estado_inicial((18,18)).

%estado_final((agente, sala final)).
estado_final((26,26)).

%bloqueadas(casa_inicial, casa_final)
bloqueadas((1,2), (1,3)).
bloqueadas((1,3), (1,2)).
bloqueadas((2,3), (2,2)).
bloqueadas((2,2), (2,3)).
bloqueadas((3,4), (4,4)).
bloqueadas((4,4), (3,4)).
bloqueadas((4,5), (3,5)).
bloqueadas((3,5), (4,5)).


%op(Estado_atual, operador, estado_seguinte, custo)

op((X, Y), desce, (Z, Y), 1) :- 
		profundidade(Prof),
		X < Prof,
		Z is X+1,
		( visited((Z,Y))
			-> fail	
			; ( bloqueadas((X, Y), (Z, Y))
				-> fail
				; asserta(visited((Z,Y)))
			  )
		).


op((X, Y), dir, (X, Z), 1) :- 
		largura(Larg),
		Z is Y+1,
		Y < Larg,
		( visited((X,Z))
			-> fail
		  	;(bloqueadas((X, Y), (X, Z))
		  		-> fail
		  		; asserta(visited((X,Z)))
		  	)
		).


op((X, Y), sobe, (Z, Y), 1) :- 
		X > 1,
		Z is X-1,
		( visited((Z,Y))
			-> fail
		  	; ( bloqueadas((X, Y), (Z, Y))
				-> fail
				; asserta(visited((Z,Y)))
			  )
		).


op((X, Y), esq, (X, Z), 1) :- 
		Y > 1,
		Z is Y-1,
		( visited((X,Z))
			-> fail
			 ; ( bloqueadas((X, Y), (X, Z))
		 		-> fail
		 		; asserta(visited((X,Z)))
			   )
		 ).



%HEURISTICA 
%distancia de manhattan. soma do módulo da diferença das coords, X e Y.


h((Cx,Cy),C):-
	estado_final((Fx,Fy)),
	(Cx>=Fx
		-> K1 is Cx-Fx,
		(Cy>=Fy
			-> K2 is Cy-Fy,
				C is K1 + K2
			;  K2 is Fy-Cy,
				C is K1 + K2
			)
		; K1 is Fx-Cx,
		 (Cy>=Fy
			-> K2 is Cy-Fy,
				C is K1 + K2
			;  K2 is Fy-Cy,
				C is K1 + K2
			)
		).




%HEURISTICA Euclediana, duplica os valores horizontais. Prioridade vertical

h1((Cx,Cy),C):-
	estado_final((Fx,Fy)),
	(Cx>=Fx
		-> K1 is Cx-Fx,
			K3 is K1*2,
		(Cy>=Fy
			-> K2 is Cy-Fy,
				C is K3 + K2
			;  K2 is Fy-Cy,
				C is K3 + K2
			)
		; K1 is Fx-Cx,
			K3 is K1*2,
		 (Cy>=Fy
			-> K2 is Cy-Fy,
				C is K3 + K2
			;  K2 is Fy-Cy,
				C is K3 + K2
			)
		).

