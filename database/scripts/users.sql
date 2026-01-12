IF OBJECT_ID('dbo.users', 'U') IS NOT NULL DROP TABLE dbo.zones;

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,      -- L'email è spesso usata come username ed è unica
    hashed_password VARCHAR(255) NOT NULL,   -- MAI salvare password in chiaro!
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    created_at DATETIME2 DEFAULT GETDATE()   -- Data di registrazione
);
GO

INSERT INTO users (email, hashed_password, first_name, last_name)
VALUES ('admin@alpinetrails.com', '','Admin', 'User');
GO