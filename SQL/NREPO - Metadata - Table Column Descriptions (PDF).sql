/*** NREPO - Metadata - Table Column Descriptions **/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @system_name VARCHAR(254) SET @system_name = 'Lab SDA Data Mart 1.0';
/**  NASIS 7.4.2
  SSURGO 2.3.3
  METADATA 2.0.2
  Repository VERSION
  Lab SDA Data Mart 1.0
  Global Domains VERSION
  Soil Data Mart 4.2 **/


USE Nasis

SELECT 
tabphynm, 
tablab, 
tablognm,
attphynm, 
collab, 
ISNULL(attoffdef, 'No description available.') AS ColDesc, 
coldefseq,
ISNULL(tabhelptext, 'No help text available.') AS TabHelp
FROM system 
INNER JOIN systemtable ON system.sysiid = systemtable.sysiidref AND (system.sysver = @system_name)
AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = @system_name))
INNER JOIN tablecolumn ON tablecolumn.systabiidref = systemtable.systabiid AND tablecolumn.sysiidref IN 
	((SELECT sysiid FROM system WHERE sysver = @system_name))
INNER JOIN attribute ON attribute.attiid = tablecolumn.attiidref AND attribute.sysiidref IN 
	((SELECT sysiid FROM system WHERE sysver = @system_name))
WHERE systemtable.tabserveronly <> 1 and systemtable.tabtemp <> 1
ORDER BY  tabphynm, tablab, coldefseq;