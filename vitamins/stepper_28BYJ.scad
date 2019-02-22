// Model of cheap stepper motor 28BYJ 
// Include with use function to avoid calling top geometry

$fn=60;

module 28BYJ() {
    difference() {
        union() {
            translate([0,0,-19.2])cylinder(d=29,h=19.2);  //main cylinder
            translate([9,-8.75,-17.5])cube([8,17.5,17.5]);
            translate([10,-3.5,-17.5])cube([8.5,7,17.5]);
            translate([-8.1,0,-1])cylinder(d=9.2,h=2.5);
            translate([-8.1,0,0])cylinder(d=4.9,h=9.2);
            hull() {
                translate([0,17.5,-8])cylinder(d=7.5,h=8);//left and right screw holder
                translate([0,-17.5,-8])cylinder(d=7.5,h=8);
            }
        }
        translate([-13,1.45,3.2])cube([10,4,10]);
        translate([-13,-5.45,3.2])cube([10,4,10]);
        //translate([0,17.5,-1])cylinder(d=4.2,h=2);
        //translate([0,-17.5,-1])cylinder(d=4.2,h=2);
    }
}

28BYJ();