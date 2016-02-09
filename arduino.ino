// lee la temperatura de un termopar conectado a vdd, a A1 y de ahi a gnd por una resistencia de 10k .
 // hace el calculo y lo manda por el puerto serie cada 60 segundos con dos valores decimales para thigspeak
 
 const int ThermPin1 = A1;  // el termistor en el analog 1
 const int ThermPin2 = A2;  // el termistor en el analog 2
 float ThermValue1 = 0; // ahi guardamos lo leido del pin anterior
 float temp1 =0;    // esta sera la variable con el valor final 
 
 float ThermValue2 = 0; // ahi guardamos lo leido del pin anterior
 float temp2 =0;    // esta sera la variable con el valor final 
 
 
 #include <math.h>
 
 
 void setup(){
   Serial.begin(9600);
 }
 
 void loop(){
 ThermValue1 = analogRead(ThermPin1); 
 ThermValue2 = analogRead(ThermPin2);   
 
 
              
 float TempVal1 = 1/((1/298.00)+(1/4100.00)*log(1024.00/ThermValue1-1.00));
   TempVal1 = TempVal1 - 273.00;  
   temp1= TempVal1;
 
 float TempVal2 = 1/((1/298.00)+(1/4100.00)*log(1024.00/ThermValue2-1.00));
   TempVal2 = TempVal2 - 273.00;  
   temp2= TempVal2;
 
 
 
   
   Serial.print(temp1);
 Serial.println(temp2);
   delay(6000);
 }
