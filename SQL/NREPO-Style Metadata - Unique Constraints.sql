/*** NREPO - Metadata - Tables & Columns  **/
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



SELECT tabphynm, tablab, constraintorindexname,indexcolnames
FROM system
INNER JOIN systemtable ON system.sysiid = systemtable.sysiidref AND (system.sysver = @system_name)
AND systemtable.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = @system_name))
INNER JOIN indexmaster ON systemtable.systabiid = indexmaster.systabiidref AND indexmaster.sysiidref IN ((SELECT sysiid FROM system WHERE sysver = @system_name))
WHERE indexmaster.uniqueindex = 1 AND tabserveronly = 0 AND tabtemp = 0
ORDER BY tabphynm, tablab, constraintorindexname;
