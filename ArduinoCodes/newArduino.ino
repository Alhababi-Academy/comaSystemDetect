#include <DHT.h>
#include <SoftwareSerial.h>
#include <Adafruit_Sensor.h>
#include <ArduinoJson.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include <PulseSensorPlayground.h>
#define trig 9 //define trigger pin at arduino pin 9.
#define echo 8 //define echo pin at arduino pin 8.

//Initialise Arduino to NodeMCU (5=Rx & 6=Tx)
LiquidCrystal_I2C lcd(0x27, 16, 2); // Set the LCD address to 0x27 for a 16 chars and 2 line display
SoftwareSerial nodemcu(5, 6);
//Initialisation of DHT11 Sensor
#define DHTPIN A0
int const PULSE_SENSOR_PIN = A1;   // 'S' Signal pin connected to A0
DHT dht(DHTPIN, DHT11);

byte degree_symbol[8] = {0b00111, 0b00101, 0b00111, 0b00000, 0b00000, 0b00000, 0b00000, 0b00000};
int temp;
int hum;
int heartBeat;
int Signal;
int Threshold = 550;
int ledPin = 13;                // choose the pin for the LED
int inputPin = 2;               // choose the input pin (for PIR sensor)
int pirState = LOW;             // we start, assuming no motion detected
int val = 0;                    // variable for reading the pin status
String motion;

void setup() {
  Serial.begin(9600);
  Signal = analogRead(PULSE_SENSOR_PIN); // Read the sensor value
  pinMode(ledPin, OUTPUT);      // declare LED as output
  pinMode(inputPin, INPUT);     // declare sensor as input
  dht.begin();
  nodemcu.begin(9600);
  lcd.init();
  lcd.backlight(); // Turn on the blacklight and print a message.
  delay(500);

  Serial.println("Program started");
}

void dht11_func() {
  hum = dht.readHumidity();
  temp = dht.readTemperature();
  Serial.print("Humidity: ");
  Serial.println(hum);
  Serial.print("Temperature: ");
  Serial.println(temp);

  // Display Temperature
  lcd.clear();
  lcd.setCursor(0, 0); // Set the cursor to column 0,row 0.
  lcd.print("Temp:"); // Print the massage
  lcd.setCursor(5, 0);
  lcd.print(temp);
  lcd.createChar(1, degree_symbol);
  lcd.setCursor(7, 0);
  lcd.write(1);

  // Display Humidity
  lcd.setCursor(0, 3); // Set the cursor to column 0,row 0.
  lcd.print("Humidity:");
  lcd.setCursor(9, 3);
  lcd.print(hum);
  lcd.setCursor(11, 3);
  lcd.print("%");
  delay(2000);
}

void heartBeatFunction() {
  Signal = analogRead(PULSE_SENSOR_PIN); // Read the sensor value
  if (Signal > Threshold) {              // If the signal is above threshold, turn on the LED
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);    // Else turn off the LED
  }
  heartBeat = Signal;
  Serial.println(Signal);
  // Display HeartBeat
  lcd.clear();
  lcd.setCursor(0, 0); // Set the cursor to column 0,row 0.
  lcd.print("BMP:"); // Print the massage
  lcd.setCursor(4, 0);
  lcd.print(heartBeat);
  delay(2000);
}

void savingData() {
  StaticJsonBuffer<1000> jsonBuffer;
  JsonObject& data = jsonBuffer.createObject();
  //Assign collected data to JSON Object
  data["motion"] = motion;
  data["humidity"] = hum;
  data["temperature"] = temp;
  data["heartbeat"] = heartBeat;


  //Send data to NodeMCU
  data.printTo(nodemcu);
  jsonBuffer.clear();

  // Display HeartBeat
  lcd.clear();
  lcd.setCursor(0, 0); // Set the cursor to column 0,row 0.
  lcd.print("Saving Data..."); // Print the massage
  delay(2000);
}

void loop() {
  val = digitalRead(inputPin);  // read input value
  
  if (val == HIGH) {
    // check if the input is HIGH
    digitalWrite(ledPin, HIGH);  // turn LED ON
    if (pirState == LOW) {
      // we have just turned on
      Serial.println("Motion detected!");
      motion = "Motion Detected";
      // Display Motion
      lcd.setCursor(0, 0); // Set the cursor to column 0,row 0.
      lcd.print("Motion Detected:"); // Print the massage
      delay(1500);
      // We only want to print on the output change, not state
      pirState = HIGH;
      //Function to get Temp and Hum
      dht11_func();
      //Function to get HeartBeat
      heartBeatFunction();
      savingData();
    }
  } else {
    digitalWrite(ledPin, LOW); // turn LED OFF
    if (pirState == HIGH) {
      // we have just turned of
      Serial.println("Motion ended!");
      // We only want to print on the output change, not state
      pirState = LOW;
    }
  }
}
