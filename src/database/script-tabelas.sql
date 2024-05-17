-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

create database valorant_club;

use valorant_club;

create table usuario(
idUsuario int auto_increment primary key,
nome varchar(45),
nomeReal varchar(45),
email varchar(50),
senha varchar(255),
historia longtext
);

select * from usuario;