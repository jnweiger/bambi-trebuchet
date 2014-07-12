// (c) 2014 juewei@fabfolk.com
// GPLv2.0 or ask.

frame_width=412;
bar_l1=570;
bar_l2=980;
side_x=220;
side_alpha=17;
side_beta=32;
x1=(bar_l1-frame_width)/2;
x2=(bar_l2-frame_width)/2;

side_x_center =   (988+885)/2;
center_pocket_w =  988-885;

module rcube_xy(size, radius) 
{
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z) hull() 
    {
      translate([radius, radius, 0])
      circle(r=radius);

      translate([x - radius, radius, 0])
      circle(r=radius);

      translate([x - radius, y - radius, 0])
      circle(r=radius);

      translate([radius, y - radius, 0])
      circle(r=radius);
    }
}

module lower_beam()
{
  lhl=1500;	// length of lower beam 
  d1=8;		// bolt diameter for gluing struts
  difference()
    {
      cube([lhl,44,44]);		// lower lengthwise beam
      // cut back edges
                            rotate([0,-45,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([0,0,45])   rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,45]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);
      translate([lhl,0,0])  rotate([0,-135,0]) translate([0,-10,-10]) cube([8,60,20]);
    
	   // hole for rear round bar
      rotate([-90,0,0]) translate([45,-22,-10]) cylinder(60,8,8); 

      // Pocket for bottom bar rear
      translate([420, -10, -10]) cube([35, 60, 17]);
      // Hole for bottom bar rear	
      translate([420+35/2, 22, 0]) cylinder(50, 7,7);
      // 480?? Hole for bolting rear strut
      rotate([-90,0,0]) translate([480,-22,-10]) cylinder(60,d1/2,d1/2); 

      // Pocket for bottom bars center
      translate([side_x_center-center_pocket_w/2, -10, -10]) cube([center_pocket_w, 60, 17]);		
      // hole for bolting center strut
      rotate([-90,0,0]) translate([side_x_center,-22,-10]) cylinder(60,d1/2,d1/2);     

      // Pocket for for bottom bar front
      translate([1415, -10, -10]) cube([35, 60, 17]);
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
      rotate([0,-side_alpha,0]) translate([60,22,-30]) cylinder(100,8,8); 
      
      // Slanted ends
      translate([0,0,44])  rotate([0,180-side_alpha,0]) translate([0,-10,-10]) cube([15,60,60]);
      translate([lss,0,0]) rotate([0,-side_alpha,0])    translate([0,-10,-10]) cube([15,60,60]);

      // Hole for upper triangle bolt
      rotate([-90,0,0]) translate([472,-38,-10]) cylinder(60,7,7); 

      // pockets for bottom center bars
      translate([1193,-10, 0]) rotate([0,-side_alpha,0]) translate([0,0,-20]) cube([60,17,80]);
      translate([1193,44-7,0]) rotate([0,-side_alpha,0]) translate([0,0,-20]) cube([60,17,80]);

      // Hole for bottom center bars bolt
      rotate([-90,0,0]) translate([1214,-22,-10]) cylinder(60,7,7); 
    }
}

module bottom_center_bar()
{
  difference()
    {
		cube([bar_l2,34,53]);

		// cut back edges
      translate([0,     0,53]) rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([bar_l2,0,53]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);
      
      // lower beam pockets
      translate([x2-45/2,            -10,53-7]) cube([45, 60, 17]);
      translate([x2-45/2+frame_width,-10,53-7]) cube([45, 60, 17]);

	   // holes for center struts
		rotate([-90,0,0]) translate([x2+44/2*2,            -53/2,-10]) cylinder(60,7,7); 
		rotate([-90,0,0]) translate([x2+frame_width-44/2*2,-53/2,-10]) cylinder(60,7,7); 

		// holes for side supports
		rotate([-90,0,0]) translate([x2-side_x+8,            -53/2,-10]) cylinder(60,7,7); 
		rotate([-90,0,0]) translate([x2+frame_width+side_x-8,-53/2,-10]) cylinder(60,7,7); 

    }
}

module bottom_bar()
{
  x2=(bar_l1-85)/2;
  difference()
    {
  		union()
        {
			cube([bar_l1,34,53]);
			translate([0,0,-9]) cube([60,34,9]);
			translate([bar_l1-60,0,-9]) cube([60,34,9]);
	 	  }
      // cut back edges
      translate([0,     0,53]) rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([bar_l1,0,53]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);

		// beam pockets
      translate([x1-45/2,            -10,53-7]) cube([45,50,17]);
		translate([x1-45/2+frame_width,-10,53-7]) cube([45,50,17]);

		// beam holes
		translate([x1,            34/2,-10]) cylinder(60,7,7); 
   	translate([x1+frame_width,34/2,-10]) cylinder(60,7,7); 

		// pin holes for slide
		translate([x2,34/2,   40]) cylinder(25,3,3); 
   	translate([x2+85,34/2,40]) cylinder(25,3,3); 

    } 

}

module triangle_post()
{
      translate([0,-32,-30]) cube([44,44,960]);
}

module center_post()
{
      
      translate([0,-32,-40]) cube([44,44,660]);
}


module side_triangle()
{
  tri_width = 510;
  union()
    {
      lower_beam();
      translate([side_x_center-tri_width,0,0])                 rotate([0,side_beta,0]) triangle_post();
      translate([side_x_center+tri_width,0,0]) scale([-1,1,1]) rotate([0,side_beta,0]) triangle_post();
      translate([side_x_center-22,0,0]) rotate([0,00,0]) center_post();
    }
}


#side_triangle();
translate([0,-frame_width+44,0]) scale([1,-1,1]) side_triangle();

translate([420.5,x1+44/2,-50]) rotate([0,0,-90]) bottom_bar();  // rear bar
translate([1415.5,x1+44/2,-50]) rotate([0,0,-90]) bottom_bar(); // front bar

translate([side_x_center-center_pocket_w/2,   x2+44/2,-50]) rotate([0,0,-90]) bottom_center_bar();  // rear c bar
translate([side_x_center+center_pocket_w/2-34,x2+44/2,-50]) rotate([0,0,-90]) bottom_center_bar();  // front c bar


% translate([side_x_center-22,          44+220,-53+7]) rotate([0,90+side_alpha,-90]) side_support();
% translate([side_x_center+22,-frame_width-220,-53+7]) rotate([0,90+side_alpha, 90]) side_support();

// rcube_xy([100,100,100],20);
// translate([0,0,100])rcube_xy([100,100,100],40);
// translate([0,0,-100])cube([100,100,100]);
