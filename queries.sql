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

-- Write queries using JOIN

-- What animals belong to Melody Pond?
SELECT animals.name, animals.owners_id, owners.full_name, owners.id 
FROM animals INNER JOIN owners ON animals.owners_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, animals.species_id, species.name, species.id 
FROM animals INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name) from animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name, animals.name, species.name FROM animals
LEFT JOIN owners ON animals.owners_id = owners.id
LEFT JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' 
AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals
LEFT JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) FROM animals
LEFT JOIN owners ON animals.owners_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC LIMIT 1;