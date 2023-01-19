/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name and escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered IS 'true';
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Update table

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
---
ROLLBACK;
SELECT species FROM animals;
---
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
---
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
---
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
SELECT * FROM animals;
---
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
---
ROLLBACK TO SAVEPOINT SP1;
SELECT * FROM animals;
---
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;
---

--Write queries
SELECT COUNT(*) FROM animals;
---
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;
---
SELECT AVG(weight_kg) FROM animals;
---
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY(neutered);
---
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY(species);
---
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY(species);
