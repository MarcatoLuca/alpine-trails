IF OBJECT_ID('dbo.operators', 'U') IS NOT NULL DROP TABLE dbo.operators;

CREATE TABLE operators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE, -- Nome dell'operatore
    description VARCHAR(MAX)
);
GO

-- Popolamento della tabella operators
-- Questa sezione ha funzionato correttamente
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
