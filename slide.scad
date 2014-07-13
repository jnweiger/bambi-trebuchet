// (c) 2014 juewei@fabfolk.com
//
// slide for bambi trebuichet

module slide_support(h=60,d=18,l=150,w=60,z=18)
{
  // w & z are the dimensions of the boards placed on the support. 
  // Needed for fine tuning.

  a=0.08*z;
  difference()
    {
      translate([0,.5*w-.5*l,0]) cube([d,l,h]);
      translate([-10,0,0.5*h]) rotate([0,0,0]) cube([d+20,w,w]);
      translate([-10,0,0.5*h+a]) rotate([45,0,0]) cube([d+20,w,w]);
      translate([-10,w,0.5*h+a]) rotate([45,0,0]) cube([d+20,w,w]);
    }
}

module slide(w=60,d=18,l=1500)
{

  uw=2.3*w;
  uh=w;
  ud=d;

  translate([-ud,-0.5*w,0.5*uh]) 
    {
      difference()
	{
	  cube([l, w, d]);
	  translate([-10,-.5*d,0]) rotate([45,0,0]) cube([l+20,2*d,2*d]);
	  translate([-10,w+.5*d,0]) rotate([45,0,0]) cube([l+20,2*d,2*d]);
	}
      translate([0, -.21*d,0.295*d]) rotate([45,0,0]) cube([l,d,w]);
      translate([0,w+.21*d,0.295*d]) rotate([45,0,0]) cube([l,w,d]);

      for (x = [ud : (l-ud-2*ud)/3 : l-ud]) 
	{
	  translate([x,0,-0.5*uh]) slide_support(uh,ud,uw,w,d);
	}
    }
}

slide(d=18);
