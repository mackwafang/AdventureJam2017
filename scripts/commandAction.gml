///commandAction(string)
var str = argument0;
var keyWord = "";
sendMessage("-------------------------");
switch(string_lower(str)) {
    case "leave":
        if((global.currentLocation mod 2) == 1) {
            switch(global.currentLocation) {
                default:
                    show_error("Location "+string(global.currentLocation)+" does not exists",true);
                    break;
            }
        }
        break;
    case "game info":
        sendMessage("Day "+string(global.days));
        break;
    case "sleep":
        if(global.currentLocation == 1) {
            sendMessage("You went to bed");
            global.timeOfDay = 0;
            global.days++;
            sendDelayMessage("It is a new day.");
            if(irandom(global.dreamChance-1) <= 0) {
                sendDelayMessage("You recall a dream from last night");
                sendDelayMessage("Everything were in black and white");
                sendDelayMessage("You were in someone's house");
                sendDelayMessage("A body in laying inside");
                sendDelayMessage("Everything else is a blur...");
                if(global.dreamChance > 0) {global.dreamChance -= 5;}
            }
        }
        break;
    default:
        /*       GO       */
        if(string_copy(str,0,2) == "go") {
            /*
            Usage:
                go [locationName]
            */
            keyWord = "go"
            var subCommand = string_lower(string_copy(str,4,string_length(str)-3));

            break;
        }
        sendMessage("Command ["+str+"] is invalid");
        break;
}
cmdString = "";
