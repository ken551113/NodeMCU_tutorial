#include <ESP8266WiFi.h>

char ssid[] = "IAR2";
char pass[] = "iar31977";

WiFiServer server(80);

int led1 = D4;
int led2 = D8;

int value1 = LOW;
int value2 = LOW;

String request;

void setup() {

  Serial.begin(115200);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);

  // Connect to WiFi network
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");

  // Start the server
  server.begin();
  Serial.println("Server started");

  // Print the IP address
  Serial.print("Use this URL to connect: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");

}

void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  // Wait until the client sends some data
  Serial.println("new client");
  while (!client.available()) {
    delay(1);
  }
  // Read the first line of the request
  request = client.readStringUntil('\r');
  Serial.println(request);
  client.flush();

  matchRequest();
  returnResponse(client);

  delay(1);
  Serial.println("Client disonnected");
  Serial.println("");
}

void matchRequest() {
  // Match the request
  if (request.indexOf("/LED1=ON") != -1) {
    digitalWrite(led1, HIGH);
    value1 = HIGH;
  }
  if (request.indexOf("/LED1=OFF") != -1) {
    digitalWrite(led1, LOW);
    value1 = LOW;
  }
  if (request.indexOf("/LED2=ON") != -1) {
    digitalWrite(led2, HIGH);
    value2 = HIGH;
  }
  if (request.indexOf("/LED2=OFF") != -1) {
    digitalWrite(led2, LOW);
    value2 = LOW;
  }
}

void returnResponse(WiFiClient client) {
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println(""); // do not forget this one
  client.println("<!DOCTYPE HTML>");
  client.println("<html>");

  client.print("Led pin1 is now: ");
  if (value1 == HIGH) {
    client.print("On");
  } else {
    client.print("Off");
  }
  client.println("<br>");
  client.print("Led pin2 is now: ");
  if (value2 == HIGH) {
    client.print("On");
  } else {
    client.print("Off");
  }
  client.println("<br><br>");
  client.println("<a href=\"/LED1=ON\"><button>Led1 ON</button></a><a href=\"/LED1=OFF\"><button>Led1 OFF</button></a></p>");
  client.println("<a href=\"/LED2=ON\"><button>Led2 ON</button></a><a href=\"/LED2=OFF\"><button>Led2 OFF</button></a></p>");
  client.println("</html>");
}


