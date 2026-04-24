# ENME 351 Lab 8 - Op-Amp Circuits with Arduino

This project contains the Arduino and Processing code for Lab 8.

## Folder layout

```text
Lab8_OpAmp_Arduino_Project/
├── arduino/
│   └── Lab8_OpAmp_Reader/
│       └── Lab8_OpAmp_Reader.ino
├── processing/
│   └── Lab8_OpAmp_Oscope/
│       └── Lab8_OpAmp_Oscope.pde
└── README.md
```

## Arduino pin meanings

| Arduino pin | Signal |
|---|---|
| A0 | Vin |
| A1 | V- |
| A2 | Vo |
| A3 | V+ |

## Lab-required colors

| Signal | Wire / plot color |
|---|---|
| 5 V | red |
| 0 V / GND | black |
| Vin / A0 | white |
| V- / A1 | green |
| Vo / A2 | blue |
| V+ / A3 | yellow |

## Upload Arduino code

Open:

```text
arduino/Lab8_OpAmp_Reader/Lab8_OpAmp_Reader.ino
```

Upload it to the Arduino.

The Arduino prints:

```text
Vin,Vminus,Vout,Vplus
```

every 50 ms.

## Run Processing code

Open:

```text
processing/Lab8_OpAmp_Oscope/Lab8_OpAmp_Oscope.pde
```

Run it.

If the wrong serial port is selected, change this line:

```java
myPort = new Serial(this, Serial.list()[0], 9600);
```

Try:

```java
Serial.list()[1]
Serial.list()[2]
Serial.list()[3]
```

until it connects to the Arduino.

## Exercise 2: Voltage follower

Measure:

```text
A0 = Vin
A1 = V-
A2 = Vo
```

Expected result:

```text
Vin ≈ V- ≈ Vo
```

## Exercise 3: Inverting amplifier

Measure:

```text
A0 = Vin
A1 = V-
A2 = Vo
A3 = V+ = 2.5 V reference
```

Expected result around the 2.5 V reference:

```text
Vo - 2.5 = -10(Vin - 2.5)
```

## Exercise 4: Integrator

Measure:

```text
A0 = Vin
A1 = V-
A2 = Vo
A3 = V+ = 2.5 V reference
```

Expected result:

```text
Vin > 2.5 V  -> Vo ramps down
Vin < 2.5 V  -> Vo ramps up
Vin ≈ 2.5 V  -> Vo stays nearly flat
```
