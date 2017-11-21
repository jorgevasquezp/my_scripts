project_items = app.project.items

searchFont = function ( font_name ){
for ( var i = 1; i <= project_items.length  ; i ++)
    {
        var item = project_items[i];
        if( item.typeName == "Composition" )
            {
                var comp = item;
                var comp = item;
                
                for ( var j = 1 ; j <= comp.numLayers ; j ++ )
                    {
                        var layer = comp.layer(j);
                        if (layer instanceof TextLayer)
                        {
                            if ( String(layer.sourceText.value.font).search( font_name ) != -1 )
                            {                        
                                layer.comment = "Contains " + font_name;
                                comp.comment = "Contains " + font_name;
                            }
                            // Layer is a text layer
                        }
                    } 
            }
    }
}

searchFont("GoodDog")
