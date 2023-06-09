/* Database schema to keep the structure of entire database. */

--Create table
    CREATE TABLE animals(
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL, 
        date_of_birth DATE NOT NULL, 
        escape_attempts INT NOT NULL, 
        neutered BOOLEAN NOT NULL, 
        weight_kg DECIMAL NOT NULL
        )

--update table col
ALTER TABLE animals ADD COLUMN species VARCHAR(50);

-- BEGIN; COMMIT; ROLLBACK; transactions
BEGIN;
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Create more tables
CREATE TABLE owners(
    id BIGSERIAL PRIMARY KEY, 
    full_name VARCHAR(50) NOT NULL, 
    age INT NOT NULL);

CREATE TABLE species(
    id BIGSERIAL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL);
    
-- Add references to the parent table
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id); 
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);

--CREATE TABLE VETS
CREATE TABLE vets (
        id BIGSERIAL PRIMARY KEY, 
        name VARCHAR(50) NOT NULL,
        age INT NOT NULL,
        date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
        id BIGSERIAL PRIMARY KEY, 
        vets_id INT REFERENCES vets(id), 
        species_id INT REFERENCES species(id)
);

CREATE TABLE visits (
    id BIGSERIAL PRIMARY KEY,
    animals_id INT REFERENCES animals(id),
    vets_id INT REFERENCES vets(id),
    visit_date DATE NOT NULL
);



        

