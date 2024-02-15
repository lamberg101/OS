1. PRE-CHECK
- Check dataguard make sure no gap 
- SR Above 99,99%, and healtcheck db


2. MAIN TASK (#OPDGPOSTBS exa62pdb3 & exa62pdb4)
$> srvctl config database -d OPDGPOSTBS
$> srvctl modify database -d OPDGPOSTBS -startoption OPEN
$> srvctl config database -d OPDGPOSTBS


3. POST-CHECK
- Healtcheck db
- Check rebalance etc

