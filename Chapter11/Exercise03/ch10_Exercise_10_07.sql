USE world;

FROM worldcol WHERE doc->'$.is_capital'=TRUE
ORDER BY doc->'$.country.surface_area' DESC LIMIT 5

SELECT
  doc->>'$.name' AS city_name, 
  doc->>'$.country.name' AS country_name

SELECT
  doc->>'$.name' AS city_name,
  doc->>'$.country.name' AS country_name 
FROM worldcol
WHERE doc->'$.is_capital'=TRUE
ORDER BY doc->'$.country.surface_area' DESC LIMIT 5;
