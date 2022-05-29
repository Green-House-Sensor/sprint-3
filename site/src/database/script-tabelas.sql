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
INSERT INTO estufa VALUES
(null, 'cenoura', 23, 40, 700, 10, 40);
INSERT INTO estufa VALUES
(null, 'abóbora', 23, 40, 700, 10, 40);

INSERT INTO acesso VALUES
(null, 1, 1, '2022-05-20 22:35:35'),
(null, 1, 2, '2022-05-20 22:35:35'),
(null, 1, 3, '2022-05-20 22:35:35'),
(null, 1, 4, '2022-05-20 22:35:35');


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
  (2,38,50,492),
  (2,53,55,978),
  (2,94,18,469),
  (2,39,88,86),
  (2,74,30,986),
  (2,28,78,39),
  (2,5,33,875),
  (2,78,46,337),
  (2,99,74,352),
  (2,36,100,118),
  (2,53,29,697),
  (2,84,30,577),
  (2,27,66,981),
  (2,54,47,699),
  (2,74,88,411),
  (2,62,97,572),
  (2,51,72,29),
  (2,22,13,802),
  (2,35,40,941),
  (2,29,37,118),
  (2,84,14,424),
  (2,16,30,38),
  (2,34,44,649),
  (2,93,87,697),
  (2,84,19,904),
  (2,26,29,154),
  (2,69,33,973),
  (2,40,41,408),
  (2,76,72,159),
  (2,66,59,317),
  (2,67,73,140),
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
  (3,21,64,182),
  (3,18,23,929),
  (3,96,90,234),
  (3,35,66,145),
  (3,34,12,117),
  (3,15,62,685),
  (3,45,74,333),
  (3,25,29,175),
  (3,60,37,968),
  (3,95,52,595),
  (3,48,71,507),
  (3,96,28,157),
  (3,16,10,538),
  (3,67,16,408),
  (3,23,91,246),
  (3,56,100,944),
  (3,93,20,212),
  (3,57,85,921),
  (3,30,49,588),
  (3,97,81,233),
  (3,80,22,346),
  (3,18,69,269),
  (3,82,36,706),
  (3,57,24,321),
  (3,39,78,553),
  (3,40,30,516),
  (3,52,51,301),
  (3,26,39,524),
  (3,53,67,590),
  (3,22,97,881),
  (3,45,16,248),
  (3,55,92,581),
  (3,16,57,265),
  (3,14,95,752),
  (3,65,49,734),
  (3,78,77,577),
  (3,79,24,596),
  (3,82,61,262),
  (3,62,70,292),
  (3,96,12,744),
  (3,59,33,195),
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
  
  INSERT INTO dado (fkEstufa,dht11Umidade,lm35Temperatura,luminosidade)
VALUES
  (4,66,13,978),
  (4,73,65,417),
  (4,24,44,541),
  (4,25,62,627),
  (4,55,14,882),
  (4,93,56,992),
  (4,75,93,653),
  (4,35,60,957),
  (4,76,26,575),
  (4,70,71,234),
  (4,21,94,418),
  (4,18,61,757),
  (4,74,67,687),
  (4,75,31,205),
  (4,79,55,450),
  (4,85,89,256),
  (4,73,90,219),
  (4,35,47,815),
  (4,25,16,613),
  (4,24,59,934),
  (4,98,90,455),
  (4,46,26,304),
  (4,73,30,295),
  (4,80,82,941),
  (4,44,89,729),
  (4,68,51,757),
  (4,89,28,844),
  (4,40,26,512),
  (4,47,58,529),
  (4,88,53,786),
  (4,86,26,703),
  (4,68,78,213),
  (4,100,80,341),
  (4,23,57,690),
  (4,96,57,793),
  (4,71,19,290),
  (4,71,41,641),
  (4,31,87,232),
  (4,60,92,602),
  (4,67,28,932),
  (4,71,77,436),
  (4,25,43,486),
  (4,89,29,708),
  (4,69,90,279),
  (4,31,29,437),
  (4,45,17,536),
  (4,45,46,522),
  (4,15,16,521),
  (4,38,26,226),
  (4,15,92,250),
  (4,25,39,742),
  (4,29,34,276),
  (4,54,86,436),
  (4,79,69,798),
  (4,13,26,872),
  (4,60,20,998),
  (4,42,83,960),
  (4,36,29,763),
  (4,38,17,221),
  (4,45,89,785);
