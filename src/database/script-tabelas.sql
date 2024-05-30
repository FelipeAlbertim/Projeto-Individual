create database valorant_club;

use valorant_club;

create table usuario (
    idUsuario int primary key auto_increment,
    nome varchar(45),
    nomeReal varchar(45),
    email varchar(45),
    senha varchar(255),
    historia longtext
);

insert into usuario (nome, email, senha) values
('Felipe Albertim', 'felipe@gmail.com', '123');

create table quiz (
    idQuiz int primary key auto_increment,
    fkUsuario int,
    nomeQuiz varchar(45),
    foreign key (fkUsuario) references usuario(idUsuario)
);

insert into quiz (fkUsuario, nomeQuiz) values 
(1, 'Quiz Geral');

create table pergunta (
    idPergunta int auto_increment,
    fkQuiz int,
    foreign key (fkQuiz) references quiz(idQuiz),
    primary key (idPergunta, fkQuiz),
    textoPergunta varchar(200)
);

insert into pergunta (fkQuiz, textoPergunta) values 
(1, 'Em que ano o Valorant foi oficialmente lançado?'), -- id 1
(1, 'Qual é o agente mais recente adicionado ao Valorant?'), -- id 2
(1, 'Qual é o nome da habilidade ultimate do agente Jett?'), -- id 3
(1, 'Em que mapa foi jogada a final do primeiro campeonato mundia l de Valorant?'), -- id 4
(1, 'Qual é o nome do modo de jogo onde os jogadores precisam desarmar a Spike?'), -- id 5
(1, 'Quantos agentes estavam disponíveis no lançamento do Valorant?'), -- id 6
(1, 'Qual agente tem a habilidade chamada "Flecha de Choque"?'), -- id 7
(1, 'Qual o nome do estúdio que desenvolveu Valorant?'), -- id 8
(1, 'Quantos jogadores formam uma equipe em uma partida de Valorant?'), -- id 9
(1, 'Qual agente tem a habilidade "Orge Curativo"?'); -- id 10

create table resposta (
    idResposta int auto_increment,
    fkPergunta int,
    foreign key (fkPergunta) references pergunta(idPergunta),
    primary key (idResposta, fkPergunta),
    textoResposta varchar(45),
    correta boolean
);

insert into resposta (fkPergunta, textoResposta, correta) values
(1, '1859', false), -- id 1
(1, '1503', false), -- id 2
(1, '1968', false), -- id 3
(1, '2020', true), -- id 4

(2, 'Killjoy', false), -- id 5
(2, 'Astra', false), -- id 6
(2, 'Yoru', false), -- id 7
(2, 'Neon', true), -- id 8

(3, 'Tormenta de aço', true), -- id 9
(3, 'Sobrecarga', false), -- id 10
(3, 'Dizzy', false), -- id 11
(3, 'Furia do caçador', false), -- id 12

(4, 'Split', false), -- id 13
(4, 'Bind', false), -- id 14
(4, 'Ascent', true), -- id 15
(4, 'Haven', false), -- id 16

(5, 'Mata-Mata', false), -- id 17
(5, 'Frenético', false), -- id 18
(5, 'Mata-Mata em Equipe', false), -- id 19
(5, 'Sem Classificação', true), -- id 20

(6, '8', false), -- id 21
(6, '10', true), -- id 22
(6, '12', false), -- id 23
(6, '14', false), -- id 24

(7, 'Cypher', false), -- id 25
(7, 'Sova', true), -- id 26
(7, 'Phoenix', false), -- id 27
(7, 'Breach', false), -- id 28

(8, 'Ubisoft', false), -- id 29
(8, 'Riot Games', true), -- id 30
(8, 'Epic Games', false), -- id 31
(8, 'Activision', false), -- id 32

(9, '3', false), -- id 33
(9, '4', false), -- id 34
(9, '5', true), -- id 35
(9, '6', false), -- id 36

(10, 'Viper', false), -- id 37
(10, 'Sage', true), -- id 38
(10, 'Raze', false), -- id 39
(10, 'Breach', false); -- id 40

create table ranking (
    fkQuiz int,
    fkUsuario int,
    tentativa int auto_increment,
    duracao time,
    unique (tentativa),
    pontuacao int,
    foreign key (fkQuiz) references quiz(idQuiz),
    foreign key (fkUsuario) references usuario(idUsuario),
    primary key (fkQuiz, fkUsuario, tentativa)
);

insert into ranking values 
(1, 1, default, '00:01:42', 1000);

create table resposta_usuario (
    fkUsuario int,
    fkPergunta int,
    fkResposta int,
    foreign key (fkUsuario) references usuario(idUsuario),
    foreign key (fkPergunta) references pergunta(idPergunta),
    foreign key (fkResposta) references resposta(idResposta),
    primary key (fkUsuario, fkPergunta)
);

insert into resposta_usuario (fkUsuario, fkPergunta, fkResposta) values 
(1, 1, 4), 
(1, 2, 7),  
(1, 3, 9),  
(1, 4, 15), 
(1, 5, 20), 
(1, 6, 22), 
(1, 7, 28),
(1, 8, 32),
(1, 9, 33), 
(1, 10, 40); 

select usuario.nome as 'Nome Usuário',
    pergunta.textoPergunta as 'Pergunta',
    resposta.textoResposta as 'Resposta',
    resposta.correta as 'Acertou ?'
	from resposta_usuario ru join
    usuario on ru.fkUsuario = usuario.idUsuario
	join resposta 
	on ru.fkResposta = resposta.idResposta
	join pergunta 
	on ru.fkPergunta = pergunta.idPergunta
	order by pergunta.idPergunta;