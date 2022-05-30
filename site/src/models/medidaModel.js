var database = require("../database/config");

function buscarUltimasMedidas(idEstufa) {
    instrucaoSql = `SELECT dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, momento, FORMAT (momento,'dd-mm-yy,HH:mm:ss') AS momento FROM dado
    JOIN estufa ON fkEstufa = idEstufa 
    where idEstufa = ${idEstufa}
    order by idDado desc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function medidaskpi(idEstufa) {
    instrucaoSql = `SELECT max(dht11Umidade) AS umidade, max(lm35Temperatura) AS temperatura, max(luminosidade) AS luminosidade, momento, FORMAT  (momento,'dd-mm-yy,HH:mm:ss') AS momento FROM dado
    JOIN estufa ON fkEstufa = idEstufa 
    where idEstufa = ${idEstufa}
    order by idDado desc;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idEstufa) {
    instrucaoSql = `SELECT dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, momento, FORMAT (momento,'dd-mm-yy,HH:mm:ss') AS momento FROM dado
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