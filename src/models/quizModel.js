var database = require("../database/config")

function cadastrar(idUsuario, tempoQuiz, pontos) {
    var instrucao = `
    insert into tentativa(fkQuiz,fkUsuario,tempoTentativa, pontuacao) values (1,${idUsuario},${tempoQuiz},${pontos})
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listar(idUsuario) {
    var instrucao = `
    select min(tempoTentativa) as 'minTempo',
        avg(tempoTentativa) as 'mediaTempo',
        max(tempoTentativa) as 'maxTempo',
        (select tempoTentativa 
        from tentativa 
        where fkUsuario = ${idUsuario} and fkQuiz = 1 
        order by dataHoraTentativa desc 
        limit 1) as 'tentativaTempo'
    from tentativa
    where fkQuiz = 1; 
    `
    ;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


module.exports = {
    listar,
    cadastrar
};
