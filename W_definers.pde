void defineField(){
  field.x = ( width  - fieldSize.x )/2;
  field.y = ( height - fieldSize.y )/2;
  field.w = fieldSize.x;
  field.h = fieldSize.y; 
}

PVector[] initVectorArray( PVector[] array ){
  for(int i=0; i < array.length; i++){
    array[i] = new PVector(0, 0);
  }
  return array;
}

//void definePattern( int amount, int indexOffset, int xOffset, int yOffset, int xStep, int yFactor, int objectWidth, int objectHeight ){
//  for(int i=0; i < amount; i++){
//    rectCoords( i+indexOffset, xOffset + (i+1) * xStep, yOffset + yFactor * (height - objectHeight), objectWidth, objectHeight );
//  }
//}

//void rectCoords(int i,int x,float y,int w,int h){
//  bricks[i*2] = new PVector(x,y);
//  bricks[i*2+1] = new PVector(w,h);
//  //print(x,y,"_")
//}

//void randomBox( box_t[] array, float w, float h ){
//  for( int i=0; i < array.length; i++ ){
//    array[i].x = random(width);
//    array[i].y = random(height);
//    array[i].r = random(360);
//    array[i].w = w;
//    array[i].h = h;
//    //array[i].w = random(w);
//    //array[i].h = random(h);
//  }
//}
