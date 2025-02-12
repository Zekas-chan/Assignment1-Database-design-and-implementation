-- Skapar databasen samt lägger in värden i lookup-tables
-- Tinyint(1) = boolean

CREATE SCHEMA IF NOT EXISTS `Assignment_1_Design&Implement`;
USE `Assignment_1_Design&Implement`;

CREATE TABLE author
(
	AuthorID INT AUTO_INCREMENT PRIMARY KEY,
	FName    VARCHAR(50) NOT NULL,
	LName    VARCHAR(50) NOT NULL
);

CREATE TABLE fine
(
	FineID     INT  NOT NULL PRIMARY KEY,
	FineAmount INT  NULL,
	IssueDate  DATE NULL DEFAULT (CURRENT_DATE),
	PaidDate   DATE NULL
);

CREATE TABLE itemtype
(
	ItemType     VARCHAR(20)           NOT NULL PRIMARY KEY,
	loanDuration INT                   NOT NULL,
	Unit         ENUM ('day', 'month') NOT NULL
);

CREATE TABLE librarywork
(
	WorkID                INT AUTO_INCREMENT PRIMARY KEY,
	ItemType              VARCHAR(20) NULL,
	Title                 VARCHAR(50) NOT NULL,
	isCourseLiterature    TINYINT(1)  NOT NULL DEFAULT FALSE,
	isReferenceLiterature TINYINT(1)  NOT NULL DEFAULT FALSE,
	Keywords              BLOB        NULL
);

CREATE TABLE editions
(
	EditionID INT         NOT NULL PRIMARY KEY,
	WorkID    INT         NULL,
	ISBN      VARCHAR(13) NULL,
	Publisher VARCHAR(50) NULL,
	CONSTRAINT editions_ibfk_WorkID
		FOREIGN KEY (WorkID) REFERENCES librarywork (WorkID)
			ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE user
(
	UserID   INT AUTO_INCREMENT PRIMARY KEY,
	UserType VARCHAR(10)  NOT NULL,
	Fname    VARCHAR(50)  NOT NULL,
	Lname    VARCHAR(50)  NOT NULL,
	Email    VARCHAR(100) NULL,
	Phone    VARCHAR(50)  NULL,
	Address  VARCHAR(200) NULL
);

CREATE TABLE reservation
(
	ReservationID   INT  NOT NULL PRIMARY KEY,
	UserID          INT  NULL,
	WorkID          INT  NULL,
	ReservationDate DATE NULL DEFAULT (CURRENT_DATE),
	CONSTRAINT reservation_ibfk_WorkID
		FOREIGN KEY (WorkID) REFERENCES librarywork (WorkID)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT reservation_ibfk_UserID
		FOREIGN KEY (UserID) REFERENCES user (UserID)
			ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE usertype
(
	UserType VARCHAR(10) NOT NULL PRIMARY KEY,
	maxLoans TINYINT     NOT NULL
);

CREATE TABLE work_author
(
	AuthorID INT NOT NULL,
	WorkID   INT NOT NULL,
	PRIMARY KEY (AuthorID, WorkID),
	CONSTRAINT work_author_ibfk_AuthorID
		FOREIGN KEY (AuthorID) REFERENCES author (AuthorID)
			ON UPDATE CASCADE,
	CONSTRAINT work_author_ibfk_WorkID
		FOREIGN KEY (WorkID) REFERENCES librarywork (WorkID)
			ON UPDATE CASCADE
);

CREATE TABLE workcopy
(
	Barcode    INT        NOT NULL PRIMARY KEY,
	WorkID     INT        NULL,
	isBorrowed TINYINT(1) NULL,
	CONSTRAINT workcopy_ibfk_WorkID
		FOREIGN KEY (WorkID) REFERENCES librarywork (WorkID)
			ON UPDATE CASCADE
);

CREATE TABLE loan
(
	LoanID           INT AUTO_INCREMENT PRIMARY KEY,
	Barcode          INT     NOT NULL,
	UserID           INT     NULL,
	FineID           INT     NULL,
	BorrowDate       DATE    NOT NULL DEFAULT (CURRENT_DATE),
	ReturnDate       DATE    NULL     DEFAULT (ADDDATE(CURRENT_DATE, INTERVAL 30 DAY)),
	NoLoanExtensions TINYINT NOT NULL,
	CONSTRAINT loan_ibfk_FineID
		FOREIGN KEY (FineID) REFERENCES fine (FineID)
			ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT loan_ibfk_UserID
		FOREIGN KEY (UserID) REFERENCES user (UserID)
			ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT loan_ibfk_Barcode
		FOREIGN KEY (Barcode) REFERENCES workcopy (Barcode)
			ON UPDATE CASCADE ON DELETE CASCADE
);

-- User types
INSERT INTO usertype(usertype, maxloans)
VALUES ('Student', 5),
       ('Teacher', 10),
       ('Researcher', 20);

-- Item types
INSERT INTO itemtype(itemtype, loanduration, unit)
VALUES ('Book', 2, 'month'),
       ('Course literature', 1, 'month'),
       ('DVD', 14, 'day'),
       ('Reference literature', 0, 'day');