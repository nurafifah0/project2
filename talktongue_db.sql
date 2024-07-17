-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2024 at 05:43 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `talktongue_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accsetting`
--

CREATE TABLE `tbl_accsetting` (
  `user_id` int(11) NOT NULL,
  `user_age` int(11) NOT NULL,
  `user_nativelang` varchar(16) NOT NULL,
  `user_learninglang` varchar(16) NOT NULL,
  `user_fluency` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_messages`
--

CREATE TABLE `tbl_messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_by_sender` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_by_receiver` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_messages`
--

INSERT INTO `tbl_messages` (`message_id`, `sender_id`, `receiver_id`, `content`, `timestamp`, `deleted_by_sender`, `deleted_by_receiver`) VALUES
(3, 1, 9, 'hi nikki am nana 😊', '2024-07-02 16:38:02', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_moments`
--

CREATE TABLE `tbl_moments` (
  `post_id` int(255) NOT NULL,
  `user_id` varchar(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `post_deets` varchar(2000) NOT NULL,
  `post_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_moments`
--

INSERT INTO `tbl_moments` (`post_id`, `user_id`, `user_name`, `post_deets`, `post_date`) VALUES
(7, '1', 'nana', 'hi', '2024-06-03 19:38:57.329420'),
(8, '7', 'nora', 'its me nora', '2024-06-03 20:04:53.906324'),
(9, '1', 'nana', 'its me nana', '2024-06-03 20:13:09.821231');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(4) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_password`, `user_datereg`) VALUES
(1, 'nana@gmail.com', 'nana', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '2023-12-18 21:22:01.126528'),
(7, 'nora@gmail.com', 'nora', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '2023-12-18 21:53:47.982680'),
(9, 'nikki@gmail.com', 'nikki', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '2024-06-06 22:33:37.199392'),
(10, 'syed@gmail.com', 'syed', '8b14cb697a5c1a25281711cec11b7d39a00f9bcc', '2024-06-07 22:10:16.817675');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_accsetting`
--
ALTER TABLE `tbl_accsetting`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `tbl_messages`
--
ALTER TABLE `tbl_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `receiver_id` (`receiver_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `tbl_moments`
--
ALTER TABLE `tbl_moments`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_messages`
--
ALTER TABLE `tbl_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_moments`
--
ALTER TABLE `tbl_moments`
  MODIFY `post_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_messages`
--
ALTER TABLE `tbl_messages`
  ADD CONSTRAINT `tbl_messages_ibfk_1` FOREIGN KEY (`receiver_id`) REFERENCES `tbl_users` (`user_id`),
  ADD CONSTRAINT `tbl_messages_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `tbl_users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
