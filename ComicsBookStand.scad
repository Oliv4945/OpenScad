// Book stand by Oliv'

// Width of stand
width = 120;
// Height of the stand
height = 170;
// Depth of the stand
depth = 50;
// Max fit height
wallFeet = 6;
// Max bodywidth
wallBody = 10;

// Rendering parameter
$fn = 40;

module comicsBookStand() {
  union() {
    // Body
    hull() {
      cube( [wallBody*1.5, depth, wallFeet] );
      translate( [wallBody*0.5, 0, height-wallBody] )
        cube( [wallBody, depth, wallBody] );
    }
    translate( [wallBody, 0, height]) rotate( [-90, 0, 0] )
      cylinder( r=wallBody/2, h=depth);
    // Feet
    hull() {
      cube( [wallFeet, depth, wallFeet] );
      translate( [width-1, 0, 0] )
        cube( [1, depth, 1] );
    }
  }
}

comicsBookStand();