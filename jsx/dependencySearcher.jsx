﻿//Walk the items.
search_string = "uni.";
project_items = app.project.items
for ( var i = 1; i <= project_items.length  ; i ++)
    {
        var item = project_items[i];
        if( item.typeName == "Composition" )
            {
                var comp = item;
                //alert( comp.name );
                var comp = item;
                for ( var j = 1 ; j <= comp.numLayers ; j ++ )
                    {
                        var layer = comp.layer(j);
                        if ( layer.matchName == "ADBE AV Layer") //Only go into layers... not cameras and lights.
                        {
                            var effects = layer.property("Effects");
                            //alert( comp.name + " , " + layer.name );
                            for ( var k = 1 ; k <= effects.numProperties ; k ++ )
                            {
                                var effect = effects.property(k);
                                if ( effect.name.search(search_string) != -1 )
                                {
                                    //alert()
                                    layer.comment = "Contains " + effect.name + " layer.";
                                    comp.comment = "Contains " + effect.name + " layer.";
                                }
                                //alert( comp.name + " , " + layer.name + " , " + effect.name );
                            }
                        }
                    }                    
            }
    }
