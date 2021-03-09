-- b) Calculate the total number of Members of the Parliament that each party has got.
SELECT partido, SUM(mandatos)
FROM listas
GROUP BY partido;

-- c) In each district, how many votes got each party?
SELECT votacoes.partido, distritos.nome, sum(votacoes.votos)
FROM votacoes, freguesias, concelhos, distritos
WHERE votacoes.freguesia = freguesias.codigo AND freguesias.concelho = concelhos.codigo
AND concelhos.distrito = distritos.codigo
GROUP BY votacoes.partido, distritos.nome
ORDER BY distritos.nome

-- d) Find the names of the districts and the designations of the parties for the cases where the party got an absolute majority in the district (meaning more votes than the sum of the remaining lists).
SELECT Partido, Nome, DistrictVotes, PartyVotes FROM
    (SELECT distritos.nome AS Nome, sum(votacoes.votos) AS DistrictVotes
    FROM votacoes, freguesias, concelhos, distritos
    WHERE votacoes.freguesia = freguesias.codigo AND freguesias.concelho = concelhos.codigo
    AND concelhos.distrito = distritos.codigo
    GROUP BY distritos.nome
    ORDER BY distritos.nome),
    (SELECT partidos.designacao AS Partido, distritos.nome as Distrito, sum(votacoes.votos) AS PartyVotes
    FROM votacoes, freguesias, concelhos, distritos, partidos
    WHERE votacoes.freguesia = freguesias.codigo AND freguesias.concelho = concelhos.codigo
    AND concelhos.distrito = distritos.codigo AND partidos.sigla = votacoes.partido
    GROUP BY partidos.designacao, distritos.nome
    ORDER BY distritos.nome)
WHERE Distrito = Nome AND PartyVotes > DistrictVotes/2

-- e) Check whether any district violates the following integrity rule: the sum of the votes in the several lists, the white and the null votes, plus the number of abstentions must equal the number of enrolled citizens.
SELECT *
FROM distritos, participacoes
WHERE participacoes.distrito = distritos.codigo
AND participacoes.votantes + participacoes.abstencoes != participacoes.inscritos

-- f) Which are the diferences between the percentages of mandates and of votes for each party at the national level?
SELECT (PercentageOfMandatos-PercentageOfVotes) * 100

FROM
    (
    SELECT listas.partido, vote_percent AS PercentageOfVotes,
           (SUM(mandatos)/(SELECT SUM(mandatos) FROM listas)) AS PercentageOfMandatos
    FROM listas,
         (SELECT votacoes.partido AS Party, (SUM(votos)/(SELECT SUM(VOTOS) FROM VOTACOES)) AS vote_percent FROM votacoes GROUP BY votacoes.partido)
    WHERE listas.partido = Party
    GROUP BY listas.partido,vote_percent
    )


-- g) Which parties got Members of the Parliament in every district?
SELECT listas.partido
FROM listas, distritos
WHERE listas.distrito = distritos.codigo AND listas.mandatos > 0
GROUP BY listas.partido
HAVING count(distritos.codigo) = (SELECT count(DISTINCT(distritos.codigo)) FROM distritos)
ORDER BY listas.partido