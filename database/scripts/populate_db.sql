-- =============================================================================
-- Schema: Creazione delle tabelle per SQL Server (Corretto v3)
-- =============================================================================

-- Drop delle tabelle se esistono (in ordine inverso per via delle FOREIGN KEY)
IF OBJECT_ID('dbo.operator_zones', 'U') IS NOT NULL DROP TABLE dbo.operator_zones;
IF OBJECT_ID('dbo.operator_activities', 'U') IS NOT NULL DROP TABLE dbo.operator_activities;
IF OBJECT_ID('dbo.operators', 'U') IS NOT NULL DROP TABLE dbo.operators;
IF OBJECT_ID('dbo.zones', 'U') IS NOT NULL DROP TABLE dbo.zones;
IF OBJECT_ID('dbo.activities', 'U') IS NOT NULL DROP TABLE dbo.activities;
IF OBJECT_ID('dbo.mapmarker', 'U') IS NOT NULL DROP TABLE dbo.mapmarker;
GO

-- Tabella per i Punti Geografici di Interesse (come da tua definizione)
CREATE TABLE mapmarker (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    latitude DECIMAL(10, 6) NOT NULL,
    longitude DECIMAL(10, 6) NOT NULL,
    description VARCHAR(MAX) -- TEXT è deprecato, usare VARCHAR(MAX)
);
GO

-- Tabella di lookup per le Zone/Aree Geografiche (corrisponde al campo 'zona')
CREATE TABLE zones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- Tabella di lookup per le Attività (corrisponde al campo 'attivita')
CREATE TABLE activities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
GO

-- Creazione della tabella operators con i campi di contatto integrati
CREATE TABLE operators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,      
    description VARCHAR(MAX),               
    phone VARCHAR(50),                      
    email VARCHAR(255),                     
    website VARCHAR(255)                    
);
GO

-- Tabella di collegamento tra Operatori e Zone (Many-to-Many)
CREATE TABLE operator_zones (
    operator_id INT NOT NULL,
    zone_id INT NOT NULL,
    PRIMARY KEY (operator_id, zone_id),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE,
    FOREIGN KEY (zone_id) REFERENCES zones(id) ON DELETE CASCADE
);
GO

-- Tabella di collegamento tra Operatori e Attività (Many-to-Many)
CREATE TABLE operator_activities (
    operator_id INT NOT NULL,
    activity_id INT NOT NULL,
    PRIMARY KEY (operator_id, activity_id),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE,
    FOREIGN KEY (activity_id) REFERENCES activities(id) ON DELETE CASCADE
);
GO


-- =============================================================================
-- Data: Popolamento delle tabelle per SQL Server (Corretto v3)
-- =============================================================================

-- Popolamento della tabella map_markers (usando i dati che hai fornito)
-- Questa sezione è la stessa che hai fornito e che funziona correttamente
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
('Croda Rossa d''Ampezzo', 'Vetta Iconica/Punto Panoramico', 46.631700, 12.133300, 'Vetta'),
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
('Cortina d''Ampezzo', 'Cittadina/Località', 46.537600, 12.135700, 'Centro'),
('Ortisei / St. Ulrich', 'Cittadina/Località', 46.574000, 11.673000, 'Val Gardena'),
('Selva di Val Gardena / Wolkenstein', 'Cittadina/Località', 46.555000, 11.760000, NULL),
('Corvara in Badia', 'Cittadina/Località', 46.549000, 11.875000, NULL),
('Canazei', 'Cittadina/Località', 46.477000, 11.771000, 'Val di Fassa'),
('Arabba', 'Cittadina/Località', 46.497000, 11.875000, NULL),
('San Martino di Castrozza', 'Cittadina/Località', 46.262000, 11.800000, NULL),
('Alleghe', 'Cittadina/Località', 46.407000, 12.019000, 'Lago di Alleghe');
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
('Sci Alpinismo'),
('Escursioni Naturalistiche'),
('Noleggio E-Bike'),
('Noleggio MTB');
GO

-- Popolamento della tabella operators con dati integrati
INSERT INTO operators (name, description, phone, email, website) VALUES
('Dolomiti Trekking Guide', 'Guide alpine esperte per esplorare i sentieri più suggestivi.', '+39 345 1234567', 'info@dolomitisentieri.it', 'www.dolomitisentieri.it'),
('Centro Campeggio Cime Aperte', 'Area attrezzata immersa nella natura, ideale per camper e tende.', '+39 0436 123456', 'prenota@campeggiocortina.it', 'www.campeggiocortina.it'),
('Avventura Dolomitica', 'Esperienze adrenaliniche su ferrate e pareti con guide certificate.', '+39 335 9876543', 'info@avventuradolomiti.it', 'www.avventuradolomiti.it'),
('Bike Explore Dolomites', 'Percorsi guidati in bici per tutti i livelli, con noleggio e-bike.', '+39 348 7654321', 'bike@exploredolomites.com', 'www.exploredolomites.com'),
('Sci & Neve Valleys', 'Scuole sci e maestri qualificati per divertimento sulla neve.', '+39 0471 234567', 'scuola@scivalleys.it', 'www.scivalleys.it'),
('Snowshoeing Secrets', 'Scopri la magia delle Dolomiti d''inverno con le nostre ciaspolate.', '+39 329 8765432', 'info@snowshoedolomites.com', 'www.snowshoedolomites.com'),
('Parapendio Cime Volanti', 'Voli in tandem per ammirare le Dolomiti dall''alto.', '+39 333 1122334', 'vola@cimevolanti.it', 'www.cimevolanti.it'),
('Horse Riding Dolomiti', 'Passeggiate a cavallo e trekking immersi nel paesaggio alpino.', '+39 340 5566778', 'cavalli@dolomiti.it', 'www.horseridingdolomiti.it'),
('Centro Sci Alpinismo Dolomites', 'Avventure fuoripista con guide esperte e brevettate.', '+39 347 1231234', 'skialp@dolomites.com', 'www.skialpdolomites.com'),
('Foto Natura Dolomiti', 'Cattura la bellezza delle Dolomiti con i nostri tour fotografici guidati.', '+39 339 9876543', 'scatta@fotonaturadolomiti.it', 'www.fotonaturadolomiti.it'),
('Campeggio Sotto le Stelle', 'Moderno campeggio con vista panoramica sulle cime della Val di Fassa.', '+39 0462 987654', 'info@campeggiosottolestelle.it', 'www.campeggiosottolestelle.it'),
('Guide Alpine Cortina', 'Le guide storiche di Cortina, al tuo fianco per ogni avventura in montagna.', '+39 0436 223344', 'guide@cortinaalpi.it', 'www.guidealpinecortina.it'),
('Dolomiti Bike Park Fun', 'Adrenalina pura sui percorsi downhill e freeride con servizi di noleggio.', '+39 349 1234567', 'bikefun@dolomiti.com', 'www.dolomitibikeparkfun.it'),
('Ciaspole Dolomiti Orientali', 'Itinerari guidati con le ciaspole nella parte orientale delle Dolomiti.', '+39 320 9876543', 'ciaspolecadore@gmail.com', NULL),
('Centro Equitazione Alpe', 'Avvicinati al mondo dei cavalli con passeggiate sull''Alpe.', '+39 0471 876543', 'info@equitazionealpe.it', 'www.equitazionealpe.it'),
('Scuola Sci Val Badia', 'Impara a sciare o perfeziona la tua tecnica con i nostri maestri.', '+39 0471 112233', 'info@scuolascivalbadia.it', 'www.scuolascivalbadia.it'),
('Dolomiti Avventura Park', 'Divertimento per tutta la famiglia con percorsi sospesi tra gli alberi.', '+39 346 5566778', 'parcoavventura@dolomiti.it', 'www.dolomiavventurapark.it'),
('Guide Alpine Fassa', 'Affronta le pareti più iconiche della Val di Fassa in sicurezza.', '+39 0462 123123', 'info@guidefassane.it', 'www.guidefassane.it'),
('Noleggio Sport & Outdoor', 'Attrezzatura di qualità per tutte le tue avventure, estate e inverno.', '+39 0436 554433', 'noleggio@sportsdolomiti.it', 'www.noleggiosportsdolomiti.it'),
('Trekking & Sapori Ladini', 'Combina la passione per l''escursionismo con la scoperta dei sapori locali.', '+39 338 1122334', 'saporiladini@trekking.it', 'www.trekkingesapori.it'),
('Campeggio Dolomiti Centrali', 'Posizione strategica per esplorare la Val Pusteria e i suoi laghi.', '+39 0474 876543', 'prenota@campcentrali.it', 'www.campeggidolomiticentrali.it'),
('Sci Fuoripista Group', 'Avventure in neve fresca con guide specializzate in sicurezza.', '+39 345 6789012', 'info@freeridearabba.it', 'www.freeridearabba.it'),
('Mountain Bike Val Del Sole (vicino Dolomiti)', 'Uno dei bike park più famosi, con noleggio e percorsi per tutti i livelli.', '+39 0463 112233', 'bike@valdisole.it', 'www.valdisolebikeland.com'),
('Via Ferrata Specialist', 'Guide dedicate esclusivamente alle vie ferrate, per iniziare o migliorare.', '+39 331 2345678', 'ferrate@specialist.it', 'www.viaferrataspecialist.it'),
('Trekking Laghi Alpini', 'Itinerari suggestivi alla scoperta dei meravigliosi laghi alpini.', '+39 340 1234567', 'laghialpini@trekking.it', NULL),
('Guide Naturalistiche Dolomiti', 'Scopri la ricchezza della biodiversità dolomitica con guide esperte.', '+39 339 1122334', 'info@guidefaunaflora.it', 'www.guidenaturalistichedolomiti.it'),
('Centro Addestramento Cani da Ricerca (Valanghe/Superficie)', 'Impara le basi della sicurezza in ambiente innevato e l''importanza dei cani da ricerca.', '+39 348 9876543', 'caniuniti@sicurezzaneve.it', 'www.sicurezzaneve.it'),
('Noleggio Attrezzatura Sci & Snowboard', 'Attrezzatura da sci e snowboard di ultima generazione per il massimo divertimento.', '+39 0471 223344', 'noleggio@skiworld.it', 'www.noleggioskiworld.it'),
('Corso Introduzione Arrampicata', 'Primo approccio sicuro all''arrampicata con istruttori qualificati.', '+39 333 9876543', 'arrampicabase@climb.it', NULL),
('E-Bike Tours Panoramici', 'Goditi panorami mozzafiato senza fatica con le nostre e-bike guidate.', '+39 347 1122334', 'ebike@panoramici.it', 'www.ebiketourpanoramici.it'),
('Campeggio Verde Montagna', 'Campeggio tranquillo, punto di partenza ideale per escursioni e ciclabili.', '+39 0474 123456', 'info@campeggioverdemontagna.it', 'www.campeggioverdemontagna.it'),
('Guide Alta Quota', 'Per chi cerca le sfide delle grandi vette, con guide altamente specializzate.', '+39 349 9876543', 'altaquota@guides.it', 'www.guidealtaquota.it'),
('Ciaspolata Sotto le Stelle', 'Un''esperienza unica: ciaspolare al chiaro di luna con cena in rifugio.', '+39 338 5566778', 'ciaspolenotturne@dolomiti.it', NULL),
('Parapendio Dolomiti Fly', 'Il punto di riferimento per il volo in parapendio con viste spettacolari.', '+39 340 1122334', 'fly@dolomiti.com', 'www.parapendiodolomitifly.it'),
('Trekking Family Friendly', 'Percorsi facili e divertenti pensati per le famiglie con bambini.', '+39 339 6543210', 'famiglia@trekkingdolomiti.it', 'www.trekkingfamilyfriendly.it'),
('Noleggio E-Bike Dolomiti Adventure', 'Noleggia la tua e-bike e parti all''avventura, consegniamo anche al tuo alloggio.', '+39 348 1234567', 'noleggio@ebikeadventure.it', 'www.noleggioebikedolomiti.it'),
('Scuola Sci & Snowboard Cortina', 'Tradizione e professionalità sulle piste di Cortina.', '+39 0436 112233', 'info@scuolascicortina.it', 'www.scuolascicortina.it'),
('Campeggio Vista Tre Cime', 'Campeggio con una vista impareggiabile sulle iconiche Tre Cime.', '+39 0434 987654', 'prenota@campeggiotrecime.it', 'www.campeggiovistatrecime.it'),
('Guide Alpine San Martino', 'Esplora il maestoso gruppo delle Pale con le nostre guide locali.', '+39 0439 123123', 'info@guidesanmartino.it', 'www.guidealpinesanmartino.it'),
('Ciaspole Panoramiche Val Gardena', 'Itinerari con le ciaspole sui punti panoramici più belli della Val Gardena.', '+39 335 1234567', 'ciaspolevg@dolomiti.it', 'www.ciaspoledolomiti.it'),
('Mountain Bike Trails Cadore', 'Scopri i sentieri e le ciclabili del Cadore in mountain bike.', '+39 340 9876543', 'bikecadore@trails.it', 'www.mbtcai.it'),
('Corso di Sopravvivenza Montana', 'Impara le tecniche essenziali per la sopravvivenza in ambiente montano.', '+39 333 1122334', 'survival@montagna.it', 'www.sopravvivenzadolomiti.it'),
('Centro Parco Naturale Dolomiti Friulane', 'Esplora un''area meno conosciuta ma selvaggia e bellissima delle Dolomiti.', '+39 0434 112233', 'info@parcodolomitifriulane.it', 'www.parcodolomitifriulane.it'),
('Avventura Speleologica Dolomiti', 'Addentrati nel mondo sotterraneo delle Dolomiti con guide speleologiche.', '+39 345 5566778', 'grotte@speleo.it', 'www.speleodolomiti.it');
GO


-- Popolamento delle tabelle di collegamento (operator_zones, operator_activities)

-- Operatore: Dolomiti Trekking Guide
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Val Badia')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM activities WHERE name = 'Hiking')),
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), (SELECT id FROM activities WHERE name = 'Escursioni Guidate'));
GO

-- Operatore: Centro Campeggio Cime Aperte
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), (SELECT id FROM zones WHERE name = 'Cadore'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), (SELECT id FROM activities WHERE name = 'Campeggio'));
GO

-- Operatore: Avventura Dolomitica
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM zones WHERE name = 'Marmolada'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM activities WHERE name = 'Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM activities WHERE name = 'Arrampicata')),
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), (SELECT id FROM activities WHERE name = 'Corsi'));
GO

-- Operatore: Bike Explore Dolomites
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM zones WHERE name = 'Alta Badia')),
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM activities WHERE name = 'Mountain Bike')),
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM activities WHERE name = 'E-Bike Tours')),
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), (SELECT id FROM activities WHERE name = 'Noleggio Bici'));
GO

-- Operatore: Sci & Neve Valleys
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM activities WHERE name = 'Sci Alpino')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM activities WHERE name = 'Snowboard')),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), (SELECT id FROM activities WHERE name = 'Lezioni Sci/Snowboard'));
GO

-- Operatore: Snowshoeing Secrets
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM zones WHERE name = 'Tre Cime')),
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM activities WHERE name = 'Ciaspole (Snowshoeing)')),
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), (SELECT id FROM activities WHERE name = 'Escursioni Invernali'));
GO

-- Operatore: Parapendio Cime Volanti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), (SELECT id FROM zones WHERE name = 'Val Gardena'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), (SELECT id FROM activities WHERE name = 'Parapendio'));
GO

-- Operatore: Horse Riding Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi')),
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM activities WHERE name = 'Equitazione')),
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), (SELECT id FROM activities WHERE name = 'Trekking a Cavallo'));
GO

-- Operatore: Centro Sci Alpinismo Dolomites
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Marmolada')),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Sella Group')),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM zones WHERE name = 'Piazzale del Ghiacciaio (Marmolada)'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM activities WHERE name = 'Sci Alpino')),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), (SELECT id FROM activities WHERE name = 'Freeride'));
GO

-- Operatore: Foto Natura Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Tre Cime')),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Passo Giau')),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM zones WHERE name = 'Val Fiscalina'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM activities WHERE name = 'Workshop Fotografia')),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), (SELECT id FROM activities WHERE name = 'Tour Fotografici'));
GO

-- Operatore: Campeggio Sotto le Stelle
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Moena Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), (SELECT id FROM activities WHERE name = 'Campeggio'));
GO

-- Operatore: Guide Alpine Cortina
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM zones WHERE name = 'Dolomiti Ampezzane'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM activities WHERE name = 'Arrampicata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM activities WHERE name = 'Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), (SELECT id FROM activities WHERE name = 'Sci Alpinismo'));
GO

-- Operatore: Dolomiti Bike Park Fun
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM zones WHERE name = 'Belvedere Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM activities WHERE name = 'Downhill')),
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM activities WHERE name = 'Freeride')),
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), (SELECT id FROM activities WHERE name = 'Noleggio Downhill/Freeride'));
GO

-- Operatore: Ciaspole Dolomiti Orientali
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM zones WHERE name = 'Misurina'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM activities WHERE name = 'Ciaspole (Snowshoeing)')),
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), (SELECT id FROM activities WHERE name = 'Escursioni Invernali'));
GO

-- Operatore: Centro Equitazione Alpe
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Equitazione Alpe'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Equitazione Alpe'), (SELECT id FROM activities WHERE name = 'Equitazione')),
((SELECT id FROM operators WHERE name = 'Centro Equitazione Alpe'), (SELECT id FROM activities WHERE name = 'Passeggiate Brevi a Cavallo'));
GO

-- Operatore: Scuola Sci Val Badia
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), (SELECT id FROM activities WHERE name = 'Sci Alpino')),
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), (SELECT id FROM activities WHERE name = 'Snowboard')),
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), (SELECT id FROM activities WHERE name = 'Lezioni Private/Gruppo'));
GO

-- Operatore: Dolomiti Avventura Park
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), (SELECT id FROM zones WHERE name = 'Val di Fiemme')),
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), (SELECT id FROM zones WHERE name = 'Dintorni Bolzano'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), (SELECT id FROM activities WHERE name = 'Parco Avventura (Percorsi sugli alberi)'));
GO

-- Operatore: Guide Alpine Fassa
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM zones WHERE name = 'Val di Fassa')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM zones WHERE name = 'Gruppo Sella')); -- Corretto: cambiato 'Sella Group' in 'Gruppo Sella' per coerenza con il JSON
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM activities WHERE name = 'Arrampicata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM activities WHERE name = 'Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), (SELECT id FROM activities WHERE name = 'Corsi di Alpinismo'));
GO

-- Operatore: Noleggio Sport & Outdoor
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM zones WHERE name = 'Alta Badia'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), (SELECT id FROM activities WHERE name = 'Noleggio Attrezzatura (Trekking, Sci, Ciaspole, Via Ferrata)'));
GO

-- Operatore: Trekking & Sapori Ladini
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM zones WHERE name = 'Val Badia')),
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM zones WHERE name = 'Val di Fassa'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), (SELECT id FROM activities WHERE name = 'Escursioni Enogastronomiche'));
GO

-- Operatore: Campeggio Dolomiti Centrali
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), (SELECT id FROM zones WHERE name = 'Val Pusteria')),
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), (SELECT id FROM zones WHERE name = 'Lago di Braies Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), (SELECT id FROM activities WHERE name = 'Campeggio'));
GO

-- Operatore: Sci Fuoripista Group
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM zones WHERE name = 'Arabba')),
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM zones WHERE name = 'Marmolada'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM activities WHERE name = 'Freeride')),
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), (SELECT id FROM activities WHERE name = 'Sci Alpinismo'));
GO

-- Operatore: Mountain Bike Val Del Sole (vicino Dolomiti)
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM zones WHERE name = 'Val di Sole (TN - vicino Dolomiti di Brenta)'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM activities WHERE name = 'Mountain Bike')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM activities WHERE name = 'Downhill')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM activities WHERE name = 'Noleggio')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), (SELECT id FROM activities WHERE name = 'Escursioni Guidate'));
GO

-- Operatore: Via Ferrata Specialist
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM zones WHERE name = 'Val di Fassa'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM activities WHERE name = 'Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM activities WHERE name = 'Corsi Base Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), (SELECT id FROM activities WHERE name = 'Corsi'));
GO

-- Operatore: Trekking Laghi Alpini
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM zones WHERE name = 'Val Pusteria'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), (SELECT id FROM activities WHERE name = 'Escursioni ai Laghi'));
GO

-- Operatore: Guide Naturalistiche Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM zones WHERE name = 'Parco Naturale Fanes-Sennes-Braies')),
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM zones WHERE name = 'Parco Naturale Paneveggio-Pale di San Martino'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM activities WHERE name = 'Escursioni Naturalistiche')),
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM activities WHERE name = 'Birdwatching')),
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), (SELECT id FROM activities WHERE name = 'Flora & Fauna Tour'));
GO

-- Operatore: Centro Addestramento Cani da Ricerca (Valanghe/Superficie)
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM zones WHERE name = 'Corvara')),
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM zones WHERE name = 'Arabba'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM activities WHERE name = 'Corsi Base Sicurezza Neve (Valanghe/Superficie)')),
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), (SELECT id FROM activities WHERE name = 'Dimostrazioni Unità Cinofile'));
GO

-- Operatore: Noleggio Attrezzatura Sci & Snowboard
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Attrezzatura Sci & Snowboard'), (SELECT id FROM zones WHERE name = 'Ogni località sciistica principale'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio Attrezzatura Sci & Snowboard'), (SELECT id FROM activities WHERE name = 'Noleggio Attrezzatura Sci & Snowboard')),
((SELECT id FROM operators WHERE name = 'Noleggio Attrezzatura Sci & Snowboard'), (SELECT id FROM activities WHERE name = 'Noleggio Attrezzatura (Sci, Snowboard, Scarponi, Caschi)'));
GO

-- Operatore: Corso Introduzione Arrampicata
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), (SELECT id FROM zones WHERE name = 'Dintorni Bolzano')),
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), (SELECT id FROM zones WHERE name = 'Val Gardena (rocce attrezzate)'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), (SELECT id FROM activities WHERE name = 'Arrampicata (Corsi Base Indoor/Outdoor)'));
GO

-- Operatore: E-Bike Tours Panoramici
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), (SELECT id FROM zones WHERE name = 'Alta Badia')),
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), (SELECT id FROM zones WHERE name = 'Passo Giau'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), (SELECT id FROM activities WHERE name = 'E-Bike Tours Panoramici'));
GO

-- Operatore: Campeggio Verde Montagna
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), (SELECT id FROM zones WHERE name = 'Val Pusteria')),
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), (SELECT id FROM zones WHERE name = 'San Candido Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), (SELECT id FROM activities WHERE name = 'Campeggio'));
GO

-- Operatore: Guide Alta Quota
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Marmolada')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Gruppo Sella')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM zones WHERE name = 'Pale di San Martino'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM activities WHERE name = 'Alpinismo')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM activities WHERE name = 'Trekking Alta Quota')),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), (SELECT id FROM activities WHERE name = 'Cime'));
GO

-- Operatore: Ciaspolata Sotto le Stelle
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), (SELECT id FROM activities WHERE name = 'Ciaspole (Escursioni Notturne)'));
GO

-- Operatore: Parapendio Dolomiti Fly
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Dolomiti Fly'), (SELECT id FROM zones WHERE name = 'Bassano del Grappa (vicino Dolomiti, noto punto di volo)'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Parapendio Dolomiti Fly'), (SELECT id FROM activities WHERE name = 'Parapendio')),
((SELECT id FROM operators WHERE name = 'Parapendio Dolomiti Fly'), (SELECT id FROM activities WHERE name = 'Corsi Parapendio'));
GO

-- Operatore: Trekking Family Friendly
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM zones WHERE name = 'Val di Fiemme')),
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM zones WHERE name = 'Alta Pusteria'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), (SELECT id FROM activities WHERE name = 'Escursioni per Famiglie'));
GO

-- Operatore: Noleggio E-Bike Dolomiti Adventure
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo')),
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM zones WHERE name = 'Misurina'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM activities WHERE name = 'Noleggio E-Bike')),
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), (SELECT id FROM activities WHERE name = 'E-Bike Delivery'));
GO

-- Operatore: Scuola Sci & Snowboard Cortina
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), (SELECT id FROM zones WHERE name = 'Cortina d''Ampezzo'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), (SELECT id FROM activities WHERE name = 'Sci Alpino')),
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), (SELECT id FROM activities WHERE name = 'Snowboard')),
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), (SELECT id FROM activities WHERE name = 'Maestri Private'));
GO

-- Operatore: Campeggio Vista Tre Cime
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Vista Tre Cime'), (SELECT id FROM zones WHERE name = 'Tre Cime di Lavaredo Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Campeggio Vista Tre Cime'), (SELECT id FROM activities WHERE name = 'Campeggio'));
GO

-- Operatore: Guide Alpine San Martino
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM zones WHERE name = 'Pale di San Martino')),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM zones WHERE name = 'San Martino di Castrozza'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM activities WHERE name = 'Trekking')),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM activities WHERE name = 'Arrampicata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM activities WHERE name = 'Via Ferrata')),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), (SELECT id FROM activities WHERE name = 'Sci Alpinismo'));
GO

-- Operatore: Ciaspole Panoramiche Val Gardena
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM zones WHERE name = 'Val Gardena')),
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM zones WHERE name = 'Alpe di Siusi'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM activities WHERE name = 'Ciaspole (Snowshoeing)')),
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), (SELECT id FROM activities WHERE name = 'Escursioni Invernali'));
GO

-- Operatore: Mountain Bike Trails Cadore
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM zones WHERE name = 'Cadore')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM zones WHERE name = 'Auronzo Area'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM activities WHERE name = 'Mountain Bike')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM activities WHERE name = 'Noleggio MTB')),
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), (SELECT id FROM activities WHERE name = 'Tour Guidati'));
GO

-- Operatore: Corso di Sopravvivenza Montana
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso di Sopravvivenza Montana'), (SELECT id FROM zones WHERE name = 'Zone boschive e remote'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Corso di Sopravvivenza Montana'), (SELECT id FROM activities WHERE name = 'Survival')),
((SELECT id FROM operators WHERE name = 'Corso di Sopravvivenza Montana'), (SELECT id FROM activities WHERE name = 'Corsi Base Montagna'));
GO

-- Operatore: Centro Parco Naturale Dolomiti Friulane
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), (SELECT id FROM zones WHERE name = 'Dolomiti Friulane'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), (SELECT id FROM activities WHERE name = 'Escursioni Guidate')),
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), (SELECT id FROM activities WHERE name = 'Attività Didattiche')),
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), (SELECT id FROM activities WHERE name = 'Informazioni Parco'));
GO

-- Operatore: Avventura Speleologica Dolomiti
INSERT INTO operator_zones (operator_id, zone_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Speleologica Dolomiti'), (SELECT id FROM zones WHERE name = 'Zone Carsiche'));
INSERT INTO operator_activities (operator_id, activity_id) VALUES
((SELECT id FROM operators WHERE name = 'Avventura Speleologica Dolomiti'), (SELECT id FROM activities WHERE name = 'Speleologia (Esplorazione Grotte)'));
GO

-- Fine script