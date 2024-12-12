CREATE DATABASE RosaPlane;
USE RosaPlane;

CREATE TABLE Destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nome_destino VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    descricao TEXT
);

CREATE TABLE Pacotes (
    id_pacote INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    nome_pacote VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    FOREIGN KEY (id_destino) REFERENCES Destinos(id_destino)
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco TEXT
);

CREATE TABLE Reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_pacote INT NOT NULL,
    data_reserva DATE NOT NULL,
    numero_pessoas INT NOT NULL,
    status_reserva ENUM('confirmada', 'pendente', 'cancelada') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_pacote) REFERENCES Pacotes(id_pacote)
);

CREATE INDEX idx_cliente_reservas ON Reservas(id_cliente);
CREATE INDEX idx_pacote_reservas ON Reservas(id_pacote);
CREATE INDEX idx_destino_pacotes ON Pacotes(id_destino);

CREATE VIEW PacotesDisponiveis AS
SELECT 
    p.id_pacote, 
    p.nome_pacote, 
    p.preco, 
    p.data_inicio, 
    p.data_termino, 
    d.nome_destino, 
    d.pais
FROM 
    Pacotes p
JOIN 
    Destinos d ON p.id_destino = d.id_destino;

CREATE VIEW ReservasPorCliente AS
SELECT 
    r.id_reserva, 
    r.data_reserva, 	
    r.numero_pessoas, 
    r.status_reserva, 
    p.nome_pacote, 
    p.preco, 
    d.nome_destino
FROM 
    Reservas r
JOIN 
    Pacotes p ON r.id_pacote = p.id_pacote
JOIN 
    Destinos d ON p.id_destino = d.id_destino;


-- Inserir dados na tabela Destinos
INSERT INTO Destinos (nome_destino, pais, descricao)
VALUES 
('Paris', 'França', 'Cidade das luzes, conhecida por sua cultura e monumentos históricos como a Torre Eiffel'),
('Roma', 'Itália', 'Cidade famosa por suas ruínas históricas e arquitetura antiga como o Coliseu'),
('Tóquio', 'Japão', 'Capital do Japão, conhecida pela fusão entre tradição e tecnologia moderna');

-- Inserir dados na tabela Pacotes
INSERT INTO Pacotes (id_destino, nome_pacote, preco, data_inicio, data_termino)
VALUES 
(1, 'Tour pela Torre Eiffel', 1500.00, '2024-01-01', '2024-01-07'),
(2, 'Exploração da Roma Antiga', 1200.00, '2024-02-01', '2024-02-07'),
(3, 'Tecnologia e Tradição em Tóquio', 2000.00, '2024-03-01', '2024-03-07');

-- Inserir dados na tabela Clientes
INSERT INTO Clientes (nome_cliente, email, telefone, endereco)
VALUES 
('Carlos Silva', 'carlos@email.com', '11987654321', 'Rua das Flores, 123'),
('Ana Oliveira', 'ana@email.com', '21987654321', 'Avenida Central, 456'),
('João Pereira', 'joao@email.com', '31987654321', 'Rua do Sol, 789');

-- Inserir dados na tabela Reservas
INSERT INTO Reservas (id_cliente, id_pacote, data_reserva, numero_pessoas, status_reserva)
VALUES 
(1, 1, '2023-12-15', 2, 'confirmada'),
(2, 2, '2023-12-16', 4, 'pendente'),
(3, 3, '2023-12-17', 1, 'cancelada');
