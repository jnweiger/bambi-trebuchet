// (c) 2014 juewei@fabfolk.com
// GPLv2 or ask.

module lower_beam()
{
  lhl=1500;	// length of lower beam 
  d1=8;		// bolt diameter for gluing struts
  difference()
    {
      cube([lhl,44,44]);		// lower lengthwise beam
      // cut back edges
                          rotate([0,-45,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([0,0,45]) rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,45]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,0])  rotate([0,-135,0]) translate([0,-10,-10]) cube([8,60,20]);
    
	   // hole for rear round bar
      rotate([-90,0,0]) translate([45,-22,-10]) cylinder(60,8,8); 

      // Pocket for bottom bar rear
		translate([420, -10, -10]) cube([37, 60, 17]);
		// Hole for bottom bar rear	
		translate([420+37/2, 22, 0]) cylinder(50, 7,7);
	   // 480?? Hole for bolting rear strut
	   rotate([-90,0,0]) translate([480,-22,-10]) cylinder(60,d1/2,d1/2); 

		// Pocket for bottom bars center
      translate([885, -10, -10]) cube([988-885, 60, 17]);		
	   // hole for bolting center strut
	   rotate([-90,0,0]) translate([(988+885)/2,-22,-10]) cylinder(60,d1/2,d1/2);     

      // Pocket for for bottom bar front
		translate([1415, -10, -10]) cube([37, 60, 17]);
		// Hole for bottom bar front	
		translate([1415+37/2, 22, 0]) cylinder(50, 7,7);
	   // 1400?? Hole for bolting front strut
	   rotate([-90,0,0]) translate([1400,-22,-10]) cylinder(60,d1/2,d1/2); 
 

    }
}

module wedge15(len)
{
  difference()
    {
      rotate([0,-15,0]) translate([0,0,-44]) cube([len,44,44]);
      translate([0,-10,-44]) cube([2*len, 60,44]);
    }
}

module side_support()
{
  lss=1248;	// Length side support
  d1=8;		// bolt diameter for gluing struts
  translate([-lss,0,0]) difference()
    {
      union()
        {
          cube([lss,44,44]);		// side support
          translate([0,0,44.2]) wedge15(106);  //hypothenusis=110
          translate([413,0,44.2]) wedge15(92); //hypothenusis=95
		
        }
      // Hole for main shaft
		rotate([0,-15,0]) translate([60,22,-20]) cylinder(80,8,8); 
      
		// Slanted ends
      translate([0,0,44]) rotate([0,180-15,0])  translate([0,-10,-10]) cube([12,60,60]);
      translate([lss,0,0]) rotate([0,-15,0]) translate([0,-10,-10]) cube([12,60,60]);

		// Hole for upper triangle bolt
		rotate([-90,0,0]) translate([472,-38,-10]) cylinder(60,7,7); 

      // pockets for bottom center bars
		translate([1193,-10, 0]) rotate([0,-15,0]) translate([0,0,-20]) cube([60,17,80]);
		translate([1193,44-7,0]) rotate([0,-15,0]) translate([0,0,-20]) cube([60,17,80]);

		// Hole for bottom center bars bolt
		rotate([-90,0,0]) translate([1214,-22,-10]) cylinder(60,7,7); 

    }
}

lower_beam();
translate([0,-400,0]) scale([1,-1,1]) lower_beam();

translate([911,220,-53+7]) rotate([0,90+15,-90]) side_support();
translate([911+44,-400-220,-53+7]) rotate([0,90+15, 90]) side_support();
