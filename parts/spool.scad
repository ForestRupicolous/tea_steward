//Spool
//variables
OuterRadius = 16;
InnerRadius = 8;
BearingInnerRadius = 7.9/2;
BearingInnerRing = 3;
BearingOuterRadius = 22/2;
BearingHeight = 7;
SpoolCoreLenght = 30;
RingHeight = 1.5;
BoarderThickness = 3;
RopeRadius = 0.8;
Tolerance = 0.1;
SpoolHeight = SpoolCoreLenght+2*BoarderThickness; //total spool hight

// ------ top level geometry --------
spool();
//functions
function get_OuterRadius() = OuterRadius;
function get_InnerRadius() = InnerRadius;
function get_SpoolCoreLenght() = SpoolCoreLenght;
function get_BoarderThickness() =BoarderThickness;
// modules
module spool()
{
    difference()
    {
        //mainpart
        mainRoll();
        translate([0,0,SpoolHeight/2+BoarderThickness])
            rotate([90,0,0])
                ropeHole();
        
    }
    //bearing holders
    rotate([180,0,0])   bearingInnerPart();

    translate([0,0,SpoolHeight])    bearingInnerPart();
       
}

module mainRoll()
{
    rollBoarder();

    translate([0,0,BoarderThickness])
    {
        cylinder(h = SpoolCoreLenght/3, r1=OuterRadius, r2=InnerRadius);
    translate([0,0,SpoolCoreLenght/3])
        cylinder(h = SpoolCoreLenght/3, r1=InnerRadius, r2=InnerRadius);
    translate([0,0,2*SpoolCoreLenght/3])
        cylinder(h = SpoolCoreLenght/3, r1=InnerRadius, r2=OuterRadius);
    }
    translate([0,0,SpoolCoreLenght+BoarderThickness])
        rollBoarder();
}

module rollBoarder()
{
    cylinder(BoarderThickness, OuterRadius, OuterRadius);
}

module bearingInnerPart()
{
    cylinder(BearingHeight+BearingInnerRing, BearingInnerRadius, BearingInnerRadius);
    cylinder(BearingInnerRing,BearingInnerRadius+1,BearingInnerRadius+1);
}

module bearingHole()
{
    cylinder(BearingHeight+Tolerance, BearingOuterRadius+Tolerance, BearingOuterRadius+Tolerance);
    translate([0,0,BearingHeight])
        cylinder(BearingHeight/4, BearingOuterRadius+Tolerance, BearingInnerRadius+Tolerance);
}

module ropeHole()
{
    cylinder(h=InnerRadius, r=RopeRadius);
    translate([0,0,-InnerRadius])
        cylinder(InnerRadius,RopeRadius*2);
}
//-------------- END of spool-------------------