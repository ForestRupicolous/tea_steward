//Spool
use <../vitamins/bearing.scad>;

//variables
OuterRadius = 14;
InnerRadius = 7;
BearingModel = 608;
BearingInnerRadius = bearingInnerDiameter(BearingModel)/2;
BearingDistanceRing = 3;
BearingOuterRadius = bearingOuterDiameter(BearingModel)/2;
BearingHeight = bearingWidth(BearingModel);

SpoolCoreLenght = 25;
RingHeight = 1.5;
BoarderThickness = 3;
RopeRadius = 0.8;
Tolerance = 0.1;
SpoolHeight = SpoolCoreLenght+2*BoarderThickness; //total spool hight

// ------ top level geometry --------
spool();
//functions
function get_SpoolOuterRadius() = OuterRadius;
function get_SpoolInnerRadius() = InnerRadius;
function get_SpoolCoreLenght() = SpoolCoreLenght;
function get_SpoolBoarderThickness() = BoarderThickness;
function get_SpoolUsedBearingModel() = BearingModel;
function get_SpoolBearingDistanceRing() = BearingDistanceRing;



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
    //rotate([180,0,0])   bearingInnerPart();

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
    cylinder(BearingHeight+BearingDistanceRing, BearingInnerRadius, BearingInnerRadius);
    cylinder(BearingDistanceRing,BearingInnerRadius+1,BearingInnerRadius+1);
}

module ropeHole()
{
    cylinder(h=InnerRadius, r=RopeRadius);
    translate([0,0,-InnerRadius])
        cylinder(InnerRadius,RopeRadius*2);
}
//-------------- END of spool-------------------