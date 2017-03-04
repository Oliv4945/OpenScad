$fn = 60;

wallT = 3;
clearance = 0.2;
magnetW = 20;
magnetD = 10;
magnetH = 3;
magnetID = 3;

screwOD = 3;

holderW = magnetW;
holderH = 10;
holderD = 40;


module magnet()  {
    difference() {
        translate([0, 0, magnetH/2]) cube( [magnetW, magnetD, magnetH], center=true );
        translate([0, 0, -1]) cylinder( r=magnetID/2+clearance, h=magnetH+2 );
    }
}

module magnetHolder() {
    difference() {
        // Add - Body
        cube([holderW, holderD, holderH]);
        // Remove - Magnet screw
        translate([holderW/2, magnetD/2, -1])
            cylinder(r=magnetID/2-clearance, h=holderH+2);
        // Remove - Back
        translate([-1, holderD*2/3, wallT])
            cube([holderW+2, holderD, holderH]);
        // Remove - Holder screws
        translate( [wallT, holderD*4/5, -1])hull(){
            cylinder(r=screwOD/2+clearance, h=holderH+2);
            translate([wallT, 0, 0])
                cylinder(r=screwOD/2+clearance, h=holderH+2);
        }
        translate( [holderW-wallT*2, holderD*4/5, -1])hull(){
            cylinder(r=screwOD/2+clearance, h=holderH+2);
            translate([wallT, 0, 0])
                cylinder(r=screwOD/2+clearance, h=holderH+2);
        }
    }
}

magnetHolder();