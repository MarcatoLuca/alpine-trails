IF OBJECT_ID('dbo.operator_activities', 'U') IS NOT NULL DROP TABLE dbo.operator_activities;
IF OBJECT_ID('dbo.operators', 'U') IS NOT NULL DROP TABLE dbo.operators;
IF OBJECT_ID('dbo.zones', 'U') IS NOT NULL DROP TABLE dbo.zones;

CREATE TABLE operators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE, -- Nome dell'operatore
    description VARCHAR(MAX)
);
GO

CREATE TABLE zones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE operator_zones (
    operator_id INT NOT NULL,
    zone_id INT NOT NULL,
    PRIMARY KEY (operator_id, zone_id),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE,
    FOREIGN KEY (zone_id) REFERENCES zones(id) ON DELETE CASCADE
);
GO

INSERT INTO operators (name, description) VALUES
('Dolomiti Trekking Guide', 'Guide alpine esperte per esplorare i sentieri più suggestivi.'),
('Centro Campeggio Cime Aperte', 'Area attrezzata immersa nella natura, ideale per camper e tende.'),
('Avventura Dolomitica', 'Esperienze adrenaliniche su ferrate e pareti con guide certificate.'),
('Bike Explore Dolomites', 'Percorsi guidati in bici per tutti i livelli, con noleggio e-bike.'),
('Sci & Neve Valleys', 'Scuole sci e maestri qualificati per divertimento sulla neve.'),
('Snowshoeing Secrets', 'Scopri la magia delle Dolomiti d''inverno con le nostre ciaspolate.'),
('Parapendio Cime Volanti', 'Voli in tandem per ammirare le Dolomiti dall''alto.'),
('Horse Riding Dolomiti', 'Passeggiate a cavallo e trekking immersi nel paesaggio alpino.'),
('Centro Sci Alpinismo Dolomites', 'Avventure fuoripista con guide esperte e brevettate.'),
('Foto Natura Dolomiti', 'Cattura la bellezza delle Dolomiti con i nostri tour fotografici guidati.'),
('Campeggio Sotto le Stelle', 'Moderno campeggio con vista panoramica sulle cime della Val di Fassa.'),
('Guide Alpine Cortina', 'Le guide storiche di Cortina, al tuo fianco per ogni avventura in montagna.'),
('Dolomiti Bike Park Fun', 'Adrenalina pura sui percorsi downhill e freeride con servizi di noleggio.'),
('Ciaspole Dolomiti Orientali', 'Itinerari guidati con le ciaspole nella parte orientale delle Dolomiti.'),
('Centro Equitazione Alpe', 'Avvicinati al mondo dei cavalli con passeggiate sull''Alpe.'),
('Scuola Sci Val Badia', 'Impara a sciare o perfeziona la tua tecnica con i nostri maestri.'),
('Dolomiti Avventura Park', 'Divertimento per tutta la famiglia con percorsi sospesi tra gli alberi.'),
('Guide Alpine Fassa', 'Affronta le pareti più iconiche della Val di Fassa in sicurezza.'),
('Noleggio Sport & Outdoor', 'Attrezzatura di qualità per tutte le tue avventure, estate e inverno.'),
('Trekking & Sapori Ladini', 'Combina la passione per l''escursionismo con la scoperta dei sapori locali.'),
('Campeggio Dolomiti Centrali', 'Posizione strategica per esplorare la Val Pusteria e i suoi laghi.'),
('Sci Fuoripista Group', 'Avventure in neve fresca con guide specializzate in sicurezza.'),
('Mountain Bike Val Del Sole (vicino Dolomiti)', 'Uno dei bike park più famosi, con noleggio e percorsi per tutti i livelli.'),
('Via Ferrata Specialist', 'Guide dedicate esclusivamente alle vie ferrate, per iniziare o migliorare.'),
('Trekking Laghi Alpini', 'Itinerari suggestivi alla scoperta dei meravigliosi laghi alpini.'),
('Guide Naturalistiche Dolomiti', 'Scopri la ricchezza della biodiversità dolomitica con guide esperte.'),
('Centro Addestramento Cani da Ricerca (Valanghe/Superficie)', 'Impara le basi della sicurezza in ambiente innevato e l''importanza dei cani da ricerca.'),
('Noleggio Attrezzatura Sci & Snowboard', 'Attrezzatura da sci e snowboard di ultima generazione per il massimo divertimento.'),
('Corso Introduzione Arrampicata', 'Primo approccio sicuro all''arrampicata con istruttori qualificati.'),
('E-Bike Tours Panoramici', 'Goditi panorami mozzafiato senza fatica con le nostre e-bike guidate.'),
('Campeggio Verde Montagna', 'Campeggio tranquillo, punto di partenza ideale per escursioni e ciclabili.'),
('Guide Alta Quota', 'Per chi cerca le sfide delle grandi vette, con guide altamente specializzate.'),
('Ciaspolata Sotto le Stelle', 'Un''esperienza unica: ciaspolare al chiaro di luna con cena in rifugio.'),
('Parapendio Dolomiti Fly', 'Il punto di riferimento per il volo in parapendio con viste spettacolari.'),
('Trekking Family Friendly', 'Percorsi facili e divertenti pensati per le famiglie con bambini.'),
('Noleggio E-Bike Dolomiti Adventure', 'Noleggia la tua e-bike e parti all''avventura, consegniamo anche al tuo alloggio.'),
('Scuola Sci & Snowboard Cortina', 'Tradizione e professionalità sulle piste di Cortina.'),
('Campeggio Vista Tre Cime', 'Campeggio con una vista impareggiabile sulle iconiche Tre Cime.'),
('Guide Alpine San Martino', 'Esplora il maestoso gruppo delle Pale con le nostre guide locali.'),
('Ciaspole Panoramiche Val Gardena', 'Itinerari con le ciaspole sui punti panoramici più belli della Val Gardena.'),
('Mountain Bike Trails Cadore', 'Scopri i sentieri e le ciclabili del Cadore in mountain bike.'),
('Corso di Sopravvivenza Montana', 'Impara le tecniche essenziali per la sopravvivenza in ambiente montano.'),
('Centro Parco Naturale Dolomiti Friulane', 'Esplora un''area meno conosciuta ma selvaggia e bellissima delle Dolomiti.'),
('Avventura Speleologica Dolomiti', 'Addentrati nel mondo sotterraneo delle Dolomiti con guide speleologiche.');
GO

INSERT INTO zones (name) VALUES
('Val Gardena'),
('Val Badia'),
('Alpe di Siusi'),
('Cortina d''Ampezzo'),
('Cadore'),
('Val di Fassa'),
('Marmolada'),
('Alta Badia'),
('Val Pusteria'),
('Tre Cime'),
('Passo Giau'),
('Val Fiscalina'),
('Moena Area'),
('Dolomiti Ampezzane'),
('Belvedere Area'),
('Misurina'),
('Val di Fiemme'),
('Dintorni Bolzano'),
('Sella Group'), -- Presente per Centro Sci Alpinismo Dolomites
('Gruppo Sella'), -- Presente per Guide Alpine Fassa e Guide Alta Quota
('Arabba'),
('Lago di Braies Area'),
('Zone boschive e remote'),
('Dolomiti Friulane'),
('Zone Carsiche'),
('Ogni località sciistica principale'),
('Bassano del Grappa (vicino Dolomiti, noto punto di volo)'),
('Piazzale del Ghiacciaio (Marmolada)'), -- Mancava in v2, presente per Centro Sci Alpinismo Dolomites
('Pale di San Martino'),
('San Martino di Castrozza'),
('Tre Cime di Lavaredo Area'),
('Val di Sole (TN - vicino Dolomiti di Brenta)'),
('Parco Naturale Fanes-Sennes-Braies'),
('Parco Naturale Paneveggio-Pale di San Martino'),
('Corvara'),
('Val Gardena (rocce attrezzate)'),
('San Candido Area'),
('Alta Pusteria'), -- Presente per Trekking Family Friendly
('Auronzo Area');
GO

-- Data: Popolamento della tabella di collegamento operator_zones

-- Operatore: Dolomiti Trekking Guide
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Val Badia')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
GO

-- Operatore: Centro Campeggio Cime Aperte
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), (SELECT id FROM zones WHERE name = 'Cadore'));
GO

-- Operatore: Avventura Dolomitica
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM zones WHERE name = 'Marmolada'));
GO

-- Operatore: Bike Explore Dolomites
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM zones WHERE name = 'Alta Badia')),
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
GO

-- Operatore: Sci & Neve Valleys
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
GO

-- Operatore: Snowshoeing Secrets
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM zones WHERE name = 'Tre Cime')),
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo'));
GO

-- Operatore: Parapendio Cime Volanti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), (SELECT id FROM zones WHERE name = 'Val Gardena'));
GO

-- Operatore: Horse Riding Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi')),
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
GO

-- Operatore: Centro Sci Alpinismo Dolomites
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Marmolada')),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Sella Group')),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Piazzale del Ghiacciaio (Marmolada)'));
GO

-- Operatore: Foto Natura Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Tre Cime')),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Passo Giau')),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Val Fiscalina'));
GO

-- Operatore: Campeggio Sotto le Stelle
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Moena Area'));
GO

-- Operatore: Guide Alpine Cortina
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM zones WHERE name = 'Dolomiti Ampezzane'));
GO

-- Operatore: Dolomiti Bike Park Fun
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM zones WHERE name = 'Belvedere Area'));
GO

-- Operatore: Ciaspole Dolomiti Orientali
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM zones WHERE name = 'Misurina'));
GO

-- Operatore: Centro Equitazione Alpe
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Equitazione Alpe'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
GO

-- Operatore: Scuola Sci Val Badia
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
GO

-- Operatore: Dolomiti Avventura Park
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), (SELECT id FROM zones WHERE name = 'Val di Fiemme')),
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), (SELECT id FROM zones WHERE name = 'Dintorni Bolzano'));
GO

-- Operatore: Guide Alpine Fassa
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM zones WHERE name = 'Gruppo Sella'));
GO

-- Operatore: Noleggio Sport & Outdoor
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
GO

-- Operatore: Trekking & Sapori Ladini
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM zones WHERE name = 'Val Badia')),
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM zones WHERE name = 'Val di Fassa'));
GO

-- Operatore: Campeggio Dolomiti Centrali
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), (SELECT id FROM zones WHERE name = 'Val Pusteria')),
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), (SELECT id FROM zones WHERE name = 'Lago di Braies Area'));
GO

-- Operatore: Sci Fuoripista Group
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM zones WHERE name = 'Arabba')),
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM zones WHERE name = 'Marmolada'));
GO

-- Operatore: Mountain Bike Val Del Sole (vicino Dolomiti)
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM zones WHERE name = 'Val di Sole (TN - vicino Dolomiti di Brenta)'));
GO

-- Operatore: Via Ferrata Specialist
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM zones WHERE name = 'Val di Fassa'));
GO

-- Operatore: Trekking Laghi Alpini
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
GO

-- Operatore: Guide Naturalistiche Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM zones WHERE name = 'Parco Naturale Fanes-Sennes-Braies')),
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM zones WHERE name = 'Parco Naturale Paneveggio-Pale di San Martino'));
GO

-- Operatore: Centro Addestramento Cani da Ricerca (Valanghe/Superficie)
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM zones WHERE name = 'Corvara')),
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM zones WHERE name = 'Arabba'));
GO

-- Operatore: Noleggio Attrezzatura Sci & Snowboard
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Attrezzatura Sci & Snowboard'), (SELECT id FROM zones WHERE name = 'Ogni località sciistica principale'));
GO

-- Operatore: Corso Introduzione Arrampicata
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), (SELECT id FROM zones WHERE name = 'Dintorni Bolzano')),
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), (SELECT id FROM zones WHERE name = 'Val Gardena (rocce attrezzate)'));
GO

-- Operatore: E-Bike Tours Panoramici
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), (SELECT id FROM zones WHERE name = 'Alta Badia')),
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), (SELECT id FROM zones WHERE name = 'Passo Giau'));
GO

-- Operatore: Campeggio Verde Montagna
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), (SELECT id FROM zones WHERE name = 'Val Pusteria')),
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), (SELECT id FROM zones WHERE name = 'San Candido Area'));
GO

-- Operatore: Guide Alta Quota
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Marmolada')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Gruppo Sella')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Pale di San Martino'));
GO

-- Operatore: Ciaspolata Sotto le Stelle
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
GO

-- Operatore: Parapendio Dolomiti Fly
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Dolomiti Fly'), (SELECT id FROM zones WHERE name = 'Bassano del Grappa (vicino Dolomiti, noto punto di volo)'));
GO

-- Operatore: Trekking Family Friendly
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM zones WHERE name = 'Val di Fiemme')),
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM zones WHERE name = 'Alta Pusteria'));
GO

-- Operatore: Noleggio E-Bike Dolomiti Adventure
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM zones WHERE name = 'Misurina'));
GO

-- Operatore: Scuola Sci & Snowboard Cortina
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo'));
GO

-- Operatore: Campeggio Vista Tre Cime
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Vista Tre Cime'), (SELECT id FROM zones WHERE name = 'Tre Cime di Lavaredo Area'));
GO

-- Operatore: Guide Alpine San Martino
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM zones WHERE name = 'Pale di San Martino')),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM zones WHERE name = 'San Martino di Castrozza'));
GO

-- Operatore: Ciaspole Panoramiche Val Gardena
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
GO

-- Operatore: Mountain Bike Trails Cadore
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM zones WHERE name = 'Auronzo Area'));
GO

-- Operatore: Corso di Sopravvivenza Montana
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso di Sopravvivenza Montana'), (SELECT id FROM zones WHERE name = 'Zone boschive e remote'));
GO

-- Operatore: Centro Parco Naturale Dolomiti Friulane
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), (SELECT id FROM zones WHERE name = 'Dolomiti Friulane'));
GO

-- Operatore: Avventura Speleologica Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Speleologica Dolomiti'), (SELECT id FROM zones WHERE name = 'Zone Carsiche'));
GO
