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

DECLARE @domain_name VARCHAR(254) SET @domain_name = 'Current NASIS/SSURGO Domains';
/*Current NASIS/SSURGO Domains*/
USE Nasis



SELECT DISTINCT domnm, choseq, choobbool, choid, chodetxt, cholabtxt, 
ISNULL(chodesc, 'No description available.') AS Choice_Description
FROM domaingroup
INNER JOIN domainmaster ON domaingroup.domgrpiid = domainmaster.domgrpiidref AND domaingroup.domgrpname = @domain_name
INNER JOIN domaindetail ON domainmaster.domiid = domaindetail.domiidref
inner join attribute on domainmaster.domiid = attribute.domiidref and attribute.sysiidref in 
((SELECT sysiid FROM system WHERE sysver = @system_name ))
ORDER BY domnm, choseq;