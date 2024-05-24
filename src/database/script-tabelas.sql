create database	valorant_club;

use valorant_club;

create table usuario(
idUsuario int auto_increment primary key,
nome varchar(45),
nomeReal varchar(45),
email varchar(45),
senha varchar(255),
historia longtext);

insert into usuario (nome,email,senha) values 
('Felipe Albertim','felipe@gmail.com','123');

create table quiz(
idQuiz int auto_increment primary key,
fkUsuario int,
nomeQuiz varchar(45),
foreign key (fkUsuario) references usuario(idUsuario)
);

insert into quiz (fkUsuario,nomeQuiz) values 
(1,'Quiz Geral');

create table pergunta(
idPergunta int auto_increment,
fkQuiz int,
foreign key (fkQuiz) references quiz(idQuiz),
primary key (idPergunta,fkQuiz),
textoPergunta varchar(200));

insert into pergunta(fkQuiz,textoPergunta) values 
(1,'Quando foi o primeiro campeonato mundial de valorant ?');

create table resposta(
idResposta int auto_increment,
fkPergunta int,
foreign key (fkPergunta) references pergunta(idPergunta),
primary key (idResposta,fkPergunta),
textoResposta varchar(45),
correta boolean);

insert into resposta (fkPergunta,textoResposta,correta) values
(1,'1859',false),
(1,'1503',false),
(1,'1968',false),
(1,'2021',true);

create table ranking(
fkQuiz int,
fkUsuario int,
tentativa int auto_increment,
duracao time,
unique (tentativa),
pontuacao int,
foreign key (fkQuiz) references quiz(idQuiz),
foreign key (fkUsuario) references usuario(idUsuario),
primary key (fkQuiz,fkUsuario,tentativa));

insert into ranking values
(1,1,default,'00:01:42',1000);
