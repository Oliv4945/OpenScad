// T séchoir
$fn = 60;
wallT = 3;
length = 25;
pipeOD = 10;
clear = 0.2;

use <MCAD/boxes.scad>

feetWidth = pipeOD+2*(clear+wallT);

module t() {
    difference() {
        union() {
            roundedBox([length*2+feetWidth, feetWidth, feetWidth], 2, false);
            translate([0, length/2, ])
                roundedBox([feetWidth, length+feetWidth, feetWidth], 2, false );
        }
       translate([-length-feetWidth/2-1, 0, ]) rotate([0, 90, 0])
            cylinder(r=pipeOD/2+clear, h=length*2+feetWidth+2);
        translate([0, 0,0 ]) rotate([-90, 0, 0])
            cylinder(r=pipeOD/2+clear, h=length+feetWidth);
    }
}

t();