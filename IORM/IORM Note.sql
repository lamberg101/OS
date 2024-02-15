[Forwarded from Eka Fitriani]
Tujuan IORM
Menunjukkan consumed i/o tinggi di database dengan load rendah (Memberikan limit database non critical) 
Objektif : Low latency
Default 1%
Positif : Response time lebih cepat dan i/o jadi lebih rendah (dari pov disk) 

Check dari OEM
1. Dari ash report lihat load yang paling tinggi di filter user i/o buat tau query apa
2. Cari di jam saat alertnya pas muncul
3. Target >> All target >> Oracle Exadata Storage Server >> Monitoring >> All metrics >> Exadata IORM DB Metric 
- Grafik hard disk i/o

Ketika ada alert high IORM sebagai indikasi problem database, tapi kalau berlanjut baru bahaya, penyebab:
1. Backup
2. Running query dengan reads paling gede
di table SQL Reads by order hasil dari awr report
(Bisa salah satu atau keduanya) 
Biasanya yang kena
- smart scan
- multiple block
- rman (backup) 

Improvement:
Top query dari alert IORM bisa dikurangin dengan menambah index (mengoptimalkan query) 
Naikkan total shared