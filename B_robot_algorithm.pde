void robotAlgorithm( robot_t robot ){
  
  // sensor demo
  float proximitySample = senseProximity( robot.proximitySensors[0], robot.position );
  boolean floorTapeLeft = senseFloorTape( robot.floorSensors[0], robot.position );
  boolean floorTapeRight = senseFloorTape( robot.floorSensors[1], robot.position );
  int colorSample = senseColor( robot.colorSensors[0], robot.position );
  vector2_t position = recallRobotPosition( robot );
  println( position.x, position.y, proximitySample, floorTapeLeft, floorTapeRight, colorSample );
  
  // sample demo
  sendSample( distanceToPoint( proximitySample, robot ) );
  
  // motion demo
  if( millis() < 1000                      ) robotMove  ( 100   , robot, 0.5 );
  if( millis() > 5000  && millis() < 6000  ) robotRotate( 0.5*PI, robot, 1   );
  if( millis() > 10000 && millis() < 11000 ) robotMove  ( 100   , robot, 1   );
  //if( mousePressed ) robotMove  ( 100   , robot, 1 );
  //if( mousePressed ) robotRotate( 0.5*PI, robot, 1 );
}
