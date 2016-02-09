import processing.serial.*;
import processing.net.*;
String APIKEY = "YOURUPLOARAPIKEY";
String FIELD = "field1";
String FIELD2 = "field2";
int PORTNUM = 1; //port number of your arduino
Serial arduino;
Client c;
String data;
float number1; //read from arduino
float number2; //read from arduino
String puerto;
Boolean error = false;
void setup() {
  size(820, 500);
  //println(Serial.list());
  try {arduino = new Serial(this, Serial.list()[PORTNUM], 9600);
     
    }
    catch(Exception ex) {
    rectMode(CENTER);  
    fill(255,0,0); 
    rect(width/2, height/2, width/2, height/2);
    PFont font;//you can change the font or simply delete this line
    font = loadFont("HelveticaNeue-MediumExt-30.vlw"); //you can change the font or simply delete this line
    textFont(font);//you can change the font or simply delete this line
    fill(#FFFF00);
    textAlign(CENTER);
    text("Puerto ocupado", width/2, height/2);
   
     {
       error = true;
       noLoop();
       

}
   
    }
 
    
  
  
  PFont font;
  font = loadFont("HelveticaNeue-MediumExt-15.vlw"); 
  textFont(font); 
}
void draw() {
   
  background(50);
  rectMode(CORNER);  
  fill(#251A6C); 
  rect(0, 0, 820, 65);
   puerto = (Serial.list()[PORTNUM]);
   fill(#E8E57E);
   text("Subiendo al canal 82841 de thingspeak.com los datos obtenidos por arduino en el puerto " +puerto , 10, 15);
    //text(puerto = (Serial.list()[PORTNUM]),500,15);
    fill(0, 255, 0);
   text("sonda 1 en la salida del notebook      |    sonda 2 temperatura ambiente", 10, 40);
   text("temperatura 1:  " + number1, 10, 60);
   text("temperatura 2:  " + number2, 350, 60);
  if( data != null ) {
    fill(0, 255, 0);
    text("Server Response:", 10, 90);
    fill(200);
    text(data, 10, 110);}
  if(c != null) {
    if (c.available() > 0) { // If there's incoming data from the client...
      data = c.readString(); // ...then grab it
      println(data);
    }}
 

 
  String ln;
 if (error == true ) {
 delay(3000);
 exit();}
  else {
  if ((ln = arduino.readStringUntil('\n')) != null) {
    try {
      String temp1 = ln.substring(0,5);    
      String temp2 = ln.substring(5);  
      
      number1 = new Float(trim(temp1));
      number2 = new Float(trim(temp2));
      { println("Writing " + number1);
        println("Writing " + number2);
        sendNumber(number1,number2);
      }
    }
    catch(Exception ex) {
    }
  }}
}

void sendNumber(float num1,float num2) {
  c = new Client(this, "api.thingspeak.com", 80); // Connect to server on port 80
  c.write("GET /update?key="+APIKEY+"&"+FIELD+"=" + num1 + "&" +FIELD2+"=" + num2 + " HTTP/1.1\n");
  c.write("Host: my_domain_name.com\n\n"); // Be polite and say who we are
}
