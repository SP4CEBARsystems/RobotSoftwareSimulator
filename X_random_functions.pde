// values
float randomPredictable( float range ){
  if ( !unpredictable_terrain ) {
    randomSeed( predictable_terrain_seed );
    predictable_terrain_seed += seed_step;
  }
  return random( range );
}

float randomWithSeed( float range, int seedOffset ){
  if ( !unpredictable_terrain ) {
    randomSeed( predictable_terrain_seed + seedOffset );
    predictable_terrain_seed += seed_step;
  }
  return random( range );
}

float randomInRange( float low, float range ){
  if (range<0) return 0;
  return low + randomPredictable( range );
}

float randomInRangeWithSeed( float low, float range, int seedOffset ){
  if (range<0) return 0;
  return low + randomWithSeed( range, seedOffset );
}

float randomInBounds( float low, float high ){
  return randomInRange( low, high - low );
}

float randomInBoundsWithSeed( float low, float high, int seedOffset ){
  return randomInRangeWithSeed( low, high - low, seedOffset );
}


// Structures

PVector randomPVector(){
  float x = field.x + randomPredictable( field.w );
  float y = field.y + randomPredictable( field.h );
  return new PVector( x, y );
}

vector2_t randomVector(){
  vector2_t v = new vector2_t();
  v.x = randomInRange( field.x, field.w );
  v.y = randomInRange( field.y, field.h );
  //v.x = field.x + randomPredictable( field.w, index * primeX );
  //v.y = field.y + randomPredictable( field.h, index * primeY );
  return v;
}

vector2r_t randomVector2r(){
  vector2r_t v = new vector2r_t();
  v.x = randomInRange( field.x, field.w );
  v.y = randomInRange( field.y, field.h );
  v.r = randomInRange( 0      , 360     );
  return v;
}

box_t randomBox( float w, float h ){
  box_t v = new box_t();
  v.x = randomInRange( field.x, field.w );
  v.y = randomInRange( field.y, field.h );
  v.r = randomInRange( 0      , 360     );
  v.w = w;
  v.h = h;
  //v.w = random(w);
  //v.h = random(h);
  return v;
}


// Arrays

PVector[] randomPVectorArray( PVector[] array ){
  for ( int i = 0; i < array.length; i++ ) {
  //for ( PVector v : array ) {
    array[i] = randomPVector();
  }
  return array;
}

vector2_t[] randomVectorArray( vector2_t[] array ){
  for ( int i = 0; i < array.length; i++ ) {
    array[i] = randomVector();
  }
  return array;
}

vector2r_t[] randomVector2rArray( vector2r_t[] array ){
  for ( int i = 0; i < array.length; i++ ) {
    array[i] = randomVector2r();
  //for ( vector2r_t v : array ) {
  //  v = randomVector2r();
  }
  return array;
}

block_t[] randomBoxArray( block_t[] array, float w, float h, int lowestType, int highestType ){
  for ( int i = 0; i < array.length; i++ ) {
    array[i] = new block_t();
    array[i].box = randomBox( w, h );
    array[i].type = floor( randomInBounds( (float)lowestType, (float)highestType ) );
  }
  return array;
}
