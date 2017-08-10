#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

char ssid[] = "your SSID"; //Wifi SSID
char pass[] = "your password"; //Password

#define firebaseURl  "firebaseURl" //輸入firebase資料庫的網址記得去掉前面的"http://"與最後面的"/"
#define authCode  "authCode"//資料庫金鑰

int led = D5;

void setupFirebase() {
  Firebase.begin(firebaseURl, authCode);
}

void setupWifi() {
  WiFi.begin(ssid, pass);
  Serial.println("Hey i 'm connecting...");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.println(".");
    delay(500);
  }
  Serial.println();
  Serial.println("I 'm connected and my IP address: ");
  Serial.println(WiFi.localIP());
}


void setup() {
  pinMode(led, OUTPUT);
  Serial.begin(115200);
  setupWifi();
  setupFirebase();
}

void loop() {
  String path = "device/led"; //資料的路徑
  FirebaseObject object = Firebase.get(path); //將資料抓進去一個firebase物件

  bool ledState = object.getBool("state"); //抓取物件裡面"state"欄位的值

  Serial.println("ledState:");
  Serial.println(ledState);
  digitalWrite(led, ledState); 
}


