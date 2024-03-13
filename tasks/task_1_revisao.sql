-- funcionario
CREATE TABLE Funcionario (
id_funcionario INT NOT NULL PRIMARY KEY,
nm_funcionario VARCHAR2(60) NOT NULL
);

-- inserindo registro no funcionario
INSERT INTO Funcionario (id_funcionario, nm_funcionario) VALUES (1, 'João Silva');
INSERT INTO Funcionario (id_funcionario, nm_funcionario) VALUES (2, 'Maria Oliveira');
INSERT INTO Funcionario (id_funcionario, nm_funcionario) VALUES (3, 'Pedro Santos');
INSERT INTO Funcionario (id_funcionario, nm_funcionario) VALUES (4, 'Ana Pereira');
INSERT INTO Funcionario (id_funcionario, nm_funcionario) VALUES (5, 'Carlos Souza');

-- pedidos
CREATE TABLE Pedidos(
id_pedido NUMBER PRIMARY KEY,
dt_pedido DATE,
nm_prato VARCHAR2(60 CHAR) NOT NULL,
nm_bebida VARCHAR2(60 CHAR) NOT NULL,
id_funcionario NUMBER NOT NULL,
CONSTRAINT FK_Funcionario FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario)
);

-- inserindo registros nos Pedidos

INSERT INTO Pedidos (id_pedido, dt_pedido, nm_prato, nm_bebida, id_funcionario)
VALUES (1, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Pizza Margherita', 'Coca-Cola', 1);
INSERT INTO Pedidos (id_pedido, dt_pedido, nm_prato, nm_bebida, id_funcionario)
VALUES (2, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Hambúrguer', 'Suco de Laranja', 2);
INSERT INTO Pedidos (id_pedido, dt_pedido, nm_prato, nm_bebida, id_funcionario)
VALUES (3, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Salada Caesar', 'Água Mineral', 3);
INSERT INTO Pedidos (id_pedido, dt_pedido, nm_prato, nm_bebida, id_funcionario)
VALUES (4, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Sushi Combo', 'Chá Verde', 4);
INSERT INTO Pedidos (id_pedido, dt_pedido, nm_prato, nm_bebida, id_funcionario)
VALUES (5, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 'Lasanha', 'Vinho Tinto', 5);

-- mesa
CREATE TABLE Mesa (
ID_numeroMesa INT PRIMARY KEY,
qt_numeroLugar NUMBER,
ds_localizacao VARCHAR(50),
id_pedido NUMBER,
FOREIGN KEY (id_pedido) REFERENCES Pedidos (id_pedido)
);

-- inserindo Registros da Mesa
INSERT INTO Mesa (ID_numeroMesa, qt_numeroLugar, ds_localizacao, id_pedido)
VALUES (1, 4, 'Perto da janela', 1);

INSERT INTO Mesa (ID_numeroMesa, qt_numeroLugar, ds_localizacao, id_pedido)
VALUES (2, 6, 'Na área externa', 2);

INSERT INTO Mesa (ID_numeroMesa, qt_numeroLugar, ds_localizacao, id_pedido)
VALUES (3, 2, 'Ao lado do bar', 3);

INSERT INTO Mesa (ID_numeroMesa, qt_numeroLugar, ds_localizacao, id_pedido)
VALUES (4, 8, 'No centro do restaurante', 4);

INSERT INTO Mesa (ID_numeroMesa, qt_numeroLugar, ds_localizacao, id_pedido)
VALUES (5, 4, 'Na área de fumantes', 5);

-- clientes
CREATE TABLE Clientes (
id_cliente NUMBER PRIMARY KEY,
nm_cliente VARCHAR2(60 CHAR) NOT NULL,
dt_nascimento_cliente DATE,
tel_cliente NUMBER NOT NULL,
nm_email_cliente VARCHAR2(100 CHAR) NOT NULL,
cd_cpf_cliente VARCHAR2(20) NOT NULL,
cd_cep_cliente VARCHAR2(20) NOT NULL,
num_endereco_cliente NUMBER NOT NULL,
nm_complemento_cliente VARCHAR2(100 CHAR),
id_pedido NUMBER,
id_numeroMesa NUMBER,
CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos (id_pedido),
CONSTRAINT fk_Mesa FOREIGN KEY (id_numeroMesa) REFERENCES Mesa (ID_numeroMesa)
);

-- inserindo na tabela Clientes
INSERT INTO Clientes (id_cliente, nm_cliente, dt_nascimento_cliente, tel_cliente,
nm_email_cliente, cd_cpf_cliente, cd_cep_cliente, num_endereco_cliente,
nm_complemento_cliente, id_pedido, id_numeroMesa)
VALUES (1, 'Fernanda Oliveira', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 1234567890,
'fernanda@example.com', '123.456.789-00', '12345-678', 123, 'Apartamento 101', 1, 1);

INSERT INTO Clientes (id_cliente, nm_cliente, dt_nascimento_cliente, tel_cliente,
nm_email_cliente, cd_cpf_cliente, cd_cep_cliente, num_endereco_cliente,
nm_complemento_cliente, id_pedido, id_numeroMesa)
VALUES (2, 'Ricardo Silva', TO_DATE('1985-08-20', 'YYYY-MM-DD'), 987654321,
'ricardo@example.com', '987.654.321-00', '98765-432', 456, 'Sala 2', 2, 2);

INSERT INTO Clientes (id_cliente, nm_cliente, dt_nascimento_cliente, tel_cliente,
nm_email_cliente, cd_cpf_cliente, cd_cep_cliente, num_endereco_cliente,
nm_complemento_cliente, id_pedido, id_numeroMesa)
VALUES (3, 'Amanda Souza', TO_DATE('1992-03-10', 'YYYY-MM-DD'), 456123789,
'amanda@example.com', '456.123.789-00', '45678-912', 789, NULL, 3, 3);

INSERT INTO Clientes (id_cliente, nm_cliente, dt_nascimento_cliente, tel_cliente,
nm_email_cliente, cd_cpf_cliente, cd_cep_cliente, num_endereco_cliente,
nm_complemento_cliente, id_pedido, id_numeroMesa)
VALUES (4, 'Lucas Santos', TO_DATE('1988-11-25', 'YYYY-MM-DD'), 789123456,
'lucas@example.com', '789.123.456-00', '78901-234', 1011, 'Bloco A', 4, 4);

INSERT INTO Clientes (id_cliente, nm_cliente, dt_nascimento_cliente, tel_cliente,
nm_email_cliente, cd_cpf_cliente, cd_cep_cliente, num_endereco_cliente,
nm_complemento_cliente, id_pedido, id_numeroMesa)
VALUES (5, 'Juliana Pereira', TO_DATE('1995-06-30', 'YYYY-MM-DD'), 321654987,
'juliana@example.com', '321.654.987-00', '32109-876', 1213, 'Casa 3', 5, 5);

-- tipo Ingrediente
CREATE TABLE TIPO_INGREDIENTE(
cd_tipo_ingrediente INTEGER PRIMARY KEY,
nm_tipo_ingrediente VARCHAR(30) NOT NULL
)
  
-- insert na tabela Tipo Ingrediente
INSERT INTO TIPO_INGREDIENTE (cd_tipo_ingrediente, nm_tipo_ingrediente) VALUES (1, 'Grãos');

INSERT INTO TIPO_INGREDIENTE (cd_tipo_ingrediente, nm_tipo_ingrediente) VALUES (2, 'Vegetais');

INSERT INTO TIPO_INGREDIENTE (cd_tipo_ingrediente, nm_tipo_ingrediente) VALUES (3, 'Frutas');

INSERT INTO TIPO_INGREDIENTE (cd_tipo_ingrediente, nm_tipo_ingrediente) VALUES (4, 'Carnes');

INSERT INTO TIPO_INGREDIENTE (cd_tipo_ingrediente, nm_tipo_ingrediente) VALUES (5, 'Laticínios');

-- fornecedor
CREATE TABLE FORNECEDOR (
cd_fornecedor INT NOT NULL,
nm_fornecedor VARCHAR2(100) NOT NULL,
cd_telefone_fornecedor VARCHAR2(20) NOT NULL,
cd_cnpj VARCHAR2(14) NOT NULL, constraint FORNECEDOR_PK PRIMARY KEY (cd_fornecedor)
);

-- insert na tabela Fornecedor
INSERT INTO FORNECEDOR (cd_fornecedor, nm_fornecedor, cd_telefone_fornecedor, cd_cnpj)
VALUES (1, 'Fornecedor A', '1234567890', '12345678901234');

INSERT INTO FORNECEDOR (cd_fornecedor, nm_fornecedor, cd_telefone_fornecedor, cd_cnpj)
VALUES (2, 'Fornecedor B', '0987654321', '98765432109876');

INSERT INTO FORNECEDOR (cd_fornecedor, nm_fornecedor, cd_telefone_fornecedor, cd_cnpj)
VALUES (3, 'Fornecedor C', '1112223334', '11122233344455');

INSERT INTO FORNECEDOR (cd_fornecedor, nm_fornecedor, cd_telefone_fornecedor, cd_cnpj)
VALUES (4, 'Fornecedor D', '4445556667', '44455566677788');

INSERT INTO FORNECEDOR (cd_fornecedor, nm_fornecedor, cd_telefone_fornecedor, cd_cnpj)
VALUES (5, 'Fornecedor E', '7778889990', '77788899900011');

-- ingredientes
CREATE TABLE INGREDIENTE (
cd_ingrediente INTEGER PRIMARY KEY,
nm_ingrediente VARCHAR2(20) NOT NULL,
dt_validade_ingrediente DATE NOT NULL,
qt_ingrediente INTEGER NOT NULL,
dt_recebimento_ingrediente DATE NOT NULL,
fk_tipo_ingrediente INTEGER NOT NULL,
fk_fornecedor INTEGER NOT NULL,
cd_tipo_ingrediente NUMBER,
cd_fornecedor NUMBER,
CONSTRAINT fk_tipo_ingrediente FOREIGN KEY (fk_tipo_ingrediente) REFERENCES TIPO_INGREDIENTE (cd_tipo_ingrediente),
CONSTRAINT fk_fornecedor FOREIGN KEY (fk_fornecedor) REFERENCES FORNECEDOR (cd_fornecedor)
);

-- inserindo na tabela Ingredientes
INSERT INTO INGREDIENTE (cd_ingrediente, nm_ingrediente, dt_validade_ingrediente,
qt_ingrediente, dt_recebimento_ingrediente, fk_tipo_ingrediente, fk_fornecedor)
VALUES (1, 'Farinha de Trigo', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 100, TO_DATE('2024-03-12',
'YYYY-MM-DD'), 1, 1);

INSERT INTO INGREDIENTE (cd_ingrediente, nm_ingrediente, dt_validade_ingrediente,
qt_ingrediente, dt_recebimento_ingrediente, fk_tipo_ingrediente, fk_fornecedor)
VALUES (2, 'Tomate', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 50, TO_DATE('2024-03-10', 'YYYY-MMDD'), 2, 2);

INSERT INTO INGREDIENTE (cd_ingrediente, nm_ingrediente, dt_validade_ingrediente,
qt_ingrediente, dt_recebimento_ingrediente, fk_tipo_ingrediente, fk_fornecedor)
VALUES (3, 'Maçã', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 30, TO_DATE('2024-03-08', 'YYYY-MMDD'), 3, 3);

INSERT INTO INGREDIENTE (cd_ingrediente, nm_ingrediente, dt_validade_ingrediente,
qt_ingrediente, dt_recebimento_ingrediente, fk_tipo_ingrediente, fk_fornecedor)
VALUES (4, 'Carne Bovina', TO_DATE('2024-03-25', 'YYYY-MM-DD'), 80, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 4, 4);

INSERT INTO INGREDIENTE (cd_ingrediente, nm_ingrediente, dt_validade_ingrediente,
qt_ingrediente, dt_recebimento_ingrediente, fk_tipo_ingrediente, fk_fornecedor)
VALUES (5, 'Queijo Mussarela', TO_DATE('2024-03-18', 'YYYY-MM-DD'), 40, TO_DATE('2024-03-03', 'YYYY-MM-DD'), 5, 5);

-- pedido Fornecedor
CREATE TABLE PEDIDO_FORNECEDOR (
cd_pedido_fornecedor INT NOT NULL,
dt_pedido_fornecedor TIMESTAMP NOT NULL,
vl_total_pedido_fornecedor DECIMAL NOT NULL,
ds_observacao_pedido_fornecedor VARCHAR2(255) NOT NULL,
cd_nfe_pedido_fornecedor VARCHAR2(50) NOT NULL,
dt_entrega_pedido_fornecedor TIMESTAMP NOT NULL,
cd_fornecedor INT NOT NULL,
constraint PEDIDO_FORNECEDOR_PK PRIMARY KEY (cd_pedido_fornecedor)
);

-- inserir na tabela Pedido Fornecedor
INSERT INTO PEDIDO_FORNECEDOR (cd_pedido_fornecedor, dt_pedido_fornecedor,
vl_total_pedido_fornecedor, ds_observacao_pedido_fornecedor, cd_nfe_pedido_fornecedor,
dt_entrega_pedido_fornecedor, cd_fornecedor)
VALUES (1, CURRENT_TIMESTAMP, 150.50, 'Urgente: Entregar o mais rápido possível.', '123456789', CURRENT_TIMESTAMP, 1);

INSERT INTO PEDIDO_FORNECEDOR (cd_pedido_fornecedor, dt_pedido_fornecedor,
vl_total_pedido_fornecedor, ds_observacao_pedido_fornecedor, cd_nfe_pedido_fornecedor,
dt_entrega_pedido_fornecedor, cd_fornecedor)
VALUES (2, CURRENT_TIMESTAMP, 200.00, 'Favor entregar na portaria.', '987654321', CURRENT_TIMESTAMP, 2);

INSERT INTO PEDIDO_FORNECEDOR (cd_pedido_fornecedor, dt_pedido_fornecedor,
vl_total_pedido_fornecedor, ds_observacao_pedido_fornecedor, cd_nfe_pedido_fornecedor,
dt_entrega_pedido_fornecedor, cd_fornecedor)
VALUES (3, CURRENT_TIMESTAMP, 300.75, 'Favor ligar antes de entregar.', '111222333', CURRENT_TIMESTAMP, 3);

INSERT INTO PEDIDO_FORNECEDOR (cd_pedido_fornecedor, dt_pedido_fornecedor,
vl_total_pedido_fornecedor, ds_observacao_pedido_fornecedor, cd_nfe_pedido_fornecedor,
dt_entrega_pedido_fornecedor, cd_fornecedor)
VALUES (4, CURRENT_TIMESTAMP, 180.25, 'Entregar apenas de manhã.', '444555666', CURRENT_TIMESTAMP, 4);

INSERT INTO PEDIDO_FORNECEDOR (cd_pedido_fornecedor, dt_pedido_fornecedor,
vl_total_pedido_fornecedor, ds_observacao_pedido_fornecedor, cd_nfe_pedido_fornecedor,
dt_entrega_pedido_fornecedor, cd_fornecedor)
VALUES (5, CURRENT_TIMESTAMP, 250.00, 'Entregar na recepção.', '777888999', CURRENT_TIMESTAMP, 5);

-- pedido Forcenedor Cliente
CREATE TABLE PEDIDO_FORNECEDOR_INGREDIENTE (
cd_pedido_fornecedor_ingrediente INT NOT NULL,
cd_pedido_fornecedor INT NOT NULL,
qt_pedido_fornecedor_ingrediente FLOAT NOT NULL,
vl_unitario_pedido_fornecedor_ingrediente DECIMAL NOT NULL,
id_ingrediente INT NOT NULL,
constraint PEDIDO_FORNECEDOR_INGREDIENTE_PK PRIMARY KEY (cd_pedido_fornecedor_ingrediente)
);

-- inserir na tabela Pedido Fornecedor Cliente
INSERT INTO PEDIDO_FORNECEDOR_INGREDIENTE (cd_pedido_fornecedor_ingrediente,
cd_pedido_fornecedor, qt_pedido_fornecedor_ingrediente,
vl_unitario_pedido_fornecedor_ingrediente, id_ingrediente)
VALUES (1, 1, 10.0, 5.0, 1);

INSERT INTO PEDIDO_FORNECEDOR_INGREDIENTE (cd_pedido_fornecedor_ingrediente,
cd_pedido_fornecedor, qt_pedido_fornecedor_ingrediente,
vl_unitario_pedido_fornecedor_ingrediente, id_ingrediente)
VALUES (2, 2, 8.0, 4.0, 2);

INSERT INTO PEDIDO_FORNECEDOR_INGREDIENTE (cd_pedido_fornecedor_ingrediente,
cd_pedido_fornecedor, qt_pedido_fornecedor_ingrediente,
vl_unitario_pedido_fornecedor_ingrediente, id_ingrediente)
VALUES (3, 3, 15.0, 3.0, 3);

INSERT INTO PEDIDO_FORNECEDOR_INGREDIENTE (cd_pedido_fornecedor_ingrediente,
cd_pedido_fornecedor, qt_pedido_fornecedor_ingrediente,
vl_unitario_pedido_fornecedor_ingrediente, id_ingrediente)
VALUES (4, 4, 12.0, 6.0, 4);

INSERT INTO PEDIDO_FORNECEDOR_INGREDIENTE (cd_pedido_fornecedor_ingrediente,
cd_pedido_fornecedor, qt_pedido_fornecedor_ingrediente,
vl_unitario_pedido_fornecedor_ingrediente, id_ingrediente)
VALUES (5, 5, 20.0, 8.0, 5);

-- Ingrediente F3
CREATE TABLE INGREDIENTE_F3 (
id_ingrediente INT NOT NULL,
constraint INGREDIENTE_PK PRIMARY KEY (id_ingrediente)
);

-- inserir na tabela Ingrediente F3
INSERT INTO INGREDIENTE_F3 (id_ingrediente) VALUES (1);

INSERT INTO INGREDIENTE_F3 (id_ingrediente) VALUES (2);

INSERT INTO INGREDIENTE_F3 (id_ingrediente) VALUES (3);

INSERT INTO INGREDIENTE_F3 (id_ingrediente) VALUES (4);

INSERT INTO INGREDIENTE_F3 (id_ingrediente) VALUES (5);

-- criar uma consulta com junção de tabelas
SELECT pf.cd_pedido_fornecedor, pf.dt_pedido_fornecedor, pf.vl_total_pedido_fornecedor,
pfi.cd_pedido_fornecedor_ingrediente, pfi.qt_pedido_fornecedor_ingrediente,
pfi.vl_unitario_pedido_fornecedor_ingrediente,
i.nm_ingrediente, i.dt_validade_ingrediente
FROM PEDIDO_FORNECEDOR pf
JOIN PEDIDO_FORNECEDOR_INGREDIENTE pfi ON pf.cd_pedido_fornecedor = pfi.cd_pedido_fornecedor
JOIN INGREDIENTE i ON pfi.id_ingrediente = i.cd_ingrediente;

-- criar uma consulta com função de grupo
SELECT f.nm_fornecedor, COUNT(pf.cd_pedido_fornecedor) AS total_pedidos
FROM PEDIDO_FORNECEDOR pf
JOIN FORNECEDOR f ON pf.cd_fornecedor = f.cd_fornecedor
GROUP BY f.nm_fornecedor;
