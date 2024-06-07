class box_t
{
    public float x;
    public float y;
    public float w;
    public float h;
    public float r;
};

class block_t
{
    public box_t box;
    public int type;
};

class color_t
{
    public float r;
    public float g;
    public float b;
};

class vector2_t
{
    public float x;
    public float y;
};

class vector2Polar_t
{
    public float radius;
    public float theta;
};

//rename to "ray_t"?
class vector2r_t
{
    public float x;
    public float y;
    public float r;
};

class lineSegment_t
{
    public vector2r_t line;
    public float lineLength;
};

class intersection_t
{
    public vector2_t point;
    public block_t box;
};

class proximitySensor_t
{
    public vector2r_t ray;
    public float minDistance;
    public float maxDistance;
};

class robot_t
{
    public vector2_t size;
    public vector2r_t position;
    public vector2r_t velocity;
    public vector2r_t forces;
    public vector2r_t motorStrength;
    public vector2r_t motorMaxSpeed;
    public vector2r_t speedFactor;
    public float mass;
    public vector2r_t distanceToTravel;
    public proximitySensor_t[] proximitySensors;
    public vector2_t[] floorSensors;
    public proximitySensor_t[] colorSensors;
};

box_t newBox( float x, float y, float w, float h, float r ){
  box_t p = new box_t();
  p.x = x;
  p.y = y;
  p.w = w;
  p.h = h;
  p.r = r;
  return p;
};

color_t newColor( float r, float g, float b ){
  color_t p = new color_t();
  p.r = r;
  p.g = g;
  p.b = b;
  return p;
};

vector2r_t newVector2r( float x, float y, float r ){
  vector2r_t p = new vector2r_t();
  p.x = x;
  p.y = y;
  p.r = r;
  return p;
};

vector2_t newVector2( float x, float y ){
  vector2_t p = new vector2_t();
  p.x = x;
  p.y = y;
  return p;
};

vector2Polar_t newVector2Polar( float radius, float theta ){
  vector2Polar_t p = new vector2Polar_t();
  p.radius = radius;
  p.theta = theta;
  return p;
};

lineSegment_t newLineSegment( vector2r_t line, float lineLength ){
  lineSegment_t p = new lineSegment_t();
  p.line = line;
  p.lineLength = lineLength;
  return p;
};

intersection_t newIntersection( vector2_t point, block_t box ){
  intersection_t p = new intersection_t();
  p.point = point;
  p.box = box;
  return p;
};

block_t newBlock( box_t box, int type ){
  block_t p = new block_t();
  p.box = box;
  p.type = type;
  return p;
};

proximitySensor_t newProximitySensor( vector2r_t ray, float minDistance, float maxDistance ){
  proximitySensor_t p = new proximitySensor_t();
  p.ray = ray;
  p.minDistance = minDistance;
  p.maxDistance = maxDistance;
  return p;
};

robot_t newRobot( vector2_t size, vector2r_t position, vector2r_t velocity, vector2r_t forces, vector2r_t motorStrength, vector2r_t motorMaxSpeed, vector2r_t speedFactor, float mass, vector2r_t distanceToTravel, proximitySensor_t[] proximitySensors, vector2_t[] floorSensors, proximitySensor_t[] colorSensors ){
  robot_t p = new robot_t();
  p.size             = size;
  p.position         = position;
  p.velocity         = velocity;
  p.forces           = forces;
  p.motorStrength    = motorStrength;
  p.motorMaxSpeed    = motorMaxSpeed;
  p.speedFactor      = speedFactor;
  p.mass             = mass;
  p.distanceToTravel = distanceToTravel;
  p.proximitySensors = proximitySensors;
  p.floorSensors     = floorSensors;
  p.colorSensors     = colorSensors;
  return p;
};
