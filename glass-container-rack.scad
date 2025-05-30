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


// *** "Private" variables ***

corner_rounding = 2;

base_width = container_diameter + (2 * wall_thickness);
base_depth = container_height + (2 * wall_thickness);
base_height = container_diameter * 0.25; // Height of the base is 25% of the container diameter

// 
// Creates a single rack for a glass container
//
module glass_container_base() {

    // Create a base cube that is the diameter of the container plus the side wall thickness on each side.

    cuboid([base_width, base_depth, base_height],
            rounding=corner_rounding, except=[BOTTOM]);
}

//
// Creates the cutout for the glass container in the base.
//
module glass_container_cutout() {

    z_offset = ((container_diameter / 2) + wall_thickness) - (base_height / 2);

    translate([0, 0, z_offset])
        rotate([90, 0, 0]) 
            cylinder(d=container_diameter, h=container_height, anchor=LEFT + FRONT, center=true);
}


//
// Main function build the model in its entirety.
//
module build_model() {
    difference() {
        // Create the base of the rack
        glass_container_base();

        // Create the cutout for the glass container
        glass_container_cutout();
    }

    // glass_container_base();
    // glass_container_cutout();


}

// Build the model
build_model();

