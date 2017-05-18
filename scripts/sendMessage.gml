///sendMessage(string)
var str = argument0;
var loc = 0;
if(string_length(str) > 60) {
    while(string_length(str) > 0) {
        loc = autoStringCutLocation(str,60);
        //sendMessage(string_copy(str,61,string_length(str)-60));
        sendMessage(autoStringCut(str,60));
        str = string_copy(str,loc+1,string_length(str)-loc);
    }
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
    messageDetail[messageMaxSize-1,2] = gameFont;
}
ds_list_add(messageHistory,str);
ds_list_add(message,str);
