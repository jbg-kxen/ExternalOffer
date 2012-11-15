CREATE OR REPLACE FUNCTION urbano(
	iState VARCHAR(42),
	iGender VARCHAR(42),
	iIncomeRange VARCHAR(42),
	iAge INTEGER,
	iMaritalStatus VARCHAR(42)) RETURNS numeric AS $$
SELECT (-1.201960521871e-3 + 
 (CASE 
WHEN (  $1  IS NULL OR  $1  = ''  ) THEN -8.397715854414e-3
WHEN  $1  IN('AK', 'CA', 'CO', 'IA', 'LA', 'MA', 'MD', 'MS', 'ND', 'NM', 'TX', 'UT')  THEN -1.764588660611e-3
WHEN  $1  IN('AZ', 'CT', 'GA', 'ID', 'IL', 'IN', 'KS', 'MI', 'MO', 'NE', 'NH', 'NJ', 'NY', 'PA', 'SC', 'SD', 'TN', 'VA', 'VT', 'WV')  THEN 5.490914276726e-3
WHEN  $1  IN('DE', 'NV')  THEN 8.110530085347e-2
ELSE -8.397715854414e-3
END) +
 (CASE 
WHEN (  $2  IS NULL OR  $2  = ''  ) THEN -2.606583894506e-4
WHEN  $2  IN('Female')  THEN 2.665030675843e-4
ELSE -2.606583894506e-4
END) +
 (CASE 
WHEN (  $3  IS NULL OR  $3  = ''  ) THEN 2.65286769526e-3
WHEN  $3  IN('$100,000 to $124,999', '$200,000 or more', '$25,000 to $29,999', '$35,000 to $39,999', '$40,000 to $44,999')  THEN -3.495267198882e-3
WHEN  $3  IN('$125,000 to $149,999', '$50,000 to $59,999')  THEN 4.858436315589e-3
WHEN  $3  IN('$150,000 to $199,999', '$30,000 to $34,999', '$45,000 to $49,999')  THEN 5.072247932768e-4
ELSE 2.65286769526e-3
END) +
 (CASE 
WHEN (  $4  IS NULL ) THEN -1.386623574447e-3
WHEN  $4  < 2.1e1 THEN 2.368084161203e-3
WHEN  $4  <= 2.699400007725e1 THEN  ( -1.123451229634e-4* $4 +4.727331743434e-3 ) 
WHEN  $4  <= 2.7e1 THEN  ( -4.41271102881e-1* $4 +1.191336687274e1 ) 
WHEN  $4  <= 2.991165172855e1 THEN  ( -1.930501080372e-3* $4 +5.117062412539e-2 ) 
WHEN  $4  <= 3.120049759749e1 THEN  ( 1.94136706394e-3* $4 -6.464334734616e-2 ) 
WHEN  $4  <= 3.2e1 THEN  ( 5.224713850498e-3* $4 -1.670854008719e-1 ) 
WHEN  $4  <= 3.384851326186e1 THEN  ( 2.195991830654e-3* $4 -7.01662962369e-2 ) 
WHEN  $4  <= 3.751944106926e1 THEN  ( 4.729739257093e-4* $4 -1.184470183095e-2 ) 
WHEN  $4  <= 4.2e1 THEN  ( -1.071450451199e-3* $4 +4.610123756439e-2 ) 
WHEN  $4  <= 4.282054070621e1 THEN  ( -2.730940344038e-3* $4 +1.157998130636e-1 ) 
WHEN  $4  <= 4.400392927308e1 THEN  ( -1.371310812403e-3* $4 +5.757974135887e-2 ) 
WHEN  $4  <= 4.450196463654e1 THEN  ( 2.879100288921e-3* $4 -1.294550481253e-1 ) 
WHEN  $4  <= 4.5e1 THEN  ( 2.879100288921e-3* $4 -1.294550481253e-1 ) 
WHEN  $4  <= 5.000987491771e1 THEN  ( 4.824184699182e-4* $4 -2.160436627019e-2 ) 
WHEN  $4  <= 5.261287122021e1 THEN  ( -6.847030635188e-4* $4 +3.676323563076e-2 ) 
WHEN  $4  <= 5.5e1 THEN  ( -7.928999476725e-4* $4 +4.245578436317e-2 ) 
WHEN  $4  <= 5.501000000047e1 THEN  ( -1.625695382357e-1* $4 +8.940170890204e0 ) 
WHEN  $4  <= 6.5e1 THEN  ( -1.123451229634e-4* $4 +3.400696995878e-3 ) 
WHEN  $4  >= 6.5e1 THEN -3.901735996741e-3
ELSE -1.386623574447e-3
END)+
 (CASE 
WHEN (  $5  IS NULL OR  $5  = ''  ) THEN -2.145229365051e-3
WHEN  $5  IN('Divorced', 'Never married', 'Widowed')  THEN 3.05166430803e-3
ELSE -2.145229365051e-3
END) );
$$ LANGUAGE SQL IMMUTABLE;