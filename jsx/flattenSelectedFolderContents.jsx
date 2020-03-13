/*
function isInArray( array, value ){
	result = false
	for ( var i = 0 ; i < array.length ; i ++ ){
		if ( array[i] == value ){
			result = true
		}
	}
	return result
}
*/

function getSelectedProjectItems (){
    var items = [];
    var p = app.project;
    for ( var i = 1 ; i <= p.numItems ; i ++ ){
        var item = p.item(i);
        if ( item.selected ){
            items.push(item);
        }
    }
    return items;
}
function getAllItems( folderItem ){
	
	var items = [];
	var folders = [];
	
	for ( var i = 1 ; i <= folderItem.numItems ; i ++ ){
	var item = folderItem.item(i);
	
	if ( (item.typeName != "Folder") ){
			//if ( (isInArray( items ,item )) == false ){
				items.push( item );
			//}
		}else{
				var new_items = getAllItems(item);
				for ( var j = 0 ; j < new_items.length ; j ++ ){
					new_item = new_items[j];
					//if ( (isInArray ( new_item )) == false ){
						items.push ( new_item );
					//}
				}
			}
		}
	return items
}
function flatten( items, root ){
	app.beginUndoGroup("Flatten Selected Folder Contents")
	for ( var i = 0; i < items.length ; i ++){
		item = items[i];
		item.parentFolder = root;
	}
	app.endUndoGroup()
	purgeEmptyFolders();
	return
}
function purgeEmptyFolders(){
	app.beginUndoGroup("Purge Empty Folders")
	var emptyFolders = [];
	
	var p = app.project;
	for ( var i = p.numItems ; i >= 1 ; i -- ){
		item = p.item(i);
		if ( item.typeName == "Folder" ){
			if ( item.numItems <= 0 ){
				item.remove();
			}
		}
	}
	
	app.endUndoGroup()
}


flatten( getAllItems( getSelectedProjectItems()[0] ) , getSelectedProjectItems()[0] );
alert("You're welcome ;-) ");
