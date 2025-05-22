-- Verifica se la tabella operators esiste e, in caso affermativo, la elimina
IF OBJECT_ID('dbo.operators', 'U') IS NOT NULL
    DROP TABLE dbo.operators;
GO

-- Creazione della tabella operators con i campi di contatto integrati
CREATE TABLE operators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,      -- Nome dell'operatore
    description VARCHAR(MAX),               -- Descrizione dell'operatore
    phone VARCHAR(50),                      -- Numero di telefono (precedentemente in contacts)
    email VARCHAR(255),                     -- Indirizzo email (precedentemente in contacts)
    website VARCHAR(255)                    -- Sito web (precedentemente in contacts)
);
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