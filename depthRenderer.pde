//https://forum.processing.org/two/discussion/2153/how-to-render-z-buffer-depth-pass-image-of-a-3d-scene

PShader depthShader;
float angle = 0.0;

boolean isDepth = true;//false;

PGraphics pg;

void setup() {
  colorMode(HSB, 255, 255, 255);
  // Set screen size and renderer
  size(800, 800, P3D);
  noStroke();
  noiseSeed(0);
  // Load shader
  depthShader = loadShader("frag.glsl", "vert.glsl");
  depthShader.set("near", 0.0); // Standard: 0.0
  depthShader.set("far", 200.0); // Standard: 100.0
  //depthShader.set("nearColor", 1.0, 0.0, 0.0, 1.0); // Standard: white
  //depthShader.set("farColor", 0.0, 0.0, 1.0, 1.0); // Standard: black

  pg = createGraphics(800, 800, P3D);
  pg.beginDraw();
  pg.background(255);
  pg.noStroke();
  pg.fill(0);
  for (int i = 0; i < 200; i++) {
    pg.rect(i*4, 0, 2, 800);
  }
  pg.endDraw();
  //textureMode(NORMAL);
}


void draw() {

  // Fill background and set camera
  background(#000000);
  image(pg, 0, 0);

  camera(0.0, 0.0, 50.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);

  // Bind shader
  if (isDepth)
    shader(depthShader);
  else
    lights();

  // Calculate angle
  angle += 0.01;

  // Render "sky"-cube
  pushMatrix();
  rotate(angle, 0.0, 1.0, 0.0);
  //box(100.0);
  popMatrix();

  // Render cubes
  //pushMatrix();
  //for (int i = -10; i <= 10; i++) {
  //  for (int j = -10; j <= 10; j++) {
  //    pushMatrix();
  //    translate(j * 15, i * 15, -140 -100 * noise(i+10, j+10));
  //    fill((j) * 10 + 100, 255, 255);
  //    rotateX(PI/4 + 0.01*(i+10));
  //    rotateZ(0.03*(j));
  //    texture(pg);
  //    //box(10, 10, 40);
  //    scale(10,20,40);
  //    TexturedCube(pg);
  //    popMatrix();
  //  }
  //}
  //popMatrix();

  for (float i = -11; i <= 10; i+=2) {
    for (float j = -11; j <= 10; j+=2) {
      for (float k = -6; k <= i+3; k+=2) {
        pushMatrix();
        translate(j * 10, i * 10, (k-10)*10-70);// + -70 -100 * noise(i+10, j+10));
        fill((j+20) * 4 + 30, 255, 255);
        box(0.5,20,0.5);
        box(20,0.5,0.5);
        //sphere(1.5);
        popMatrix();
      }
    }
  }

  if(isDepth)
  saveFrame("img_depth.png");
  else
  saveFrame("img.png");
  noLoop();
}


void TexturedCube(PGraphics tex) {
  beginShape(QUADS);
  texture(tex);

  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)

  // +Z "front" face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex( 1, 1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1, 1, 1, 0, 0);
  vertex( 1, 1, 1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  // +X "right" face
  vertex( 1, -1, 1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex( 1, 1, 1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 1, 0);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  endShape();
}
