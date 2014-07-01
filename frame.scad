module lower_beam()
{
  lhl=1500;	// Länge Längsholm
  d1=8;		// Dübeldurchmesser verleimt
  difference()
    {
      cube([lhl,44,44]);		// Längsholm unten
      // Kanten brechen
                          rotate([0,-45,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([0,0,45]) rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,45]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,0])  rotate([0,-135,0]) translate([0,-10,-10]) cube([8,60,20]);
    
	   // Bohrung für Querstange hinten
      rotate([-90,0,0]) translate([45,-22,-10]) cylinder(60,8,8); 

      // Aussparung für Querholz hinten
		translate([420, -10, -10]) cube([37, 60, 17]);
		// Dübelloch für Querholz hinten	
		translate([420+37/2, 22, 0]) cylinder(50, 7,7);
	   // 480?? Dübelloch für Strebe hinten
	   rotate([-90,0,0]) translate([480,-22,-10]) cylinder(60,d1/2,d1/2); 

		// Aussparung für Querhölzer Mitte
      translate([885, -10, -10]) cube([988-885, 60, 17]);		
	   // Dübelloch für Mittelstrebe
	   rotate([-90,0,0]) translate([(988+885)/2,-22,-10]) cylinder(60,d1/2,d1/2);     

      // Aussparung für Querholz vorne
		translate([1415, -10, -10]) cube([37, 60, 17]);
		// Dübelloch für Querholz vorne	
		translate([1415+37/2, 22, 0]) cylinder(50, 7,7);
	   // 480?? Dübelloch für Strebe vorne
	   rotate([-90,0,0]) translate([1400,-22,-10]) cylinder(60,d1/2,d1/2); 
 

    }
}


lower_beam();

translate([0,-400,0]) scale([1,-1,1]) lower_beam();