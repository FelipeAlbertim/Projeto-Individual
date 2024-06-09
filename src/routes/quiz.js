var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

router.post("/cadastrar", function (req, res) {
    quizController.cadastrar(req, res);
});

router.get("/buscarTentativaTempo/:idUsuario", function (req, res) {
    quizController.buscarTentativaTempo(req, res);
});

router.get("/buscarCriteriosElo", function (req, res) {
    quizController.buscarCriteriosElo(req, res);
});

router.get("/playersPorElo", function (req, res) {
    quizController.playersPorElo(req, res);
});

router.get("/atualizarEloUsuario/:fkElo/:idEloTentativa", function (req, res) {
    quizController.atualizarEloUsuario(req, res);
});

module.exports = router;