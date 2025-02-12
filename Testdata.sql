-- Testdata vi gjort själva som kan behövas under utvecklingen läggs här. Kommer inte lämnas in.

-- Testdata courtesy of ChatGPT
-- Authors
INSERT INTO author (FName, LName)
VALUES ('John', 'Smith'),
       ('Jane', 'Doe'),
       ('Alice', 'Johnson'),
       ('Bob', 'Brown'),
       ('Charlie', 'Davis');

-- Library works (Books)
INSERT INTO librarywork (ItemType, Title, isCourseLiterature, isReferenceLiterature, DeweyDecimal, Keywords)
VALUES ('Book', 'Database Systems', FALSE, FALSE, 005.74, '"database, sql, design"'),
       ('Book', 'Computer Networks', FALSE, FALSE, 004.6, '"network, tcp/ip, security"'),
       ('Course literature', 'Algorithms and Data Structures', TRUE, FALSE, 005.1,
        '"algorithms, data structures, programming"'),
       ('Book', 'Machine Learning Basics', FALSE, FALSE, 006.3, '"ai, machine learning, python"'),
       ('Book', 'Cybersecurity Essentials', FALSE, FALSE, 005.8, '"security, encryption, hacking"'),
       ('Reference literature', 'Library Science Handbook', FALSE, TRUE, 020, '"library, science, management"'),
       ('Book', 'Software Engineering Principles', FALSE, FALSE, 005.1, '"software, engineering, development"'),
       ('Course literature', 'Operating System Concepts', TRUE, FALSE, 005.43, '"os, kernel, processes"'),
       ('Book', 'Artificial Intelligence: A Modern Approach', FALSE, FALSE, 006.3, '"ai, robotics, planning"'),
       ('Book', 'Ethical Hacking Guide', FALSE, FALSE, 005.8, '"hacking, cybersecurity, penetration testing"');

-- Work Authors
INSERT INTO work_author (AuthorID, WorkID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (1, 6),
       (2, 7),
       (3, 8),
       (4, 9),
       (5, 10);

-- Editions
INSERT INTO editions (EditionID, WorkID, ISBN, Publisher)
VALUES (1, 1, '9781234567890', 'Pearson'),
       (2, 2, '9780987654321', 'O\'Reilly'),
       (3, 3, '9781122334455', 'Springer'),
       (4, 4, '9782233445566', 'MIT Press'),
       (5, 5, '9783344556677', 'McGraw Hill'),
       (6, 6, '9785566778899', 'Elsevier'),
       (7, 7, '9786677889900', 'Cambridge Press'),
       (8, 8, '9787788990011', 'Addison-Wesley'),
       (9, 9, '9788899001122', 'John Wiley & Sons'),
       (10, 10, '9789900112233', 'Packt Publishing');

-- Users
INSERT INTO user (UserType, Fname, Lname, Email, Phone, Address)
VALUES ('Student', 'Alice', 'Smith', 'alice.smith@example.com', '1234567890', '123 Main St'),
       ('Teacher', 'Bob', 'Jones', 'bob.jones@example.com', '2345678901', '456 Elm St'),
       ('Researcher', 'Charlie', 'White', 'charlie.white@example.com', '3456789012', '789 Pine St'),
       ('Student', 'David', 'Black', 'david.black@example.com', '4567890123', '101 Maple St'),
       ('Teacher', 'Eva', 'Green', 'eva.green@example.com', '5678901234', '202 Oak St');

-- Reservations
INSERT INTO reservation (ReservationID, UserID, WorkID, ReservationDate)
VALUES (1, 1, 3, '2025-02-01'),
       (2, 2, 5, '2025-02-02'),
       (3, 3, 7, '2025-02-03'),
       (4, 4, 9, '2025-02-04'),
       (5, 5, 2, '2025-02-05');

-- Work Copies
INSERT INTO workcopy (Barcode, WorkID, isBorrowed)
VALUES (1001, 1, FALSE),
       (1002, 2, FALSE),
       (1003, 3, TRUE),
       (1004, 4, FALSE),
       (1005, 5, TRUE),
       (1006, 6, FALSE),
       (1007, 7, FALSE),
       (1008, 8, TRUE),
       (1009, 9, FALSE),
       (1010, 10, FALSE);

-- Fines
INSERT INTO fine (FineID, FineAmount, IssueDate, PaidDate)
VALUES (1, 50, '2025-01-15', NULL),
       (2, 100, '2025-01-20', '2025-01-25');

-- Loans
INSERT INTO loan (Barcode, UserID, FineID, BorrowDate, ReturnDate, NoLoanExtensions)
VALUES (1003, 1, NULL, '2025-01-10', '2025-02-10', 0),
       (1005, 2, 1, '2025-01-05', '2025-02-05', 1),
       (1008, 3, 2, '2025-01-15', '2025-02-15', 2);