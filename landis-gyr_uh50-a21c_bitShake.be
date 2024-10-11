>D
scnt=0
res=0
>B
->sensor53 r
>F
scnt=scnt+1
switch scnt
;start after 1.6 seconds (16 x 100ms)
case 16
;set transfer speed to 300 baud
res=sml(1 0 300)
;trigger meter by sending 40 times 'NUL'
res=sml(1 1 "0000000000000000000000000000000000000000")
res=sml(1 1 "0000000000000000000000000000000000000000")
;followed by '/?! CR LF'
res=sml(1 1 "2F3F210D0A")
case 24
res=sml(1 1 "063033300D0A")
;set transfer speed to 2400 baud
res=sml(1 0 2400)
;restart sequence after 10 minutes (6000 x 100 ms)
case 6000
scnt=0
ends
>M 1
+1,5,o,0,2400,T550,4
1,=so2,0
1,6.8(@1,Zählerstand,MWh,mwh_count,3
1,6.6(@1,Max. Heizleistung,kWh,kwh_max_heatperf,1
1,6.26(@1,Durchlauf,m³,m3_throughput,2
1,6.33(@1,Max. Durchlauf per h,m³h,m3h_max_throughput,3
1,9.4(@1,Max. Temp. V-/R-Lauf,°C,c_max_temp_fb,1
#