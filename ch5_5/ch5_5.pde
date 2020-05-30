import processing.opengl.*;
int z = 0;
int zMove = 10;
int zVector = 1;

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
  sphere(100);

  zMove = (int)random(1, 10);
  if (z >= 255) {
    zVector =  zVector * -1;
  }
  if (z <= 0) {
    zVector = abs(zVector);
  }

  z = z + (zMove * zVector);
}
