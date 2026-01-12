IF OBJECT_ID('dbo.user_favorite_operators', 'U') IS NOT NULL DROP TABLE dbo.zones;

CREATE TABLE user_favorite_operators (
    user_id INT NOT NULL,
    operator_id INT NOT NULL,
    PRIMARY KEY (user_id, operator_id), -- La coppia utente-operatore deve essere unica
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (operator_id) REFERENCES operators(id) ON DELETE CASCADE
);
GO