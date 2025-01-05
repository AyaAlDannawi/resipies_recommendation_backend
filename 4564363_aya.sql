-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: fdb1029.awardspace.net
-- Generation Time: Jan 03, 2025 at 04:22 PM
-- Server version: 8.0.32
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `4564363_aya`
--

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Tomato', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(2, 'Cucumber', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(3, 'Carrot', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(4, 'Lettuce', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(5, 'Spinach', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(6, 'Chicken', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(7, 'Beef', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(8, 'Olive Oil', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(9, 'Garlic', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(10, 'Pepper', '2025-01-03 11:34:55', '2025-01-03 11:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `flavor` enum('Sweet','Salty') DEFAULT NULL,
  `vegan` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `name`, `flavor`, `vegan`, `created_at`, `updated_at`) VALUES
(1, 'Pasta with Tomato Sauce', 'Salty', 1, '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(2, 'Chocolate Cake', 'Sweet', 0, '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(3, 'Omelette', 'Salty', 0, '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(4, 'Fruit Salad', 'Sweet', 1, '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(5, 'Vegan Tacos', 'Salty', 1, '2025-01-03 11:34:55', '2025-01-03 11:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ingredients`
--

CREATE TABLE `recipe_ingredients` (
  `recipe_id` int DEFAULT NULL,
  `ingredient_id` int DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `recipe_ingredients`
--

INSERT INTO `recipe_ingredients` (`recipe_id`, `ingredient_id`, `quantity`) VALUES
(1, 1, '2 Tomatoes'),
(1, 8, '3 tbsp Olive Oil'),
(1, 9, '2 cloves Garlic'),
(2, 6, '100g Chicken'),
(2, 10, '1 tsp Pepper'),
(3, 6, '2 Eggs'),
(3, 9, '1 clove Garlic'),
(4, 1, '2 Tomatoes'),
(4, 3, '2 Carrots'),
(5, 4, '1 Lettuce'),
(5, 5, '1 Spinach');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', 'john.doe@example.com', 'password123', '2025-01-03 11:34:55', '2025-01-03 11:34:55'),
(2, 'Jane Smith', 'jane.smith@example.com', 'securepassword', '2025-01-03 11:34:55', '2025-01-03 11:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `user_history`
--

CREATE TABLE `user_history` (
  `user_id` int DEFAULT NULL,
  `recipe_id` int DEFAULT NULL,
  `searched_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_history`
--

INSERT INTO `user_history` (`user_id`, `recipe_id`, `searched_at`) VALUES
(1, 1, '2025-01-03 11:34:55'),
(1, 3, '2025-01-03 11:34:55'),
(2, 4, '2025-01-03 11:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `user_ingredients`
--

CREATE TABLE `user_ingredients` (
  `user_id` int DEFAULT NULL,
  `ingredient_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_ingredients`
--

INSERT INTO `user_ingredients` (`user_id`, `ingredient_id`, `created_at`) VALUES
(1, 1, '2025-01-03 11:34:55'),
(1, 4, '2025-01-03 11:34:55'),
(2, 6, '2025-01-03 11:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `user_id` int DEFAULT NULL,
  `selected_flavor` enum('Sweet','Salty') DEFAULT NULL,
  `vegan_only` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_preferences`
--

INSERT INTO `user_preferences` (`user_id`, `selected_flavor`, `vegan_only`) VALUES
(1, 'Salty', 0),
(2, 'Sweet', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD KEY `recipe_id` (`recipe_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_history`
--
ALTER TABLE `user_history`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `user_ingredients`
--
ALTER TABLE `user_ingredients`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ingredient_id` (`ingredient_id`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipe_ingredients`
--
ALTER TABLE `recipe_ingredients`
  ADD CONSTRAINT `recipe_ingredients_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`),
  ADD CONSTRAINT `recipe_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);

--
-- Constraints for table `user_history`
--
ALTER TABLE `user_history`
  ADD CONSTRAINT `user_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_history_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`);

--
-- Constraints for table `user_ingredients`
--
ALTER TABLE `user_ingredients`
  ADD CONSTRAINT `user_ingredients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_ingredients_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`);

--
-- Constraints for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
