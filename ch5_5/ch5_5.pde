import processing.opengl.*;

void setup() {
  // OPENGL is deprecated.
  // I must use other library.
  // May be for example "Metal"?
  size(500, 300, OPENGL);
  sphereDetail(100);
}


void draw() {
  background(255);

  translate(width / 2, height / 2, 100);
  sphere(100);
}
