﻿debug = {};
pTools = {
    debug:{
        active : true
    }
};

pTools.debug.log = function ( string )
{
    if ( pTools.debug.active ){
        $.writeln( string );
        writeLn( string );
    }
    return;
}
function pad ( n , pad ) {
    zeros = "";
    for ( i = 0 ; i < pad ; i ++ )
    {
        zeros+="0";
    }
    n = String(n);
    padded = zeros.substr( 0, pad - n.length ) + String(n) ;
    return padded
}
function getItem( item_name, item_type ){
    var result = null;
    var items = app.project.items;
    var names = [];
    
    for ( i = 1 ; i <= items.length ; i ++ )
    {
        var item = items[i];
        var type = item.typeName;
        if ( ( type == item_type ) && ( item.name == item_name ) )
        {
            result = item;
            //$.writeln( item.name );
        }
    }
    return result;
}
function getFolder( given_name ){
    
    result = getItem( given_name, "Folder" );
    
    return result;
}
function getComp( given_name ){
    
    result = getItem( given_name, "Composition" );
    
    return result;
}
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
function duplicateSuffix( items , suffix ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        var new_item = item.duplicate();
        new_item.name = item.name+"_"+suffix
    }
    return true;
}
function duplicateReplace( items , string , newString ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        var new_item = item.duplicate();
        new_item.name = item.name.replace( string , newString );
    }
    return true;
}
function suffix( items , suffix ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        item.name+= "_"+suffix
    }
    return true;
}
function prefix( items , prefix ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        item.name = suffix + "_" + item.name;
    }
    return true;
}
function replace( items , string , newString ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        item.name = item.name.replace( string , newString );
    }
    return true;
}
function checkDuration( items , duration ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        pTools.debug.log(item.duration);
    }
}
function enforceDuration( items , duration ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        item.duration = duration;
    }
}
function fitToComp( layer ){
    var orig_scale = layer.transform.scale.value;
    var comp_width = layer.containingComp.width;
    var comp_height = layer.containingComp.height;
    var layer_width = layer.source.width;
    var layer_height = layer.source.height;
    
    var new_scale = [ ( comp_width / layer_width ) * 100 , ( comp_height / layer_height ) * 100 ] ;

    layer.transform.scale.setValue( new_scale );
    
}
function claritize( items ){
    var orig_target_folder_name = "1920x1080@23.976";
    var target_folder_name = "1280x720@59.97";
    var w = 1280;
    var h = 720;
    var a = 1;
    var r = 59.94;
    target_folder = app.project.items.addFolder( target_folder_name );
    orig_target_folder =  app.project.items.addFolder( orig_target_folder_name );

    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        var new_comp = app.project.items.addComp(item.name,1280,720,1,item.duration+2,59.94);
        new_comp.parentFolder = target_folder;
        var new_layer = new_comp.layers.add(item);
        new_layer.startTime = 1;
        
        item.parentFolder = orig_target_folder;
        fitToComp( new_layer );
        
        //debug.log(item.duration);
    }
}
function claritizeSame( items ){
    var orig_target_folder_name = "1920x1080@23.976";
    var target_folder_name = "1920x1080@59.94";
    var w = 1920;
    var h = 1080;
    var a = 1;
    var r = 59.94;
    target_folder = app.project.items.addFolder( target_folder_name );
    orig_target_folder =  app.project.items.addFolder( orig_target_folder_name );

    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        var new_comp = app.project.items.addComp(item.name,w,h,1,item.duration,r);
        new_comp.parentFolder = target_folder;
        var new_layer = new_comp.layers.add(item);
        //new_layer.startTime = 1;
        
        item.parentFolder = orig_target_folder;
        fitToComp( new_layer );
        
        //debug.log(item.duration);
    }
}
function makineizeProjectNames( items ){
    var pcode = getProjectCode();
    
    for ( var i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        var pcodeloc = item.name.search( pcode );
        if( pcodeloc == -1 ){
            var old_name = getCompNameNoRev( item );
            //alert(getCompNameNoRev( item ));
            var rev = pad( getCompRevision( item ) , 2 );
            var new_name = pcode + "_[" + old_name + "]_" + rev;
            item.name = new_name;
        }
    }
    
}
function getCompNameNoRev( comp ){
    var name = String( comp.name );
    var exp = /\_[rv][0-9].*/i;
    var matches = name.match( exp );
    new_string = "";
    var result =  name;
    
    try{
        for ( i = 0 ; i < matches.length ; i ++ ){
            split_name = name.split( matches[i]);
            for ( j = 0 ; j < split_name.length ; j ++ ){
                new_string+=split_name[j];
            }
        }
            result = new_string; 
    }
    catch(err){
        
    }
    
    
    
    return result;
}
function getCompRevision( comp ){
    var name = String(comp.name);
    var exp = /\_[rv][0-9].*/i;
    var matches = name.match( exp );
    var result = 0;
    try{
        
        if ( matches.length > 0 )
        {
            var r = matches[0];
            var rev = r.split("_");
            result = rev[0]+"_"+rev[1];
        }
    }catch(err){
    }
    if( result != 0 ){
        result = "r"+pad(parseInt(String(rev[1]).substr(1,rev[1].length)),2);
    }
    else
    {
        result = "r00";
    }
    return result;
}
function getProjectCode(){
    file = app.project.file
    if ( file != null )
    {
        pcode = file.path.split("/")[3].split("_")[1];
    }
    else
    {
        alert("Save your project first, dummy.")
    }
    
    return pcode
}
function setRendersToProjectPath(){
    var q = app.project.renderQueue;
    //check the render queue item is not already rendered.
    
    for ( var i = 1 ; i <= q.numItems ; i ++ ){
        item = q.item(i);
        //3015 is QUEUED 
        //3013 is NEEDS_OUTPUT
        
        if ( (item.status == 3015) || (item.status == 3013) ){
            for ( var j = 1 ; j <= item.numOutputModules ; j ++ ){
                o_module = item.outputModule(j);
                var old_name = item.comp.name.replace(".","_");
                //alert(old_name);
                if ( o_module.file != null ){
                    
                    
                    var new_path = getOutputBasePath();
                    var new_folder = Folder( new_path );
                    if ( !new_folder.exists ){
                        new_folder.create();
                    }
                    alert(new_path + "/" + old_name)
                    var new_file = new File( new_path + "/" + old_name );
                    o_module.file = new_file ;
                    //alert ( new_path );
                    //o_module.file= new_file;
                    //alert( o_module.file );
                }
            }
        }
    }
}
function getTodayTag(){
    var today = new Date();
    var month_component = pad(String(today.getMonth()+1),2);
    var date_component = pad(today.getDate(),2);
    var full_year_component = String(today.getFullYear())
    var year_component = full_year_component.substr(full_year_component.length - 2,full_year_component.length );
    var tag = month_component + date_component + year_component
    return tag;
}
function getOutputBasePath(){
    var file = app.project.file;
    var file_path = String(app.project.file);
    var gfx_output_base = "05_Graphics_Output";
    var endtag_output_extra = "02_EndTags";
    var scene_output_extra = "01_GFX_Scenes";
    var vfx_output_base = "03_Composite_Outputs";
    var vfx_output_base;
    var gfx_string = "09_Graphics";
    var vfx_string = "08_Composite";
    var endtag_string = "EndTags";
    
    var search_gfx = file_path.search(gfx_string);
    var search_vfx = file_path.search(vfx_string);
    var search_endtag = file_path.search(endtag_string);
    var base_path;
    
    if ( search_gfx != -1 ){
        var base_path = file_path.substr(0,search_gfx+gfx_string.length)+"/"+gfx_output_base;
        if ( search_endtag != -1 ){
            base_path += "/" + endtag_output_extra;
        }
        base_path += "/" + scene_output_extra + "/" + getTodayTag();
    }
    
    if( search_vfx != -1 ){
        var base_path = file_path.substr(0,search_vfx+vfx_string.length)+"/"+vfx_output_base + "/" + getTodayTag();;
    }
    
    return base_path;
}
function incrementCompRevs( items ){
    for ( i = 0 ; i < items.length ; i ++ )
    {
        var item = items[i];
        
        
        alert(getCompRevision( items[i] ));
    }
    return true; 
}
function reRoute( items , search_str , replace_str ){
    for ( var i = 0 ; i < items.length ; i ++ ){
        var item = items[i];
        var new_file = new File ( String(item.file.path).replace( search_str , replace_str ) );
        alert ( item.replace(new_file) );
        //writeLn( String(item.file.path).replace( search_str , replace_str ));
        //writeLn( String(item.file.path));
    }    
}
function renderMarkers(){
	p = app.project;
	rq = p.renderQueue;
	rqi = rq.items;
	comp = p.activeItem;
	
	var myRenderNull = comp.layer("Render");
    if ( myRenderNull == null ){
        myRenderNull = app.project.activeItem.layers.addNull();
		myRenderNull.name = "Render";
		myRenderNull.inPoint = -1;
		myRenderNull.outPoint = -1;
		alert('Created "Render Stills" layer.\nAdd markers to this layer and run again to render stills.');
    }	
	
	markers= myRenderNull.property("Marker");
	
	for ( var j = 1 ; j <= markers.numKeys ; j ++ ){
		i = rqi.add( comp );
		var destPath = i.outputModule(1).file.path;
		i.outputModule(1).applyTemplate("PNG+");
		var markerName = markers.keyValue(j).comment;
		i.timeSpanStart = markers.keyTime(j);
		i.timeSpanDuration = comp.frameDuration;
		
		var destName = comp.name.replace(" ","_");
		
		var destFrame =  markers.keyTime(j) / comp.frameDuration;
		if ( markerName == "" ){
			i.outputModule(1).file = new File( destPath + "/" + destName + "_Still_f" + "[####]" )
		}else{
			i.outputModule(1).file = new File( destPath + "/" + destName + "_Still" + "_f[####]_" + markerName )
		}
		//alert( i.outputModule(1).file );
		//i.outputModule(1).includeSourceXMP = true;
	rq.render();	
	}
	//alert(i.timeSpanStart);
	//alert(i.timeSpanDuration);
	
}
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
				var new_items = getItems(item);
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
	app.beginUndoGroup("Flatten Folder Item");
	for ( var i = 0; i < items.length ; i ++){
		item = items[i];
		item.parentFolder = root;
	}
	app.endUndoGroup();
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
	return
	app.endUndoGroup()
}


//reRoute( getSelectedProjectItems() , "MAkinE/Wells%20Fargo" , "Wells Fargo"  )
//duplicateSuffix(getSelectedProjectItems (),"txtlss");
//suffix(getSelectedProjectItems (),"5s");
//replace(getSelectedProjectItems (),"00","0");
//duplicateReplace(getSelectedProjectItems (),"next\_", "");
//enforceDuration(getSelectedProjectItems (),5);
//checkDuration(getSelectedProjectItems (),5)
//claritizeSame(getSelectedProjectItems());
//fitToComp( app.project.activeItem.layer(1) );
//pTools.debug.log( app.project.file.path );
//makineizeProjectNames( getSelectedProjectItems() );
/*
p = getSelectedProjectItems();
for ( var i = 0 ; i < p.length ; i ++ ){
 pTools.debug.log( getCompRevision( p[i] ) );
}
*/
//setRendersToProjectPath()
//alert( getTodayTag() );
//getOutputBasePath();
//incrementCompRevs( getSelectedProjectItems() );

renderMarkers()

//alert(getSelectedProjectItems()[0].name)

//flatten( getAllItems( getSelectedProjectItems()[0] ) , getSelectedProjectItems()[0] );

