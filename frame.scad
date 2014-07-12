// (c) 2014 juewei@fabfolk.com
// GPLv2.0 or ask.

explode = 0;	// 50;		// descend all the bottom bars

frame_width=412;
bar_l1=570;
bar_l2=980;
side_x=176;
side_alpha=15;
side_beta=32;
x1=(bar_l1-frame_width)/2;
x2=(bar_l2-frame_width)/2;
d1=8;		// bolt diameter for gluing struts

side_x_center =   (988+885)/2;
center_pocket_w =  988-885;
pocket_depth = 	7;

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
      translate([420, -10, -10]) cube([35, 60, 10+pocket_depth]);
      // Hole for bottom bar rear	
      translate([420+35/2, 22, 0]) cylinder(50, 7,7);
      // 480?? Hole for bolting rear strut
      rotate([-90,0,0]) translate([480,-22,-10]) cylinder(60,d1/2,d1/2); 

      // Pocket for bottom bars center
      translate([side_x_center-center_pocket_w/2, -10, -10]) cube([center_pocket_w, 60, 10+pocket_depth]);		
      // hole for bolting center post
      rotate([-90,0,0]) translate([side_x_center,-22-pocket_depth,-10]) cylinder(60,d1/2,d1/2);     

      // Pocket for bottom bar front
      translate([1415, -10, -10]) cube([35, 60, 10+pocket_depth]);
      // Hole for bottom bar front	
      translate([1415+37/2, 22, 0]) cylinder(50, 7,7);
      // 1400?? Hole for bolting front strut
      rotate([-90,0,0]) translate([1400,-22,-10]) cylinder(60,d1/2,d1/2); 
    }
}

module wedge_alpha(len)
{
  difference()
    {
      rotate([0,-side_alpha,0]) translate([0,0,-44]) cube([len,44,44]);
      translate([0,-10,-44]) cube([2*len, 60,44]);
    }
}

module side_support()
{
  lss=1248;	// Length side support
  translate([-lss,0,0]) difference()
    {
      union()
        {
          cube([lss,44,44]);		// side support
          translate([0,0,44.2]) wedge_alpha(106);  //hypothenusis=110
          translate([419,0,44.2]) wedge_alpha(88); //hypothenusis=95
        }
      // Hole for main shaft
      rotate([0,-side_alpha,0]) translate([60,22,-30]) cylinder(100,8,8); 
      
      // Slanted ends
      translate([0,0,44])  rotate([0,180-side_alpha,0]) translate([0,-10,-10]) cube([15,60,60]);
      translate([lss,0,0]) rotate([0,-side_alpha,0])    translate([0,-10,-10]) cube([15,60,60]);

      // Hole for upper triangle bolt
      rotate([-90,0,0]) translate([472,-38,-10]) cylinder(60,7,7); 

      // pockets for bottom center bars
      translate([1193,-10, 0]) rotate([0,-side_alpha,0]) translate([0,0,-20]) cube([60,10+pocket_depth,80]);
      translate([1193,44-7,0]) rotate([0,-side_alpha,0]) translate([0,0,-20]) cube([60,10+pocket_depth,80]);

      // Hole for bottom center bars bolt
      rotate([-90,0,0]) translate([1214,-22,-10]) cylinder(60,7,7); 
    }
}

module bottom_center_bar()
{
  xc1 = bar_l2/2-frame_width/2;
  xc2 = bar_l2/2+frame_width/2;
  difference()
    {
      cube([bar_l2,34,53]);

      // cut back edges
      translate([0,     0,53]) rotate([0,45,0])   translate([0,-10,-10]) cube([8,60,20]);
      translate([bar_l2,0,53]) rotate([0,135,0])  translate([0,-10,-10]) cube([8,60,20]);
      
      // lower beam pockets
      translate([x2-45/2,            -10,53-7]) cube([45, 60, 10+pocket_depth]);
      translate([x2-45/2+frame_width,-10,53-7]) cube([45, 60, 10+pocket_depth]);

      // holes for center posts
      rotate([-90,0,0]) translate([xc1+(44+44-pocket_depth)/2, -53/2,-10]) cylinder(60,7,7); 
      rotate([-90,0,0]) translate([xc2-(44+44-pocket_depth)/2, -53/2,-10]) cylinder(60,7,7); 

      // holes for side supports
      rotate([-90,0,0]) translate([x2-side_x+9,            -53/2,-10]) cylinder(60,7,7); 
      rotate([-90,0,0]) translate([x2+frame_width+side_x-9,-53/2,-10]) cylinder(60,7,7); 

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
	translate([x1-45/2,            -10,53-pocket_depth]) cube([45,50,10+pocket_depth]);
	translate([x1-45/2+frame_width,-10,53-pocket_depth]) cube([45,50,10+pocket_depth]);

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
    translate([0,-44+pocket_depth,-30]) cube([44,44,960]);
}

module center_post()
  {
    h=618;
    difference()
      {
	translate([0,-44+pocket_depth,-53+2*pocket_depth]) cube([44,44,h+44-2*pocket_depth+53]);

	// three sides pockets at the bottom end:
	translate([-10,0,-53+2*pocket_depth-10]) cube([44+10+10,pocket_depth+10,53+44-2*pocket_depth+10]);
	translate([-pocket_depth+44,-44-10,-53+2*pocket_depth-10]) cube([pocket_depth+10,44+10+10,53+10]);
	translate([-10,-44-10,-53+2*pocket_depth-10]) cube([pocket_depth+10,44+10+10,53+10]);

        // hole for bolting center post, glued to lower_beam.
        rotate([-90,0,0]) translate([22,-22-pocket_depth,-44]) cylinder(60,d1/2,d1/2);     

        // hole for bolting center post with center bottom bars
        translate([-10, -(44-pocket_depth)/2, -53/2+2*pocket_depth]) rotate([0,90,0]) cylinder(60,7,7); 

	// tapered top
	translate([-10,-44+pocket_depth+23,h+44]) rotate([-90+side_alpha,0,0]) cube([60,80,20]);
      }
  }

cross_board_len = 442.5;

module cross_board()
{
  difference()
    {
      cube([cross_board_len, 16, 70]);
      // slanted ends
      rotate([0,side_beta,0]) translate([-50,-10,-20]) cube([50,30,120]);
      translate([cross_board_len,0,0])rotate([0,-side_beta,0])translate([0, -10, -20]) cube([50,30,120]);
      // slanted ends, beveled, 45°, 5mm
      rotate([0,side_beta,0]) rotate([0,0,-45]) translate([-50-5,-10,-20]) cube([50,30,120]);
      translate([cross_board_len,0,0]) rotate([0,-side_beta,0]) rotate([0,0,45]) translate([5, -10, -20]) cube([50,30,120]);
    }
}

module side_triangle()
{
  tri_width = 510;
  union()
    {
      %lower_beam();
      translate([side_x_center-tri_width,0,0])                 rotate([0,side_beta,0]) triangle_post();
      translate([side_x_center+tri_width,0,0]) scale([-1,1,1]) rotate([0,side_beta,0]) triangle_post();
      translate([side_x_center-22,0,0]) rotate([0,00,0]) center_post();
      translate([side_x_center-cross_board_len/2,pocket_depth,418+44]) cross_board();
    }
}


% side_triangle();
% translate([0,-frame_width+44,0]) scale([1,-1,1]) side_triangle();

translate([ 420.5, x1+44/2,-53+2*pocket_depth-explode]) rotate([0,0,-90]) bottom_bar();  // rear bar
translate([1415.5, x1+44/2,-53+2*pocket_depth-explode]) rotate([0,0,-90]) bottom_bar(); // front bar

%translate([side_x_center-center_pocket_w/2,   x2+44/2,-53+2*pocket_depth-explode]) rotate([0,0,-90]) bottom_center_bar();  // rear c bar
%translate([side_x_center+center_pocket_w/2-34,x2+44/2,-53+2*pocket_depth-explode]) rotate([0,0,-90]) bottom_center_bar();  // front c bar


translate([side_x_center-22,          44+side_x+explode,-53+2*pocket_depth]) rotate([0,90+side_alpha,-90]) side_support();
translate([side_x_center+22,-frame_width-side_x-explode,-53+2*pocket_depth]) rotate([0,90+side_alpha, 90]) side_support();

// rcube_xy([100,100,100],20);
// translate([0,0,100])rcube_xy([100,100,100],40);
// translate([0,0,-100])cube([100,100,100]);
