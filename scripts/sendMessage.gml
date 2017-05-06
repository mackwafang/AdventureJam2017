///sendMessage(string)
str = argument0;
if(ds_list_size(global.message) == global.messageMaxSize) {
    ds_list_delete(global.message,0);
    for(var i = 0; i < global.messageMaxSize-1; i++) {
        global.messageDetail[i,0] = global.messageDetail[i+1,0];
        global.messageDetail[i,1] = global.messageDetail[i+1,1];
    }
}
ds_list_add(global.message,str);
