void motionPhysics( robot_t robot ){
  robot.forces   = rotationMatrixVector2r( moveToTarget( robot ), robot.position.r );
  // the motor force should be set in the algorithm function by calling the API's motor functions
  robot.forces   = addVector2r( robot.forces, calculateFriction( robotTerrainFriction, robot.velocity ) );
  // the drag force is assumed to be insignificant and is ommitted in this simulation
  robot.velocity = addVector2r( robot.velocity, toAcceleration( robot.forces, robot.mass ) );
  robot.velocity = rayClamp( robot.velocity, robot.motorMaxSpeed );
  robot.position = addVector2r( robot.position, robot.velocity );
  robot.forces   = new vector2r_t();
  robot.distanceToTravel = updateTarget( robot.distanceToTravel, robot.velocity, robot.position );
  //println( robot.forces.r );
  //println( robot.distanceToTravel.x );
  //robotOnMouse( robot );
}

vector2r_t updateTarget( vector2r_t distanceToTravel, vector2r_t velocity, vector2r_t position ){
  return roundToZero( subtractVector2r( distanceToTravel, rotationMatrixVector2r( velocity, - position.r ) ), newVector2r( 3, 3, 0.01 ) );
}

vector2r_t moveToTarget( robot_t robot ){
  return vector2rMultiply3( vector2rSgn( robot.distanceToTravel ), robot.speedFactor, robot.motorMaxSpeed );
}

vector2r_t calculateFriction( vector2r_t maxFriction, vector2r_t velocity ){
  // disabled still
  return vector2rMultiply( vector2rNegate( vector2rSgn( velocity ) ), rayClamp( maxFriction, vector2rAbs( velocity ) ) );
}

vector2r_t toAcceleration( vector2r_t forces, float mass ){
  return multiplyVector2rByConstant( forces, 1 / mass ); // if this gives an error then you should set your mass in "B define" to a value other than zero
}

void robotOnMouse( robot_t robot ){
  robot.position.x = mouseX;
  robot.position.y = mouseY;
  robot.position.r += 0.002*PI;
}

//void robotSetTarget( vector2r_t target, robot_t robot, float powerFactor ){
//  robot.forces.x += robot.motorStrength.x * powerFactor;
//  if( robot.distanceToTravel == 0 ) robot.distanceToTravel = distance;
//}
