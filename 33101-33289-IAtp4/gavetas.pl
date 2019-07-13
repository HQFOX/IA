
sobre(0,1).
sobre(1,2).
sobre(2,3).


% accao(nome_accao, condicao, antes(adicionar), depois(remover)).

% abrir a gaveta
accao(abreGaveta(Gav),[mao([]), fechada(Gav)],[aberta(Gav)],[fechada(Gav)]) :- 
	member(Gav,[1,2,3]).

% retirar o objecto da gaveta
accao(tiraObjecto(Gav,Obj), [mao([]), aberta(Gav), possuiObj(Gav,Obj), fechada(GavAux)], [mao(Obj)], [possuiObj(Gav,Obj), mao([])]):- 
	sobre(GavAux,Gav), 
	member(Obj, [a,b,c]).

% colocar o objecto na gaveta
accao(colocaObjecto(Gav,Obj), [mao(Obj), aberta(Gav), fechada(Gav1)], [possuiObj(Gav,Obj), mao([])], [mao(Obj)]):- 
	sobre(Gav1,Gav),
	member(Obj, [a,b,c]).

% fechar a gaveta
accao(fecharGaveta(Gav),[aberta(Gav)],[fechada(Gav)],[aberta(Gav)]) :- 
	member(Gav,[1,2,3]).




% estado inicial(0)
estado_inicial([mao([]), possuiObj(1,a), possuiObj(2,b), possuiObj(3,c), fechada(1), fechada(2), fechada(3), fechada(0)] ).

% estado final(2)
estado_final([possuiObj(3,a), possuiObj(2,b), possuiObj(1,c), fechada(1), fechada(2), fechada(3)]). 

%estado_final([possuiObj(2,a), possuiObj(2,c), possuiObj(3,b), fechada(1), fechada(2), fechada(3)]). --> demorava tempo demais para testar



% P = [s1-inicial,s5-abreGaveta(1),s6-abreGaveta(3),s4-tiraObjecto(1,a),
%	   s3-colocaObjecto(3,a),s8-tiraObjecto(3,c),s214-fecharGaveta(3),
% 	   s7-colocaObjecto(1,c),s213-fecharGaveta(1),s2-final]
