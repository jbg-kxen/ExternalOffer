CREATE OR REPLACE FUNCTION dueudf (
	iState VARCHAR(42),
	iIncomeRange VARCHAR(42),
	iAge INTEGER,
	iHomeowner INTEGER,
	iMaritalStatus VARCHAR(42) ) RETURNS numeric AS $$
	
	SELECT (-1.633607027955e-4 + 
	 (CASE
	WHEN (  $1  IS NULL OR  $1  = ''  ) THEN -3.011824353568e-2
	WHEN  $1  IN('AL', 'AR', 'CA', 'CT', 'FL', 'GA', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'NJ', 'NM', 'NY', 'OH', 'OK', 'PA', 'SC', 'SD', 'TX', 'VA', 'VT', 'WA', 'WI', 'WV')  THEN 5.105432806807e-3
	ELSE -3.011824353568e-2
	END) +
	 (CASE 
	WHEN (  $2  IS NULL OR  $2  = ''  ) THEN -7.598035618456e-3
	WHEN  $2  IN('$100,000 to $124,999', '$30,000 to $34,999')  THEN -3.051762883263e-2
	WHEN  $2  IN('$125,000 to $149,999', '$150,000 to $199,999', '$200,000 or more', '$25,000 to $29,999')  THEN -6.040421202999e-2
	WHEN  $2  IN('$40,000 to $44,999', '$45,000 to $49,999', '$50,000 to $59,999', '$60,000 to $74,999')  THEN 4.273776641492e-2
	ELSE -7.598035618456e-3
	END) +
	 (CASE 
	WHEN (  $3  IS NULL ) THEN 2.496388003369e-3
	WHEN  $3  < 2.1e1 THEN 1.392467011194e-3
	WHEN  $3  <= 3.198900014162e1 THEN  ( -9.76556689918e-5* $3 +3.443236060022e-3 ) 
	WHEN  $3  <= 3.2e1 THEN  ( 1.131922018418e-1* $3 -3.620586031898e0 ) 
	WHEN  $3  <= 4.105728429986e1 THEN  ( 1.775200563537e-4* $3 -4.116214762599e-3 ) 
	WHEN  $3  <= 4.603692396736e1 THEN  ( -3.479091956819e-4* $3 +1.745648341769e-2 ) 
	WHEN  $3  <= 5.0e1 THEN  ( -4.927594931951e-4* $3 +2.412494555096e-2 ) 
	WHEN  $3  <= 5.138209678673e1 THEN  ( -1.230591155961e-3* $3 +6.101652868924e-2 ) 
	WHEN  $3  <= 5.303688181056e1 THEN  ( -8.879683152632e-4* $3 +4.341184872717e-2 ) 
	WHEN  $3  <= 5.6e1 THEN  ( 7.850614199586e-4* $3 -4.532043160534e-2 ) 
	WHEN  $3  <= 5.747976878613e1 THEN  ( 1.669914431769e-3* $3 -9.487220026671e-2 ) 
	WHEN  $3  <= 5.778961030855e1 THEN  ( -4.318515161801e-3* $3 +2.493413481637e-1 ) 
	WHEN  $3  <= 5.8e1 THEN  ( -9.252083762586e-3* $3 +5.344503550336e-1 ) 
	WHEN  $3  <= 5.891612802822e1 THEN  ( -2.199978971689e-3* $3 +1.254282771615e-1 ) 
	WHEN  $3  <= 6.0531107739e1 THEN  ( -7.741710943234e-4* $3 +4.142519771502e-2 ) 
	WHEN  $3  <= 6.2e1 THEN  ( 1.389939731904e-3* $3 -8.957082786649e-2 ) 
	WHEN  $3  <= 6.200300000014e1 THEN  ( 3.640885556779e-1* $3 -2.257688501652e1 ) 
	WHEN  $3  <= 6.5e1 THEN  ( -9.76556689918e-5* $3 +3.752645674991e-3 ) 
	WHEN  $3  >= 6.5e1 THEN -2.594972809476e-3
	ELSE 2.496388003369e-3
	END)+
	 (CASE 
	WHEN (  $4  IS NULL ) THEN -3.652343387113e-2
	WHEN  $4  IN(1)  THEN 5.792667693687e-2
	ELSE -3.652343387113e-2
	END) +
	 (CASE 
	WHEN (  $5  IS NULL OR  $5  = ''  ) THEN 1.128150870983e-2
	WHEN  $5  IN('Divorced', 'Never married', 'Widowed')  THEN -1.604834337596e-2
	ELSE 1.128150870983e-2
	END) );
  $$ LANGUAGE SQL IMMUTABLE;
