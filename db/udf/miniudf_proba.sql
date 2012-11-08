CREATE OR REPLACE FUNCTION miniudf_proba(
iScore DOUBLE precision) RETURNS double precision AS $$
SELECT ( CASE
WHEN  $1  <= -1.157155301418e0 THEN 0.0e0
WHEN  $1  <= -1.581552885438e-1 THEN 0.0e0
WHEN  $1  <= -1.571553014184e-1 THEN  ( 4.115279320037e-3* $1 +6.508532294515e-4 ) 
WHEN  $1  <= -1.218016446444e-1 THEN  ( 1.164017166247e-4* $1 +2.240837436324e-5 ) 
WHEN  $1  <= -1.217662560547e-1 THEN  ( 1.161705267397e2* $1 +1.414977060827e1 ) 
WHEN  $1  <= -1.046822092531e-1 THEN  ( 2.406403564015e-1* $1 +3.342121922486e-2 ) 
WHEN  $1  <= -9.452419203365e-2 THEN  ( 6.806628968892e-1* $1 +7.948375528452e-2 ) 
WHEN  $1  <= -8.479730780922e-2 THEN  ( 7.108324996706e-1* $1 +8.23355129131e-2 ) 
WHEN  $1  <= -8.0366984738e-2 THEN  ( 3.426446651991e0* $1 +3.126123092346e-1 ) 
WHEN  $1  <= -7.29297398311e-2 THEN  ( 2.041114128241e0* $1 +2.012772975881e-1 ) 
WHEN  $1  <= -5.708122682196e-2 THEN  ( 4.494841825142e-1* $1 +8.520012382251e-2 ) 
WHEN  $1  <= -4.827215428131e-2 THEN  ( 8.086726362058e-1* $1 +1.057030450114e-1 )
WHEN  $1  <= -4.231063811973e-2 THEN  ( 1.765711188926e0* $1 +1.519013672519e-1 ) 
WHEN  $1  <= -3.820231202444e-2 THEN  ( 2.562190913123e0* $1 +1.856009405968e-1 ) 
WHEN  $1  <= -3.161052588505e-2 THEN  ( 9.952566429927e-1* $1 +1.257404130182e-1 ) 
WHEN  $1  <= -3.055091744559e-2 THEN  ( 6.191455919128e0* $1 +2.899950567023e-1 ) 
WHEN  $1  <= -2.393301210444e-2 THEN  ( 1.587239638402e-1* $1 +1.056895004376e-1 ) 
WHEN  $1  <= -2.911919819532e-3 THEN  ( 4.996981859127e-2* $1 +1.030866850754e-1 ) 
WHEN  $1  <= -1.369831968515e-3 THEN  ( 9.28538892222e0* $1 +1.299795773591e-1 ) 
WHEN  $1  <= 5.692157072322e-4 THEN  ( 7.384493753304e0* $1 +1.27375651379e-1 ) 
WHEN  $1  <= 9.009776178133e-3 THEN  ( 3.897221867613e-1* $1 +1.313571152755e-1 ) 
WHEN  $1  <= 1.526666256704e-2 THEN  ( 5.257365212902e-1* $1 +1.301316579245e-1 ) 
WHEN  $1  <= 1.868565232167e-2 THEN  ( 1.760715092135e0* $1 +1.112776691557e-1 ) 
WHEN  $1  <= 4.087152785019e-2 THEN  ( 2.713378091881e-1* $1 +1.391076403468e-1 ) 
WHEN  $1  <= 5.068398537086e-2 THEN  ( 1.387100342746e0* $1 +9.350473203995e-2 ) 
WHEN  $1  <= 5.951158730203e-2 THEN  ( 1.541852849305e0* $1 +8.566125980893e-2 ) 
WHEN  $1  <= 6.891642891482e-2 THEN  ( 1.358393008781e0* $1 +9.657924429013e-2 ) 
WHEN  $1  <= 8.221969130338e-2 THEN  ( 9.60326175817e-1* $1 +1.240125849067e-1 ) 
WHEN  $1  <= 1.005450222309e-1 THEN  ( 5.060942796989e-1* $1 +1.613593866434e-1 ) 
WHEN  $1  <= 1.208735474277e-1 THEN  ( 4.56223216701e-1* $1 +1.663736732825e-1 ) 
WHEN  $1  <= 1.238112964034e-1 THEN  ( 2.184538786425e1* $1 -2.41901032029e0 ) 
WHEN  $1  <= 1.238658637369e-1 THEN  ( 1.176093125532e3* $1 -1.453279075492e2 ) 
WHEN  $1  <= 1.783786273242e-1 THEN  ( 1.178448900801e-3* $1 +3.497255494082e-1 ) 
WHEN  $1  <= 1.793786273717e-1 THEN  ( 6.424050327788e-2* $1 +3.384766273427e-1 ) 
WHEN  $1  <= 1.178378627324e0 THEN 3.5e-1
WHEN  $1  > 1.178378617324e0 THEN 3.5e-1
WHEN  $1  >= 1.678378607324e0 THEN 3.5e-1
END);
$$ LANGUAGE SQL IMMUTABLE;
