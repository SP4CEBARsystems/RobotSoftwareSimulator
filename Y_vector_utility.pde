vector2r_t addVector2r( vector2r_t a, vector2r_t b ){
  // doesn't use a rotation matrix
  return newVector2r(
    a.x + b.x, 
    a.y + b.y, 
    a.r + b.r
  );
}

vector2r_t subtractVector2r( vector2r_t a, vector2r_t b ){
  // doesn't use a rotation matrix
  return newVector2r(
    a.x - b.x, 
    a.y - b.y, 
    a.r - b.r
  );
}

vector2r_t addVector2rWithMatrix( vector2r_t a, vector2r_t b ){
  // uses a rotation matrix
  vector2_t rotatedB = rotationMatrix( rayToPoint( b ), a.r );
  return newVector2r(
    a.x + rotatedB.x, 
    a.y + rotatedB.y, 
    a.r + b.r
  );
}


vector2r_t roundToZero( vector2r_t a, vector2r_t threshold ){
  return newVector2r(
    abs( a.x ) < threshold.x ? 0 : a.x,
    abs( a.y ) < threshold.y ? 0 : a.y,
    abs( a.r ) < threshold.r ? 0 : a.r
  );
}

vector2r_t vector2rMultiply( vector2r_t a, vector2r_t b ){
  return newVector2r( 
    a.x * b.x, 
    a.y * b.y, 
    a.r * b.r
  ); 
}

vector2r_t vector2rMultiply3( vector2r_t a, vector2r_t b, vector2r_t c ){
  return newVector2r( 
    a.x * b.x * c.x, 
    a.y * b.y * c.y, 
    a.r * b.r * c.r
  ); 
}

vector2r_t vector2rAbs( vector2r_t value ){
  return newVector2r( 
    abs( value.x ), 
    abs( value.y ), 
    abs( value.r ) 
  ); 
}

vector2r_t vector2rSgn( vector2r_t value ){
  return newVector2r( 
    sgn( value.x ), 
    sgn( value.y ), 
    sgn( value.r ) 
  ); 
}

vector2r_t vector2rNegate( vector2r_t value ){
  return newVector2r( 
    - value.x, 
    - value.y, 
    - value.r 
  ); 
}

vector2r_t rayClamp( vector2r_t value, vector2r_t upperBoundary ){
  return newVector2r( 
    min( value.x, upperBoundary.x ), 
    min( value.y, upperBoundary.y ), 
    min( value.r, upperBoundary.r ) 
  );
}


vector2_t rotationMatrix( vector2_t a, float theta ){
  vector2_t b = new vector2_t();
  b.x = a.x * cos( theta ) + a.y * -sin( theta );
  b.y = a.x * sin( theta ) + a.y *  cos( theta );
  return b;
}

vector2r_t rotationMatrixVector2r( vector2r_t a, float theta ){
  vector2r_t b = new vector2r_t();
  b.x = a.x * cos( theta ) + a.y * -sin( theta );
  b.y = a.x * sin( theta ) + a.y *  cos( theta );
  b.r = a.r;
  return b;
}

vector2r_t multiplyVector2rByConstant( vector2r_t v, float c ){
  return newVector2r( v.x * c, v.y * c, v.r * c );
}

vector2_t rayToPoint( vector2r_t ray ){
  return newVector2( ray.x, ray.y );
}

vector2_t boxToPoint( box_t box ){
  return newVector2( box.x, box.y );
}

vector2r_t vector2ToRay( vector2_t point ){
  return newVector2r( point.x, point.y, 0 );
}

vector2_t rayToVector2( vector2r_t ray ){
  return newVector2( ray.x, ray.y );
}

box_t vectorsToBox( vector2r_t position, vector2_t size ){
  return newBox( position.x, position.y, size.x, size.y, position.r );
}

//float distanceRelative( vector2_t a, vector2_t b ){
//  return vector2Length( vector2Subtract( a, b ) );
//}

float distanceBetween( vector2_t a, vector2_t b ){
  return vector2Length( vector2Subtract( a, b ) );
}

float vector2Length( vector2_t point ){
  return pythagoras( point.x, point.y );
}

vector2_t vector2Add( vector2_t a, vector2_t b ){
  return newVector2( a.x + b.x, a.y + b.y );
}

vector2_t vector2Subtract( vector2_t a, vector2_t b ){
  return newVector2( a.x - b.x, a.y - b.y );
}

vector2Polar_t toPolar( vector2_t carthesianPoint ){
  return newVector2Polar( vector2Length( carthesianPoint ), atan2( carthesianPoint.y, carthesianPoint.x ) ); // yes atan2 has parameters ordered like y, x
}

vector2_t toCartesian( vector2Polar_t polarPoint ){
  return newVector2( polarPoint.radius * cos( polarPoint.theta ), polarPoint.radius * sin( polarPoint.theta ) );
} 
