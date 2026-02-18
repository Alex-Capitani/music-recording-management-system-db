/* ==========================================================
   Music Recording Database - Query Exercises
   ========================================================== */

USE musicdb;

/* ==========================================================
   Query 01 - Retrieve the Singer(s) with the Lowest Number of Recordings (Including Ties)
   ========================================================== */

SELECT c.nome_cantor
FROM cantor c
LEFT JOIN gravacao g ON g.cod_cantor = c.cod_cantor
GROUP BY c.cod_cantor, c.nome_cantor
HAVING COUNT(g.cod_gravacao) = (
    SELECT MIN(qtd)
    FROM (
        SELECT COUNT(g2.cod_gravacao) AS qtd
        FROM cantor c2
        LEFT JOIN gravacao g2 ON g2.cod_cantor = c2.cod_cantor
        GROUP BY c2.cod_cantor
    ) t
);


/* ==========================================================
   Query 02 - Retrieve the Singer(s) Who Recorded with the Highest Number of Distinct Labels
   ========================================================== */

SELECT c.nome_cantor
FROM cantor c
JOIN gravacao g ON g.cod_cantor = c.cod_cantor
GROUP BY c.cod_cantor, c.nome_cantor
HAVING COUNT(DISTINCT g.cod_gravadora) = (
    SELECT MAX(qtd)
    FROM (
        SELECT COUNT(DISTINCT g2.cod_gravadora) AS qtd
        FROM gravacao g2
        GROUP BY g2.cod_cantor
    ) t
);


/* ==========================================================
   Query 03 - Retrieve the Singer(s) with the Highest Average Song Duration
   ========================================================== */

SELECT c.nome_cantor
FROM cantor c
JOIN gravacao g ON g.cod_cantor = c.cod_cantor
JOIN musica m   ON m.cod_musica = g.cod_musica
GROUP BY c.cod_cantor, c.nome_cantor
HAVING AVG(m.duracao) = (
    SELECT MAX(media_duracao)
    FROM (
        SELECT AVG(m2.duracao) AS media_duracao
        FROM gravacao g2
        JOIN musica m2 ON m2.cod_musica = g2.cod_musica
        GROUP BY g2.cod_cantor
    ) t
);


/* ==========================================================
   Query 04 - Retrieve the Singers Who Have Never Recorded with the Label 'Sony'
   ========================================================== */

SELECT c.nome_cantor
FROM cantor c
WHERE NOT EXISTS (
    SELECT 1
    FROM gravacao g
    JOIN gravadora gr ON gr.cod_gravadora = g.cod_gravadora
    WHERE g.cod_cantor = c.cod_cantor
      AND gr.nome_gravadora = 'Sony'
)
ORDER BY c.nome_cantor;


/* ==========================================================
   Query 05 - Retrieve Songs, Singers, and Recording Dates for Recordings from the Year 2004
   ========================================================== */

SELECT m.titulo       AS musica,
       c.nome_cantor  AS cantor,
       g.data_gravacao
FROM gravacao g
JOIN musica m ON m.cod_musica = g.cod_musica
JOIN cantor c ON c.cod_cantor = g.cod_cantor
WHERE YEAR(g.data_gravacao) = 2004
ORDER BY g.data_gravacao, m.titulo, c.nome_cantor;


/* ==========================================================
   Query 06 - Retrieve Each Singer and the Date of Their Most Recent Recording (NULL if None)
   ========================================================== */

SELECT c.nome_cantor,
       MAX(g.data_gravacao) AS ultima_gravacao
FROM cantor c
LEFT JOIN gravacao g ON g.cod_cantor = c.cod_cantor
GROUP BY c.cod_cantor, c.nome_cantor
ORDER BY ultima_gravacao DESC;


/* ==========================================================
   Query 07 - Retrieve Residential, Business, and Mobile Phone Numbers for Each Person in a Single Row
   ========================================================== */

SELECT p.nome_pessoa AS nome,
       MAX(CASE WHEN f.tipo = 'R' THEN f.numero END) AS residencial,
       MAX(CASE WHEN f.tipo = 'L' THEN f.numero END) AS comercial,
       MAX(CASE WHEN f.tipo = 'C' THEN f.numero END) AS celular
FROM pessoa p
LEFT JOIN fone f ON f.cod_pessoa = p.cod_pessoa
GROUP BY p.cod_pessoa, p.nome_pessoa
ORDER BY p.nome_pessoa;
