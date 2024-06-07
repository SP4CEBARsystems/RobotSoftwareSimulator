intersection_t findVenusIntersection( vector2r_t ray, float maxLength ){
  intersection_t venusIntersection = newIntersection( null, null );
  intersection_t smallBlocksIntersection = findBoxesIntersection( smallBlocks, ray, maxLength );
  intersection_t bigBlocksIntersection   = findBoxesIntersection( bigBlocks  , ray, maxLength );
  intersection_t mountainsIntersection   = findBoxesIntersection( mountains  , ray, maxLength );
  // there will be no wall detection
  venusIntersection = closestToOriginIntersection( smallBlocksIntersection, venusIntersection, rayToPoint( ray ) );
  venusIntersection = closestToOriginIntersection( bigBlocksIntersection  , venusIntersection, rayToPoint( ray ) );
  venusIntersection = closestToOriginIntersection( mountainsIntersection  , venusIntersection, rayToPoint( ray ) );
  return venusIntersection; // value is null if no intersection was found
}

intersection_t findBoxesIntersection( block_t[] boxes, vector2r_t ray, float maxLength ){
  vector2_t boxesIntersection = null;
  block_t intersectedBox = null;
  for( block_t box : boxes ){
    vector2_t boxIntersection = findBoxIntersection( box.box, ray, maxLength );
    boxesIntersection = closestToOrigin( boxIntersection, boxesIntersection, rayToPoint( ray ) );
    if( boxesIntersection == boxIntersection ) intersectedBox = box;
  }
  return newIntersection( boxesIntersection, intersectedBox ); // value is null if no intersection was found
}

vector2_t findBoxIntersection( box_t box, vector2r_t ray, float maxLength ){
  vector2_t boxIntersection = null;
  //float closestDistance = width + height;
  //pointAndDistance_t boxIntersection
  for(int faceIndex=0; faceIndex<4; faceIndex++){
    lineSegment_t face = getFaceOfBox( box, faceIndex );
    //stroke( 255, 0, 0 );
    //drawLine( face.line, face.lineLength );
    //stroke( 255 );
    //vector2_t lineIntersection = findLineIntersection( ray, face.line, face.lineLength );
    vector2_t lineIntersection = findLineSegmentIntersection( newLineSegment( ray, maxLength ), face ); // NaN is used to signify an "unbounded" line segment - Make sure to check this case
    //if( lineIntersection == null ) continue;
    //fill( 0, 0, 255 );
    //ellipse( lineIntersection.x, lineIntersection.y, 10, 10 );
    boxIntersection = closestToOrigin( lineIntersection, boxIntersection, rayToPoint( ray ) );
  }
  //if( boxIntersection == null ) return null; // no intersection found
  return boxIntersection; // value is null if no intersection was found
  //return findLineIntersection( ray, box.x + box.w, box.y + box.h, box.r );
}

vector2_t closestToOrigin( vector2_t newPoint, vector2_t oldPoint, vector2_t origin ){
  //float distance = distanceBetween( newPoint, origin );
  //if( distance <= closestDistance ){
  if( newPoint == null ) return oldPoint;
  if( oldPoint == null ) return newPoint;
  if( distanceBetween( newPoint, origin ) <= distanceBetween( oldPoint, origin ) ){
    //closestDistance = distance;
    //oldPoint = newPoint;
    return newPoint;
  }
  return oldPoint;
}

intersection_t closestToOriginIntersection( intersection_t newPoint, intersection_t oldPoint, vector2_t origin ){
  //float distance = distanceBetween( newPoint, origin );
  //if( distance <= closestDistance ){
  if( newPoint.point == null ) return oldPoint;
  if( oldPoint.point == null ) return newPoint;
  if( distanceBetween( newPoint.point, origin ) <= distanceBetween( oldPoint.point, origin ) ){
    //closestDistance = distance;
    //oldPoint = newPoint;
    return newPoint;
  }
  return oldPoint;
}

//vector2_t senseLineIntersection( vector2r_t ray, vector2r_t face, float faceLength ){
//  //findLineIntersection( vector2r_t ray, vector2r_t face, float faceLength );
//  //findLineIntersection( vector2r_t ray, vector2r_t face, float faceLength );
//}

vector2_t findLineSegmentIntersection( lineSegment_t a, lineSegment_t b ){
  //return findLineIntersection( a.line, b.line, b.lineLength );
  //custom domains: a: [0, inf), b: [0, faceLength]
  //float ta = 0;
  float ta = findLineSegmentIntersectionParameter( b, a );
  float tb = findLineSegmentIntersectionParameter( a, b );
  if( Float.isNaN( ta ) || Float.isNaN( tb ) ) return null;
  return findLinePoint( b.line, tb );
}

vector2_t findLineIntersection( vector2r_t ray, vector2r_t face, float faceLength ){
  //custom domains: a: [0, inf), b: [0, faceLength]
  float t = findLineIntersectionParameter( ray, face );
  if( Float.isNaN( t ) ) return null;
  if( t < 0 || t > faceLength ) return null; //new vector2_t(); // intersection lays outside of the box - MAKE SURE TO DETECT NULL CASES IN LATER FUNCTIONS
  //float t_ray = ;
  return findLinePoint( face, t );
}

float findLineSegmentIntersectionParameter( lineSegment_t a, lineSegment_t b ){
  float t = findLineIntersectionParameter( a.line, b.line );
  if( t < 0 ) return Float.NaN; // lower bound
  if( Float.isNaN( b.lineLength ) ) return t; // unbounded
  if( t > b.lineLength ) return Float.NaN; // upper bound
  return t; //MAKE SURE TO DETECT THESE NaN CASES IN LATER FUNCTIONS
}

float findLineIntersectionParameter( vector2r_t a, vector2r_t b ){
  // intersection of parametric lines linear algebra solution that took me five attempts to find
  float n = cos( a.r ) * ( a.y - b.y ) - sin( a.r ) * ( a.x - b.x );
  float d = cos( a.r ) * sin( b.r )    - sin( a.r ) * cos( b.r );
  if( d == 0 ) return Float.NaN; // the lines are parallel - MAKE SURE TO DETECT this NaN CASE IN LATER FUNCTIONS
  return n / d;
}

vector2_t findLinePoint( vector2r_t ray, float t ){
  vector2_t p = new vector2_t();
  p.x = ray.x + t * cos( ray.r );
  p.y = ray.y + t * sin( ray.r );
  return p;
}

void drawLine( vector2r_t ray, float l ){
  vector2_t p = findLinePoint( ray, l );
  line( ray.x, ray.y, p.x, p.y );
}

lineSegment_t getFaceOfBox( box_t box, int faceIndex ){
  float cornerDistance = pythagoras( 0.5 * box.w, 0.5 * box.h );
  float cornerAngle = box.r + 0.25 * PI + faceIndex * 0.5 * PI;
  return newLineSegment( 
    newVector2r(
      box.x + cos( cornerAngle ) * cornerDistance, 
      box.y + sin( cornerAngle ) * cornerDistance, 
      cornerAngle - 0.75 * PI
    ),
    faceIndex % 2 == 1 ? box.w : box.h
  );
  //return newVector2r( box.x + cos( angle ) * w - sin( angle ) * h, box.y + sin( angle ) * w + cos( angle ) * h, angle - 0.5 * PI );
  //addVector2r( 
}
