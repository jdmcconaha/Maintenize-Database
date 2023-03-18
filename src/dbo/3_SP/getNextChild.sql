CREATE PROCEDURE getNextChild
    (@parentHierarchyID HIERARCHYID,
    @TableName varchar(50))
AS
BEGIN
    DECLARE @nextID int;

    -- get the current maximum child ID for the given parent
    SELECT @nextID = (SELECT MAX(childId)
        FROM @TableName
        WHERE hierarchyid = @parentHierarchyID);

    -- if there are no child IDs for this parent, start with 1
    IF (@nextID IS NULL)
        SET @nextID = 1;
    ELSE 
        -- otherwise increment by 1 to get the next available child ID
        SET @nextID = @nextID + 1;

    -- return the next available child ID
    SELECT @nextID;
END