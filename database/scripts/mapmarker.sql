CREATE TABLE mapmarker (
    id INT IDENTITY(1,1) PRIMARY KEY, -- O SERIAL per PostgreSQL, o INTEGER PRIMARY KEY AUTOINCREMENT per SQLite
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    latitude DECIMAL(10, 6) NOT NULL,  -- Aumentata precisione per sicurezza
    longitude DECIMAL(10, 6) NOT NULL, -- Aumentata precisione per sicurezza
    description TEXT
);

-- Popolamento della tabella map_markers

-- Vette Iconiche e Punti Panoramici
INSERT INTO mapmarker (name, type, latitude, longitude, description) VALUES
('Tre Cime di Lavaredo', 'Vetta Iconica/Punto Panoramico', 46.617500, 12.303000, 'Cima Grande - per riferimento della vetta'),
('Rifugio Auronzo', 'Vetta Iconica/Punto Panoramico', 46.613500, 12.295500, 'Accesso Tre Cime'),
('Rifugio Locatelli', 'Vetta Iconica/Punto Panoramico', 46.619000, 12.315000, 'Vista Tre Cime lato nord'),
('Forcella Lavaredo', 'Vetta Iconica/Punto Panoramico', 46.615200, 12.309100, 'Passaggio Tre Cime'),
('Marmolada - Punta Penia', 'Vetta Iconica/Punto Panoramico', 46.434400, 11.852500, 'Vetta'),
('Sass Pordoi', 'Vetta Iconica/Punto Panoramico', 46.496400, 11.810000, 'Stazione Funivia'),
('Piz Boè', 'Vetta Iconica/Punto Panoramico', 46.503000, 11.824000, 'Vetta Gruppo Sella'),
('Seceda', 'Vetta Iconica/Punto Panoramico', 46.605000, 11.765300, 'Stazione Funivia, vista Odle'),
('Sassolungo', 'Vetta Iconica/Punto Panoramico', 46.516700, 11.758300, 'Cima - riferimento'),
('Rifugio Toni Demetz', 'Vetta Iconica/Punto Panoramico', 46.515200, 11.771000, 'Forcella Sassolungo'),
('Col Rodella', 'Vetta Iconica/Punto Panoramico', 46.496100, 11.758300, 'Panorama Val di Fassa/Sassolungo'),
('Cima Rosetta', 'Vetta Iconica/Punto Panoramico', 46.271000, 11.830000, 'Funivia, Pale di San Martino'),
('Tofana di Mezzo', 'Vetta Iconica/Punto Panoramico', 46.547000, 12.099000, 'Stazione Funivia, Cortina'),
('Monte Cristallo', 'Vetta Iconica/Punto Panoramico', 46.583300, 12.166700, 'Cima di Mezzo - riferimento'),
('Monte Pelmo', 'Vetta Iconica/Punto Panoramico', 46.415000, 12.060000, 'Vetta - riferimento'),
('Monte Civetta', 'Vetta Iconica/Punto Panoramico', 46.383300, 12.050000, 'Vetta - riferimento'),
('Rifugio Tissi', 'Vetta Iconica/Punto Panoramico', 46.393100, 12.028000, 'Vista parete Civetta'),
('Cima della Vezzana', 'Vetta Iconica/Punto Panoramico', 46.299500, 11.822400, 'Pale di San Martino'),
('Piz La Ila', 'Vetta Iconica/Punto Panoramico', 46.555000, 11.898000, 'Corvara, Val Badia'),
('Sass de Putia / Peitlerkofel', 'Vetta Iconica/Punto Panoramico', 46.655000, 11.825000, 'Vetta isolata'),
('Croda Rossa d''Ampezzo', 'Vetta Iconica/Punto Panoramico', 46.631700, 12.133300, 'Vetta'), -- Nota: ' in d''Ampezzo è stato escapato
('Cinque Torri', 'Vetta Iconica/Punto Panoramico', 46.509000, 12.049000, 'Area'),
('Monte Rite', 'Vetta Iconica/Punto Panoramico', 46.360000, 12.230000, 'Messner Mountain Museum Dolomites'),
('Piz de Sieles', 'Vetta Iconica/Punto Panoramico', 46.606300, 11.778100, 'Odle, vicino Seceda');

-- Laghi Suggestivi
INSERT INTO mapmarker (name, type, latitude, longitude, description) VALUES
('Lago di Braies', 'Lago Suggestivo', 46.698500, 12.085500, NULL),
('Lago di Sorapis', 'Lago Suggestivo', 46.514000, 12.216000, NULL),
('Lago di Misurina', 'Lago Suggestivo', 46.582000, 12.255000, NULL),
('Lago di Carezza / Karersee', 'Lago Suggestivo', 46.409000, 11.575000, NULL),
('Lago di Dobbiaco / Toblacher See', 'Lago Suggestivo', 46.715000, 12.222000, NULL),
('Lago di Landro / Dürrensee', 'Lago Suggestivo', 46.650000, 12.230000, NULL),
('Lago Federa', 'Lago Suggestivo', 46.500000, 12.090000, 'Croda da Lago'),
('Lago di Fedaia', 'Lago Suggestivo', 46.455000, 11.880000, 'Vicino Marmolada'),
('Lago Coldai', 'Lago Suggestivo', 46.398000, 12.054000, 'Sotto la Civetta'),
('Lago di Limides', 'Lago Suggestivo', 46.520000, 12.018000, 'Vicino Passo Falzarego');

-- Passi Alpini Importanti
INSERT INTO mapmarker (name, type, latitude, longitude, description) VALUES
('Passo Pordoi', 'Passo Alpino', 46.487800, 11.811500, NULL),
('Passo Sella', 'Passo Alpino', 46.509000, 11.757000, NULL),
('Passo Gardena', 'Passo Alpino', 46.549000, 11.809000, NULL),
('Passo Campolongo', 'Passo Alpino', 46.526000, 11.859000, NULL),
('Passo Falzarego', 'Passo Alpino', 46.518600, 12.009000, NULL),
('Passo Giau', 'Passo Alpino', 46.484000, 12.053000, NULL),
('Passo Fedaia', 'Passo Alpino', 46.456000, 11.873000, 'punto centrale del passo'),
('Passo Rolle', 'Passo Alpino', 46.296000, 11.787000, NULL),
('Passo Valparola', 'Passo Alpino', 46.529000, 11.987000, NULL),
('Passo Staulanza', 'Passo Alpino', 46.393000, 12.110000, NULL),
('Forcella Staunies', 'Passo Alpino', 46.577500, 12.151300, 'Cristallo - arrivo vecchia cabinovia');

-- Rifugi Noti
INSERT INTO mapmarker (name, type, latitude, longitude, description) VALUES
('Rifugio Lagazuoi', 'Rifugio Noto', 46.527500, 12.008800, NULL),
('Rifugio Nuvolau', 'Rifugio Noto', 46.491800, 12.049500, 'Vista spettacolare'),
('Rifugio Gardeccia', 'Rifugio Noto', 46.439000, 11.673000, 'Catinaccio'),
('Rifugio Re Alberto I', 'Rifugio Noto', 46.450000, 11.655000, 'Torri del Vajolet'),
('Rifugio Pedrotti alla Rosetta', 'Rifugio Noto', 46.270500, 11.833000, 'Pale di San Martino'),
('Rifugio Puez', 'Rifugio Noto', 46.597000, 11.834000, 'Parco Naturale Puez-Odle'),
('Rifugio Fonda Savio', 'Rifugio Noto', 46.600000, 12.280000, 'Cadini di Misurina'),
('Rifugio Pian dei Fiacconi', 'Rifugio Noto', 46.441000, 11.868000, 'Marmolada (già menzionato ma fondamentale)'),
('Rifugio Comici', 'Rifugio Noto', 46.532000, 11.777000, 'Sassolungo'),
('Rifugio Alpe di Tires / Tierser Alpl', 'Rifugio Noto', 46.483000, 11.650000, NULL);

-- Cittadine e Località Principali
INSERT INTO mapmarker (name, type, latitude, longitude, description) VALUES
('Cortina d''Ampezzo', 'Cittadina/Località', 46.537600, 12.135700, 'Centro'), -- Nota: ' in d''Ampezzo è stato escapato
('Ortisei / St. Ulrich', 'Cittadina/Località', 46.574000, 11.673000, 'Val Gardena'),
('Selva di Val Gardena / Wolkenstein', 'Cittadina/Località', 46.555000, 11.760000, NULL),
('Corvara in Badia', 'Cittadina/Località', 46.549000, 11.875000, NULL),
('Canazei', 'Cittadina/Località', 46.477000, 11.771000, 'Val di Fassa'),
('Arabba', 'Cittadina/Località', 46.497000, 11.875000, NULL),
('San Martino di Castrozza', 'Cittadina/Località', 46.262000, 11.800000, NULL),
('Alleghe', 'Cittadina/Località', 46.407000, 12.019000, 'Lago di Alleghe');