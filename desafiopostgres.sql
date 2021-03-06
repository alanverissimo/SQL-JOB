CREATE TABLE livros (
    livro_id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    ano INTEGER,
    maximo_tempo_reserva INTEGER,
    prateleira INTEGER,
);

INSERT INTO livros (nome, ano, maximo_tempo_reserva, prateleira) VALUES ('Senhor dos Anéis', 2001, 11, 23);
INSERT INTO livros (nome, ano, maximo_tempo_reserva, prateleira) VALUES ('Harry Potter e a Pedra Filosofal', 1999, 5, 16);
INSERT INTO livros (nome, ano, maximo_tempo_reserva, prateleira) VALUES ('O Hobbit', 2004, 16, 23);
INSERT INTO livros (nome, ano, maximo_tempo_reserva, prateleira) VALUES ('Duna', 2003, 1, 25);
    
SELECT livro_id, nome, maximo_tempo_reserva 
FROM livros
WHERE maximo_tempo_reserva > (
    SELECT AVG(maximo_tempo_reserva)::NUMERIC(12,2) as media_de_tempo 
    FROM livros 
    GROUP BY prateleira
    LIMIT 1
) ORDER BY livro_id;

---------------------------------------------------------------------------------------------------

CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    mnt_id SERIAL,
    descricao VARCHAR(255),
    
    FOREIGN KEY (mnt_id) REFERENCES mentores (mnt_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE curtidas (
    mnt_id SERIAL,
    post_id SERIAL,
    
    PRIMARY KEY (mnt_id, post_id),
    FOREIGN KEY (mnt_id) REFERENCES mentores (mnt_id),
    FOREIGN KEY (post_id) REFERENCES posts (post_id)
);

INSERT INTO mentores (nome, sala_de_aula) VALUES ('Warren Buffett', 'Sala de Aula Torvalds');
INSERT INTO mentores (nome, sala_de_aula) VALUES ('Steven Spielberg', 'Sala de Aula Gates');
INSERT INTO mentores (nome, sala_de_aula) VALUES ('Socrates', 'Sala de Aula Jobs');

INSERT INTO posts (mnt_id, descricao) VALUES (1, 'Post 01');
INSERT INTO posts (mnt_id, descricao) VALUES (1, 'Post 02');
INSERT INTO posts (mnt_id, descricao) VALUES (3, 'Post 03');

INSERT INTO curtidas (mnt_id, post_id) VALUES (1, 1);
INSERT INTO curtidas (mnt_id, post_id) VALUES (3, 2);
INSERT INTO curtidas (mnt_id, post_id) VALUES (3, 3);

-----------------------------------------------------------------

SELECT mentores.nome, COUNT(curtidas.mnt_id) AS curtidas 
FROM mentores 
INNER JOIN curtidas ON curtidas.mnt_id = mentores.mnt_id 
GROUP BY 1 
ORDER BY 1

--------------------------------------------------------------

SELECT mentores.sala_de_aula, curtidas.post_id 
FROM mentores 
INNER JOIN curtidas ON curtidas.mnt_id = mentores.mnt_id 
GROUP BY 1, 2 
ORDER BY 2

------------------------------------------------------------------

SELECT mentores.sala_de_aula, AVG(curtidas.post_id)::NUMERIC(11,1) as media
FROM mentores 
INNER JOIN curtidas ON curtidas.mnt_id = mentores.mnt_id 
GROUP BY mentores.sala_de_aula										   

-----------------------------------------------------------------------
	
	