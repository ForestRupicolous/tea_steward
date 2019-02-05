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

    openscad -o Tea_Steward_View.png assemblies/tea_steward.scad  --camera=200,200,100,0,0,10

## Idea collection  
When preview has errors switch view mode (F12)  

https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/FAQ#How_can_I_export_multiple_parts_from_one_script?

Get rid of left bearing

### export parts as STL
    openscad -DPARTNO=1 -o tree.stl model.scad
    openscad -DPARTNO=2 -o trunk.stl model.scad
    openscad -DPARTNO=3 -o base.stl model.scad
 
### export image of all the parts combined
    openscad -DPARTNO=0 -o model.png model.scad