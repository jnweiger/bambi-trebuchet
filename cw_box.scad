// (c) 2014 juewei@fabfolk.com
//
// counterweight box for bambi trebuchet

use <bbox.scad>

d1=8;	// bolt diameter for gluing walls

module cw_box_handle(wn=1.5,hn=3,l=400,bw=174,bz=27,h=450)
{
  w = bw*wn;

  difference()
    {
      union()
	{
	  translate([-53/2,-w/2,0])          bbox(53,34,h,bz=3);
	  translate([-53/2, w/2-34,0])       bbox(53,34,h,bz=3);
	  translate([-53/2,-w/2+34,h-80])    bbox(53,20,80,bz=3);
	  translate([-53/2, w/2-34-20,h-80]) bbox(53,20,80,bz=3);

	  translate([ 53/2,-w/2,0])    bbox(44,w,44,by=3);
	  translate([-44-53/2,-w/2,0]) bbox(44,w,44,by=3);
	}
      
      // hole for rear shaft
      translate([0,0,h-80/2]) rotate([90,0,0]) translate([0,0,-w/2-10]) cylinder(w+20,8,8);

      // base bolt holes, glued
      translate([0, w/2-34/2,44/2]) rotate([0,90,0]) translate([0,0,-100]) cylinder(200,5,5);
      translate([0,-w/2+34/2,44/2]) rotate([0,90,0]) translate([0,0,-100]) cylinder(200,5,5);
    }
}

module cw_box_floor(wn,l,bw,bz)
{
  w=wn*bw;
  w2 = floor(wn)*bw;

  translate([-l/2, -w/2, 0]) difference()
    {
      union()
	{
	  for (y = [0 : bw : w-bw])
	    {
	      translate([0,y,0]) bbox(l,bw,bz,bx=3);
	    }
	  if (w2 < w)
	    {
	      translate([0,w2,0]) bbox(l,w-w2,bz,bx=3);
	    }
	}
      translate([l/2-(53+1)/2, -10,-10]) cube([53+1,34+1+10,bz+20]);
      translate([l/2-(53+1)/2, w-34-1,-10]) cube([53+1,34+1+10,bz+20]);
    }
}

module cw_box_long_wall(l, bw, hn, bz)
{
  alpha=25;
  h = hn*bw;
  h2 = floor(hn)*bw;

  difference()
    {
      union()
        {
	  for (y = [0 : bw : h-bw])
	    {
	      translate([0,0,y]) bbox(l+2*bz,bz,bw,bx=3,bz=3);
	    }
	  if (h2 < h)
	    {
	      translate([0,0,h2]) bbox(l+2*bz,bz,h-h2,bx=3,bz=3);
	    }
        }
      translate([0,0,44-5])      rotate([0,alpha,0])  translate([0,-10,-10-44]) cube([120,bz+20,10+44]);
      translate([l+2*bz,0,44-5]) rotate([0,90-alpha,0]) translate([0,-10,-120]) cube([44+10,bz+20,120]);
      for (y = [20 : 40 : h])
        {
          for (x = [bz/2 : (l+bz)/2 : l+2*bz])
	    {
	      translate([x,-10,y]) rotate([-90,0,0]) cylinder(bz+20, d1/2, d1/2);
	    }
	}
      for (x = [50 : 40 : l/2])
        {
	   translate([x,-10,44+bz/2]) rotate([-90,0,0]) cylinder(bz+20, d1/2, d1/2);
	   translate([l+2*bz-x,-10,44+bz/2]) rotate([-90,0,0]) cylinder(bz+20, d1/2, d1/2);
	}
    }
}

module cw_box_short_wall(w, bw, hn, bz)
{
  alpha=25;
  h = hn*bw;
  h2 = floor(hn)*bw;

  difference()
    {
      union()
        {
	  for (y = [0 : bw : h-bw])
	    {
	      translate([0,0,y]) bbox(bz,w,bw,by=3);
	    }
	  if (h2 < h)
	    {
	      translate([0,0,h2]) bbox(bz,w,h-h2,by=3);
	    }
	}
      translate([0,0,44-5]) rotate([0,alpha,0]) translate([0,-10,-10-44]) cube([44+10,w+20,10+44]);
      for (y = [20 : 40 : w])
        {
	   translate([-10,y,44+bz/2]) rotate([0,90,0]) cylinder(bz+20, d1/2, d1/2);
	}
    }
}

module cw_box(wn=2,hn=2.7,l=470,bw=120,bz=27,h=520)
{
  w=wn*bw;
  translate([0,0,44]) cw_box_floor(wn,l,bw,bz);
  cw_box_handle(wn,hn,l,bw,bz,h);
  translate([-l/2-bz,w/2    ,0]) cw_box_long_wall(l, bw, hn, bz);
  translate([-l/2-bz,-w/2-bz,0]) cw_box_long_wall(l, bw, hn, bz);
  translate([-l/2-bz,-w/2   ,0]) cw_box_short_wall(w, bw, hn, bz);
  translate([ l/2+bz,-w/2   ,0]) scale([-1,1,1]) cw_box_short_wall(w, bw, hn, bz);
}

cw_box();
