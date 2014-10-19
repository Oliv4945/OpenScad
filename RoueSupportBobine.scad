smallOD = 28;
largeOD = 60;
height = 40;
bearingOD = 22;
bearingT = 7;
clearance = 0.2;
layerHeight = 0.2;

$fn = 60;


module roueSupportBobine() {
	difference() {
		cylinder( r1=largeOD/2, r2=smallOD/2, h=height );
		translate( [0, 0, -1] )
			cylinder( r=bearingOD/2+clearance, h=bearingT+clearance+1);
		translate( [0, 0, height-bearingT-clearance] )
			cylinder( r=bearingOD/2+clearance, h=bearingT+clearance+1);
		translate( [0, 0, bearingT+clearance+layerHeight] )
			cylinder( r=bearingOD/2*0.8, h=height);
		for ( i=[0:10:360] ) {
			rotate( [0, 0, i] )
				translate( [0, -0.5, -1] )
					cube( [largeOD, 1, layerHeight+1]);
		}
	}
}


roueSupportBobine();