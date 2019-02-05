//---------------------------------------------------------------------------------------------
//-- Tea Steward
//-- (c) Martin Korinek	work@korinek.cc
//-- 2018-2019
//---------------------------------------------------------------------------------------------
//--
//---------------------------------------------------------------------------------------------
//includes
use <../vitamins/stepper_28BYJ.scad>; //use doesn't executes functions in the file
use <../parts/spool.scad>;
use <../vitamins/bearing.scad>;
$fn = 80; //10 for development /80

//variables == constants
SpoolLenght = get_SpoolCoreLenght()+2*get_SpoolBoarderThickness(); //total spool lenght
DefaultHolderHeight = 2*(get_SpoolOuterRadius()+get_SpoolInnerRadius());
HolderWidth = 2*(get_SpoolOuterRadius()+get_SpoolInnerRadius());
DefaultHolderThickness = bearingWidth(get_SpoolUsedBearingModel())-0.1;
HolderAxis= (get_SpoolOuterRadius()+get_SpoolInnerRadius());
BlockLenght = SpoolLenght+2*DefaultHolderThickness+2*get_SpoolBearingDistanceRing();
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
    translate([HolderWidth/2,DefaultHolderThickness+get_SpoolBearingDistanceRing(),HolderAxis]) rotate([-90,0,0]) //deactivate for printing
        spool();
    spoolHolder();
}

//Outer shell


//parts



module stepperHolder()
{
    translate([HolderWidth/2, -1.49+DefaultHolderThickness, HolderAxis+8]) //8 is shift of axis to mounting points
        rotate([90,-90,180])
            28BYJ();
}

   
    

module mainHolder()
{
    //spoolHolder
    //electric holder
    //Endstop
}


module spoolHolder()
{
    //Mounting block
    mountingBlock();
    //holds the stepper
    holderBlock(DefaultHolderThickness);

    translate([0,SpoolLenght+DefaultHolderThickness+2*get_SpoolBearingDistanceRing(),0])
    {
        difference()
        {
            holderBlock(HolderHeight = 30);
            translate([HolderWidth/2, -0.01, HolderAxis])
                rotate([-90,0,0])
                    bearing(get_SpoolUsedBearingModel(),outline=true);
        }
        //show bearing
        translate([HolderWidth/2, -0.01, HolderAxis])
            rotate([-90,0,0])
                bearing(get_SpoolUsedBearingModel());
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

    translate([0,SpoolLenght+DefaultHolderThickness+2*BearingInnerRing,0])
        holderBlock();

}
 
