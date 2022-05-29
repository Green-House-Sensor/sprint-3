CREATE DATABASE greenhouse;

USE greenhouse;

-- MY SQL WORKBENCH
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_razaosocial VARCHAR(45),
    dtNasc DATE,
    tipo CHAR(2),
    CHECK (tipo in('PF', 'PJ')),
    cpf_cnpj VARCHAR(14),
    cep CHAR(8),
    numero INT,
    email VARCHAR(60),
    senha VARCHAR(45),
    fkDependente INT,
    FOREIGN KEY (fkDependente) REFERENCES usuario(idUsuario)
);

CREATE TABLE estufa(
	idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(45),
    tempIdeal DOUBLE,
    umidIdeal DOUBLE,
    lumiIdeal DOUBLE,
    comprimento DOUBLE,
    largura DOUBLE
);


CREATE TABLE acesso(
	idAcesso INT AUTO_INCREMENT,
    fkUsuario INT,
    fkEstufa INT,
    PRIMARY KEY(idAcesso, fkUsuario, fkEstufa),
    momento DATETIME,
    FOREIGN KEY(fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY(fkEstufa) REFERENCES estufa(idEstufa)
);

CREATE TABLE dado(
	idDado INT AUTO_INCREMENT,
    fkEstufa INT,
    PRIMARY KEY(idDado, fkEstufa),
    dht11Umidade DOUBLE,
    lm35Temperatura DOUBLE,
    luminosidade DOUBLE,
    momento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(fkEstufa) REFERENCES estufa(idEstufa)
);

select dht11Umidade, lm35Temperatura, luminosidade FROM dado
JOIN sensor ON fkSensor = idSensor 
JOIN estufa ON fkEstufa = idEstufa where fkSensor = 1
                    order by idDado desc limit 7;
                    
SELECT MAX(lm35Temperatura) FROM dado
JOIN sensor ON fkSensor = idSensor 
JOIN estufa ON fkEstufa = idEstufa where fkSensor = 1
                    order by idDado desc limit 7;


SELECT MAX(lm35Temperatura) FROM dado;
SELECT * FROM estufa;
select * from sensor;
select * from acesso;

INSERT INTO estufa VALUES
(null, 'morango', 20, 50, 500, 10, 50);
INSERT INTO estufa VALUES
(null, 'alface', 20, 50, 500, 10, 50);

INSERT INTO acesso VALUES
(null, 1, 1, '2022-05-20 22:35:35');

INSERT INTO acesso VALUES
(null, 1, 2, '2022-05-20 22:35:35');

INSERT INTO dado(fkEstufa, dht11Umidade, lm35Temperatura, luminosidade) VALUES
(1, 500, 23, 700),
(2, 400, 20, 500),
(1, 700, 21, 600),
(2, 600, 25, 700);

SELECT * FROM dado;

INSERT INTO dado(fkEstufa, dht11Umidade, lm35Temperatura, luminosidade) VALUES
(1, 50, 23, 700),
(1, 40, 20, 500),
(1, 70, 21, 400),
(1, 60, 27, 900),
(1, 57, 26, 750),
(1, 48, 25, 530),
(1, 72, 24, 610),
(1, 61, 23, 780),
(1, 50, 21, 700),
(1, 45, 29, 520),
(1, 72, 31, 610),
(1, 68, 21, 760),
(1, 54, 27, 720),
(1, 40, 20, 560),
(1, 72, 26, 670),
(1, 67, 22, 740),
(1, 55, 29, 720),
(1, 42, 25, 580),
(1, 73, 21, 620),
(1, 65, 25, 710);

INSERT INTO dado(fkSensor, dht11Umidade, lm35Temperatura, luminosidade) VALUES
(1, 500, 37, 700);

INSERT INTO dado (fkSensor,dht11Umidade,lm35Temperatura, momento)
VALUES
  (1,346,34,"2022-09-20 10:44:09");

DESC dado;
use acquatec;
select MAX(dht11_temperatura) as temperatura, 
                        fk_aquario 
                        from medida where fk_aquario = 1
                    order by id desc limit 1;

-- MYSQL SERVER

-- CREATE TABLE usuario(
-- 	idUsuario INT PRIMARY KEY IDENTITY(1,1),
--     nome_razaosocial VARCHAR(45),
--     dtNasc DATE,
--     tipo CHAR(2),
--     cpf_cnpj VARCHAR(14),
--     CHECK (cpf_cnpj in('PF', 'PJ')),
--     email VARCHAR(60),
--     senha VARCHAR(45),
--     fkDependente INT,
--     FOREIGN KEY (fkDependente) REFERENCES usuario(idUsuario)
-- );

-- CREATE TABLE estufa(
-- 	idEstufa INT PRIMARY KEY IDENTITY(1,1),
--     produto VARCHAR(45),
--     tempIdeal DECIMAL,
--     umidIdeal DECIMAL,
--     lumiIdeal DECIMAL,
--     comprimento DECIMAL,
--     largura DECIMAL
-- );

-- CREATE TABLE acesso(
-- 	idAcesso INT IDENTITY(1,1),
--     fkUsuario INT,
--     fkEstufa INT,
--     PRIMARY KEY(idAcesso, fkUsuario, fkEstufa),
--     momento DATETIME,
--     FOREIGN KEY(fkUsuario) REFERENCES usuario(idUsuario),
--     FOREIGN KEY(fkEstufa) REFERENCES estufa(idEstufa)
-- );

-- CREATE TABLE sensor(
-- 	idSensor INT IDENTITY(1,1),
--     fkEstufa INT,
--     PRIMARY KEY (idSensor, fkEstufa),
--     localizacao VARCHAR(45)
-- );

-- CREATE TABLE dado(
-- 	idDado INT IDENTITY(1,1),
--     fkSensor INT,
--     PRIMARY KEY(idDado, fkSensor),
--     dht11Umidade DECIMAL,
--     lm35Temperatura DECIMAL,
--     luminosidade DECIMAL,
--     FOREIGN KEY(fkSensor) REFERENCES sensor(idSensor)
-- );

INSERT INTO dado (fkEstufa, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (1,83,96,773),
  (1,0,88,880),
  (1,99,90,678),
  (4,76,94,143),
  (2,65,52,377),
  (3,15,24,125),
  (2,6,92,140),
  (2,52,64,532),
  (2,80,59,983),
  (1,47,21,963);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (1,68,2,691),
  (4,18,75,849),
  (2,0,65,188),
  (3,8,62,244),
  (2,29,24,413),
  (2,1,92,942),
  (1,13,21,244),
  (3,46,45,407),
  (2,13,34,50),
  (4,27,77,591);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (1,85,21,519),
  (4,90,43,795),
  (4,16,3,630),
  (1,5,46,827),
  (1,99,65,0),
  (1,37,18,234),
  (4,36,54,605),
  (3,98,20,744),
  (4,70,46,705),
  (1,75,32,552);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (1,64,46,90),
  (3,13,37,219),
  (2,69,71,547),
  (4,63,16,787),
  (4,1,58,8),
  (1,11,84,436),
  (3,32,24,54),
  (2,93,94,906),
  (3,73,38,982),
  (2,30,20,551);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (4,25,56,388),
  (2,49,16,517),
  (0,58,26,97),
  (3,15,85,496),
  (1,56,93,779),
  (4,88,47,750),
  (1,1,44,953),
  (0,96,30,879),
  (2,73,6,188),
  (1,34,53,10);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (3,52,13,31),
  (0,15,29,5),
  (4,38,61,550),
  (1,46,39,573),
  (4,41,76,34),
  (1,55,65,185),
  (2,73,1,677),
  (3,96,100,248),
  (3,95,25,925),
  (3,62,1,330);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (0,2,1,841),
  (3,66,10,316),
  (3,7,57,466),
  (0,93,46,464),
  (3,45,37,882),
  (3,18,51,728),
  (1,23,66,1),
  (0,21,90,768),
  (3,24,90,62),
  (4,76,60,159);
  select * from estufa;
  select * from sensor;
  select * from dado;
  -- idEstufa, idDado, dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, momento, DATE_FORMAT  (momento,'%H:%i:%s') AS momento;
--   SELECT *  FROM dado
--                     JOIN sensor ON fkSensor = idSensor
--                     JOIN estufa ON fkEstufa = idEstufa
--                     where idEstufa = 2
--                     order by idDado desc limit 7;
                    
SELECT idEstufa, idDado, dht11Umidade AS umidade, lm35Temperatura AS temperatura, luminosidade AS luminosidade, momento, DATE_FORMAT  (momento,'%H:%i:%s') AS momento FROM dado
                    JOIN estufa ON fkEstufa = idEstufa 
                    where idEstufa = ${idEstufa}
                    order by idDado desc limit 7;
                    
SELECT MAX(dht11Umidade) AS umidade, MAX(lm35Temperatura) AS temperatura, MAX(luminosidade) AS luminosidade, momento, DATE_FORMAT  (momento,'%H:%i:%s') AS momento FROM dado
                    JOIN estufa ON fkEstufa = idEstufa 
                    where idEstufa = ${idEstufa}
                    order by idDado desc limit 7;

INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (3,18,93,384),
  (2,30,62,325),
  (1,75,89,71),
  (2,45,46,465),
  (4,21,72,951),
  (3,84,68,371),
  (3,51,3,144),
  (2,2,39,590),
  (4,53,26,798),
  (1,96,100,548);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (4,3,43,75),
  (1,78,94,653),
  (1,57,12,151),
  (4,38,90,98),
  (2,69,98,208),
  (1,66,85,33),
  (2,50,78,618),
  (1,73,46,795),
  (1,14,47,709),
  (1,80,55,322);
INSERT INTO dado (fkSensor, dht11Umidade, lm35Temperatura, luminosidade)
VALUES
  (3,79,93,477),
  (2,61,96,172),
  (3,34,22,437),
  (2,72,62,740),
  (3,51,51,159),
  (2,59,17,663),
  (2,24,86,226),
  (2,11,80,855),
  (4,14,4,281),
  (4,70,27,953);

INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (2,39,25,368),
  (2,44,37,986),
  (2,46,48,573),
  (2,29,86,994),
  (2,89,85,801),
  (2,39,91,241),
  (2,56,21,318),
  (2,42,66,845),
  (2,81,4,129),
  (2,38,50,492);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (2,53,55,978),
  (2,94,18,469),
  (2,39,88,86),
  (2,74,30,986),
  (2,28,78,39),
  (2,5,33,875),
  (2,78,46,337),
  (2,99,74,352),
  (2,36,100,118),
  (2,53,29,697);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (2,84,30,577),
  (2,27,66,981),
  (2,54,47,699),
  (2,74,88,411),
  (2,62,97,572),
  (2,51,72,29),
  (2,22,13,802),
  (2,35,40,941),
  (2,29,37,118),
  (2,84,14,424);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (2,16,30,38),
  (2,34,44,649),
  (2,93,87,697),
  (2,84,19,904),
  (2,26,29,154),
  (2,69,33,973),
  (2,40,41,408),
  (2,76,72,159),
  (2,66,59,317),
  (2,67,73,140);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (2,8,23,203),
  (2,84,81,269),
  (2,96,65,339),
  (2,0,96,779),
  (2,78,41,652),
  (2,62,3,495),
  (2,32,92,550),
  (2,87,18,268),
  (2,16,44,647),
  (2,33,77,992);
  
  INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,29,79,942),
  (3,31,72,809),
  (3,97,77,239),
  (3,12,25,635),
  (3,57,42,721),
  (3,57,19,279),
  (3,87,66,317),
  (3,51,82,613),
  (3,56,87,537),
  (3,21,64,182);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,18,23,929),
  (3,96,90,234),
  (3,35,66,145),
  (3,34,12,117),
  (3,15,62,685),
  (3,45,74,333),
  (3,25,29,175),
  (3,60,37,968),
  (3,95,52,595),
  (3,48,71,507);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,96,28,157),
  (3,16,10,538),
  (3,67,16,408),
  (3,23,91,246),
  (3,56,100,944),
  (3,93,20,212),
  (3,57,85,921),
  (3,30,49,588),
  (3,97,81,233),
  (3,80,22,346);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,18,69,269),
  (3,82,36,706),
  (3,57,24,321),
  (3,39,78,553),
  (3,40,30,516),
  (3,52,51,301),
  (3,26,39,524),
  (3,53,67,590),
  (3,22,97,881),
  (3,45,16,248);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,55,92,581),
  (3,16,57,265),
  (3,14,95,752),
  (3,65,49,734),
  (3,78,77,577),
  (3,79,24,596),
  (3,82,61,262),
  (3,62,70,292),
  (3,96,12,744),
  (3,59,33,195);
INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (3,46,40,997),
  (3,84,60,312),
  (3,89,26,689),
  (3,64,93,694),
  (3,20,86,222),
  (3,23,63,433),
  (3,32,12,249),
  (3,94,51,906),
  (3,33,75,969),
  (3,16,77,266);
