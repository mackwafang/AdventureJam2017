///commandAction(string)
var str = argument0;
var keyWord = "";
sendMessage("-------------------------");
if(!global.gameStarted){ 
    if(string_lower(str) == "start") {
        repeat(global.messageMaxSize) sendDelayMessage("",5);
        sendDelayMessage("This game is a text-based adventure",60);
        sendDelayMessage("Use your imagination",60);
        sendDelayMessage("For a list of usable commands, type [commands]",60);
        sendDelayMessage("",120);
        repeat(9) sendDelayMessage("",5);
        sendDelayMessage("You live with your family in a distant village",60);
        sendDelayMessage("There is a tavern, shop and a forge",60);
        sendDelayMessage("",120);
        repeat(9) sendDelayMessage("",5);
        sendDelayMessage("It is a new day",60);
        sendDelayMessage("You are at your house",60);
        global.gameStarted = true;
    }
    else {
        sendMessage("Command ["+str+"] is invalid");
    }
}
else {
    switch(string_lower(str)) {
        case "leave":
            if((global.currentLocation mod 2) == 1) {
                switch(global.currentLocation) {
                    case 1: case 3: case 5:
                        global.currentLocation = 0;
                        sendMessage("You are outside");
                        if(global.murder && timeOfDayString() != "Night") {
                            sendDelayMessage("There is a commotion in town",60);
                        }
                        break;
                    default:
                        show_error("Location "+string(global.currentLocation)+" does not exists",true);
                        break;
                }
            }
            break;
        case "talk":
            if(global.currentLocation == 1) {
                sendMessage("You talked to your family");
               if(global.murder) {
                    sendDelayMessage("They said someone was murdered last night",90);
                    sendDelayMessage("You decide to investigate the murder",90);
                    sendDelayMessage("[TUTORIAL]",60);
                    sendDelayMessage("[You can now investigate about the murder]",90);
                    sendDelayMessage("[by typing the command [investigate] in various locations]",90);
                }
                else {
                    sendDelayMessage("REST OF TALKING TO FAMILY DIALOGUE HERE",90);
                }
            }
            break;
        case "work":
            if(global.currentLocation == 3 || global.currentLocation == 5) {
                sendMessage("You worked for the rest of the day");
                global.timeOfDay = 3;
                global.money += 5;
                sendMessage("You earned 5 golds");
                sendDelayMessage("It is "+string(timeOfDayString()),60);
                commandAction("leave");
            }
            break;
        case "surrouding": case "current location":
            sendMessage("You are at "+string(ds_list_find_value(global.locationName,global.currentLocation)));
            break;
        case "game info":
            sendMessage(timeOfDayString()+" of the "+ordinalNumber(global.days)+" day");
            sendMessage(string(global.money)+" golds");
            break;
        case "investigate":
            switch(global.currentLocation) {
                case 0: //Outside
                    sendMessage("You asked a guard that was nearby");
                    if(global.murder) {
                        sendDelayMessage("Guard: ",90);
                    }
                    else {
                        sendDelayMessage("They said there is nothing to be worried about",90);
                    }
                    break;
                case 3: 
                    sendMessage("You asked the bartender in the tavern");
                    sendDelayMessage("-------------------------",60);
                    if(global.murder) {
                        sendDelayMessage("You: What can you tell me about the man who was murdered?",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Bartender: Not much I'm afraid. He arrived here recently. Strange man, "+
                            "but he did pay for this room so I did not pay much attention to him",90);
                        sendDelayMessage("-------------------------",60);
                        global.discover++;
                    }
                    else {
                        sendDelayMessage("There weren't anything useful",60);
                    }
                    break;
                case 5:
                    sendMessage("You asked the shopkeeper some informations");
                    if(global.murder) {
                        sendDelayMessage("You: Can you tell me anything about the person who was murdered?",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Keeper: That old drunk? He asked me for my silver dagger, you know. "
                            +"He wanted to buy it, but when I said no he stared to become very agitated. "
                            +"Luckily, one of the guards came by just then and showed him out. I've been armed since then.",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("You: Why did he want your silver dagger?",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Keeper: No idea. He didn't say. I'm surprised he even knew that I had one. "
                            +"I don't keep it in the shop, but in my house and good thing too. Otherwise, I'm pretty sure he would try to rob me.",90);
                        sendDelayMessage("-------------------------",60);
                        global.discover++;
                    }
                    else {
                        sendDelayMessage("There wasn't anything useful",90);
                    }
                    break;
            }
            break;
        case "commands":
            /*
                List all command that can be used in the current situation/event
                
            */
            sendMessage("Current available commands");
            switch(global.currentLocation) {
                case 0:
                    if(global.murder) {
                        sendMessage("investigate");
                    }
                    sendMessage("go home");
                    sendMessage("go to:");
                    sendMessage("   tavern");
                    sendMessage("   shop");
                    if(global.murder) {
                        sendMessage("   murder scene");
                    }
                    break;
                case 1: 
                    sendMessage("sleep");
                    sendMessage("talk");
                    if(global.murder && global.timeOfDay == 0) {
                        sendMessage("investigate");
                    }
                    sendMessage("leave");
                    break;
                case 3:
                    sendMessage("work");
                    if(global.murder) {
                        sendMessage("investigate");
                    }
                    if(timeOfDayString() == "Night") {
                        sendMessage("drink");
                    }
                    sendMessage("leave");
                    break;
                default:
                    break;
            }
            break;
        case "go home":
            global.currentLocation = 1;
            sendMessage("You are at home");
            break;
        case "sleep":
            if(global.currentLocation == 1) {
                sendMessage("You went to sleep");
                global.timeOfDay = 0;
                global.days++;
                global.numMovements = 0;
                global.murder = false;
                if(irandom(4) == 0 || global.days == 3) {
                    global.murder = true;
                    if(global.dreamChance < 100) {global.dreamChance += 0.6;}
                    global.alive--;
                }
                sendDelayMessage("It is a new day.",90);
                if(irandom(100-global.dreamChance) <= 0 || global.days == 5) {
                    sendDelayMessage("You recall a dream from last night",90);
                    sendDelayMessage("Everything were in black and white",90);
                    sendDelayMessage("You were in someone's house",90);
                    sendDelayMessage("A body in laying inside",90);
                    sendDelayMessage("Everything else is a blur...",90);
                    if(global.dreamChance > 5) {global.dreamChance -= 5;}
                }
            }
            else {
                sendMessage("There is no where to sleep on...");
            }
            break;
        default:
            /*       GO       */
            if(string_copy(str,0,5) == "go to") {
                /*
                Usage:
                    go [locationName]
                */
                keyWord = "go to";
                var moved = true;
                var subCommand = string_lower(string_copy(str,string_length(keyWord)+2,string_length(str)-4));
                switch(subCommand) {
                    case "tavern":
                        global.currentLocation = 3;
                        sendMessage("You are at the tavern");
                        if(global.murder) {
                            sendDelayMessage("You have been hearing a rumor at the tavern",60);
                        }
                        if(timeOfDayString() != "Night") {
                            sendDelayMessage("The tavern is currently hiring",60);
                        }
                        else {
                            sendDelayMessage("The tavern is filled with people",60);
                            sendDelayMessage("You can drink at the bar to relief some stress",60);
                        }
                        break;
                    case "shop":
                        if(global.timeOfDay != 3) {
                            global.currentLocation = 5;
                            sendMessage("You are at the shop");
                        }
                        else {
                            sendMessage("The shop is currently closed");
                        }
                        break;
                    case "murder scene":
                        break;
                    default:
                        moved = false
                        sendMessage("Location ["+string(subCommand)+"] does not exists");
                        break;
                }
                if(moved) {
                    if(global.numMovements < 3) {
                        global.numMovements++
                    }
                    else {
                        global.numMovements = 0;
                        global.timeOfDay++;
                        if(global.timeOfDay == 0) {
                            sendMessage("It is a new day");
                            global.days++;
                        }
                        sendMessage("It is "+timeOfDayString());
                    }
                }
                break;
            }
            sendMessage("Command ["+str+"] is invalid");
            break;
    }
}
cmdString = "";
