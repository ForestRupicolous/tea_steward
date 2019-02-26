# Tea steward
3D printed automatic tea steeper designed in OpenSCAD
![TeaSteward](https://raw.githubusercontent.com/ForestRupicolous/tea_steward/master/Tea_Steward_View.png)  
  

Uses OpenSCAD MCAD library from: https://github.com/openscad/MCAD  
  


##File organisation  
See https://medium.com/@urish/designing-3d-printable-mechanisms-in-openscad-5838dcb65b39  

**parts**: Files for single self designed parts I want to print  
**vitamins**: 3D designs of non printable items like screws, nuts, motors  
**assemblies**: Views of different parts and vitamins together  

## Create updated image
enter in Terminal (e.g. directly in VS code)

    openscad -DPARTNO=0 -o Tea_Steward_View.png assemblies/tea_steward.scad  --camera=200,200,100,0,0,10

## Idea collection  
When preview has errors switch view mode (F12)  

https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?


### export parts as STL
    openscad -DPARTNO=1 -o Tea_Steward_spool.stl assemblies/tea_steward.scad
    openscad -DPARTNO=4 -o Tea_Steward_mountingBlock.stl assemblies/tea_steward.scad
    openscad -DPARTNO=2 -o Tea_Steward_stepperHolder.stl assemblies/tea_steward.scad
    openscad -DPARTNO=3 -o Tea_Steward_spoolHolder.stl assemblies/tea_steward.scad
 
### export image of all the parts combined
    openscad -DPARTNO=0 -o model.png model.scad

##CODE:  
Digispark Pin P5 not connected to program (RESET?!)

====== Digispark Pin Usage Guide ======

This table details the function of each pin on the Digispark and any notes the are relevant.

^  Pin \\ Number  ^  Output \\ Voltage  ^  Analogue Port Number \\ ''analogRead()''  ^  PWM  ^  USB  ^  Test \\ LED  ^  I2C  ^  SPI*  ^
|0          |5 V            |                     |Y - 504 Hz |                   |Rev 1    |SDA  |  MISO  |
|1          |5 V            |                     |Y - 504 Hz |                   |Rev 2 / 4|     |  MOSI  |
|2          |5 V            |1                    |           |                   |         |SCL  |  SCK   |
|3          |3.6 V          |3                    |           |Y - 1.5k Ohm to 5 V \\ Zener diode (3.6 V maximum in- & output) | |
|4          |3.6 V          |2                    |Y - 1007 Hz|Y \\ Zener diode (3.6 V maximum in- & output)   | | |
|5          |3 V            |0                    |           |                   |         |     |

* Note that the labeling of the pins for SPI is somewhat misleading. The table above is correct, as MISO is actually DI and MOSI is DO, but for use with ISP MISO and MOSI are swapped.