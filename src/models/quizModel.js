var database = require("../database/config")

function cadastrar(idUsuario, tempoQuiz, pontos) {
    var instrucao = `
    insert into tentativa(fkQuiz,fkUsuario,tempoTentativa, pontuacao) values (1,${idUsuario},${tempoQuiz},${pontos})
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function buscarTentativaTempo(idUsuario) {
    var instrucao = `
    select min(tempoTentativa) as 'minTempo',
        avg(tempoTentativa) as 'mediaTempo',
        (select tempoTentativa 
        from tentativa 
        where fkUsuario = ${idUsuario} and fkQuiz = 1 
        order by dataHoraTentativa desc 
        limit 1) as 'tentativaTempo',
        max(tempoTentativa) as 'maxTempo'
    from tentativa
    where fkQuiz = 1; 
    `
        ;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function buscarCriteriosElo() {
    var instrucao = `
    select * from elo
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function playersPorElo() {
    var instrucao = `
    select nomeElo, count(idUsuario) as qtdUsuario from usuario join elo on fkElo = idElo group by idElo;
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function atualizarEloUsuario(fkElo,idUsuario){
    var instrucao = `
    update usuario set fkElo = ${fkElo} where idUsuario = ${idUsuario};
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listaRanking(){
    var instrucao = `
    select 
    tentativa.fkUsuario as idUsuario,
    usuario.nome as NomeUsuario,
    elo.nomeElo as Elo,
    tentativa.pontuacao as Pontuacao,
    tentativa.tempoTentativa as Tempo,
    tentativa.dataHoraTentativa as DataHora,
    rank() over (partition by tentativa.fkQuiz order by tentativa.pontuacao desc, tentativa.tempoTentativa asc, tentativa.dataHoraTentativa asc) as PosicaoRanking
        from 
            (
                select 
                    fkUsuario,
                    fkQuiz,
                    max(dataHoraTentativa) as ultimaTentativa
                from 
                    tentativa
                group by 
                    fkUsuario, fkQuiz
            ) as ultimas_tentativas
        join 
            tentativa on ultimas_tentativas.fkUsuario = tentativa.fkUsuario and ultimas_tentativas.fkQuiz = tentativa.fkQuiz and ultimas_tentativas.ultimaTentativa = tentativa.dataHoraTentativa
        join 
            usuario on tentativa.fkUsuario = usuario.idUsuario
        join 
            elo on usuario.fkElo = elo.idElo    
        order by 
            tentativa.fkQuiz, PosicaoRanking;
    `
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    buscarTentativaTempo,
    buscarCriteriosElo,
    playersPorElo,
    atualizarEloUsuario,
    listaRanking,
    cadastrar
};
