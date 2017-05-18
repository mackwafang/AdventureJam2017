///sendDelayMessage(string,delay)
/*
    string: string of the message
    delay: how long until the next message appear
*/
var str = argument0;
var delay = argument1;
var loc = 0;
if(string_length(str) > 60) { // if string is larger than size allowed
    while(string_length(str) > 0) { //while string size is > 0
        loc = autoStringCutLocation(str,60);
        ds_queue_enqueue(messageDelayQueue,autoStringCut(str,60),loc,gameFont); //enqueue the appropiate string
        str = string_copy(str,loc+1,string_length(str)-loc); //reduce the string
    }
    //ds_queue_enqueue(messageDelayQueue,string_copy(str,61,string_length(str)-60));
}
else {
    ds_queue_enqueue(messageDelayQueue,str,delay,gameFont);
}
