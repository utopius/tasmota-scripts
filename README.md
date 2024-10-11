# tasmota-scripts

Trying to get my smart meters integrated into [Home Assistant](https://www.home-assistant.io/).

## Landis+Gyr T550 UH50-A21C-DE00-F heat meter

Script: [landis-gyr_uh50-a21c_simple.be](landis-gyr_uh50-a21c_simple.be)

Combination of https://forum.creationx.de/forum/index.php?thread/1095-d0-z%C3%A4hler-sml-auslesen-mit-tasmota/&postID=41928#post41928 and https://docs.bitshake.de/script/ (search for "Landis+Gyr T550").

SML dump
```
15:32:28.983
15:32:29.184 : 6.26*01(02655.81*m3)6.8*01(0079.462*MWh)
15:32:29.333 : F(0)9.20(69794947)6.35(60*m)
15:32:29.688 : 6.6(0017.0*kW)6.6*01(0017.0*kW)6.33(001.080*m3ph)9.4(094.7*C&089.8*C)
15:32:30.038 : 6.31(0052125*h)6.32(0000006*h)9.22(R)9.6(000&69794947&0&000&69794947&0)
15:32:30.388 : 9.7(20000)6.32*01(0000006*h)6.36(01-01&00:00)6.33*01(001.080*m3ph)
15:32:30.588 : 6.8.1()6.8.2()6.8.3()6.8.4()6.8.5()
15:32:30.738 : 6.8.1*01()6.8.2*01()6.8.3*01()
15:32:30.839 : 6.8.4*01()6.8.5*01()
15:32:30.988 : 9.4*01(094.7*C&089.8*C)
15:32:31.188 : 6.36.1(2022-04-04)6.36.1*01(2022-04-04)
15:32:31.388 : 6.36.2(2022-04-09)6.36.2*01(2022-04-09)
15:32:31.594 : 6.36.3(2021-09-30)6.36.3*01(2021-09-30)
15:32:31.825 : 6.36.4(2022-01-11)6.36.4*01(2022-01-11)
15:32:32.094 : 6.36.5()6.36*02(01&00:00)9.36(2024-10-11&13:29:41)9.24(1.5*m3ph)
15:32:32.244 : 9.17(0)9.18()9.19()9.25()
15:32:32.595 : 9.1(0&1&0&1700&CECV&CECV&1&5.23&5.23&F&101008&1>1>04&08&0&00&:5&00&20)
15:32:32.743 : 9.2(&&)9.29()9.31(0027139*h)
15:32:33.094 : 9.0.1(00000000)9.0.2(00000000)9.34.1(000.00000*m3)9.34.2(000.00000*m3)
15:32:33.294 : 8.26.1(00000000*m3)8.26.2(00000000*m3)
15:32:33.543 : 8.26.1*01(00000000*m3)8.26.2*01(00000000*m3)
15:32:33.649 : 6.26.1()6.26.4()6.26.5()
15:32:33.898 : 6.26.1*01()6.26.4*01()6.26.5*01()0.0(69794947)
15:32:33.900 : !
```

SML description
```
6,26 - Volumen (m3)
6,26*01 – Volumen im Vorjahr (m3)
6,33*01 – Max. Durchfluss im Vorjahr (m3/h)
6,6 – Maximale Leistung (kW)
6,6*01 – Maximale Leistung im Vorjahr (kW)
6.31 – Betriebsstunden (Stunde)
6.32 - Fehlerstunden (Stunde)
6.32*01 – Fehlerstunden im Vorjahr (Stunde)
6.33 – Durchflussmenge max. (m3/h)
6.35 – Messzeitraum (Minuten)
6.36 – Jährlicher Stichtag (Datum)
6.36.1 – Zeitpunkt (Datum)
6.36.1*01 – Zeitpunkt (Datum)
6.36.2 – Zeitpunkt (Datum)
6.36.2*01 – Zeitpunkt (Datum)
6.36.3 – Zeitpunkt (Datum)
6.36.3*01 – Zeitpunkt (Datum)
6.36.4 – Zeitpunkt (Datum)
6.36.4*01 – Zeitpunkt (Datum)
6.36.5 – Zeitpunkt (Datum)
6.36.5*01 – Zeitpunkt (Datum)
6.36*02 – Monatlicher Stichtag (Datum)
6.8 - Wärmemenge (GJ)
6.8.1 – (unbekannt, bleibt leer)
6.8.1*01 – (unbekannt, bleibt leer)
6.8.2 – (unbekannt, bleibt leer)
6.8.2*01 – (unbekannt, bleibt leer)
6.8.3 – (unbekannt, bleibt leer)
6.8.3*01 – (unbekannt, bleibt leer)
6.8.4 – (unbekannt, bleibt leer)
6.8.4*01 – (unbekannt, bleibt leer)
6.8.5 – (unbekannt, bleibt leer)
6.8.5*01 – (unbekannt, bleibt leer)
6.8*01 - Wärmemenge Vorjahr (GJ)
9,7 - (unbekannt, in allen Metern identisch)
9.1 - Einstellungen und Firmware (5.19) (identisch in allen Messgeräten)
9.17 – (unbekannt, bleibt leer)
9.18 – (unbekannt, bleibt leer)
9.19 – (unbekannt, bleibt leer)
9.20 – Gerätenummer
9.21 – Eigentumsnummer
9.22 - (unbekannt)
9.24 - Messbereich (m3/h)
9.25 – (unbekannt, bleibt leer)
9.31 – Durchflussstunden (Stunde)
9.36 – Datum und Uhrzeit des Messgeräts
9.4 – Vorlauftemperatur max. / Rücklauftemperatur max. (Celcius)
9.4*01 – Vorlauftemperatur Max. / Rücklauftemperatur Max. Vorjahr (Celsius)
9.6 – Verschiedene Einstellungen von Eneco (nicht bestätigt)
F(n) – Fehlernummer (unbestätigt)
```

## Related links

* Tasmota Smart Meter Interface: https://tasmota.github.io/docs/Smart-Meter-Interface/#meter-definition
* Tasmota SML Dekoder: https://tasmota-sml-parser.dicp.net/
