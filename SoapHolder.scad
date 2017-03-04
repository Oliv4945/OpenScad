$fn = 60;

include <../MCAD/boxes.scad>

wallT = 3;
radius = 3;
clearance = 0.2;

holeOD= 8;
holeX = 5;
holeY = 5;

holderW = (holeOD*2+wallT)*holeX+wallT*4;
holderD = (holeOD+wallT)*holeY+wallT*5;
holderH = 10;

pipeOD = 20;
supportW = pipeOD+wallT*6;
supportH = 130;

module holder() {
    difference() {
        // Add - Main box
        translate([holderW/2, holderD/2, holderH/2])
            roundedBox([holderW, holderD, holderH], radius, false);
        // Remove - Main area
        translate([wallT, wallT, wallT])
            cube([holderW-2*wallT, holderD-2*wallT, holderH]);
        // Remove - Holes
         translate([wallT*3+holeOD/2, wallT*3+holeOD/2, -1])
            for (x = [0 : holeX-1]) {
                for (y = [0 : holeY-1]) {
                     translate([x*(holeOD*2+wallT), y*(holeOD+wallT), 0]) hull(){
                         cylinder(r=holeOD/2, h=wallT+2, $fn=6);
                         translate([holeOD, 0, 0])
                            cylinder(r=holeOD/2, h=wallT+2);
                     }
                 }
             }
         //  Remove - Support holes
         translate([(holderW-supportW-clearance/2)/2, holderD-2*wallT-clearance, -1])
             cube([supportW+clearance, wallT, wallT+2]);
    }
}

module support() {
    difference() {
        union() {// Add - Main part
            cube([supportW, wallT, supportH]);
            // Add - Upper part
            translate([supportW/2, 0, supportH]) rotate([-90, 0, 0])
                cylinder(r=supportW/2, h=wallT);
            // Add - Base
            translate([0, -supportW/2, 0])
                cube([supportW, supportW/2, wallT*2]);
       }
       // Remove - Handle
       hull() {
           translate([supportW/2, -1, supportH]) rotate([-90, 0, 0])
             cylinder(r=pipeOD/2, h=wallT+2);
          translate([supportW*3/2, -1, supportH-supportW*3]) rotate([-90, 0, 0])
             cylinder(r=pipeOD/2*4/3, h=wallT+2);
       }
       // Remove - Main hole
       hull() {
           translate([wallT*2+(supportW/2-wallT*3)/2, -supportW/4, -1])
               cylinder(r=(supportW/2-wallT*3)/2, h= wallT*2+2);
           translate([supportW-wallT*2-(supportW/2-wallT*3)/2, -supportW/4, -1])
               cylinder(r=(supportW/2-wallT*3)/2, h= wallT*2+2);
       }
    }
}

holder();
translate([(holderW-supportW)/2, holderD-wallT*2, -wallT*2])
    support();