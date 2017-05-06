///sendDelayMessage(string)
str = argument0;
ds_queue_enqueue(global.messageDelayQueue,str);
