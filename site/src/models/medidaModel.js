var database = require("../database/config");

function buscarUltimasMedidas(idEstufa) {
    instrucaoSql = `SELECT dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, FORMAT (momento,'HH:mm:ss') AS momento FROM dado
    JOIN estufa ON fkEstufa = idEstufa 
    where idEstufa = ${idEstufa}
    order by idDado desc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function medidaskpi(idEstufa) {
    instrucaoSql = `SELECT MAX(dht11Umidade) AS umidade, MAX(lm35Temperatura) AS temperatura, MAX(luminosidade+108) AS luminosidade FROM dado
    JOIN estufa ON fkEstufa = ${idEstufa} 
    where idEstufa = 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEstufa) {
    instrucaoSql = `SELECT dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, FORMAT (momento, 'hh:mm:ss') AS momento FROM dado
    JOIN estufa ON fkEstufa = idEstufa 
    where idEstufa = ${idEstufa}
    order by idDado desc;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    medidaskpi
}

// select
//                         dht11Umidade,
//                         lm35Temperatura,
//                         fkEstufa
//                         from dado where fk_Estufa = ${idEstufa}
//                     order by id desc limit 1