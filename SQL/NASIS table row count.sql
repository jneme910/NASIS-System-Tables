SELECT SCHEMA_NAME(schema_id) AS [SchemaName],
[Tables].name AS [TableName],
SUM([Partitions].[rows]) AS [TotalRowCount]
FROM sys.tables AS [Tables]
JOIN sys.partitions AS [Partitions]
ON [Tables].[object_id] = [Partitions].[object_id]
AND [Partitions].index_id IN ( 0, 1 )
AND CASE WHEN [Tables].name   LIKE '%_l' THEN 2 
WHEN [Tables].name   LIKE '%_x' THEN 2 
WHEN [Tables].name   LIKE 'xx%' THEN 2 
WHEN [Tables].name  LIKE 'COLUMNLOOKUP%' THEN 2
WHEN [Tables].name  LIKE 'DBA_QueryActivity%' THEN 2
WHEN [Tables].name  LIKE '%SAV%' THEN 2
WHEN [Tables].name  LIKE 'FARMCLASS%' THEN 2
WHEN [Tables].name  LIKE 'IndexColumnCounts%' THEN 2
WHEN [Tables].name  LIKE 'interp_output_6dbe285b_58b6_4aaf_a146_a8a92454a035%' THEN 2
WHEN [Tables].name  LIKE 'New%' THEN 2
WHEN [Tables].name  LIKE 'Old%' THEN 2
WHEN [Tables].name  LIKE 'pc_%' THEN 2
WHEN [Tables].name  LIKE 'paoccurrence%' THEN 2
WHEN [Tables].name  LIKE 'pedon_temp%' THEN 2
WHEN [Tables].name  LIKE '%hold%' THEN 2
WHEN [Tables].name  LIKE '%projec_%' THEN 2
WHEN [Tables].name  LIKE '%QAI%' THEN 2
WHEN [Tables].name  LIKE '%QAI%' THEN 2
WHEN [Tables].name  LIKE '%rating_table%' THEN 2
WHEN [Tables].name  LIKE '%save%' THEN 2
WHEN [Tables].name  LIKE '%_d' THEN 2
WHEN [Tables].name  LIKE '%_BEF' THEN 2
WHEN [Tables].name  LIKE '%T1_0b8e808e_e0b3_412e_848d_99e53bcf2b00' THEN 2
WHEN [Tables].name  LIKE '%table_540bf98c_c441_497d_beca_f62126448223' THEN 2
WHEN [Tables].name  LIKE '%table_99aa3c27_e5f9_4be9_8c69_5ee3e643666a' THEN 2
WHEN [Tables].name  LIKE '%table1_3153e798_1571_4c59_add3_68e71ef73160' THEN 2
WHEN [Tables].name  LIKE '%temp%' THEN 2
WHEN [Tables].name  LIKE '%test%' THEN 2
WHEN [Tables].name  LIKE '%dup_comp_table_a984237c_c52f_4cd0_94f6_9e92399120db%' THEN 2
WHEN [Tables].name  LIKE '%FIRST_TABLE_b58b2395_f4f2_440c_831f_07af40459794%' THEN 2
WHEN [Tables].name  LIKE '%keyrangeserverX61%' THEN 2
WHEN [Tables].name  LIKE '%goals%' THEN 2
WHEN [Tables].name  LIKE '%phorizon105_Apr2015%' THEN 2
WHEN [Tables].name  LIKE '%ERR%' THEN 2 ELSE 1 END = 1
-- WHERE [Tables].name = N'name of the table'
GROUP BY SCHEMA_NAME(schema_id), [Tables].name
order by [TotalRowCount] desc