int interpretColor( block_t block ){
  if( block == null ) return -1;
  return block.type;
}


void plotEllipse( box_t ellipse ){
  for( float theta = 0; theta < 2 * PI; theta += 0.05 * PI ){
    vector2Polar_t polarEllipseSample = newVector2Polar( getPolarEllipseBoxRadius( theta, ellipse ), theta );
    vector2_t point = vector2Add( boxToPoint( ellipse ), toCartesian( polarEllipseSample ) );
    ellipse( point.x, point.y, 10, 10 );
  }
}

boolean onVenusCrater( vector2_t sensorPoint ){
  return pointOnEllipses( sensorPoint, craters );
}

boolean pointOnEllipses( vector2_t sensorPoint, block_t[] ellipses ){
  for( block_t ellipse : ellipses ){
    if ( pointOnEllipse( sensorPoint, ellipse.box ) ) return true;
  }
  return false; // no intersection was found
}

boolean pointOnEllipse( vector2_t sensorPoint, box_t ellipse ){
  vector2_t relativeSensorPoint = vector2Subtract( sensorPoint, boxToPoint( ellipse ) );
  return pointOnPolarEllipse( toPolar( relativeSensorPoint ), ellipse );
}

boolean pointOnPolarEllipse( vector2Polar_t sensorPoint, box_t ellipse ){
  float ellipseRadius = getPolarEllipseBoxRadius( sensorPoint.theta, ellipse );
  return sensorPoint.radius <= ellipseRadius;
}

float getPolarEllipseBoxRadius( float theta, box_t ellipse ){
  return getPolarEllipseRadius( ellipse.w / 2, ellipse.h / 2, theta - ellipse.r );
}

float getPolarEllipseRadius( float w, float h, float theta ){
  // equation found on wikipedia - https://en.wikipedia.org/wiki/Ellipse#Polar_form_relative_to_center
  return w * h / sqrt( sq( h * cos( theta ) ) + sq( w * sin( theta ) ) );
}



boolean onVenusBorder( vector2_t point, float borderThickness ){
  return pointOnBorder( point, field, borderThickness );
  //return pointInBox( point, field );
}

boolean pointOnBorder( vector2_t point, box_t box, float borderThickness ){
  return ( ! pointInBox( point, box ) ) && pointInBox( point, widenBox( box, borderThickness ) );
}

box_t widenBox( box_t box, float borderThickness ){
  box_t outerBorder = new box_t();
  outerBorder.x = box.x - borderThickness;
  outerBorder.y = box.y - borderThickness;
  outerBorder.w = box.w + borderThickness * 2;
  outerBorder.h = box.h + borderThickness * 2;
  return outerBorder;
}

boolean pointInBox( vector2_t point, box_t box ){
  return point.x > box.x 
    &&   point.y > box.y 
    &&   point.x < box.x + box.w 
    &&   point.y < box.y + box.h
  ;
}
