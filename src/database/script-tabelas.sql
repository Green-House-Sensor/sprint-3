CREATE DATABASE greenhouse;

USE greenhouse;

-- MY SQL WORKBENCH
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_razaosocial VARCHAR(45),
    dtNasc DATE,
    tipo CHAR(2),
    cpf_cnpj VARCHAR(14),
    CHECK (cpf_cnpj in('PF', 'PJ')),
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

CREATE TABLE sensor(
	idSensor INT AUTO_INCREMENT,
    fkEstufa INT,
    PRIMARY KEY (idSensor, fkEstufa),
    localizacao VARCHAR(45)
);

CREATE TABLE dado(
	idDado INT AUTO_INCREMENT,
    fkSensor INT,
    PRIMARY KEY(idDado, fkSensor),
    dht11Umidade DOUBLE,
    lm35Temperatura DOUBLE,
    luminosidade DOUBLE,
    FOREIGN KEY(fkSensor) REFERENCES sensor(idSensor)
);

DESC dado;

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

