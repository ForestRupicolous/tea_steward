//---------------------------------------------------------------------------------------------
//-- Tea Steward
//-- (c) Martin Korinek	work@korinek.cc
//-- 2018-2019
//---------------------------------------------------------------------------------------------
//--
//---------------------------------------------------------------------------------------------
//includes
use <../vitamins/stepper_28BYJ.scad>; //use doesn't executes functions in the file

$fn = 10; //10 for development /80
//variables
OuterRadius = 16;
InnerRadius = 8;
BearingInnerRadius = 7.9/2;
BearingInnerRing = 3;
BearingOuterRadius = 22/2;
BearingHeight = 7;
SpoolCore = 30;
RingHeight = 1.5;
BoarderThickness = 3;
RopeRadius = 0.8;
Tolerance = 0.1;
SpoolHeight = SpoolCore+2*BoarderThickness; //total spool hight
DefaultHolderHeight = 2*(OuterRadius+InnerRadius);
HolderWidth = 2*(OuterRadius+InnerRadius);
DefaultHolderThickness = BearingHeight;
HolderAxis= (OuterRadius+InnerRadius);
BlockLenght = SpoolHeight+2*DefaultHolderThickness+2*BearingInnerRing;
BlockWidth = HolderWidth;
BlockThickness = 5;
echo(BlockLenght);
echo(BlockWidth);
echo(BlockThickness);

//###########
//top level
difference()
{
    SpoolAndHolder();
    stepperHolder();
}
stepperHolder();

//electricHolder();
//###########


//modules
module SpoolAndHolder()
{
    translate([HolderWidth/2,DefaultHolderThickness+BearingInnerRing,HolderAxis]) rotate([-90,0,0]) //deactivate for printing
        spool();
    spoolHolder();
}

//Outer shell

module stepperHolder()
{
    translate([HolderWidth/2, -1.49, HolderAxis+8]) //8 is shift of axis to mounting points
        rotate([90,-90,180])
            28BYJ();
}

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
        cylinder(h = SpoolCore/3, r1=OuterRadius, r2=InnerRadius);
    translate([0,0,SpoolCore/3])
        cylinder(h = SpoolCore/3, r1=InnerRadius, r2=InnerRadius);
    translate([0,0,2*SpoolCore/3])
        cylinder(h = SpoolCore/3, r1=InnerRadius, r2=OuterRadius);
    }
    translate([0,0,SpoolCore+BoarderThickness])
        rollBoarder();
}    
    

module mainHolder()
{
    //spoolHolder
    //electric holder
    //Endstop
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

module spoolHolder()
{
    //Mounting block
    mountingBlock();
    difference()
    {
        translate([0,-5,0])
            holderBlock(DefaultHolderThickness+5);
        
        translate([HolderWidth/2, -0.01, HolderAxis])
            rotate([-90,0,0])
                bearingHole();



            
    }
    translate([0,SpoolHeight+DefaultHolderThickness+2*BearingInnerRing,0])
        difference()
        {
            holderBlock(HolderHeight = 30);
            translate([HolderWidth/2, -0.01, HolderAxis])
                rotate([-90,0,0])
                    bearingHole();
        }
    //Bearing Hole
    //InnerBearing
    //Motor Hole

}

module mountingBlock()
 {
    difference()
    {
        cube([BlockWidth, BlockLenght, BlockThickness]);
        translate([BlockWidth/4,DefaultHolderThickness/2,0])
            cube([2*BlockWidth/4, BlockLenght-DefaultHolderThickness,BlockThickness]);
    }
 }

 module holderBlock(HolderThickness = DefaultHolderThickness, HolderHeight = DefaultHolderHeight)
 {
     cube([HolderWidth, HolderThickness, HolderHeight]);
 } 

 module electricHolder()
{
    //Mounting block
    mountingBlock();
    holderBlock();

    translate([0,SpoolHeight+DefaultHolderThickness+2*BearingInnerRing,0])
        holderBlock();

}
 
