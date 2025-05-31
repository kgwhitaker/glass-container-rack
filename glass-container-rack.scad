// 
// A rack that holds round glass containers, such as Anchor Hocking food storage container, in a vertical position.
//

include <BOSL2/std.scad>

// *** Model Parameters ***
/* [Model Parameters] */

// Diameter of the glass container
// 1 cup = 97mm, 2 cup = 120mm, 4 cup = 148mm, 8 cup = 184mm
container_diameter = 184;

// Height of the glass container
// 1 cup = 52mm, 2 cup = 62mm, 4 cup = 76mm, 8 cup = 87mm
container_height = 87;

// Thickness of wall between each container.
wall_thickness = 1;

// Number of glass containers per rack.
num_containers = 2;

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
            echo("First Row");
            round_except = [BOTTOM, BACK];
            make_base_segment(y_offset = y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except, 
                segment_depth = base_depth);
        } else if (row == (num_containers - 1)) {
            // Last Row
            echo("Last Row");
            round_except = [BOTTOM, FRONT];
            last_y_offset = ((row * (base_depth - wall_thickness)) - segment_overlap);
            make_base_segment(
                y_offset = last_y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth
            );
        } else {
            // Middle Rows
            echo("Middle Row");
            round_except = [BOTTOM, FRONT, BACK];
            middle_y_offset = ((row * (base_depth - wall_thickness)) - segment_overlap);
            make_base_segment(
                y_offset = middle_y_offset, 
                corner_rounding = corner_rounding, 
                round_except = round_except,
                segment_depth = base_depth - wall_thickness
            );
        }
    } else {
        // There is only one row.
        corner_rounding = 2;
        round_except = [BOTTOM];
        make_base_segment(y_offset = y_offset, 
            corner_rounding = corner_rounding, 
            round_except = round_except,
            segment_depth = base_depth);
    }

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

