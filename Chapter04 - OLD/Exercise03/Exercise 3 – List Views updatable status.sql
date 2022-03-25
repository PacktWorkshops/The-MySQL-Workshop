CREATE VIEW `vw_Updatable Views` AS
SELECT 
    table_name, 
    is_updatable
FROM
    information_schema.views
WHERE
    table_schema = 'autoclub'
ORDER BY table_name;
