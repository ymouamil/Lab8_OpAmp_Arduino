/*
  ENME 351 Lab 8 - Processing Oscilloscope Plot

  Arduino must send:
    Vin,Vminus,Vout,Vplus

  Required lab colors:
    Vin / A0 = white
    V-  / A1 = green
    Vo  / A2 = blue
    V+  / A3 = yellow

  Background gray level = 125
*/

import processing.serial.*;

Serial myPort;

float x = 0;
float lastVinY;
float lastVminusY;
float lastVoutY;
float lastVplusY;
boolean firstPoint = true;

int plotTop = 50;
int plotBottom;
int leftMargin = 55;
int rightMargin = 20;

void setup() {
  size(1050, 650);
  plotBottom = height - 75;

  println("Available serial ports:");
  println(Serial.list());

  // Change the index if Processing connects to the wrong port.
  // Try [0], [1], [2], etc.
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');

  drawScreen();
}

void draw() {
}

void drawScreen() {
  background(125);

  strokeWeight(1);
  stroke(90);

  for (int v = 0; v <= 5; v++) {
    float y = map(v, 0, 5, plotBottom, plotTop);
    line(leftMargin, y, width - rightMargin, y);

    fill(20);
    textSize(13);
    text(v + " V", 15, y + 4);
  }

  for (int i = 0; i <= 10; i++) {
    float gx = map(i, 0, 10, leftMargin, width - rightMargin);
    line(gx, plotTop, gx, plotBottom);
  }

  fill(0);
  textSize(18);
  text("ENME 351 Lab 8 Op-Amp Arduino Oscilloscope", leftMargin, 25);

  textSize(14);

  fill(255);
  text("Vin / A0", leftMargin + 20, 45);

  fill(0, 255, 0);
  text("V- / A1", leftMargin + 120, 45);

  fill(0, 0, 255);
  text("Vo / A2", leftMargin + 215, 45);

  fill(255, 255, 0);
  text("V+ / A3", leftMargin + 310, 45);

  fill(0);
  text("Press R to reset plot", width - 170, 45);

  stroke(0);
  noFill();
  rect(leftMargin, plotTop, width - leftMargin - rightMargin, plotBottom - plotTop);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    x = 0;
    firstPoint = true;
    drawScreen();
  }
}

void serialEvent(Serial port) {
  String line = port.readStringUntil('\n');
  if (line == null) return;

  line = trim(line);
  if (line.length() == 0) return;

  String[] values = split(line, ',');
  if (values.length < 4) return;

  float Vin = parseSafe(values[0]);
  float Vminus = parseSafe(values[1]);
  float Vout = parseSafe(values[2]);
  float Vplus = parseSafe(values[3]);

  if (Float.isNaN(Vin) || Float.isNaN(Vminus) || Float.isNaN(Vout) || Float.isNaN(Vplus)) {
    return;
  }

  float plotX = map(x, 0, width - leftMargin - rightMargin, leftMargin, width - rightMargin);

  float yVin = map(Vin, 0, 5, plotBottom, plotTop);
  float yVminus = map(Vminus, 0, 5, plotBottom, plotTop);
  float yVout = map(Vout, 0, 5, plotBottom, plotTop);
  float yVplus = map(Vplus, 0, 5, plotBottom, plotTop);

  strokeWeight(2);

  if (!firstPoint) {
    float prevX = map(x - 1, 0, width - leftMargin - rightMargin, leftMargin, width - rightMargin);

    stroke(255);
    line(prevX, lastVinY, plotX, yVin);

    stroke(0, 255, 0);
    line(prevX, lastVminusY, plotX, yVminus);

    stroke(0, 0, 255);
    line(prevX, lastVoutY, plotX, yVout);

    stroke(255, 255, 0);
    line(prevX, lastVplusY, plotX, yVplus);
  }

  lastVinY = yVin;
  lastVminusY = yVminus;
  lastVoutY = yVout;
  lastVplusY = yVplus;
  firstPoint = false;

  drawReadout(Vin, Vminus, Vout, Vplus);

  x += 1;

  if (plotX >= width - rightMargin) {
    x = 0;
    firstPoint = true;
    drawScreen();
  }
}

float parseSafe(String s) {
  try {
    return Float.parseFloat(trim(s));
  }
  catch (Exception e) {
    return Float.NaN;
  }
}

void drawReadout(float Vin, float Vminus, float Vout, float Vplus) {
  noStroke();
  fill(125);
  rect(0, height - 45, width, 45);

  textSize(16);

  fill(255);
  text("Vin: " + nf(Vin, 1, 3) + " V", 25, height - 18);

  fill(0, 255, 0);
  text("V-: " + nf(Vminus, 1, 3) + " V", 220, height - 18);

  fill(0, 0, 255);
  text("Vo: " + nf(Vout, 1, 3) + " V", 410, height - 18);

  fill(255, 255, 0);
  text("V+: " + nf(Vplus, 1, 3) + " V", 600, height - 18);
}
