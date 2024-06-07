float senseProximity( proximitySensor_t proximitySensor, vector2r_t robot ){
  vector2r_t sensorRay = addVector2rWithMatrix( robot, proximitySensor.ray );
  vector2_t venusIntersection = findVenusIntersection( sensorRay, Float.NaN ).point;
  drawLine( sensorRay, proximitySensor.maxDistance );
  if( venusIntersection == null ) return proximitySensor.maxDistance;
  fill( 255, 0, 0 );
  plot( venusIntersection );
  float sampledDistance = distanceBetween( venusIntersection, rayToPoint( sensorRay ) );
  //return sampledDistance;
  return clamp( sampledDistance, proximitySensor.minDistance, proximitySensor.maxDistance );
}

Boolean senseFloorTape( vector2_t floorSensor, vector2r_t robot ){
  float borderThickness = 50; // move this parameter somewhere more accessible
  vector2_t sensorPoint = rayToVector2( addVector2rWithMatrix( robot, vector2ToRay( floorSensor ) ) );
  boolean tapeDetected = onVenusCrater( sensorPoint ) || onVenusBorder( sensorPoint, borderThickness );
  if( tapeDetected ) {fill( 255, 0, 0 );} else {fill( 0, 255, 0 );};
  plot( sensorPoint );
  return tapeDetected;
}

int senseColor( proximitySensor_t colorSensor, vector2r_t robot ){
  vector2r_t sensorRay = addVector2rWithMatrix( robot, colorSensor.ray );
  intersection_t venusIntersection = findVenusIntersection( sensorRay, colorSensor.maxDistance );
  drawLine( sensorRay, colorSensor.maxDistance );
  int type = interpretColor( venusIntersection.box );
  setColor( type );
  if( venusIntersection.point != null ) plotCustom( venusIntersection.point, 20 );
  return type;
}

void robotMove( float distance, robot_t robot, float speedFactor ){
  //robot.forces.x += robot.motorStrength.x * powerFactor;
  if( robot.distanceToTravel.x == 0 ) robot.distanceToTravel.x = distance;
  robot.speedFactor.x = speedFactor;
}

void robotRotate( float angle, robot_t robot, float speedFactor ){
  //robot.forces.r += robot.motorStrength.r * powerFactor;
  if( robot.distanceToTravel.r == 0 ) robot.distanceToTravel.r = angle;
  robot.speedFactor.r = speedFactor;
}

vector2_t recallRobotPosition( robot_t robot ){
  return rayToVector2( multiplyVector2rByConstant( robot.position, 1 + millis() * positionTrackingInaccuracy ) );
}

// sends a sample coordinate to be plotted
void sendSample( vector2_t point ){
  samples[samplePointer] = point;
  samplePointer++;
}

// turns a distance into a carthesian coordinate
vector2_t distanceToPoint( float proximitySample, robot_t robot ){
  return vector2Add( rayToVector2( addVector2rWithMatrix( robot.position, robot.proximitySensors[0].ray ) ), 
  toCartesian( newVector2Polar( proximitySample, robot.position.r + robot.proximitySensors[0].ray.r ) ) );
}

//void sendLink(){
  
//}
