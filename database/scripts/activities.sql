IF OBJECT_ID('dbo.activities', 'U') IS NOT NULL DROP TABLE dbo.activities;

CREATE TABLE activities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- Popolamento della tabella activities (ricavate dai dati degli operatori)
-- Lista completa e corretta basata sull'OCR JSON
INSERT INTO activities (name) VALUES
('Trekking'),
('Hiking'),
('Escursioni Guidate'),
('Campeggio'),
('Via Ferrata'),
('Arrampicata'),
('Corsi'),
('Mountain Bike'),
('E-Bike Tours'),
('Noleggio Bici'),
('Sci Alpino'),
('Snowboard'),
('Lezioni Sci/Snowboard'),
('Lezioni Private/Gruppo'),
('Ciaspole (Snowshoeing)'),
('Escursioni Invernali'),
('Parapendio'),
('Equitazione'),
('Trekking a Cavallo'),
('Freeride'),
('Workshop Fotografia'),
('Tour Fotografici'),
('Parco Avventura (Percorsi sugli alberi)'),
('Corsi di Alpinismo'),
('Noleggio Attrezzatura (Trekking, Sci, Ciaspole, Via Ferrata)'),
('Escursioni Enogastronomiche'),
('Downhill'),
('Corsi Base Via Ferrata'),
('Escursioni ai Laghi'),
('Birdwatching'),
('Flora & Fauna Tour'),
('Corsi Base Sicurezza Neve (Valanghe/Superficie)'), -- Nota: 'Superficie' con 'S' maiuscola come nell'OCR
('Dimostrazioni Unità Cinofile'),
('Noleggio Attrezzatura Sci & Snowboard'),
('Noleggio Attrezzatura (Sci, Snowboard, Scarponi, Caschi)'),
('Arrampicata (Corsi Base Indoor/Outdoor)'),
('E-Bike Tours Panoramici'),
('Escursioni per Famiglie'),
('E-Bike Delivery'),
('Maestri Private'),
('Tour Guidati'),
('Survival'),
('Corsi Base Montagna'),
('Attività Didattiche'),
('Informazioni Parco'),
('Speleologia (Esplorazione Grotte)'),
('Noleggio'), -- Attività generica di noleggio (bike park)
('Noleggio Downhill/Freeride'),
('Passeggiate Brevi a Cavallo'),
('Ciaspole (Escursioni Notturne)'),
('Alpinismo'), -- Distinto da Sci Alpinismo nell'OCR
('Trekking Alta Quota'),
('Cime'), -- Probabilmente salita a cime/vette
('Corsi Parapendio'),
('Noleggio MTB');
GO