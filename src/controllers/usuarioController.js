var usuarioModel = require("../models/usuarioModel");


// function botaoSair() {
//     document.getElementById('btn_login').style.display = 'none';
//     document.getElementById('btn_cadastro').style.display = 'none';

//     document.getElementById('btn_sair').style.display = 'block';
// }

function autenticar(req, res) {
    console.log('chegou no autenticar')
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        console.log(resultadoAutenticar);

                        res.json({
                            idUsuario: resultadoAutenticar[0].idUsuario,
                            email: resultadoAutenticar[0].email,
                            nome: resultadoAutenticar[0].nome
                        });

                    } else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
        // botaoSair();
    }

}

function cadastrar(req, res) {
    console.log("chegou na controller", req.body);

    var nomeUsuario = req.body.nomeUsuarioServer;
    var nomeReal = req.body.nomeRealServer;
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;
    var historia = req.body.historiaServer;

    console.log({
        nomeUsuario,
        nomeReal,
        email,
        senha,
        historia
    });

    if (nomeUsuario == undefined) {
        res.status(400).send("Seu nome de usuario está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Seu senha está undefined!");
    } else {
        usuarioModel.cadastrar(nomeUsuario, nomeReal, email, senha, historia)
            .then(function (resultado) {
                res.json(resultado);
            }).catch(function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            });
    }
}

module.exports = {
    autenticar,
    cadastrar
}