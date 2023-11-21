void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}
int x;
void loop() {
  // put your main code here, to run repeatedly:
  x = Serial.readString().toInt();
  Serial.print(x+1);
}
