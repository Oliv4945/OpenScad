$fn=150;
largeur = 35+2;
profondeur = 8;
hauteur = 10;
largeurProtuberence = 3;


module base( largeur, profondeur, hauteur ) {
	union() {
	translate( [largeur/2-((largeur-26)/3)-0.5+0.1, profondeur-2, 0])
		cube([(largeur-26)/3,2,profondeur/2+1]);
	difference () {
		cube( [largeur, profondeur, hauteur ] );
		translate( [5, -1, 2]) cube( [largeur-15, profondeur+2, hauteur] );
		translate( [-8, profondeur/2, hauteur/2+1.3])
			rotate( [0, 90, 0] )
			cylinder( r=1.65+0,25, h=100 );	// Layer heigh = 0.3
		translate( [largeur-6, -1, hauteur-4])difference () {
			cube( [2, profondeur+2, 100] );
			translate( [-1, profondeur/2+1, 0] )
				rotate( [0, 90, 0] )
				cylinder( r=profondeur/2, h=4 );
		};
		translate( [-1, -1, hauteur/1.4])difference () {
			cube( [largeur+2, profondeur+2, 20] );
			translate( [-1, profondeur/2+1, 0] )
				rotate( [0, 90, 0] )
				cylinder( r=profondeur/2, h=100 );
		};
		translate( [-1, profondeur/2, hauteur/2+1.3])
			rotate( [0, 90, 0] ) cylinder( r=5.5/2+0.25, h=3.4, $fn=6 );
		translate( [largeur-2, profondeur/2, hauteur/2+1.3])
			rotate( [0,90,0] ) cylinder( r=2.75+0.25, h=3 );
	};
	};
}

module support( largeur, profondeur, hauteur ) {
	largeurProtuberence = 3;
	difference() {
		 union () {
			rotate( [0, 90, 0] )  cylinder( r=profondeur/2, h=largeur );
			translate( [0, -largeurProtuberence/2, profondeur/2-2])
				cube( [largeur, largeurProtuberence, 30] );

		}
		translate( [-1, 0, 0])
			rotate( [0, 90, 0] )
			cylinder( r=1.55+0.25, h=largeur+2 );
		translate( [5,1,-profondeur/2] )
			trapeze(
				(largeur-10)/3, 0,
				(largeur-10)/3, profondeur,
				2/3*(largeur-10), profondeur,
				2/3*(largeur-10), 0,
				0, 0,
				0,profondeur,
				largeur-10, profondeur,
				largeur-10,0,
				6
		 	);
	}
}




module trapeze( p0X, p0Y, p1X, p1Y, p2X, p2Y, p3X, p3Y, p4x, p4y,
	p5x, p5y, p6x, p6y, p7x, p7y, height) {
	polyhedron(
		points=[[p0X,p0Y,height],[p1X,p1Y,height],[p2X,p2Y,height],[p3X,p3Y,height],[p4x,p4y,0],
		[p5x,p5y,0],[p6x,p6y,0],[p7x,p7y,0]],
		triangles=[
			[0,1,2],[0,2,3],[0,4,5],[5,1,0],[0,3,4],[3,7,4],
			[3,2,7],[2,6,7],[1,6,2],[1,5,6],[4,6,5],[4,7,6]
	]
	);
}

base( largeur, profondeur, hauteur );

translate( [5.5, profondeur/2, hauteur/2+1])
			support( largeur-16, profondeur, hauteur );


