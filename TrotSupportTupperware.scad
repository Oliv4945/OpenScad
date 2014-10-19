$fn=120;

barOD1 = 28.8;
barOD2 = 40.4;
holeClearance = 0.2;
thickness = 8;
height = 15;
M3OD = 3;
M3NutOD = 5.5;
M3NutHeight = 3;
M3HeadHeight=2;
M3Length = 12;
platformWidth = 10;

module ellipse( length, width, height, center = false) {
  scale( [1, width/length, 1] )
    cylinder( h=height, r=length/2, center=center );
}




module support() {
  difference() {
    union() {
      ellipse( barOD2+thickness*2, barOD1+thickness*2, height );  // Main body
      for (i = [-1, 1]) {  // Add small surface for screws
        translate( [0, (barOD1+thickness)/2*i, 0] )
          ellipse( thickness*3, thickness*2.4, height );
      }
      translate( [-barOD2/2-thickness, -platformWidth/2, 0] ) // Add a plane
        cube( [thickness, platformWidth, height] );
    };
    translate( [0, 0, -1] ) // Remove main bar
      ellipse( barOD2+holeClearance*2, barOD1+holeClearance*2, height+2 );
    // Remove support assembly screws
    for (i = [-1, 1]) {
      translate( [-thickness*3/2+1, (barOD1+thickness*2+M3OD)/2*i, height/2] )
        rotate( [0, 90, 0] )
          union() {
            cylinder( r=(M3OD+holeClearance)/2, h = barOD2 ); // Screw
#cylinder( r=(M3NutOD+holeClearance*2)/2, h = thickness, $fn=6 );  // Nut
						translate(  [0,0,thickness-M3NutHeight+M3Length] )
              cylinder( r=(M3NutOD+holeClearance*2)/2, h = thickness*2 );  // Head
          }
    }
    // Remove object screw
    translate( [-barOD2/2+1, 0, height/2] ) rotate( [0, -90, 0] ) union() {
      cylinder( r=(M3OD+holeClearance)/2, h=thickness*2 );
      cylinder( r=(M3NutOD+holeClearance)/2, h=M3HeadHeight*2+1 );
    }
  }
}

part = 1;

if ( part == 1 ) {
  difference() {
    support();
    translate( [0, -barOD2*2, -barOD2*2] ) cube( barOD2*4 );
  }
} else {
  // Part 2
  difference() {
    support();
    translate( [-barOD2*4, -barOD2*2, -barOD2*2] ) cube( barOD2*4 );
  }
}