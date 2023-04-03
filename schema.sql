/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INTEGER,
  name VARCHAR(255),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(10,2)
);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Modify the id column to be autoincremented and set as primary key
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

-- Remove the species column
ALTER TABLE animals DROP COLUMN IF EXISTS species;

-- Add the species_id column as a foreign key referencing the species table
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add the owner_id column as a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

