//https://forum.processing.org/two/discussion/2153/how-to-render-z-buffer-depth-pass-image-of-a-3d-scene

PShader depthShader;
boolean saveImages = true;
boolean isDepth = true;

void setup() {
  size(800, 800, P3D);
  noStroke();

  depthShader = loadShader("frag.glsl", "vert.glsl");
  depthShader.set("near", 0.0); // Standard: 0.0
  depthShader.set("far", 200.0); // Standard: 100.0
  depthShader.set("nearColor", 1.0, 1.0, 1.0, 1.0); // Standard: white
  depthShader.set("farColor", 0.0, 0.0, 0.0, 1.0); // Standard: black

  colorMode(HSB, 255, 255, 255);
}


void draw() {
  background(0);
  camera(0.0, 0.0, 50.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
 
  if (isDepth) {
    shader(depthShader);
  } else {
    lights();
    // draw background image here if you want
    // image(img, 0, 0);
  }

  for (float i = -11; i <= 10; i+=2) {
    for (float j = -11; j <= 10; j+=2) {
      for (float k = -6; k <= i+3; k+=2) {
        pushMatrix();
        translate(j * 10, i * 10, (k-10)*10-70);
        fill((j+20) * 4 + 30, 255, 255);
        box(10);
        popMatrix();
      }
    }
  }

  if (isDepth) {
    isDepth = false;
    if (saveImages)
      saveFrame("img_depth.png");
  } else {
    if (saveImages)
      saveFrame("img.png");
    noLoop();
  }
}
