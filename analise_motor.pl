notice:-
write('Identifica��o de falhas em m�quinas mec�nicas'),nl.

analise(Maquina,valvula_interativa_nao_vedada):-
						symptom(Maquina, atuador_pneumatico_com_vazamento),
						symptom(Maquina, vedacao_valvula_com_desgaste),
						symptom(Maquina, valvula_pneumatica_com_vazamento).

analise(Maquina,quebra_de_pinos_e_elementos_de_extrus�o):-
						symptom(Maquina, desgaste),
						symptom(Maquina, material_metalico_junto_com_produto),
						symptom(Maquina, aquecimento),
						symptom(Maquina, motor_com_ruido).

analise(Maquina,bomba_pneumatica_nao_puxa_produto):-
						symptom(Maquina, vazamento),
						symptom(Maquina, fadiga_das_esferas_e_conjuntos_de_atua�ao),
						symptom(Maquina, excesso_de_sujeira),
						symptom(Maquina, aquecimento).

analise(Maquina,mancal_trancado):-
						symptom(Maquina, falta_de_ar_para_refrigeracao),
						symptom(Maquina, excesso_de_carga),
						symptom(Maquina, fadiga_dos_rolamentos),
						symptom(Maquina, motor_com_ruido).

analise(Maquina,vazamento_em_selo_mecanico):-
						symptom(Maquina, aquecimento),
						symptom(Maquina, desgaste_do_material),
						symptom(Maquina, rolamento_trancado),
						symptom(Maquina, atuador_pneumatico_com_vazamento).


symptom(P, Val):-ask('A m�quina tem apresentado ',Val).
ask(Obj, Val):-known(Obj, Val, true),!.
ask(Obj, Val):-known(Obj, Val, false),!, fail.
ask(Obj, Val):-nl,write(Obj),write(' '),
			write( Val) , write('?(y/n)'), read(Ans), !,
			((Ans=y, assert(known(Obj, Val, true)));(assert(known(Obj, Val, false)),fail)).

diagnose:-nl,write('An�lisando..........'),nl,analise(symptom,Analise) ,!,nl,
			write('A m�quina pode estar com '), write(Analise).
diagnose:- nl, write('Desculpe, n�o foi poss�vel determinar o problema!').

start:-notice,repeat, abolish(known/3),dynamic(known/3), retractall(known/3), diagnose,nl,nl, write('Fazer nova an�lise? (y/n)'),read(Resp),\+ Resp=y,
		nl,write('Procure um mec�nico especialista'),abolish(known,3) .
