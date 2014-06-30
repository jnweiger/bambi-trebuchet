module lower_beam()
{
  l=1500;
  difference()
    {
      cube([l,44,44]);
    
      translate([410, -10, -10]) cube([80, 17, 60]);
      rotate([-90,0,0]) translate([42,-22,-10]) cylinder(60,7,7);
      translate([-10,-10,-10]) rotate([0,-45,0]) cube([20,60,20]);
      // cut corners
      rotate([0,-45,0]) translate([0,-10,-10]) cube([8,60,20]);
      translate([0,0,45]) rotate([0,45,0]) translate([0,-10,-10]) cube([8,60,20]);
      translate([l,0,45]) rotate([0,135,0]) translate([0,-10,-10]) cube([8,60,20]);
      translate([l,0,0]) rotate([0,-135,0]) translate([0,-10,-10]) cube([8,60,20]);
    }
}


lower_beam();

translate([0,400,0]) scale([1,-1,1]) lower_beam();