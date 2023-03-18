CREATE PROCEDURE selectedHierarchyId
    (@selectedHierarchyId HIERARCHYID,
    @TableName varchar(50))
AS
BEGIN
    DECLARE @nextSiblingIndex INT
    DECLARE @parentHierarchyId HIERARCHYID

    --This code block sets the input parent hierarchy id and selects the next sibling index for the given hierarchy id
    SET @parentHierarchyId = @selectedHierarchyId.GetAncestor(1)
    SET @nextSiblingIndex = (
    SELECT MIN(CONVERT(INT, REPLACE(node.value('count(ancestor::*)', 'nvarchar(100)'),'.','')))
    FROM @TableName
    WHERE node.GetAncestor(1) = @parentHierarchyId AND node.CompareTo(@selectedHierarchyId) > 0)

    --If the next sibling index is not available it gets the next unused child with the given hierarchy id and table name as parameters.
    IF @nextSiblingIndex IS NULL
        RETURN dbo.getNextChild(@parentHierarchyId, @tableName)
    ELSE 
    --else return the converted hierarchy id by concatenating parent hierarchy id with next sibling index separated by a dot '.'
        RETURN CONVERT(hierarchyid, CONCAT(@parentHierarchyId.ToString(), '.', @nextSiblingIndex))
END 