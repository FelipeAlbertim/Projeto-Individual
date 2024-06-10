create database valorant_club;

use valorant_club;

create table elo(
idElo int auto_increment primary key,
nomeElo varchar(45),
requisitoMaximoAcerto int,
requisitoMinimoAcerto int,
requisitoMaximoTempo decimal(10,3),
requisitoMinimoTempo decimal(10,3)
);
insert into elo values

-- CRITÉRIOS DE CADA ELO

(default,'Radiante',10,10,120,0), -- 10 acertos em menos de 2 minutos ok 
(default,'Imortal',10,9,180,0), -- 9 acertos em até 3 minutos ok
(default,'Diamante',10,6,300,0), -- 6 acertos em até 5 minutos ok
(default,'Ouro',10,3,420,0), -- 3 acertos em até 7 minutos ok 
(default,'Prata',10,0,600,0); -- 0 acertos em até 10 minutos


create table usuario (
idUsuario int primary key auto_increment,
fkElo int,
nome varchar(45),
nomeReal varchar(45),
email varchar(45),
senha varchar(255),
historia longtext,
foreign key (fkElo) references elo(idElo));

insert into usuario values
(default,1,'Makita#wap','Felipe Albertim','felipe@gmail.com','123','Conheci o valorant por meio de amigos da escola !'),
(default,3,'dev239#css','Samuel Luciano','samuel@gmail.com','123','Conheci pelo seu design bom demais !'),
(default,2,'KingRondonia#skt','Alejandro Castor','alejandro@gmail.com','123','Conheci pelo seus poderes !');


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

insert into tentativa (idTentativa,fkUsuario, fkQuiz, dataHoraTentativa, tempoTentativa, pontuacao)
values 
(default, 1, 1 ,'2024-06-09 09:00:00', 55.125, 10), 
(default, 2, 1 , '2024-06-09 10:00:00', 60.001, 6),
(default, 3,  1 ,'2024-06-09 10:30:00', 95.789, 9);

create table ranking(
fkUsuario int,
fkQuiz int,
fkTentativa int,
foreign key (fkUsuario) references usuario(idUsuario),
foreign key (fkQuiz) references quiz(idQuiz),
foreign key (fkTentativa) references tentativa(idTentativa),
primary key (fkUsuario,fkQuiz,fkTentativa));

insert into ranking values
(1,1,1),
(2,1,1),
(3,1,1);


/*	INÍCIO DOS SELECT's	*/

select count(*) from ranking;

select * from usuario;

select 
    tentativa.fkUsuario as idUsuario,
    usuario.nome as NomeUsuario,
    elo.nomeElo as Elo,
    tentativa.pontuacao as Pontuacao,
    tentativa.tempoTentativa as Tempo,
    tentativa.dataHoraTentativa as DataHora,
    rank() over (partition by tentativa.fkQuiz order by tentativa.pontuacao desc, tentativa.tempoTentativa asc, tentativa.dataHoraTentativa asc) as PosicaoRanking
from 
    (
        select 
            fkUsuario,
            fkQuiz,
            max(dataHoraTentativa) as ultimaTentativa
        from 
            tentativa
        group by 
            fkUsuario, fkQuiz
    ) as ultimas_tentativas
join 
    tentativa on ultimas_tentativas.fkUsuario = tentativa.fkUsuario and ultimas_tentativas.fkQuiz = tentativa.fkQuiz and ultimas_tentativas.ultimaTentativa = tentativa.dataHoraTentativa
join 
    usuario on tentativa.fkUsuario = usuario.idUsuario
join 
    elo on usuario.fkElo = elo.idElo    
order by 
    tentativa.fkQuiz, PosicaoRanking;


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
    on fkUsuario = idUsuario;

select min(tempoTentativa) as minTempoTentativa,
	avg(tempoTentativa) as mediaTempoTentativa,
    (select tempoTentativa as usuarioTempoTentativa from tentativa join usuario on tentativa.fkUsuario = idUsuario where idUsuario = 1),
    max(tempoTentativa) as maximoTempoTentativa
    from tentativa join usuario
    on fkUsuario = idUsuario;
    
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