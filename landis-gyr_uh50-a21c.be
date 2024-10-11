>D
scnt=0
res=0
;Variablen zum Zwischenspeichern der Werte
v1=0
v2=0
v3=0
v4=0
v5=0
v6=0
v7=0
v8=0
v9=0

;Stundenvariable für Tageswert
hr=0

;persistenter Speicher des letzten Werts um 0 Uhr
p:sm1=0
p:sm2=0

;persistenter Speicher des letztens Tagesverbrauchs
p:sd1=0
p:sd2=0
>T
;Bei jeder Teleperiode werden die letzten Werte in die Temp Var geschrieben
v1=LGUH50#mwh_count
v2=LGUH50#mwh_count_year
v3=LGUH50#heizleistung_max
v4=LGUH50#m3_count
v5=LGUH50#m3_count_year
v6=LGUH50#range
v7=LGUH50#durchlauf_max
v8=LGUH50#lauf_max
v9=LGUH50#flow_count

>R

>B
=>sensor53 r

>F
; Fernwärmezähler läuft mit Batterie und wird daher nur stündlich abgefragt
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
case 18
print "Sending thingy"
res=sml(1 1 "063033300D0A")
print "Changing baud rate to 2400"
res=sml(1 0 2400)
;Wait for 60s (600 * 100ms)
case 600
print "Sende Werte, wenn != 0"
;Schicke Werte, falls sie nicht Null sind
if v1!=0
then
=>publish stat/Fernwaerme/RESULT {"mwh_count":%v1%}
endif
if v2!=0
then
=>publish stat/Fernwaerme/RESULT {"mwh_count_year":%v2%}
endif
if v3!=0
then
=>publish stat/Fernwaerme/RESULT {"heizleistung_max":%v3%}
endif
if v4!=0
then
=>publish stat/Fernwaerme/RESULT {"m3_count":%v4%}
endif
if v5!=0
then
=>publish stat/Fernwaerme/RESULT {"m3_count_year":%v5%}
endif
if v6!=0
then
=>publish stat/Fernwaerme/RESULT {"unknown":%v6%}
endif
if v7!=0
then
=>publish stat/Fernwaerme/RESULT {"durchlauf_max":%v7%}
endif
if v8!=0
then
=>publish stat/Fernwaerme/RESULT {"lauf_max":%v8%}
endif
if v8!=0
then
=>publish stat/Fernwaerme/RESULT {"flow_count":%v9%}
endif
if sd1!=0
then
=>publish stat/Fernwaerme/RESULT {"Tagesverbrauch_kWh":%sd1%}
endif
if sd2!=0
then
=>publish stat/Fernwaerme/RESULT {"Tagesverbrauch_m3":%sd2%}
endif
;Neue Runde alle 60 Minuten (36000 * 100ms)
case 36000
scnt=0
ends


>S


;Tagesverbrauch
hr=hours
if chg[hr]>0
and hr==1
and v2>0
then

sd1=v2-sm1
sd2=v5-sm2
sm1=v2
sm2=v5
svars
endif


>M 1
+1,5,o,0,2400,LGUH50,4
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