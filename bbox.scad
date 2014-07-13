// (c) 2014 juewei@fabfolk.com
//
// a bevelled (or camfered) box

module bbox_chamfer_cutaway_z(x,y,z,b)
{
  translate([b,0,-10]) rotate([0,0,90+45]) cube([2*b,2*b,z+20]);
  translate([x-b,0,-10]) rotate([0,0,-45]) cube([2*b,2*b,z+20]);

  translate([b,y,-10]) rotate([0,0,90+45]) cube([2*b,2*b,z+20]);
  translate([x-b,y,-10]) rotate([0,0,-45]) cube([2*b,2*b,z+20]);
}

module bbox_x(x,y,z,b)
{
  difference()
    {
      cube([x,y,z]);
      translate([0,0,z])rotate([0,90,0]) bbox_chamfer_cutaway_z(z,y,x,b);
    }
}

module bbox_y(x,y,z,b)
{
  difference()
    {
      cube([x,y,z]);
      translate([0,y,0])rotate([90,0,0]) bbox_chamfer_cutaway_z(x,z,y,b);
    }
}

module bbox_z(x,y,z,b)
{
  difference()
    {
      cube([x,y,z]);
      bbox_chamfer_cutaway_z(x,y,z,b);
    }
}

module bbox(x,y,z,b=0,bx=0,by=0,bz=0)
{
  difference()
    {
      cube([x,y,z]);
      if (b > 0)
        {
          translate([0,0,z])rotate([0,90,0]) bbox_chamfer_cutaway_z(z,y,x,b);
          translate([0,y,0])rotate([90,0,0]) bbox_chamfer_cutaway_z(x,z,y,b);
          bbox_chamfer_cutaway_z(x,y,z,b);
	}

      if (bx > 0) translate([0,0,z])rotate([0,90,0]) bbox_chamfer_cutaway_z(z,y,x,bx);
      if (by > 0) translate([0,y,0])rotate([90,0,0]) bbox_chamfer_cutaway_z(x,z,y,by);
      if (bz > 0) bbox_chamfer_cutaway_z(x,y,z,bz);
    }
}

bbox(100,200,250,5);
