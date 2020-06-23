notice:-
write('Identificação de falhas em máquinas mecânicas'),nl.

analise(Maquina,valvula_interativa_nao_vedada):-
						symptom(Maquina, atuador_pneumatico_com_vazamento),
						symptom(Maquina, vedacao_valvula_com_desgaste),
						symptom(Maquina, valvula_pneumatica_com_vazamento).

analise(Maquina,quebra_de_pinos_e_elementos_de_extrusão):-
						symptom(Maquina, desgaste),
						symptom(Maquina, material_metalico_junto_com_produto),
						symptom(Maquina, aquecimento),
						symptom(Maquina, motor_com_ruido).

analise(Maquina,bomba_pneumatica_nao_puxa_produto):-
						symptom(Maquina, vazamento),
						symptom(Maquina, fadiga_das_esferas_e_conjuntos_de_atuaçao),
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


symptom(P, Val):-ask('A máquina tem apresentado ',Val).
ask(Obj, Val):-known(Obj, Val, true),!.
ask(Obj, Val):-known(Obj, Val, false),!, fail.
ask(Obj, Val):-nl,write(Obj),write(' '),
			write( Val) , write('?(y/n)'), read(Ans), !,
			((Ans=y, assert(known(Obj, Val, true)));(assert(known(Obj, Val, false)),fail)).

diagnose:-nl,write('Análisando..........'),nl,analise(symptom,Analise) ,!,nl,
			write('A máquina pode estar com '), write(Analise).
diagnose:- nl, write('Desculpe, não foi possível determinar o problema!').

start:-notice,repeat, abolish(known/3),dynamic(known/3), retractall(known/3), diagnose,nl,nl, write('Fazer nova análise? (y/n)'),read(Resp),\+ Resp=y,
		nl,write('Procure um mecânico especialista'),abolish(known,3) .
