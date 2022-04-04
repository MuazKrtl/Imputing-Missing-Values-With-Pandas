SELECT 
FullURL, 
(CHARINDEX('//', FullURL, 1) + 1), 
CHARINDEX('<', REVERSE (FullURL), 1), 
SUBSTRING(FullURL, 
(CHARINDEX('//', FullURL, 1) + 2), 
CHARINDEX('<', REVERSE (FullURL), 1) ) 
FROM such_a_table


