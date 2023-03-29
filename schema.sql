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
        

