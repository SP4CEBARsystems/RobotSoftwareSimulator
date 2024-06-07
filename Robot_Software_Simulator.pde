void setup() {
  size( 1024, 700 );
  //size( sizeX1, sizeY1 );
  //size(screen.height, screen.width);
  frameRate(60);
  background(255);
  defineObjects();
}

void draw() {
  drawScene();
  plotSamples();
  simulateRobot( robots[0] );
  simulateRobot( robots[1] );
}

void simulateRobot( robot_t robot ){
  robotAlgorithm( robot );
  motionPhysics( robot );
  drawRobot( robot );
}
