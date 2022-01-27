
SELECT DISTINCT tablognm, tabphynm, tablab, 
	ISNULL(tabhelptext, 'No help text available.') AS TabHelp, 
	coldefseq, attlognm, attphynm, collab, (logdatatype.cholabtxt) AS Logical_Data_Type, 
	(phydatatype.chodetxt) AS Physical_Data_Type, 
	CASE colnotnulbool WHEN 0 THEN 'no' ELSE 'yes' END Not_Null, 
	coldisplaysz, attprec, attmin, attmax, (uomsym) AS UOM, domnm
FROM system
INNER JOIN systemtable ON system.sysiid = systemtable.sysiidref AND (CASE WHEN sysver = 'NASIS 7.3.4'  THEN 1 WHEN  sysver = 'METADATA 2.0.2' THEN 1 ELSE 2 END = 1)
	AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE CASE WHEN sysver = 'NASIS 7.3.4'  THEN 1 WHEN  sysver = 'METADATA 2.0.2' THEN 1 ELSE 2 END = 1))
INNER JOIN tablecolumn ON tablecolumn.systabiidref = systemtable.systabiid AND tablecolumn.sysiidref IN 
	((SELECT sysiid FROM system WHERE CASE WHEN sysver = 'NASIS 7.3.4'  THEN 1 WHEN  sysver = 'METADATA 2.0.2' THEN 1 ELSE 2 END = 1))
INNER JOIN attribute ON attribute.attiid = tablecolumn.attiidref AND attribute.sysiidref IN 
	((SELECT sysiid FROM system WHERE CASE WHEN sysver = 'NASIS 7.3.4'  THEN 1 WHEN  sysver = 'METADATA 2.0.2' THEN 1 ELSE 2 END = 1))
LEFT JOIN domaindetail phydatatype ON phydatatype.choid = tablecolumn.colphydatatype 
	AND phydatatype.domiidref = 7862
LEFT JOIN domaindetail logdatatype ON logdatatype.choid = attribute.attlogdattyp 
	AND logdatatype.domiidref = 12539
LEFT JOIN uom ON uom.uomiid = attribute.uomiidref AND attribute.uomiidref IS NOT NULL
LEFT JOIN domainmaster ON domainmaster.domiid = attribute.domiidref AND attribute.domiidref IS NOT NULL
WHERE systemtable.tabserveronly <> 1 AND systemtable.tabtemp <> 1;