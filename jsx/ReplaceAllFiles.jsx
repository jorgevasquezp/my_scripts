﻿app.beginUndoGroup("ReplaceAllFiles");
var project = app.project;
var new_path =prompt("Enter new path for footage:","/","New Path");

function getFootageItems()
{
    footageItems =[];
    for ( var i = 1 ; i <= project.items.length ; i ++ )
    {
        footageItem = project.items[i];
        if ( footageItem.typeName == "Footage" && footageItem.file != null )
        {
             footageItems.push(footageItem);
        }
    }
    return footageItems;
}
function getLastFolder( file_path )
{
    tree = file_path.split("/");
    lastFolder = tree[tree.length-1];
    return lastFolder
}
function replaceFiles( footageItems, path )
{
    seq_ptn = new RegExp("\[[0-9\-].*\]","g");

    for ( var i = 0 ; i < footageItems.length ; i ++ )
    {
        var footageItem = footageItems[i];
        if ( footageItem.mainSource.isStill == true || footageItem.name.match ( seq_ptn ) == null ){
            footageItem.replace( File( new_path + footageItem.file.name ) );
        }
        else
        {
            footageItem.replaceWithSequence( File( new_path + getLastFolder( footageItem.file.path )  +"/"+ footageItem.file.name ), false );
            //alert( new_path + footageItem.file.name );
            //alert( new_path + getLastFolder( footageItem.file.path )  +"/"+ footageItem.file.name );
        }
    writeLn("Replacing :" +footageItem.file.name );
    clearOutput();
    }
    writeLn("Booyakasha!");
}

clearOutput();
replaceFiles( getFootageItems() , new_path );
app.endUndoGroup();
