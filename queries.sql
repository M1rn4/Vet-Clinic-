/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals; -- Verify that the species column has been updated

ROLLBACK;

SELECT * FROM animals; -- Verify that the species column has been rolled back to the original state

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

SELECT * FROM animals; -- Verify that the changes have been made and persisted

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

ROLLBACK;

SELECT * FROM animals; -- Verify that all records still exist

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT update_weights;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO update_weights;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

//How many animals are there?

SELECT COUNT(*) FROM animals;

// How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

// What the average weight_kg of animals

SELECT AVG(weight_kg) FROM animals;

// Who escapes the most, neutered  neutered animals?

SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

