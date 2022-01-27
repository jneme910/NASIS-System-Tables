
SELECT DISTINCT domnm, choseq, choobbool, choid, chodetxt, cholabtxt, 
ISNULL(chodesc, 'No description available.') AS Choice_Description
FROM domaingroup
INNER JOIN domainmaster ON domaingroup.domgrpiid = domainmaster.domgrpiidref AND domaingroup.domgrpname = 'Current NASIS/SSURGO Domains'
INNER JOIN domaindetail ON domainmaster.domiid = domaindetail.domiidref
inner join attribute on domainmaster.domiid = attribute.domiidref and attribute.sysiidref in 
((SELECT sysiid FROM system WHERE CASE WHEN sysver = 'NASIS 7.3.4'  THEN 1 WHEN  sysver = 'METADATA 2.0.2' THEN 1 ELSE 2 END = 1))
ORDER BY domnm, choseq;