>D
scnt=0
res=0

>B
=>sensor53 r

>F
; Heat meter runs on battery -> only request data once an hour
; count 100ms
scnt+=1
switch scnt
case 10
;set sml driver to 300 baud and send /?! as HEX to trigger the Meter
print "Changing baud rate to 300"
res=sml(1 0 300)
print "Requesting data"
res=sml(1 1 "0000000000000000000000000000000000000000")
res=sml(1 1 "0000000000000000000000000000000000000000")
;followed by '/?! CR LF'
print "Sending /?! CR LF"
res=sml(1 1 "2F3F210D0A")
;Without sending this (timing important) it simply does not work, no clue what it does
case 18
print "Sending strange thingy"
res=sml(1 1 "063033300D0A")
print "Changing baud rate to 2400"
res=sml(1 0 2400)
;New run every 60 minutes (36000 * 100ms)
case 36000
scnt=0
ends

>M 1
+1,5,o,0,2400,T550,4
1,=so2,0
1,6.8(@1,Zählerstand,MWh,mwh_count,3
1,6.8*01(@1,Zählerstand VJ,MWh,mwh_count_year,3
1,6.6(@1,max. Heizleistung,kWh,heizleistung_max,1
1,6.31(@1,Betriebsstunden,h,operating_time,0
1,6.26(@1,Durchlauf,m³,m3_count,2
1,6.26*01(@1,Durchlauf VJ,m³,m3_count_year,2
1,9.24(@1,Messbereich,m³h,range,1
1,6.33(@1,max. Durchlauf,m³h,durchlauf_max,3
1,6.33*1(@1,max. Durchlauf VJ,m³h,durchlauf_max_year,3
1,9.4(@1,max. VR Temp,C,lauf_max,1
1,9.31(@1,Fließdauer,h,flow_count,0
1,6.36(@1,Stichtag,day of month,reporting_day,0
#