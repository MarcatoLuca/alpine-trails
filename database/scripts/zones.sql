IF OBJECT_ID('dbo.zones', 'U') IS NOT NULL DROP TABLE dbo.zones;

CREATE TABLE zones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- Popolamento della tabella zones (ricavate dai dati degli operatori)
-- Lista completa e corretta basata sull'OCR JSON
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