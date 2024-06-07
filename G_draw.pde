void drawScene(){
  ellipseMode(CENTER);
  //rectMode(CORNERS)
  drawBackground( field );
  drawObjects();
  ////drawBricks();
  ////drawBalls();
}

void drawBackground( box_t field ){
  rectMode(CORNER);
  background(153);
  stroke(0,0,0);
  fill(255,250,200);
  rect( field.x, field.y, field.w, field.h );
  //rect( (width - fieldSize.x)/2, (height - fieldSize.y)/2, fieldSize.x, fieldSize.y );
  //rect(border,border,width-2*border,height-2*border);
}

void drawObjects(){
  drawSmallBlocks();
  drawBigBlocks();
  drawCraters();
  drawMountains();
}

void drawSmallBlocks(){
  fill(153, 0, 0);
  drawRectBoxes( smallBlocks );
}

void drawBigBlocks(){
  fill(153, 0, 0);
  drawRectBoxes( bigBlocks );
}

void drawCraters(){
  fill(200);
  drawEllipseBoxes( craters );
}

void drawMountains(){
  fill(153);
  drawRectBoxes( mountains );
}

void drawRectBoxes( block_t[] boxes ){
  rectMode(CENTER);
  for( block_t box : boxes ){
    setColor( box.type );
    drawRectBox( box.box );
  }
}

void drawRectBox( box_t box ){
  rectMode(CENTER);
  translate( box.x, box.y );
  rotate( box.r );
  rect( 0, 0, box.w, box.h );
  rotate( -box.r );
  translate( -box.x, -box.y );
  ellipse(box.x, box.y,5,5);
}

void drawEllipseBoxes( block_t[] boxes ){
  ellipseMode(CENTER);
  for( block_t box : boxes ){
    setColor( box.type );
    drawEllipseBox( box.box );
  }
}

void drawEllipseBox( box_t box ){
  ellipseMode(CENTER);
  translate( box.x, box.y );
  rotate( box.r );
  ellipse( 0, 0, box.w, box.h );
  rotate( -box.r );
  translate( -box.x, -box.y );
  ellipse(box.x, box.y,5,5);
}

void drawRobot( robot_t robot ){
  fill( 63 );
  drawRectBox( vectorsToBox( robot.position, robot.size ) );
}

void plotSamples(){
  for( int i = 0; i < samplePointer; i++ ){
    plot( samples[i] );
  }
}

void setColor( int type ){
  switch( type ){
    case 0: // reference
    fill( 0, 0, 0 );
    break;
    case 1: // corner
    fill( 0, 0, 0 );
    break;
    case 2: // border
    fill( 0, 0, 0 );
    break;
    case 3: // crater
    fill(200);
    break;
    case 4: // mountain
    fill(153);
    break;
    
    case 5: // 5 colors of big blocks
    fill( 127 );
    break;
    case 6:
    fill( 255, 63, 63 );
    break;
    case 7:
    fill( 63, 255, 63 );
    break;
    case 8:
    fill( 63, 63, 255 );
    break;
    case 9:
    fill( 191, 191, 63 );
    break;
    
    case 10: // 5 colors of small blocks
    fill( 127 );
    break;
    case 11:
    fill( 255, 127, 127 );
    break;
    case 12:
    fill( 127, 255, 127 );
    break;
    case 13:
    fill( 127, 127, 255 );
    break;
    case 14:
    fill( 191, 191, 127 );
    break;
  }
}

void plot( vector2_t point ){
  ellipse( point.x, point.y, 10, 10 );
}

void plotCustom( vector2_t point, float size ){
  ellipse( point.x, point.y, size, size );
}

void linePlot(float a1,float b1,float a2,float b2,float dir2,float xb,float yb){
  for (int i=0; i<=19; i++) {
    int y= (int)(a1*50*i+b1);
    if(((dir2==0 || dir2==3) && i*50 > xb) || ((dir2==1 || dir2==2) && i*50 < xb)) { 
      ellipse(i*50,y,10,10);
    }
    
    int x= (int)(a2*50*i+b2);
    if(((dir2==0 || dir2==1) && i*50 > yb) || ((dir2==2 || dir2==3) && i*50 < yb)) { 
      ellipse(x,i*50,10,10);
    }

    //if((dir2==0 && a1>0) || (dir2==1 && a1>0) || (dir2==2 && a1>0) || (dir2==3 && a1>0)) {
    //}
    //print(dir2,"_");
  }
}

void anglePlot(float a) {
  for(int i=0; i<50; i++){
    int x=(int)(cos(a)*i*50);
    int y=(int)(sin(a)*i*50);
    ellipse(x,y,10,10);
  }
}
