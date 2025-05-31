# Glass Container Rack

We use glass storage containers for storing various food items. I did not like nesting the different
sized containers as we are always moving them around to get to the size we needed. This is a simple rack that will let you store the container on its side. These racks are built around the [Anchor Hocking _Snugfit_](https://www.anchorhocking.com/snug-fit/) containers. It is parameter driven, so models for different sized containers can be readily created.

## Model Parameters

| Parameter          | Description                                                                                                                                                                                     |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| container_diameter | Diameter of the container in millimeters. I found that adding two millimeters to the actual diameter provides the right amount of clearance to allow the container to easily slide in to place. |
| container_height   | The hight of the container. Again add 1 or 2 mm for tolerance.                                                                                                                                  |
| wall_thickness     | This is the thickness of the walls between each container. I found 1 mm is good for more than 1 row. If doing just 1 row, 2 mm is a good size.                                                  |
| num_containers     | This is how many containers you want to hold in the rack.                                                                                                                                       |
|                    |                                                                                                                                                                                                 |

## Realized Models

The `models` directory holds models that have been generated for the various sized food containers.  
The naming convention for `stl` files is `glass-container-rack-<container_size>-<num_rows>`.  
So, the file `glass-container-rack-2c-x4.stl` is a container rack for a 2 cup container with 4 rows.

The source code has measurements in the comments for what was used for each container size.

The `3mf` files are [Orca Slicer](https://orcaslicer.com) project files I used. A suffix of `-mk3.3mf` is for a Prusa MK3s and `-a1mini.3mf` is for a Bambu Lab A1 mini.

## Dependencies and Building the 3D Model

This model is built using the tools listed below. Install these tools and you can open up the SCAD file in this repo to create your own printable object.

- [OpenSCAD](https://openscad.org)
- [The Belfry OpenScad Library, v2.0.](https://github.com/BelfrySCAD/BOSL2)

## Sample Output
