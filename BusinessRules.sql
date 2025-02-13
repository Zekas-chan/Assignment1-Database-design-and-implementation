-- Tänkt att bli filen som lämnas in för del c.
USE `assignment_1_design&implement`;

-- Vid insert på loan, kollar om användaren överskrider sin gräns genom att jämföra returvärdet från två anrop. Avbryter om sant.
CREATE TRIGGER checkLoanLimit
	AFTER INSERT
	ON loan
	FOR EACH ROW
BEGIN
	DECLARE currentLoans int DEFAULT sf_getCurrentLoansAmount(new.UserID);
	DECLARE loanLimit int DEFAULT sf_getLoanLimit(new.UserID);
	IF (currentLoans > loanLimit) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "User has reached the maximum allowed simultaneous loans.";
	END IF;
END;

-- Hämtar antal lån för en användare genom att räkna alla unika lån med dennes användarID där skillnaden mellan returdatum och dagens datum är större än -1
CREATE FUNCTION sf_getCurrentLoansAmount(User_ID INT)
	RETURNS INT
	READS SQL DATA
BEGIN
	DECLARE currentLoans int;

	SELECT COUNT(LoanID)
	INTO currentLoans
	FROM loan
	WHERE UserID = User_ID
	  AND DATEDIFF(loan.ReturnDate, CURDATE()) > -1;

	RETURN currentLoans;
END;

-- Hämtar användarens lånegräns baserad från användartyper
CREATE FUNCTION sf_getLoanLimit(User_ID INT)
	RETURNS INT
	READS SQL DATA
BEGIN
	DECLARE loanLimit int;

	SELECT maxLoans
	INTO loanLimit
	FROM usertype
	JOIN user on usertype.UserType = user.UserType
	WHERE UserID = User_ID;

	RETURN loanLimit;
END;