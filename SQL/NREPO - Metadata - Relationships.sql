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


  SELECT LeftTable.tabphynm,LeftIndex.indexcolnames AS LeftTableJoinColumnPhysicalName ,'Parent:Child' AS 'RelationshipOrientation', 
         RightTable.tabphynm, RightIndex.indexcolnames AS RightTableJoinColumnPhysicalName,relationshipmaster.relationshipname
  FROM relationshipmaster
  INNER JOIN indexmaster LeftIndex 
  ON relationshipmaster.indexiidref = LeftIndex.indexiid AND relationshipmaster.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  AND LeftIndex.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN indexmaster RightIndex 
  ON relationshipmaster.depindexiidref = RightIndex.indexiid AND relationshipmaster.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  AND RightIndex.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN systemtable LeftTable
  ON LeftIndex.systabiidref = LeftTable.systabiid AND LeftTable.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN systemtable RightTable
  ON RightIndex.systabiidref = RightTable.systabiid AND RightTable.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  WHERE LeftTable.tabserveronly <> 1 AND LeftTable.tabtemp <> 1 AND RightTable.tabserveronly <> 1 AND RightTable.tabtemp <> 1
  UNION ALL
  SELECT RightTable.tabphynm, RightIndex.indexcolnames AS LeftTableJoinColumnPhysicalName ,'Child:Parent' AS 'RelationshipOrientation', 
           LeftTable.tabphynm,LeftIndex.indexcolnames AS RightTableJoinColumnPhysicalName,relationshipmaster.relationshipname
  FROM relationshipmaster
  INNER JOIN indexmaster LeftIndex 
  ON relationshipmaster.indexiidref = LeftIndex.indexiid AND relationshipmaster.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  AND LeftIndex.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN indexmaster RightIndex 
  ON relationshipmaster.depindexiidref = RightIndex.indexiid AND relationshipmaster.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  AND RightIndex.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN systemtable LeftTable
  ON LeftIndex.systabiidref = LeftTable.systabiid AND LeftTable.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  INNER JOIN systemtable RightTable
  ON RightIndex.systabiidref = RightTable.systabiid AND RightTable.sysiidref IN (SELECT sysiid FROM system WHERE sysver = @system_name )
  WHERE LeftTable.tabserveronly <> 1 AND LeftTable.tabtemp <> 1 AND RightTable.tabserveronly <> 1 AND RightTable.tabtemp <> 1
  ORDER BY LeftTable.tabphynm, LeftIndex.indexcolnames, RightTable.tabphynm, RightIndex.indexcolnames;
