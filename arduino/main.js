const serialport = require('serialport');
const express = require('express');
const mysql = require('mysql2');
const sql = require('mssql');

const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;
const HABILITAR_OPERACAO_INSERIR = true;


// escolha deixar a linha 'desenvolvimento' descomentada se quiser conectar seu arduino ao banco de dados local, MySQL Workbench
// const AMBIENTE = 'desenvolvimento';

// escolha deixar a linha 'producao' descomentada se quiser conectar seu arduino ao banco de dados remoto, SQL Server
const AMBIENTE = 'producao';

const serial = async (
    valoresDht11Umidade,
    // valoresDht11Temperatura,
    valoresLm35Temperatura,
    valoresLuminosidade
    
    // valoresChave
) => {
    let poolBancoDados = ''

    if (AMBIENTE == 'desenvolvimento') {
        poolBancoDados = mysql.createPool(
            {
                // CREDENCIAIS DO BANCO LOCAL - MYSQL WORKBENCH
                host: 'localhost',
                user: 'root',
                password: '67578900',
                database: 'greenhouse'
            }
        ).promise();
    } else if (AMBIENTE == 'producao') {

        console.log('Projeto rodando inserindo dados em nuvem. Configure as credenciais abaixo.')

    } else {
        throw new Error('Ambiente não configurado. Verifique o arquivo "main.js" e tente novamente.');
    }


    const portas = await serialport.SerialPort.list();
    const portaArduino = portas.find((porta) => porta.vendorId == 2341 && porta.productId == 43);
    if (!portaArduino) {
        throw new Error('O arduino não foi encontrado em nenhuma porta serial');
    }
    const arduino = new serialport.SerialPort(
        {
            path: portaArduino.path,
            baudRate: SERIAL_BAUD_RATE
        }
    );
    arduino.on('open', () => {
        console.log(`A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`);
    });
    arduino.pipe(new serialport.ReadlineParser({ delimiter: '\r\n' })).on('data', async (data) => {
        const valores = data.split(';');
        const dht11Umidade = parseFloat(valores[0]);
        // const dht11Temperatura = parseFloat(valores[1]);
        const lm35Temperatura = parseFloat(valores[3]);
        const luminosidade = parseFloat(valores[2]);
        // const chave = parseInt(valores[4]);

        valoresDht11Umidade.push(dht11Umidade);
        // valoresDht11Temperatura.push(dht11Temperatura);
        valoresLm35Temperatura.push(lm35Temperatura);
        valoresLuminosidade.push(luminosidade);
        // valoresChave.push(chave);

        if (HABILITAR_OPERACAO_INSERIR) {

            if (AMBIENTE == 'producao') {

                // Este insert irá inserir os dados na tabela "medida" -> altere se necessário
                // Este insert irá inserir dados de fk_aquario id=1 >> você deve ter o aquario de id 1 cadastrado.
                sqlquery =    `INSERT INTO dado(fkEstufa, dht11Umidade, lm35Temperatura, luminosidade) VALUES
                ( ${(Math.random()*3+1).toFixed(0)} , ${dht11Umidade},${luminosidade}, ${lm35Temperatura})`
                // CREDENCIAIS DO BANCO REMOTO - SQL SERVER
                const connStr = "Server=svr-1adsb-grupo7.database.windows.net;Database=grupo7;User Id=admin-1adsb-grupo07;Password=#Gfgrupo7;";


                function inserirComando(conn, sqlquery) {
                    conn.query(sqlquery);
                    console.log("valores inseridos no banco: ", dht11Umidade + ", " + luminosidade + ", " + lm35Temperatura)
                }

                sql.connect(connStr)
                    .then(conn => inserirComando(conn, sqlquery))
                    .catch(err => console.log("erro! " + err));

            } else if (AMBIENTE == 'desenvolvimento') {

                // Este insert irá inserir os dados na tabela "medida" -> altere se necessário
                // Este insert irá inserir dados de fk_aquario id=1 >> você deve ter o aquario de id 1 cadastrado.
                await poolBancoDados.execute(
                    `INSERT INTO dado(fkEstufa, dht11Umidade, lm35Temperatura, luminosidade) VALUES (${(Math.random()*3+1).toFixed(0)}, ?, ?, ?)`,
                    [dht11Umidade, luminosidade, lm35Temperatura]
                );
                console.log("valores inseridos no banco: ", dht11Umidade + ", " + lm35Temperatura + ", " + luminosidade)

            } else {
                throw new Error('Ambiente não configurado. Verifique o arquivo "main.js" e tente novamente.');
            }

        }

    });
    arduino.on('error', (mensagem) => {
        console.error(`Erro no arduino (Mensagem: ${mensagem}`)
    });
}

const servidor = (
    valoresDht11Umidade,
    // valoresDht11Temperatura,
    valoresLm35Temperatura,
    valoresLuminosidade
    
    // valoresChave
) => {
    const app = express();
    app.use((request, response, next) => {
        response.header('Access-Control-Allow-Origin', '*');
        response.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
        next();
    });
    app.listen(SERVIDOR_PORTA, () => {
        console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
    });
    app.get('/sensores/dht11/umidade', (_, response) => {
        return response.json(valoresDht11Umidade);
    });
    // app.get('/sensores/dht11/temperatura', (_, response) => {
    //     return response.json(valoresDht11Temperatura);
    // });
    app.get('/sensores/lm35/temperatura', (_, response) => {
        return response.json(valoresLm35Temperatura);
    });
    app.get('/sensores/luminosidade', (_, response) => {
        return response.json(valoresLuminosidade);
    });
    // app.get('/sensores/chave', (_, response) => {
    //     return response.json(valoresChave);
    // });
}

(async () => {
    const valoresDht11Umidade = [];
    // const valoresDht11Temperatura = [];
    const valoresLm35Temperatura = [];
    const valoresLuminosidade = [];  
    // const valoresChave = [];
    await serial(
        valoresDht11Umidade,
        // valoresDht11Temperatura,
        valoresLm35Temperatura,
        valoresLuminosidade
        // valoresChave
    );
    servidor(
        valoresDht11Umidade,
        // valoresDht11Temperatura,
        valoresLm35Temperatura,
        valoresLuminosidade
        // valoresChave
    );
})();
