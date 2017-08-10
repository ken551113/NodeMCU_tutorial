#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <OSCBundle.h>

char ssid[] = "HITRON-2C";
char pass[] = "0972283200";

WiFiUDP Udp;                           // A UDP instance to let us send and receive packets over UDP
const unsigned int localPort = 8000;   // local port to listen for UDP packets at the NodeMCU (another device must send OSC messages to this port)
const unsigned int destPort = 9000;    // remote port of the target device where the NodeMCU sends OSC to

int digitalLed = D4;
int ledState = 0;

int inputAnalog = 0;
int analogLed = D8;

void setup() {
  
  pinMode(digitalLed, OUTPUT);
  pinMode(analogLed,OUTPUT);
  
  Serial.begin(115200);
  //Set static IP
  WiFi.config(IPAddress(192, 168, 0, 11), IPAddress(192, 168, 0, 1), IPAddress(255, 255, 255, 0));
  // Connect to WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid,pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("Starting UDP");
  Udp.begin(localPort);
  Serial.print("Local port: ");
  Serial.println(Udp.localPort());
}

void OSC() {
  OSCMessage msgIN;
  int size;
  if ((size = Udp.parsePacket()) > 0) {
    while (size--)
      msgIN.fill(Udp.read());
    if (!msgIN.hasError()) {
      msgIN.route("/led", led); //if message is come from "/led",it will run function led
      msgIN.route("/analogLed", led2); //if message is come from "/led",it will run function led
    }
  }
}

void led(OSCMessage &msg, int addrOffset) {
  ledState = msg.getInt(0); //save recivied data to ledState
}

void led2(OSCMessage &msg, int addrOffset) {
  inputAnalog = msg.getInt(0); //save recivied data to ledState
}


void loop() {
  OSC();
  digitalWrite(digitalLed,ledState);//if led State is 0,led will be light(nodemcu's LED_BUILTIN is reversed logic) 
  analogWrite(analogLed,inputAnalog);
}
