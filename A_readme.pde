// The files in Processing are concatenated and treated as one big program

// Description of the files:

// - venus_explorer_simulation : The main file with the root functions.
// - A_readme (this file)      : This describes how this simulator should be used.
// - B_robot_algorithm         : This is the place where you will write code.
// - C_Simulation_API          : This has the functions you will use.
// - D_settings                : The settings of the simulator, venus, and the robots. Almost everything is defined here.
// - E_Global_Variables        : The initializations of global variables.
// - F_Types                   : The definitions of types (structs).
// - G_draw                    : This houses anything that has something to do with drawing onto the screen.
// - T_motion_physics          : This moves the robots.
// - U_intersections           : This finds intersections between lines and boxes.
// - V_collisions              : This finds if a point is inside a crater or on the border.
// - W_definers                : This has a few functions to support "D_settings".
// - X_random_functions        : This houses a bunch of functions to generate random values.
// - Y_vector_utility          : This contains many functions that perform simple operations with types (structs).
// - Z_utility                 : This has some generally useful functions.

// feel free to create more tabs (files) to keep your code organized

// make sure that a robot doesn't bump into any box, if that happens then the distance sensor and color sensor may get inside the cube, when that happens they will detect the distance to the opposite face of the cube
