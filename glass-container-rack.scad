// 
// A rack that holds round glass containers, such as Anchor Hocking food storage container, in a vertical position.
//

include <BOSL2/std.scad>

// 3D Model Resolution.  
$fa = 1;
$fs = 0.4;

// *** Model Parameters ***

// Diameter of the glass container
container_diameter = 120;

// Height of the glass container
container_height = 60;

// Wall thickness of the rack.  This is the space from the cutout of the container around all edges.
wall_thickness = 4;

// Number of glass containers per row.
num_containers_per_row = 3;


// *** "Private" variables ***

base_width = container_diameter + (2 * wall_thickness);
base_depth = container_height + (2 * wall_thickness);
base_height = container_diameter * 0.25; // Height of the base is 25% of the container diameter

// 
// Creates a single rack for a glass container
//
module glass_container_base(row) {
    y_offset = row * (base_depth);

    corner_rounding = 2;



    translate([0, y_offset, 0])
        cuboid([base_width, base_depth, base_height],
                rounding=corner_rounding, except=[BOTTOM]);
}

//
// Creates the cutout for the glass container in the base.
//
module glass_container_cutout(row) {
    y_offset = row * (base_depth);
    z_offset = ((container_diameter / 2) + wall_thickness) - (base_height / 2);

    translate([0, y_offset, z_offset])
        rotate([90, 0, 0]) 
            cylinder(d=container_diameter, h=container_height, anchor=LEFT + FRONT, center=true);
}

module glass_container_row(row) {

    difference() {
        // Create the base for the glass container
        glass_container_base(row);
        
        // Create the cutout for the glass container
        glass_container_cutout(row);
    }
}

//
// Main function build the model in its entirety.
//
module build_model() {
    // Loop through rows to create the base and cutouts for each container
    for (row = [0:num_containers_per_row - 1]) {
        glass_container_row(row);
    }
}

// Build the model
build_model();

