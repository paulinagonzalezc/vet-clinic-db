/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);
-- New data
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '2022-05-14', 4, true, 22);

-- Owners data

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Species data

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Update animals data

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id is NULL;

UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';


-- Vets data 

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Specializations data 

INSERT INTO specializations(vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), 
(SELECT id FROM species WHERE name = 'Pokemon'));
INSERT INTO specializations(vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species WHERE name = 'Digimon'));
INSERT INTO specializations(vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species WHERE name = 'Pokemon'));
INSERT INTO specializations(vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), 
(SELECT id FROM species WHERE name = 'Digimon'));

-- Visits data
INSERT INTO visits(vets_id, animals_id, date_of_visit) 
VALUES 
      ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
      ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
      ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11'),

-- PERFORMANCE
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animals_id, (SELECT id FROM vets) vets_id, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';