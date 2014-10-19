
diamInter = 27;
diamExter = 108;
epaisseur = 2.4;
diamTrou = 2.8;

projection(cut=false) difference () {
	cylinder( r=diamExter/2, h=epaisseur );
	translate( [0, 0, -1] )
		cylinder( r=diamInter/2, h=epaisseur +2);
	translate( [26, +4, -1] )
		cylinder( r=diamTrou/2, h=epaisseur+2);
	translate( [-26, +4, -1] )
		cylinder( r=diamTrou/2, h=epaisseur+2);
	translate( [26, -4, -1] )
		cylinder( r=diamTrou/2, h=epaisseur+2);
	translate( [-26, -4, -1] )
		cylinder( r=diamTrou/2, h=epaisseur+2);
}

/*difference () {
	circle( r=diamExter/2 );
	translate( [0, 0, -1] )
		circle( r=diamInter/2 );
	translate( [26, +4, -1] )
		circle( r=diamTrou/2);
	translate( [-26, +4, -1] )
		circle( r=diamTrou/2);
	translate( [26, -4, -1] )
		circle( r=diamTrou/2 );
	translate( [-26, -4, -1] )
		circle( r=diamTrou/2);
}*/