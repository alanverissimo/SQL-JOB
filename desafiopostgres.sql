CREATE TABLE Livros
(
    L_id SERIAL PRIMARY KEY,
    nome  VARCHAR(255),
    ano DATE,
    reserva INTEGER,
    prateleira INTEGER
);
    INSERT INTO Livros (nome, ano, reserva, prateleira) VALUES('Senhor dos Aneis','2021-06-01', 15, 2);
    INSERT INTO Livros (nome, ano, reserva, prateleira) VALUES('Harry Potter e a Pedra Fiolosofal','2012-01-11',12, 1);
    INSERT INTO Livros (nome, ano, reserva, prateleira) VALUES('O Hobbit','2002-06-21',15, 2);
    INSERT INTO Livros (nome, ano, reserva, prateleira) VALUES('Duna,'2005-011-05',10, 2);
    
    SELECT * FROM Livros ORDER BY reserva DESC;
	
    SELECT L_id, nome, ano, reserva, prateleira FROM Livros livro, (SELECT AVG(reserva) media, prateleira prateleiramedia FROM Livros 
    GROUP BY prateleira) mediareserva WHERE livro.prateleira = mediareserva.prateleiramedia AND livro.reserva >= mediareserva.media
															   
	---------------------------------------------------------------------------------------------
	CREATE TABLE Mentores
(
    Mnt_id SERIAL PRIMARY KEY,
    nome  VARCHAR(255),
	turma VARCHAR(255)
);
    INSERT INTO Mentores(nome, turma) VALUES ('Paulo, 'Vertigo');
    INSERT INTO Mentores(nome, turma) VALUES ('Jorge', 'Vertigo');
    INSERT INTO Mentores(nome, turma) VALUES ('Pedro', 'Five Academy');  
	
    SELECT * FROM Mentores			
															   
	---------------------------------------------------------------------------------------------
															   
 CREATE TABLE Postagens(
    Post_id SERIAL PRIMARY KEY,
    Mnt_id SERIAL,
    texto VARCHAR(255), 
    FOREIGN KEY (Mnt_id) REFERENCES Mentores(Mnt_id)
);
    INSERT INTO Postagens(Mnt_id, texto) VALUES (1, 'Java');
    INSERT INTO Postagens(Mnt_id, texto) VALUES (2, 'JavaScript');
    INSERT INTO Postagens(Mnt_id, texto) VALUES (3, 'Node.JS');
    INSERT INTO Postagens(Mnt_id, texto) VALUES (4, 'PostgreSQL');
	
    SELECT * FROM Postagens
															   
	---------------------------------------------------------------------------------------------
															   
	CREATE TABLE Curtidas(
    M_id SERIAL,
    P_id SERIAL,
	curtidas INTEGER,
    FOREIGN KEY (Mnt_id) REFERENCES Mentores(Mnt_id),
    FOREIGN KEY (Post_id) REFERENCES Postagens(Post_id)
);
    INSERT INTO Curtidas(Mnt_id, Post_id, curtidas) VALUES (1,4,10);
    INSERT INTO Curtidas(Mnt_id, Post_id, curtidas) VALUES (2,3,7);
    INSERT INTO Curtidas(Mnt_id, Post_id, curtidas) VALUES (3,2,15);
    INSERT INTO Curtidas(Mnt_id, Post_id, curtidas) VALUES (4,1,3);
	
    SELECT * FROM Curtidas
															   
	SELECT nome, curtidas FROM Mentores, Curtidas WHERE Mentores.Mnt_id = Curtidas.Mnt_id GROUP BY(nome, curtidas) ORDER BY Curtidas DESC
	
    SELECT L_id, nome, ano, reserva, prateleira FROM Livros livro, (SELECT AVG(reserva) media, prateleira prateleiramedia FROM Livros 
    GROUP BY prateleira) mediareserva WHERE livro.prateleira = mediareserva.prateleiramedia AND livro.reserva >= mediareserva.media
    
    SELECT turma, Post_id FROM Mentores INNER JOIN Curtidas ON Mentores.Mnt_id = Curtidas.Mnt_id ORDER BY turma;
    
    SELECT turma, ROUND( AVG(P_id)::numeric, 2 ) AS media FROM Mentores INNER JOIN Curtidas ON Mentores.Mnt_id = Curtidas.Mnt_id GROUP BY(turma);