$fn = 30;



bottomHeight = 5;
bottomClearance = 6;
screwDiameter = 3;
layerHeight = 0.2;
screwsSpacing = 30;
bottomWidth = 40;


module roundCornerMask( d, height ) {
 difference() {
   translate( [0, 0, 0] ) cube( [d, d, height] );
   translate( [0, 0, -1] ) cylinder( r=d/2, h=height+2 );
 };
};

module screwM3Hole( length ) {
 union() {  // Screw head : 5.6x3
   cylinder( r=(5.6/2)+0.4, h=3+0.5+1 ); // h = diameter+clerance+avoid OpenSCAD difference on same surface
   cylinder( r=(3/2)+0.3, h=length+3+0.5+1 );
 };
};


module screwM3HoleNut( length ) {
 union() {  // Screw head : 5.6x3
   cylinder( r=5.5/sqrt(3)*2/2+0.2, h=3+0.5+1, $fn=6); // h = diameter+clearance+avoid OpenSCAD difference on same surface
   cylinder( r=(3/2)+0.3, h=length+3+0.5+1 );
 };
};


// bottom();
// translate( [50, 0, 0 ] ) top();

module base() {
 difference() {
   union() {
     translate( [0, 0, bottomHeight/2] )	// Base
       cube( [bottomWidth, bottomWidth, bottomHeight], center=true );
	  for( i = [45, 135, 225, 315] ) {  // Supports
		  rotate( [0, 0, i] )  
		  translate ( [screwsSpacing*sqrt(2)/2, 0, bottomHeight] ) cylinder( r=3.4, h=bottomClearance );
	  };
   };
	// Round corners
   for( i = [45, 135, 225, 315] ) {
	  rotate( [0,0,i] )  
	  translate ( [(bottomWidth-5.6)*sqrt(2)/2,0,-1] ) 
	  rotate( [0,0,-45] ) roundCornerMask( 5.6, bottomHeight+2 );
	};
 };
};

module bottom() {
 union() {
   difference() {
     base();
     for( i = [45, 135, 225, 315] ) {
       rotate( [0,0,i] )  
       translate ( [screwsSpacing*sqrt(2)/2,0,-1] ) 
		rotate( [0,0,-45] ) screwM3Hole( 40 );
     };
   };
	// Creates a bridge for one layer to help printing
	translate( [0,0,3+0.5] )
	  cube( [bottomWidth-5.6/2, bottomWidth-5.6/2 ,layerHeight], center=true );
 };
};

module top() {
 union() {
   difference() {
     base();
     for( i = [45, 135, 225, 315] ) {
       rotate( [0,0,i] )  
       translate ( [screwsSpacing*sqrt(2)/2,0,-1] ) 
		rotate( [0,0,-45] ) screwM3HoleNut( 40 );
     };
   };
	// Creates a bridge for one layer to help printing
	translate( [0,0,3+0.5] )
	  cube( [bottomWidth-5.6/2, bottomWidth-5.6/2 ,layerHeight], center=true );
 };
};

bottom();
//ntranslate( [50, 0 ,0] ) top();
//rotate( [180,0,0] ) translate( [0,0,-(bottomClearance+bottomHeight)*2-1.6] ) top();