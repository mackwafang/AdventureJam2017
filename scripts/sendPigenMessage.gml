///sendPigenMessage
var str = argument0;
if(string_length(str) > 60) {
    sendPigenDelayMessage(string_copy(str,61,string_length(str)-60),90);
    str = string_copy(str,0,60);
}
if(ds_list_size(message) >= messageMaxSize) {
    ds_list_delete(message,0);
    for(var i = 0; i < messageMaxSize-1; i++) {
        for(var j = 0; j < array_length_2d(messageDetail,i); j++){
            messageDetail[i,j] = messageDetail[i+1,j];
        }
    }
    messageDetail[messageMaxSize-1,0] = 0;
    messageDetail[messageMaxSize-1,1] = "";
    messageDetail[messageMaxSize-1,2] = pigenFont;
}
ds_list_add(messageHistory,str);
ds_list_add(message,str);
