///sendMessage(string)
var str = argument0;
if(string_length(str) > 60) {
    sendDelayMessage(string_copy(str,61,string_length(str)-60),90);
    str = string_copy(str,0,60);
}
if(ds_list_size(global.message) == global.messageMaxSize) {
    ds_list_delete(global.message,0);
    for(var i = 0; i < global.messageMaxSize-1; i++) {
        global.messageDetail[i,0] = global.messageDetail[i+1,0];
        global.messageDetail[i,1] = global.messageDetail[i+1,1];
    }
    global.messageDetail[global.messageMaxSize-1,0] = 0;
    global.messageDetail[global.messageMaxSize-1,1] = "";
}
ds_list_add(global.message,str);
