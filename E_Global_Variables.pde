vector2_t fieldSize = new vector2_t();
box_t field = new box_t();
int border = 10;

robot_t[] robots;

block_t[] smallBlocks = new block_t[9];
block_t[] bigBlocks   = new block_t[9];
block_t[] craters     = new block_t[9];
block_t[] mountains   = new block_t[9];

vector2_t[] samples   = new vector2_t[65535];
int samplePointer = 0;
