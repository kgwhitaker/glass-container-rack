//
// This file is intended for designing a lid compatible with the glass container rack system.
// This lid rack is intended for the 1c lids to be stored in a sideways orientation in fhe front,
// and larger lids from the 8c and 4c containers to be stored in the back.
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

// Small lid cutout depth.  The remaining space will be split into two compartments for the large lids.
small_lid_cutout_depth = 112;

// *** "Private" variables ***
/* [Hidden] */

// Calculated Global Vars
cutout_width = lid_rack_width - (2 * wall_thickness);

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

// Keeps the object in positive numbers on the axes; easier for my brain to comprehend when calculating offsets.
BASE_ANCHOR = BOTTOM+FRONT+LEFT;

corner_rounding = 2;

//
// small lid cutout is sideways and in the front.  We want to keep this static, and the remaining
// space broken into two compartments.
//
module small_lid_cutout () {
    x_offset = -((lid_rack_width - cutout_width) / 2) + (wall_thickness * 2);

    
    // Put this in the front of the rack
    y_offset = (lid_rack_depth - small_lid_cutout_depth) - wall_thickness;
    translate([x_offset, y_offset, wall_thickness]) {
        cuboid([cutout_width, small_lid_cutout_depth, lid_rack_height], anchor=BASE_ANCHOR);
    }
}

//
// Create two cutouts for the large lids, splitting the space evenly
//
module large_lid_cutouts() {
    remaining_depth = lid_rack_depth - small_lid_cutout_depth - (4 * wall_thickness);
    echo("Remaining Depth: ", remaining_depth);

    small_lid_y = ((lid_rack_depth - small_lid_cutout_depth) / 2) - wall_thickness;
    echo("Small Lid Y Offset: ", small_lid_y);

    // cutout depth
    large_lid_cutout_depth = remaining_depth / 2;
    echo("Large Lid Cutout Depth: ", large_lid_cutout_depth);

    x_offset = wall_thickness;

    for (i = [0, 1]) {
        y_offset = wall_thickness;

        translate ([x_offset, (large_lid_cutout_depth * i) + wall_thickness + (wall_thickness * i), wall_thickness]) {
            color("red") {
                cuboid([cutout_width, large_lid_cutout_depth, lid_rack_height], anchor=BASE_ANCHOR);
            }
        }
     
    }
}

//
// Create the entire glass container lid rack body
//
module glass_container_lid_body() {
    cuboid([lid_rack_width, lid_rack_depth, lid_rack_height], anchor=BASE_ANCHOR, rounding=corner_rounding, 
        except=[BOTTOM]);
}

//
// Builds the entire model
//
module build_model() {
    difference() {
        glass_container_lid_body();

        small_lid_cutout();
        large_lid_cutouts();
    }
}

build_model();