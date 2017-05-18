///initGame
var locationFile = working_directory+"/locations.txt"
var i = 0;
var file = file_text_open_read(locationFile);
locationName = ds_list_create();
while(!file_text_eof(file)) {
    ds_list_add(locationName,file_text_readln(file));    
}
for(var i = 0; i < ds_list_size(locationName); i ++) { 
    locationInvestigated[i] = false;
}
file_text_close(file);
notes = ds_list_create();