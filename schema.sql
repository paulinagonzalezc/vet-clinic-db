/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    ID INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species VARCHAR(100)
);

-- Alter table to add species
ALTER TABLE animals ADD species VARCHAR(100);

--Create owners table

CREATE TABLE owners (
    id SERIAL,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

--Create species table
CREATE TABLE species (
    id SERIAL,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

-- Remove species columns
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owners_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id) REFERENCES owners(id);

-- Create vets table

CREATE TABLE vets (
    id SERIAL,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

-- Create Join Table Specializations

CREATE TABLE specializations (
  vets_id INT NOT NULL,
  species_id INT NOT NULL,
  FOREIGN KEY (vets_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

-- Create Join Table Visits

CREATE TABLE visits(
  vets_id INT NOT NULL,
  animals_id INT NOT NULL,
  date_of_visit DATE,
  FOREIGN KEY (vets_id) REFERENCES vets (id),
  FOREIGN KEY (animals_id) REFERENCES animals (id)
);

-- PERFORMANCE

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Add index for SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX animals_id_asc ON visits(animals_id ASC);

-- Add index for SELECT * FROM visits where vet_id = 2;
CREATE INDEX vets_id_asc ON visits(vets_id ASC);

-- Add index for SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX email_asc ON owners(email ASC);