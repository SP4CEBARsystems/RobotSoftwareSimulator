boolean unpredictable_terrain = false;
long predictable_terrain_seed = 0;
long seed_step = 2222;

vector2r_t robotTerrainFriction = newVector2r( 0.1, 0.1, 0.001 ); // dynamic friction in newtons - friction is defined for all directions: ( x, y, rotation )
float positionTrackingInaccuracy = 0; //0.0001;

//vector2r_t motionTrackingInaccuracyVector = newVector2r( 0.1, 0.1, 0.001 ); // not implemented
//primes: 991 701;


void defineObjects(){
//define balls
  //println(fieldSize.x, fieldSize.y);
  //if (unpredictable_terrain) randomSeed(System.currentTimeMillis());
  fieldSize.x = randomInBounds( 500, width - border*2 );
  fieldSize.y = randomInBounds( 500, height - border*2 );
  //println(fieldSize.x, fieldSize.y);
  defineField();
  
  robots = defineRobots();
  //vectors = randomPVectorArray( vectors );
  
  smallBlocks = randomBoxArray( smallBlocks,   10, 10 ,   10, 14 );
  bigBlocks   = randomBoxArray( bigBlocks  ,   20, 20 ,   5 , 9  );
  craters     = randomBoxArray( craters    ,   50, 100,   3 , 3  );
  mountains   = randomBoxArray( mountains  ,   50, 50 ,   4 , 4  );
}

// the robots are defined just like the objects:
// - coordinates and angles relative to a robot
// - designed with two robots in mind

robot_t[] defineRobots() {
  robot_t[] robots = new robot_t[2];
  for( int i=0; i < robots.length; i++ ){
    robots[i] = defineRobot( i );
  }
  return robots;
}

robot_t defineRobot( int index ){
  robot_t robot = new robot_t();
  robot.size             = newVector2( 50, 50 );
  float front =   robot.size.x / 2;
  float left  = - robot.size.y / 2;
  float right =   robot.size.y / 2;
  robot.position         = newVector2r( 100 + index * robot.size.x * 1.5, 100, 0 );
  robot.velocity         = newVector2r( 0, 0, 0 );
  robot.forces           = newVector2r( 0, 0, 0 );
  robot.motorStrength    = newVector2r( 0.2, 0.2, 0.002 );
  robot.motorMaxSpeed    = newVector2r( 1, 1, 0.01 );
  robot.speedFactor      = newVector2r( 0, 0, 0 );
  robot.mass             = 1; // in kilograms - DON'T SET IT TO ZERO
  robot.distanceToTravel = newVector2r( 0, 0, 0 );
  robot.proximitySensors = new proximitySensor_t[1]; //proximitySensor_t
    robot.proximitySensors[0] = newProximitySensor( newVector2r( front, 0, 0 ), 0, 2000 );
  robot.floorSensors     = new vector2_t[2];
    robot.floorSensors[0]     = newVector2( front, left );
    robot.floorSensors[1]     = newVector2( front, right );
  robot.colorSensors     = new proximitySensor_t[1];
    robot.colorSensors[0]     = newProximitySensor( newVector2r( front, 0, 0 ), 0, 50 );
  return robot;
}
