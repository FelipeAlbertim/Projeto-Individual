var quizModel = require("../models/quizModel");

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

function buscarTentativaTempo(req, res) {
    
    var idUsuario = req.params.idUsuario;

    console.log(`Recuperando o idUsuario ${idUsuario}`);

    quizModel.buscarTentativaTempo(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas tentativas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function atualizarEloUsuario(req, res) {
    var fkElo = req.params.fkElo;
    var idEloTentativa = req.params.idEloTentativa;

    quizModel.atualizarEloUsuario(fkElo,idEloTentativa)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        )
        .catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o update: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            }
        );

}

function buscarCriteriosElo(req,res){
    quizModel.buscarCriteriosElo().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

function playersPorElo(req,res){
    quizModel.playersPorElo().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
    buscarTentativaTempo,
    buscarCriteriosElo,
    atualizarEloUsuario,
    playersPorElo,
    cadastrar
}