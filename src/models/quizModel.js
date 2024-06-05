var database = require("../database/config")

function cadastrar(idUsuario, tempoQuiz, pontos) {
    var instrucao = `
    insert into tentativa(fkQuiz,fkUsuario,tempoTentativa, pontuacao) values (1,${idUsuario},${tempoQuiz},${pontos})
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listar() {
    var instrucao = `
    select idTentativa as Tentativa,
        usuario.nome as 'Nome do usuario',
        quiz.nomeQuiz as 'Nome do Quiz',
        dataHoraTentativa as 'Data da Tentativa',
        tempoTentativa as 'Tempo da Tentativa (SEGUNDOS)',
        pontuacao as 'Pontos'
        from tentativa
    join usuario on tentativa.fkUsuario = idUsuario
    join quiz on tentativa.fkQuiz = idQuiz;    
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


module.exports = {
    listar,
    cadastrar
};
