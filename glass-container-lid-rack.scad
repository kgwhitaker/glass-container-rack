// 
// Rack for the glass container lids.  This one is simply a needed width, needed depth and number of compartments 
// to break it in to.
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */

// Overall width of the lid rack
lid_rack_width = 184;

// Overall depth of the lid rack
lid_rack_depth = 210;

// Overall height of the lid rack
lid_rack_height = 50;

// Thickness of the walls between compartments
wall_thickness = 2;

// Number of compartments to break the rack into
compartments = 4;


// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

corner_rounding = 2;

// Keeps the object in positive numbers on the axes; easier for my brain to comprehend when calculating offsets.
BASE_ANCHOR = BOTTOM+FRONT+LEFT;



//
// Create the base of the lid rack
//
module base() {
    translate([0, 0, 0]) {
        cuboid([lid_rack_width, lid_rack_depth, lid_rack_height], anchor=BASE_ANCHOR);
    }
}






//
// Builds the entire model
//
module build_model() {

    base();


}


build_model();

