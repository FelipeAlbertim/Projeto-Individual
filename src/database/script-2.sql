create database valorant_club2;

use valorant_club2;

create table usuario(
idUsuario int auto_increment primary key,
nome varchar(45),
nomeReal varchar(45),
email varchar(45),
senha varchar(255),
historia longtext,
elo varchar(45));

insert into usuario values 
(default,'Makita#wap','Felipe Albertim','felipe@gmail.com','123','bla bla bla bla bla bla bla ','RADIANTE');

create table quiz(
idQUiz int auto_increment primary key,
nomeQuiz varchar(45));

insert into quiz values (default,'Perguntas gerais sobre valorant');

create table pergunta(
idPergunta int primary key auto_increment,
fkQuiz int,
foreign key (fkQuiz) references quiz(idQuiz),
textoPergunta varchar(100));

insert into pergunta(fkQuiz,textoPergunta) values
(1, 'Em que ano o Valorant foi oficialmente lançado?'), 
(1, 'Qual é o agente mais recente adicionado ao Valorant?'), 
(1, 'Qual é o nome da habilidade ultimate do agente Jett?'), 
(1, 'Em que mapa foi jogada a final do primeiro campeonato mundia l de Valorant?'), 
(1, 'Qual é o nome do modo de jogo onde os jogadores precisam desarmar a Spike?'), 
(1, 'Quantos agentes estavam disponíveis no lançamento do Valorant?'), 
(1, 'Qual agente tem a habilidade chamada "Flecha de Choque"?'), 
(1, 'Qual o nome do estúdio que desenvolveu Valorant?'), 
(1, 'Quantos jogadores formam uma equipe em uma partida de Valorant?'), 
(1, 'Qual agente tem a habilidade "Orge Curativo"?'); 

create table resposta(
idResposta int auto_increment,
fkPergunta int,
foreign key (fkPergunta) references pergunta(idPergunta),
primary key (idResposta,fkPergunta),
textoResposta varchar(45),
correta boolean);

insert into resposta (fkPergunta, textoResposta, correta) values
(1, '1859', false), 
(1, '1503', false), 
(1, '1968', false), 
(1, '2020', true), 

(2, 'Killjoy', false), 
(2, 'Astra', false), 
(2, 'Yoru', false), 
(2, 'Neon', true), 

(3, 'Tormenta de aço', true), 
(3, 'Sobrecarga', false), 
(3, 'Dizzy', false), 
(3, 'Furia do caçador', false), 

(4, 'Split', false), 
(4, 'Bind', false), 
(4, 'Ascent', true), 
(4, 'Haven', false), 

(5, 'Mata-Mata', false), 
(5, 'Frenético', false), 
(5, 'Mata-Mata em Equipe', false), 
(5, 'Sem Classificação', true), 

(6, '8', false), 
(6, '10', true), 
(6, '12', false), 
(6, '14', false), 

(7, 'Cypher', false), 
(7, 'Sova', true), 
(7, 'Phoenix', false), 
(7, 'Breach', false), 

(8, 'Ubisoft', false), 
(8, 'Riot Games', true), 
(8, 'Epic Games', false), 
(8, 'Activision', false), 

(9, '3', false), 
(9, '4', false), 
(9, '5', true), 
(9, '6', false), 

(10, 'Viper', false), 
(10, 'Sage', true), 
(10, 'Raze', false), 
(10, 'Breach', false); 

create table tentativa(
idTentativa int auto_increment,
fkUsuario int,
foreign key (fkUsuario) references usuario(idUsuario),
fkQuiz int,
foreign key (fkQuiz) references quiz(idQuiz),
primary key (idTentativa,fkUsuario,fkQuiz),
dataHoraTentativa datetime default current_timestamp,
tempoTentativa decimal(10,3),
pontuacao int);

insert into tentativa values
(default,1,1,default,20,6),
(default,1,1,default,120,6);

create table ranking(
fkUsuario int,
fkQuiz int,
fkTentativa int,
fkPergunta int,
fkResposta int,
foreign key (fkUsuario) references usuario(idUsuario),
foreign key (fkQuiz) references quiz(idQuiz),
foreign key (fkTentativa) references tentativa(idTentativa),
foreign key (fkPergunta) references pergunta(idPergunta),
foreign key (fkResposta) references resposta(idResposta),
primary key (fkUsuario,fkQuiz,fkTentativa,fkPergunta,fkResposta));

insert into ranking values
(1,1,1,1,2),
(1,1,1,2,3),
(1,1,1,3,3),
(1,1,1,4,4),
(1,1,1,5,1),
(1,1,1,6,2),
(1,1,1,7,3),
(1,1,1,8,1),
(1,1,1,9,1),
(1,1,1,10,4);

/*	INÍCIO DOS SELECT's	*/

select idTentativa as Tentativa,
	usuario.nome as 'Nome do usuario',
    quiz.nomeQuiz as 'Nome do Quiz',
    dataHoraTentativa as 'Data da Tentativa',
    tempoTentativa as 'Tempo da Tentativa (SEGUNDOS)',
    pontuacao as 'Pontos'
    from tentativa
join usuario on tentativa.fkUsuario = idUsuario
join quiz on tentativa.fkQuiz = idQuiz;

-- inserirResultadoQuiz(acertos,tempo,idUsuario)

-- insert into tentativa(fkQuiz,fkUsuario,tempoTentativa, pontuacao) values (1,${idUsuario},${tempo},${acertos});
select * from tentativa;
select * from usuario;

select idTentativa as Tentativa,
        usuario.nome as 'Nome do usuario',
        quiz.nomeQuiz as 'Nome do Quiz',
        dataHoraTentativa as 'Data da Tentativa',
        tempoTentativa as 'Tempo da Tentativa (SEGUNDOS)',
        pontuacao as 'Pontos'
        from tentativa
    join usuario on tentativa.fkUsuario = idUsuario
    join quiz on tentativa.fkQuiz = idQuiz;    
    
select min(tempoTentativa) as minTempoTentativa,
	avg(tempoTentativa) as mediaTempoTentativa,
    max(tempoTentativa) as maximoTempoTentativa
    from tentativa join usuario
    on fkUsuario = idUsuario    
    where idUsuario = 1;

select min(tempoTentativa) as minTempoTentativa,
	avg(tempoTentativa) as mediaTempoTentativa,
    (select tempoTentativa as usuarioTempoTentativa from tentativa join usuario on tentativa.fkUsuario = idUsuario where idUsuario = 1),
    max(tempoTentativa) as maximoTempoTentativa
    from tentativa join usuario
    on fkUsuario = idUsuario    
    where idUsuario = 1;
    
select min(tempoTentativa) as 'minTempo',
        avg(tempoTentativa) as 'mediaTempo',
        (select tempoTentativa
        from tentativa
        where fkUsuario = 1 and fkQuiz = 1
        order by dataHoraTentativa desc
        limit 1) as 'tentativaTempo',
        max(tempoTentativa) as 'maxTempo'
    from tentativa
    where fkQuiz = 1;
    
