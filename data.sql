/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
(1, 'Agumon', '2020-02-03', 0, true, 10.23),
(2, 'Gabumon', '2018-11-15', 2, true, 8),
(3, 'Pikachu', '2021-01-07', 1, false, 15.04),
(4, 'Devimon', '2017-05-12', 5, true, 11);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES 
('Charmander', '2020-02-08', 0, false, -11, 'unknown'),
('Plantmon', '2021-11-15', 2, true, -5.7, 'unknown'),
('Squirtle', '1993-04-02', 3, false, -12.13, 'unknown'),
('Angemon', '2005-06-12', 1, true, -45, 'unknown'),
('Boarmon', '2005-06-07', 7, true, 20.4, 'unknown'),
('Blossom', '1998-10-13', 3, true, 17, 'unknown'),
('Ditto', '2022-05-14', 4, true, 22, 'unknown');

/*add new information day 3*/
INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Update animals table with owner information
UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');

-- Para hacer referencia al ID de animal en lugar del nombre, primero necesitamos conocer el ID correspondiente de cada animal en la tabla de animales. Luego podemos modificar las consultas INSERT INTO de visitas para hacer referencia al ID del animal en lugar del nombre.

-- Suponiendo que los IDs de animales son los siguientes:

-- Agumon: 1
-- Gabumon: 2
-- Pikachu: 3
-- Devimon: 4
-- Charmander: 5
-- Plantmon: 6
-- Squirtle: 7
-- Angemon: 8
-- Boarmon: 9
-- Blossom: 10
-- Las consultas actualizadas serían las siguientes:

INSERT INTO vets (nombre, edad, fecha_graduacion)
VALUES 
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

INSERT INTO specialties (vet_name, specialty)
VALUES 
('William Tatcher', 'Pokemon'),
('Stephanie Mendez', 'Digimon and Pokemon'),
('Jack Harkness', 'Digimon');

INSERT INTO visits (animal_name, vet_name, visit_date)
VALUES 
('Agumon', 'William Tatcher', '2020-05-24'),
('Agumon', 'Stephanie Mendez', '2020-07-22'),
('Gabumon', 'Jack Harkness', '2021-02-02'),
('Pikachu', 'Maisy Smith', '2020-01-05'),
('Pikachu', 'Maisy Smith', '2020-03-08'),
('Pikachu', 'Maisy Smith', '2020-05-14'),
('Devimon', 'Stephanie Mendez', '2021-05-04'),
('Charmander', 'Jack Harkness', '2021-02-24'),
('Plantmon', 'Maisy Smith', '2019-12-21'),
('Plantmon', 'William Tatcher', '2020-08-10'),
('Plantmon', 'Maisy Smith', '2021-04-07'),
('Squirtle', 'Stephanie Mendez', '2019-09-29'),
('Angemon', 'Jack Harkness', '2020-10-03'),
('Angemon', 'Jack Harkness', '2020-11-04'),
('Boarmon', 'Maisy Smith', '2019-01-24'),
('Boarmon', 'Maisy Smith', '2019-05-15'),
('Boarmon', 'Maisy Smith', '2020-02-27'),
('Boarmon', 'Maisy Smith', '2020-08-03'),
('Blossom', 'Stephanie Mendez', '2020-05-24'),
('Blossom', 'William Tatcher', '2021-01-11');
