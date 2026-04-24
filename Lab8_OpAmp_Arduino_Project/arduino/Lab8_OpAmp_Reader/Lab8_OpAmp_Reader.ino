/*
  ENME 351 Lab 8 - Op Amp Circuits with Arduino
  Reads:
    A0 = Vin
    A1 = V-  (inverting input)
    A2 = Vo  (op-amp output)
    A3 = V+  (non-inverting input / 2.5 V reference when used)

  Sends comma-separated voltages to Processing:
    Vin,Vminus,Vout,Vplus

  Sample interval: 50 ms
*/

const int pinVin = A0;
const int pinVminus = A1;
const int pinVout = A2;
const int pinVplus = A3;

const float VREF = 5.0;
const float ADC_MAX = 1023.0;

float readVoltage(int pin) {
  return analogRead(pin) * (VREF / ADC_MAX);
}

void setup() {
  Serial.begin(9600);
}

void loop() {
  float Vin = readVoltage(pinVin);
  float Vminus = readVoltage(pinVminus);
  float Vout = readVoltage(pinVout);
  float Vplus = readVoltage(pinVplus);

  Serial.print(Vin, 3);
  Serial.print(",");
  Serial.print(Vminus, 3);
  Serial.print(",");
  Serial.print(Vout, 3);
  Serial.print(",");
  Serial.println(Vplus, 3);

  delay(50);
}
