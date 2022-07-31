//ThatsEngineering
//Sending Data from Arduino to NodeMCU Via Serial Communication
//NodeMCU code
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>
//Include Lib for Arduino to Nodemcu
#include <SoftwareSerial.h>
#include <ArduinoJson.h>

// Firebase And Wifi.
#define FIREBASE_HOST "login-c1b9c.firebaseio.com"
#define FIREBASE_AUTH "EJHRw1dOd6gx2rAtoOUphrwqd3ULGAD08GTth29z"
#define WIFI_SSID "TP-LINK_D6A6"
#define WIFI_PASSWORD "40688855"

//D6 = Rx & D5 = Tx
SoftwareSerial nodemcu(D2, D1);


void setup() {
  // Initialize Serial port
  Serial.begin(9600);
  nodemcu.begin(9600);
  while (!Serial) continue;

  // connect to wifi. -------------------
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {

  StaticJsonBuffer<1000> jsonBuffer;
  JsonObject& data = jsonBuffer.parseObject(nodemcu);

  if (data == JsonObject::invalid()) {
    //Serial.println("Invalid Json Object");
    jsonBuffer.clear();
    return;
  }

  Serial.println("JSON Object Recieved");
  Serial.print("Recieved Humidity:  ");

  String motion = data["motion"];
  int hum = data["humidity"];
  int temp = data["temperature"];
  int heartBeat = data["heartbeat"];

  //set Data to Firebase
  String path = "/comaSystem";
  Firebase.setString("comaSystem/motion", motion);
  Firebase.setInt("comaSystem/Humidity", hum);
  Firebase.setInt("comaSystem/Temperature", temp);
  Firebase.setInt("comaSystem/heartBeat", heartBeat);

  //  Serial.println(hum);
  //  Serial.print("Recieved Temperature:  ");
  //
  //
  //  Serial.println(temp);
  //  Serial.println("-----------------------------------------");
}
