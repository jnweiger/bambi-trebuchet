// (c) 2014 juewei@fabfolk.com
//
// catapult arm for bambi trebuchet
//
// FIXME: arm_pyramid should be made of multiple layers
//        "sperrverleimt."

use <bbox.scad>

$fs=1;	// segment size: 1mm

d1=8;	// bolt diameter for gluing walls
endl=70;
dh=14;		// diameter of pin holder

// origin is center of main shaft.
// l1=1624/l2=325 ratio is 1:5
module arm_double_beam(l1=1625, l2=325, d=28)
{
  l=l1+l2+endl;
  lx=980;

  translate([-endl-l2, -d/2, 0]) union()
    {
      difference()
	{
	  union()
	    {
              bbox(l,d,d,bx=2);
	      translate([0,0,-28]) bbox(lx,d,d,bx=2);
	    }
	  translate([lx,-10,0]) rotate([0,180-4,0]) cube([lx,d+20,d+20]);
	  translate([endl+l2,-50,0]) rotate([-90,0,0]) cylinder(d+100,8,8);
	  translate([endl,-50,0])    rotate([-90,0,0]) cylinder(d+100,8,8);
	  for (x = [endl/2 : 210 : lx-endl])
	    {
	      translate([x,d/2,-28-10]) cylinder(d+10+10, 3,3);
	    }
	}
    }
}

module arm_head_side(w=28,s=8)
{
  difference()
    {
      union()
        {
          translate([-3*w,0,0]) cube([3*w,s,w]);
          translate([-3*w,s/2,w]) rotate([0,90,0]) cylinder(3*w,s/2,s/2);
          translate([-3*w,s/2,0]) rotate([0,90,0]) cylinder(3*w,s/2,s/2);
          translate([   0,s,w/2]) rotate([90,0,0])  cylinder(s,w/2,w/2);
	  translate([ 0,s/2,w/2]) rotate([90,0,0]) rotate_extrude() translate([w/2, 0, 0]) circle(r = s/2);
        }

      // hole for pin holder
      translate([-dh/2,10,w/2]) rotate([90,0,0]) cylinder(s+10,dh/2,dh/2);

      // flatten left right outside
      translate([-3*w,0,-10]) rotate([0,0,10]) cube([3*w,s+10,w+s+20]);
      
      // taper top 
      translate([-3*w,-5,w-3]) rotate([0,-7,0]) cube([3*w,s+10,w+s+20]);

      // taper bottom
      translate([-3*w,-5,3])  rotate([0,90+7,0]) cube([w+s+20,s+10,3*w]);
    }
}

module arm_pin_holder(w=28,s=6,d=6)
{
  l=w+2*d+2*s+1*s;
  k=1;
  dp=2;
  difference()
    {
      union()
        {
          translate([0,-l/2,0]) rotate([-90,0,0]) cylinder(l,dh/2,dh/2);
	  // add conical end caps.
          translate([0, l/2,0]) rotate([-90,0,0]) cylinder(3,dh/2,dh/2-3);
          translate([0,-l/2,0]) rotate([ 90,0,0]) cylinder(3,dh/2,dh/2-3);
	}
      // holes accros for the taps
      translate([0,-w/2-s-d/2+k,-dh/2-10]) cylinder(dh+20,d/2,d/2);
      translate([0,w/2+s+d/2-k,-dh/2-10]) cylinder(dh+20,d/2,d/2);

      // hole for the pin itself
      rotate([0,90,0]) translate([0,0,-dh/2-10]) cylinder(dh+20,dp/2,dp/2);
    }
}

module arm_head(w=28, alpha=6)
{
  translate([0, (w)/2,0])                 arm_head_side(w,6);
  translate([0,-(w)/2,0]) scale([1,-1,1]) arm_head_side(w,6);
  translate([-dh/2,0,w/2]) rotate([0,-alpha,0]) arm_pin_holder();
}

module arm_pyramid(h=20)
{
  dm=16; 	// diameter of main shaft
  difference()
    {
      intersection()
        {
          rotate([0,45,0]) translate([-40,-10,-40]) bbox(80,h+10,80,bx=8,bz=8);
          // cut away top and bottom 
          translate([-60,-28+10,-28]) cube([120,2*28,2*28]);
          rotate([45,0,0]) translate([-60,-28,-28]) cube([120,2*28,2*28]);
	}
      // cut away the inside bevel of bbox.
      rotate([0,45,0]) translate([-50,-20,-50]) cube([100,20,100]);

      // main shaft hole in pyramid
      rotate([-90,0,0]) translate([0,0,-10]) cylinder(h+20,dm/2,dm/2);

      // holes for cross setion bolts, glued
      translate([dm,h/2,-28-10]) cylinder(2*28+20,d1/2,d1/2);
      translate([-dm,h/2,-28-10]) cylinder(2*28+20,d1/2,d1/2);
    }
}

// origin is center of main shaft.	
// l1=1624/l2=325 ratio is 1:5
module arm(l1=1625, l2=325)
{
  arm_double_beam(l1-20, l2, d=28);
  translate([l1,0,0]) arm_head(w=28,alpha=12);
  translate([0, 28/2, 0])                 arm_pyramid();
  translate([0,-28/2, 0]) scale([1,-1,1]) arm_pyramid();
  translate([-l2, 28/2, 0])                 arm_pyramid();
  translate([-l2,-28/2, 0]) scale([1,-1,1]) arm_pyramid();
}

arm();
