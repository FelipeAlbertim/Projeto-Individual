create database	valorant_club;

use valorant_club;

create table usuario(
idUsuario int auto_increment primary key,
nome varchar(45),
nomeReal varchar(45),
email varchar(45),
senha varchar(255),
historia longtext);

create table quiz(
idQuiz int auto_increment primary key,
fkUsuario int,
nomeQuiz varchar(45),
foreign key (fkUsuario) references usuario(idUsuario)
);

create table pergunta(
idPergunta int auto_increment,
fkQuiz int,
foreign key (fkQuiz) references quiz(idQuiz),
primary key (idPergunta,fkQuiz),
textoPergunta varchar(45));

create table resposta(
idResposta int auto_increment,
fkPergunta int,
foreign key (fkPergunta) references pergunta(idPergunta),
primary key (idResposta,fkPergunta),
textoResposta varchar(45),
correta boolean);