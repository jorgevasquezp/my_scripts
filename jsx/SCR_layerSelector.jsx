comp = app.project.activeItem;
function selectLayersByType(){
	layers = comp.layers;
	for ( var i = 1 ; i <= layers.length ; i++ ){
		layer = layers[i];
		if ( layer.threeDLayer == true ){
			layers[i].selected = true;
		}
	}
}

selectLayersByType();

//alert( comp.selectedLayers[0].threeDLayer );
