USE gravity_books;

DELETE FROM Dim_Date;

DECLARE @tmpDOW TABLE (DOW INT, Cntr INT);
INSERT INTO @tmpDOW(DOW, Cntr) VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0);

DECLARE @StartDate datetime = '2000-01-01';
DECLARE @EndDate datetime = '2030-01-01';
DECLARE @Date datetime = @StartDate;
DECLARE @WDofMonth INT;
DECLARE @CurrentMonth INT = MONTH(@StartDate);

WHILE @Date < @EndDate
BEGIN
    IF MONTH(@Date) <> @CurrentMonth
    BEGIN
        SET @CurrentMonth = MONTH(@Date);
        UPDATE @tmpDOW SET Cntr = 0;
    END

    UPDATE @tmpDOW SET Cntr = Cntr + 1 WHERE DOW = DATEPART(WEEKDAY, @Date);
    SELECT @WDofMonth = Cntr FROM @tmpDOW WHERE DOW = DATEPART(WEEKDAY, @Date);

    INSERT INTO Dim_Date (
        Full_Date, Day_Of_Month, Day_Name,
        Month_Num, Month_Name, Quarter_Num,
        Year_Num, Is_Weekend
    )
    SELECT
        @Date,
        DAY(@Date),
        DATENAME(WEEKDAY, @Date),
        MONTH(@Date),
        DATENAME(MONTH, @Date),
        DATEPART(QUARTER, @Date),
        YEAR(@Date),
        CASE WHEN DATENAME(WEEKDAY, @Date) IN ('Saturday','Sunday') THEN 1 ELSE 0 END;

    SET @Date = DATEADD(DAY, 1, @Date);
END;