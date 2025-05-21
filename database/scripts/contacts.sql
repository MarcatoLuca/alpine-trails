IF OBJECT_ID('dbo.contacts', 'U') IS NOT NULL DROP TABLE dbo.contacts;
IF OBJECT_ID('dbo.operators', 'U') IS NOT NULL DROP TABLE dbo.operators;

CREATE TABLE operators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE, -- Nome dell'operatore
    description VARCHAR(MAX)
);
GO

CREATE TABLE contacts (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Lascia che SQL Server generi l'ID del contatto
    operator_id INT UNIQUE NOT NULL, -- Un contatto per operatore, UNIQUE assicura 1 a 1
    phone VARCHAR(50),
    email VARCHAR(255),
    website VARCHAR(255),
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE
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

-- Popolamento della tabella contacts
-- Questa sezione ha funzionato correttamente
INSERT INTO contacts (operator_id, phone, email, website) VALUES
((SELECT id FROM operators WHERE name = 'Dolomiti Trekking Guide'), '+39 345 1234567', 'info@dolomitisentieri.it', 'www.dolomitisentieri.it'),
((SELECT id FROM operators WHERE name = 'Centro Campeggio Cime Aperte'), '+39 0436 123456', 'prenota@campeggiocortina.it', 'www.campeggiocortina.it'),
((SELECT id FROM operators WHERE name = 'Avventura Dolomitica'), '+39 335 9876543', 'info@avventuradolomiti.it', 'www.avventuradolomiti.it'),
((SELECT id FROM operators WHERE name = 'Bike Explore Dolomites'), '+39 348 7654321', 'bike@exploredolomites.com', 'www.exploredolomites.com'),
((SELECT id FROM operators WHERE name = 'Sci & Neve Valleys'), '+39 0471 234567', 'scuola@scivalleys.it', 'www.scivalleys.it'),
((SELECT id FROM operators WHERE name = 'Snowshoeing Secrets'), '+39 329 8765432', 'info@snowshoedolomites.com', 'www.snowshoedolomites.com'),
((SELECT id FROM operators WHERE name = 'Parapendio Cime Volanti'), '+39 333 1122334', 'vola@cimevolanti.it', 'www.cimevolanti.it'),
((SELECT id FROM operators WHERE name = 'Horse Riding Dolomiti'), '+39 340 5566778', 'cavalli@dolomiti.it', 'www.horseridingdolomiti.it'),
((SELECT id FROM operators WHERE name = 'Centro Sci Alpinismo Dolomites'), '+39 347 1231234', 'skialp@dolomites.com', 'www.skialpdolomites.com'),
((SELECT id FROM operators WHERE name = 'Foto Natura Dolomiti'), '+39 339 9876543', 'scatta@fotonaturadolomiti.it', 'www.fotonaturadolomiti.it'),
((SELECT id FROM operators WHERE name = 'Campeggio Sotto le Stelle'), '+39 0462 987654', 'info@campeggiosottolestelle.it', 'www.campeggiosottolestelle.it'),
((SELECT id FROM operators WHERE name = 'Guide Alpine Cortina'), '+39 0436 223344', 'guide@cortinaalpi.it', 'www.guidealpinecortina.it'),
((SELECT id FROM operators WHERE name = 'Dolomiti Bike Park Fun'), '+39 349 1234567', 'bikefun@dolomiti.com', 'www.dolomitibikeparkfun.it'),
((SELECT id FROM operators WHERE name = 'Ciaspole Dolomiti Orientali'), '+39 320 9876543', 'ciaspolecadore@gmail.com', NULL), -- Sito web NULL
((SELECT id FROM operators WHERE name = 'Centro Equitazione Alpe'), '+39 0471 876543', 'info@equitazionealpe.it', 'www.equitazionealpe.it'),
((SELECT id FROM operators WHERE name = 'Scuola Sci Val Badia'), '+39 0471 112233', 'info@scuolascivalbadia.it', 'www.scuolascivalbadia.it'),
((SELECT id FROM operators WHERE name = 'Dolomiti Avventura Park'), '+39 346 5566778', 'parcoavventura@dolomiti.it', 'www.dolomiavventurapark.it'),
((SELECT id FROM operators WHERE name = 'Guide Alpine Fassa'), '+39 0462 123123', 'info@guidefassane.it', 'www.guidefassane.it'),
((SELECT id FROM operators WHERE name = 'Noleggio Sport & Outdoor'), '+39 0436 554433', 'noleggio@sportsdolomiti.it', 'www.noleggiosportsdolomiti.it'),
((SELECT id FROM operators WHERE name = 'Trekking & Sapori Ladini'), '+39 338 1122334', 'saporiladini@trekking.it', 'www.trekkingesapori.it'),
((SELECT id FROM operators WHERE name = 'Campeggio Dolomiti Centrali'), '+39 0474 876543', 'prenota@campcentrali.it', 'www.campeggidolomiticentrali.it'),
((SELECT id FROM operators WHERE name = 'Sci Fuoripista Group'), '+39 345 6789012', 'info@freeridearabba.it', 'www.freeridearabba.it'),
((SELECT id FROM operators WHERE name = 'Mountain Bike Val Del Sole (vicino Dolomiti)'), '+39 0463 112233', 'bike@valdisole.it', 'www.valdisolebikeland.com'),
((SELECT id FROM operators WHERE name = 'Via Ferrata Specialist'), '+39 331 2345678', 'ferrate@specialist.it', 'www.viaferrataspecialist.it'),
((SELECT id FROM operators WHERE name = 'Trekking Laghi Alpini'), '+39 340 1234567', 'laghialpini@trekking.it', NULL), -- Sito web NULL
((SELECT id FROM operators WHERE name = 'Guide Naturalistiche Dolomiti'), '+39 339 1122334', 'info@guidefaunaflora.it', 'www.guidenaturalistichedolomiti.it'),
((SELECT id FROM operators WHERE name = 'Centro Addestramento Cani da Ricerca (Valanghe/Superficie)'), '+39 348 9876543', 'caniuniti@sicurezzaneve.it', 'www.sicurezzaneve.it'),
((SELECT id FROM operators WHERE name = 'Noleggio Attrezzatura Sci & Snowboard'), '+39 0471 223344', 'noleggio@skiworld.it', 'www.noleggioskiworld.it'),
((SELECT id FROM operators WHERE name = 'Corso Introduzione Arrampicata'), '+39 333 9876543', 'arrampicabase@climb.it', NULL), -- Sito web NULL
((SELECT id FROM operators WHERE name = 'E-Bike Tours Panoramici'), '+39 347 1122334', 'ebike@panoramici.it', 'www.ebiketourpanoramici.it'), -- Nota: Corretto il sito web in base all'OCR
((SELECT id FROM operators WHERE name = 'Campeggio Verde Montagna'), '+39 0474 123456', 'info@campeggioverdemontagna.it', 'www.campeggioverdemontagna.it'),
((SELECT id FROM operators WHERE name = 'Guide Alta Quota'), '+39 349 9876543', 'altaquota@guides.it', 'www.guidealtaquota.it'),
((SELECT id FROM operators WHERE name = 'Ciaspolata Sotto le Stelle'), '+39 338 5566778', 'ciaspolenotturne@dolomiti.it', NULL), -- Sito web NULL
((SELECT id FROM operators WHERE name = 'Parapendio Dolomiti Fly'), '+39 340 1122334', 'fly@dolomiti.com', 'www.parapendiodolomitifly.it'),
((SELECT id FROM operators WHERE name = 'Trekking Family Friendly'), '+39 339 6543210', 'famiglia@trekkingdolomiti.it', 'www.trekkingfamilyfriendly.it'),
((SELECT id FROM operators WHERE name = 'Noleggio E-Bike Dolomiti Adventure'), '+39 348 1234567', 'noleggio@ebikeadventure.it', 'www.noleggioebikedolomiti.it'),
((SELECT id FROM operators WHERE name = 'Scuola Sci & Snowboard Cortina'), '+39 0436 112233', 'info@scuolascicortina.it', 'www.scuolascicortina.it'),
((SELECT id FROM operators WHERE name = 'Campeggio Vista Tre Cime'), '+39 0434 987654', 'prenota@campeggiotrecime.it', 'www.campeggiovistatrecime.it'),
((SELECT id FROM operators WHERE name = 'Guide Alpine San Martino'), '+39 0439 123123', 'info@guidesanmartino.it', 'www.guidealpinesanmartino.it'),
((SELECT id FROM operators WHERE name = 'Ciaspole Panoramiche Val Gardena'), '+39 335 1234567', 'ciaspolevg@dolomiti.it', 'www.ciaspoledolomiti.it'),
((SELECT id FROM operators WHERE name = 'Mountain Bike Trails Cadore'), '+39 340 9876543', 'bikecadore@trails.it', 'www.mbtcai.it'),
((SELECT id FROM operators WHERE name = 'Corso di Sopravvivenza Montana'), '+39 333 1122334', 'survival@montagna.it', 'www.sopravvivenzadolomiti.it'),
((SELECT id FROM operators WHERE name = 'Centro Parco Naturale Dolomiti Friulane'), '+39 0434 112233', 'info@parcodolomitifriulane.it', 'www.parcodolomitifriulane.it'),
((SELECT id FROM operators WHERE name = 'Avventura Speleologica Dolomiti'), '+39 345 5566778', 'grotte@speleo.it', 'www.speleodolomiti.it');
GO