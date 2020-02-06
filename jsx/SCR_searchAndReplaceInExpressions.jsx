proj = app.project.activeItem;
layers = proj.selectedLayers;
search_string = 'comp("##DSDC036_Colors##").layer("Colors").effect(" ';
replace_string = 'comp("##DSDC036_Colors##").layer("';


for ( var i = 0; i < layers.length ; i ++ ){
	var layer = layers[i];
	var properties = layer.selectedProperties;
	for ( var j = 0 ; j < layer.selectedProperties.length ; j ++ ){
        var property = properties[j];
        if ( property.canSetExpression ){
		property.expression = property.expression.replace(search_string,replace_string);
        }
	}
	
}

