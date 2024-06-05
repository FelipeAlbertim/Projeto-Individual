var quizModel = require("../models/quizModel");

function listar(req, res) {
    quizModel.listar().then(function (resultado) {
        // precisamos informar que o resultado voltará para o front-end como uma resposta em json
        res.status(200).json(resultado);
    }).catch(function (erro) {
        res.status(500).json(erro.sqlMessage);
    })
}

function cadastrar(req, res) {

    var idUsuario = req.body.fkUsuarioServer
    var tempoQuiz = req.body.tempoTentativaServer
    var pontos = req.body.pontuacaoServer

    
    quizModel.cadastrar(idUsuario,tempoQuiz,pontos).then(function (resposta) {
        res.status(200).send("Carro criado com sucesso");
    }).catch(function (erro) {
        res.status(500).json(erro.sqlMessage);
    })
}

module.exports = {
    listar,
    cadastrar
}