import processing.opengl.*;
int z = 0;
int zMove = 1;

void setup() {
  // OPENGL is deprecated.
  // I must use other library.
  // May be for example "Metal"?
  size(500, 300, OPENGL);
  sphereDetail(100);
}


void draw() {
  background(255);

  translate(width / 2, height / 2, z);
  
  z = z+zMove;
  sphere(100);
}
