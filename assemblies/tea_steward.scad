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

//use this to enable different parts/views 0=ALL (not for print)
PARTNO = 0;

//variables == constants
SpoolLenght = get_SpoolCoreLenght()+2*get_SpoolBoarderThickness(); //total spool lenght
DefaultHolderHeight = 2*(get_SpoolOuterRadius()+get_SpoolInnerRadius());
HolderWidth = 2*(get_SpoolOuterRadius()+get_SpoolInnerRadius());
DefaultHolderThickness = bearingWidth(get_SpoolUsedBearingModel())-0.1;
HolderAxis= (get_SpoolOuterRadius()+get_SpoolInnerRadius());
BlockLenght = SpoolLenght+2*DefaultHolderThickness+2*get_SpoolBearingDistanceRing();
BlockWidth = HolderWidth+10;
BlockThickness = 5;
echo(BlockLenght);
echo(BlockWidth);
echo(BlockThickness);

//###########
//top level
if(PARTNO == 0)
{
    difference()
    {
        SpoolAndHolders();
        stepper();
    }
    //show stepper
    stepper();
//electricHolder();
}
//Spool with hole
else if (PARTNO == 1)
{
    rotate([90,0,0])
    {    
        difference()
        {
            translate([HolderWidth/2,DefaultHolderThickness+get_SpoolBearingDistanceRing(),HolderAxis]) rotate([-90,0,0]) //deactivate for printing
                spool();
            stepper();
        }
    }  
}
else if(PARTNO == 2)
{   rotate([-90,0,0])
        stepperHolder();
}
else if(PARTNO == 3)
{   rotate([90,0,0])
        spoolHolder();
}
else if(PARTNO == 4)
{   
        mountingBlock();
}

else 
{
    echo("PARTNO not defined!");
}
//###########


//modules
module SpoolAndHolders()
{
    translate([HolderWidth/2,DefaultHolderThickness+get_SpoolBearingDistanceRing(),HolderAxis]) rotate([-90,0,0]) //deactivate for printing
        spool();
    mountingBlock();
    stepperHolder();
    spoolHolder();
    
}

//Outer shell


//parts



module stepper()
{
    translate([HolderWidth/2, -1.49+DefaultHolderThickness, HolderAxis+8]) //8 is shift of axis to mounting points
        rotate([90,-90,180])
            28BYJ();
}

//Holds the stepper
module stepperHolder()
{
    difference()
    {    
        holderBlock(DefaultHolderThickness);
        stepper();
    }
}

   
    

module mainHolder()
{
    //spoolHolder
    //electric holder
    //Endstop
}


module spoolHolder()
{
    //Holds the bearing
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
}

module mountingBlock()
 {
    difference()
    {
        translate([-5,0,0])
            difference()
            {
                cube([BlockWidth, BlockLenght, BlockThickness]);
                //remove hole in middle
                translate([BlockWidth/6,BlockLenght/4,0])
                    cube([2*BlockWidth/3, BlockLenght/2,BlockThickness]);
            }
        stepperHolder();
        spoolHolder();
    }
 }

 module holderBlock(HolderThickness = DefaultHolderThickness, HolderHeight = DefaultHolderHeight)
 {
     cube([HolderWidth, HolderThickness, HolderHeight]);
 } 


 
