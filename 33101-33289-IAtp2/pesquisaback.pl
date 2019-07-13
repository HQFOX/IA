p:- estado_inicial(E0), back(E0,A), esc(A).

back(e([],A),A).
back(E,Sol):- sucessor(E,E1), ve_restricoes(E1),
                          back(E1,Sol).

sucessor(e([v(N,D,V)|R],E),e(R,[v(N,D,V)|E])):- member(V,D).


f:- estado_inicial(E0), back1(E0,A), esc(A).

back1(e([],A),A).
back1(E,Sol):- sucessor(E,E1), ve_restricoes(E1),
							forward_Checking(E1,E2),
                          back(E2,Sol).

%ForwardChecking
 
forwardC(e(NAfect,[v(N,D,V)|Afect]),e(NAfectS,[v(N,D,V)|Afect])):-
        actualizaDom(V, NAfect, NAfectS).