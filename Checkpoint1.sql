DROP DATABASE IF EXISTS videojocs_db;
CREATE DATABASE videojocs_db;
USE videojocs_db;

CREATE TABLE IF NOT EXISTS VideoJoc (
    id_videojoc INT AUTO_INCREMENT PRIMARY KEY, 
    titul VARCHAR(100) NOT NULL,                
    genere VARCHAR(50),                         
    preu INT                         
);

CREATE TABLE IF NOT EXISTS Garantia (
    id_garantia INT AUTO_INCREMENT PRIMARY KEY, 
    valida VARCHAR(10),                         
    fecha VARCHAR(10),                          
    id_videojoc INT,                            
    FOREIGN KEY (id_videojoc) REFERENCES VideoJoc(id_videojoc) ON DELETE CASCADE
);

-- Crea la taula Dessarrollador
CREATE TABLE IF NOT EXISTS Dessarrollador ( 
    id_dessarrollador INT AUTO_INCREMENT PRIMARY KEY, -- Identificador únic per a cada desenvolupador
    nom VARCHAR(100) NOT NULL,                        -- Nom del desenvolupador
    pais VARCHAR(50) NOT NULL,                        -- País del desenvolupador
    id_videojoc INT,                                  -- Clau forana cap a VideoJoc
    FOREIGN KEY (id_videojoc) REFERENCES VideoJoc(id_videojoc) ON DELETE SET NULL -- Relació 1:N amb VideoJoc
);

-- Crea la taula Jugador
CREATE TABLE IF NOT EXISTS Jugador (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY, -- Identificador únic per a cada jugador
    nom VARCHAR(100) NOT NULL,                  -- Nom del jugador
    correu VARCHAR(100) NOT NULL UNIQUE         -- Correu electrònic del jugador
);

-- Crea la taula Compra (relació M:N entre Jugador i VideoJoc)
CREATE TABLE IF NOT EXISTS Compra (
    id_jugador INT,                              -- Clau forana cap a Jugador
    id_videojoc INT,                             -- Clau forana cap a VideoJoc
    PRIMARY KEY (id_jugador, id_videojoc),      -- Clau primària composta per ambdues claus foranes
    FOREIGN KEY (id_jugador) REFERENCES Jugador(id_jugador), -- Relació amb Jugador
    FOREIGN KEY (id_videojoc) REFERENCES VideoJoc(id_videojoc) -- Relació amb VideoJoc
);

INSERT INTO VideoJoc (titul, genere, preu) VALUES
('The Legend of Zelda: Breath of the Wild', 'Aventura', 99),
('The Witcher 3: Wild Hunt', 'RPG', 39),
('Red Dead Redemption 2', 'Acció', 69);

INSERT INTO Garantia (valida, fecha, id_videojoc) VALUES
('Activa', '2024-01-01', 1),
('Inactiva', '2024-01-01', 2),
('Activa', '2024-01-01', 3);

INSERT INTO Dessarrollador (nom, pais, id_videojoc) VALUES
('Nintendo', 'Japó', 1),
('CD Projekt Red', 'Polònia', 2),
('Rockstar Games', 'Estats Units', 3);

INSERT INTO Jugador (nom, correu) VALUES
('Ana García', 'ana.garcia@mail.com'),
('Carlos Pérez', 'carlos.perez@mail.com'),
('Lucía López', 'lucia.lopez@mail.com');

INSERT INTO Compra (id_jugador, id_videojoc) VALUES
(1, 1),  -- Ana García compra "The Legend of Zelda: Breath of the Wild"
(1, 2),  -- Ana García compra "The Witcher 3: Wild Hunt"
(2, 3),  -- Carlos Pérez compra "Red Dead Redemption 2"
(3, 2);  -- Lucía López compra "The Witcher 3: Wild Hunt"
