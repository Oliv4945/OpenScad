$fn=60;

module cale() {
	difference() {
		cube( [30, 7, 2] );
		#translate( [(30-18)/2, 7/2, -1]) cylinder( r=3/2, h=10);
		#translate( [(30-18)/2+18, 7/2, -1]) cylinder( r=3/2, h=10);
	}
}

cale();