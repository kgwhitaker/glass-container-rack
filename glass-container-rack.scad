// 
// A rack that holds round glass containers, such as Anchor Hocking food storage container, in a vertical position.
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */


// As a lid holder:
// 2 cup = 125mm
//
// Diameter of the glass container
// 1 cup = 97mm, 2 cup = 120mm, 4 cup = 148mm, 8 cup = 184mm
container_diameter = 125;

// As a lid holder:
// 2 cup = 48mm is 4 lids per compartment.
//
// Height of the glass container
// 1 cup = 52mm, 2 cup = 62mm, 4 cup = 76mm, 8 cup = 87mm
container_height = 48;

// Thickness of wall between each container.
wall_thickness = 1;

// Number of glass containers per rack.
num_containers = 2;

// True = Creates a support in the back of each compartment to support lids in the container.
lid_support = true;

// *** "Private" variables ***
/* [Hidden] */

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

// Calculated Global Vars
base_width = container_diameter;
base_depth = container_height + (2 * wall_thickness);
base_height = container_diameter * 0.25; //25% of the container diameter

// Model settings
segment_overlap = 0.1; // Overlap between segments in the base; ensure segments are connected

// 
// Creates a single rack for a glass container
//
module glass_container_base(row) {
    y_offset = (row * (base_depth));
    corner_rounding = 2;

    if (num_containers > 1) 
    {
        if (row == 0) {
            // First Row

            if (lid_support) {
                make_base_segment(y_offset = y_offset, 
                    corner_rounding = corner_rounding, 
                    round_except = [BOTTOM, BACK, FRONT], 
                    segment_depth = base_depth);

                lid_y_offset = y_offset - (container_height / 2);
                lid_support(lid_y_offset);
            } else {
                make_base_segment(y_offset = y_offset, 
                    corner_rounding = corner_rounding, 
                    round_except = [BOTTOM, BACK], 
                    segment_depth = base_depth);
            }

        } else if (row == (num_containers - 1)) {
            // Last Row
            round_except = [BOTTOM, FRONT];
            last_y_offset = ((row * (base_depth - wall_thickness)) - segment_overlap);
            make_base_segment(
                y_offset = last_y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth
            );
            if (lid_support) {
                lid_y_offset = last_y_offset - (container_height / 2);
                lid_support(lid_y_offset);
            }
        } else {
            // Middle Rows
            round_except = [BOTTOM, FRONT, BACK];
            middle_y_offset = ((row * (base_depth - wall_thickness)) - segment_overlap);
            make_base_segment(
                y_offset = middle_y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth - wall_thickness
            );
            if (lid_support) {
                lid_y_offset = middle_y_offset - (container_height / 2) + segment_overlap;
                lid_support(lid_y_offset);
            }
        }
    } else {
        // There is only one row.
        if (lid_support) {
            round_except = [BOTTOM, FRONT];
            make_base_segment(y_offset = y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth);
            
            lid_y_offset = y_offset - (container_height / 2);
            lid_support(lid_y_offset);
        } else {
            round_except = [BOTTOM];
            make_base_segment(y_offset = y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth);
        }
    }
}

//
// Creates an optional lid support for the back of the container.
//
module lid_support(lid_y_offset) {
    z_offset = ((container_diameter / 2) + wall_thickness) - (base_height / 2);
    x_offset = -(container_diameter / 2);

    // Lid support the size of the container
    translate([x_offset, lid_y_offset, z_offset])
        color("red")
            cuboid([container_diameter, wall_thickness, container_height],
                        anchor=LEFT + BACK + TOP, rounding=20, except=[FRONT, BACK]);
}

//
// makes a single base segment for the specified row.
//
module make_base_segment(y_offset, corner_rounding, round_except, segment_depth) {

    echo("Creating base segment at y_offset: ", y_offset);
    echo("segment_depth: ", segment_depth);

    difference() {
        translate([0, y_offset, 0])
            cuboid([base_width, segment_depth, base_height],
                    rounding=corner_rounding, except=round_except);

        z_offset = ((container_diameter / 2) + wall_thickness) - (base_height / 2);
        translate([0, y_offset , z_offset])
            rotate([90, 0, 0]) 
                cylinder(d=container_diameter, h=container_height, anchor=LEFT + FRONT, center=true);
    }

}

//
// Creates the cutout for the glass container in the base.
//
module glass_container_cutout(row) {
    y_offset = (row * base_depth) - (row * wall_thickness);
    z_offset = ((container_diameter / 2) + wall_thickness) - (base_height / 2);

    translate([0, y_offset, z_offset])
        rotate([90, 0, 0]) 
            cylinder(d=container_diameter, h=container_height, anchor=LEFT + FRONT, center=true);
}

//
// Main function build the model in its entirety.
//
module build_model() {
    // Loop through rows to create the base and cutouts for each container
    for (row = [0:num_containers - 1]) {
        glass_container_base(row);
    }
}

// Build the model
build_model();

