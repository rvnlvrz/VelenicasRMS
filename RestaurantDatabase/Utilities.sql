-- List all Stored Procedures for dropping
SELECT 'DROP PROCEDURE [' + SCHEMA_NAME(p.schema_id) + '].[' + p.NAME + ']'
FROM sys.procedures p 