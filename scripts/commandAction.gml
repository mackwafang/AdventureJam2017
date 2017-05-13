///commandAction(string)
var str = argument0;
var keyWord = "";
sendMessage("-------------------------");
if(!global.gameStarted){ 
    if(string_lower(str) == "start") {
        repeat(global.messageMaxSize) sendDelayMessage("",1);
        sendDelayMessage("This game is a text-based adventure",60);
        sendDelayMessage("Use your imagination",60);
        sendDelayMessage("For a list of usable commands, type [commands]",120);
        repeat(10) sendDelayMessage("",2);
        sendDelayMessage("You live with your family in a distant village",90);
        sendDelayMessage("Everything seems very calm",90);
        sendDelayMessage("It is a new day",90);
        sendDelayMessage("You are at your house",90);
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
                    case 1: case 3: case 5: case 7: case 9: case 11:
                        global.currentLocation = 0;
                        sendMessage("You are outside");
                        if(global.currentLocation == 11) {global.breakin = false;}
                        if(global.days == 3) {
                            if(global.event[0] == 1 && timeOfDayString() != "Night") {
                                sendDelayMessage("There is a commotion in town",60);
                            }
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
               if(global.event[0] == 1) {
                    sendDelayMessage("They said someone was murdered last night",90);
                    sendDelayMessage("You decide to investigate the murder",90);
                    sendDelayMessage("[TUTORIAL]",60);
                    sendDelayMessage("[You can now investigate about the murder]",90);
                    sendDelayMessage("[by typing the command [investigate] in various locations]",90);
                }
                else {
                    sendDelayMessage("There is nothing to catch-up on",90);
                }
            }
            break;
        case "work":
            if(timeOfDayString() != "Night") {
                if(global.currentLocation == 3 || global.currentLocation == 5) {
                    sendMessage("You worked for the rest of the day");
                    if(global.stress < 150)  {
                        global.stress += 25;
                        getStressLevel();
                    }
                    if(global.stress > 120) {
                        global.timeOfDay ++;
                        global.money += 2;
                        sendMessage("You are too stressed to work, so you left work early.");
                        sendDelayMessage("You earned 2 golds",60);
                        sendDelayMessage("It is "+string(timeOfDayString()),60);
                        commandAction("leave");
                    }
                    else {
                        global.timeOfDay = 3;
                        global.money += 5;
                        sendMessage("You earned 5 golds");
                        sendDelayMessage("It is "+string(timeOfDayString()),60);
                        commandAction("leave");
                    }
                }
            }
            else {
                sendMessage("No work is being offered right now");
            }
            break;
        case "surrounding": case "current location":
            sendMessage("You are at "+string(ds_list_find_value(global.locationName,global.currentLocation)));
            break;
        case "game info":
            sendMessage(timeOfDayString()+" of the "+ordinalNumber(global.days)+" day");
            sendMessage(string(global.money)+" golds");
            sendMessage(getStressLevel());
            if(ds_list_size(global.inventory) > 0) {
                sendMessage("Inventory:");
                for(var i = 0; i < ds_list_size(global.inventory); i ++) {
                    assert(is_string(ds_list_find_value(global.inventory,i)));
                    sendMessage("   "+ds_list_find_value(global.inventory,i));
                }
            }
            break;
        case "notes":
            if(ds_list_size(global.notes) > 0) {
                for(var i = 0; i < ds_list_size(global.notes); i++) {
                    sendMessage(string(i+1)+". "+ds_list_find_value(global.notes,i));
                }
            }
            else {
                sendMessage("There is no important infomration so far");
            }
            break;
        case "investigate":
            switch(global.currentLocation) {
                case 0: //Outside
                    sendMessage("You asked a guard that was nearby");
                    sendDelayMessage("-------------------------",90);
                    if(global.event[0] == 1) {
                        global.locationInvestigated[0] = true;
                        sendDelayMessage("Guard: Someone got murdered last night. That's all I know. If you need to know more, ask the elder",60);
                    }
                    else {
                        sendDelayMessage("They said there is nothing to be worried about",90);
                    }
                    break;
                case 3: 
                    sendMessage("You asked the bartender in the tavern");
                    sendDelayMessage("-------------------------",90);
                    if(global.event[0] == 1) {
                        global.locationInvestigated[3] = true;
                        sendDelayMessage("You: What can you tell me about the man who was murdered?",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Bartender: Not much I'm afraid. He arrived here recently. Strange man, "+
                            "but he did pay for this room so I did not pay much attention to him",90);
                        global.discover++;
                    }
                    else {
                        sendDelayMessage("There weren't anything useful",60);
                    }
                    break;
                case 5:
                    sendMessage("You asked the shopkeeper some informations");
                    sendDelayMessage("-------------------------",90);
                    if(global.event[0] == 1) {
                        sendDelayMessage("You: Can you tell me anything about the person who was murdered?",60);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Keeper: That old drunk? He asked me for my silver dagger, you know. "
                            +"He wanted to buy it, but when I said no he stared to become very agitated. "
                            +"Luckily, one of the guards came by just then and showed him out. I've been armed since then.",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("You: Why did he want your silver dagger?",60);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Keeper: No idea. He didn't say. I'm surprised he even knew that I had one. "
                            +"I don't keep it in the shop, but in my house and good thing too. Otherwise, I'm pretty sure he would try to rob me.",90);
                        global.discover++;
                        if(!global.locationInvestigated[5] && global.event[0] == 1) {
                            sendDelayMessage("Your notes have been updated",90);
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[Important informations will be written in game notes]",60);
                            sendDelayMessage("[To access them, type [notes]]",60);
                            ds_list_add(global.notes,"The shopkeeper have a silver dagger");
                        }
                        global.locationInvestigated[5] = true;
                    }
                    else {
                        sendDelayMessage("There wasn't anything useful",90);
                    }
                    break;
                case 7: 
                    if(global.event[0] == 1) {
                        global.locationInvestigated[7] = true;
                        sendMessage("You asked the village elder about the murder");
                        sendDelayMessage("-------------------------",90);
                        sendDelayMessage("You: Do you know if the murder victim have any enemies?",60);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Elder: No, I do not. Forgive me young one. The shopkeeper might know, however."+
                        "Why don't you head over there to see if they know anything",60);
                    }
                    else {
                        sendDelayMessage("There wasn't anything useful",90);
                    }
                    break;
                case 11:
                    if(!checkInventory("silver dagger") && global.locationInvestigated[5]) {
                        global.locationInvestigated[11] = true;
                        sendMessage("You found the shopkeeper's silver dagger");
                        sendDelayMessage("Do you want to steal it?",30);
                        sendDelayMessage("[Type [yes] to take]",30);
                        sendDelayMessage("[Type [no] to leave it be]",30);
                    }
                    else {
                        sendMessage("There aren't anything unique in here");
                    }
                    break;
            }
            break;
        case "commands":
            /*
                List all command that can be used in the current situation/event
                
            */
            sendMessage("Current available commands");
            sendMessage("current location");
            sendMessage("game info");
            if(global.event[0] == 1) {
                sendMessage("investigate");
            }
            switch(global.currentLocation) {
                case 0:
                    sendMessage("go home");
                    sendMessage("go to:");
                    sendMessage("   tavern");
                    sendMessage("   shop");
                    sendMessage("   elder");
                    if(global.event[0] == 1) {
                        sendMessage("   murder scene");
                    }
                    break;
                case 1: 
                    sendMessage("sleep");
                    sendMessage("talk");
                    sendMessage("leave");
                    break;
                case 3:
                    if(timeOfDayString() == "Night") {
                        sendMessage("drink");
                    }
                    else {
                        sendMessage("work");
                    }
                    sendMessage("leave");
                    break;
                case 5:
                    sendMessage("work");
                    sendMessage("leave");
                    break;
                case 7:
                    sendMessage("leave");
                    break;
                case 11:
                    sendMessage("leave");
                    break;
                default:
                    break;
            }
            break;
        case "yes": 
            if(global.currentLocation == 11 && !checkInventory("Silver Dagger")) {
                if(global.locationInvestigated[11]){
                    sendMessage("You took the silver dagger");
                    ds_list_add(global.inventory,"Silver Dagger");
                }
            }
            break;
        case "no":
            if(global.currentLocation == 11 && !checkInventory("Silver Dagger")) {
                if(global.locationInvestigated[11]){
                    sendMessage("You left the dagger alone");
                }
            }
            break;
        case "break in":
            if(global.currentLocation == 5) {
                if(!global.breakin) {
                    if(irandom(0) == 0) {
                        sendDelayMessage("You are inside the shopkeeper's house",60);
                        global.currentLocation = 11;
                        global.breakin = true;
                    }
                    else {
                        sendDelayMessage("You got caught while trying to break into the house of the shopkeeper",90);
                        sendDelayMessage("You spent 2 days in jail",90);
                        sendDelayMessage("All of your money was confiscated",90);
                        sendDelayMessage("You are outside",90);
                        global.currentLocation = 0;
                        global.timeOfDay = 0;
                        global.money = 0;
                        global.days += 2;
                    }
                }
            }
            break;
        case "drink":
            if(global.currentLocation == 3 && timeOfDayString() == "Night") { 
                if(global.money > 0) {
                    sendMessage("You ordered a drink and gave the bartender a coin");
                    sendDelayMessage("You have "+string(--global.money)+" coin(s) left",60);
                    if(global.stress > 0) {global.stress -= 20;}
                    if(global.drunk < 100) {global.drunk += 20;}
                    switch(global.drunk) {
                        case 60:
                            sendDelayMessage("You start to feel dizzy",60);
                            break;
                        case 80:
                            sendDelayMessage("You are drunk",60);
                            break;
                        case 100:
                            sendDelayMessage("You are very drunk",60);
                            sendDelayMessage("You past out in the tavern",90);
                            global.timeOfDay = 0;
                            global.days++;
                            global.numMovements = 0;
                            global.currentLocation = 0;
                            global.drunk -= 100;
                            sendDelayMessage("It is a new day",60);
                            sendDelayMessage("You are outside of the tavern",60);
                            if(global.money > 0) {
                                if(irandom(4) == 0) {
                                    sendDelayMessage("You notice that all of your money is missing",90);
                                }
                            }
                            break;
                    }
                }
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
                global.drunk -= 80;
                /*if(irandom(4) == 0 || global.days == 3) {
                    global.event[0] = 1;
                    if(global.dreamChance < 100) {global.dreamChance += random_range(0.5,3);}
                    global.alive--;
                }*/
                sendDelayMessage("It is a new day.",90);
                if(!global.event[1]) {
                    if(global.days > 3 && checkInventory("Silver Dagger")) {
                        sendDelayMessage("You recall a dream from last night",90);
                        sendDelayMessage("Everything were in black and white",90);
                        sendDelayMessage("You were in someone's house",90);
                        sendDelayMessage("A body in laying inside",90);
                        sendDelayMessage("Everything else is a blur...",90);
                        ds_list_delete(global.inventory,ds_list_find_index(global.inventory,"Silver Dagger"));
                    }
                    //if(global.dreamChance > 5) {global.dreamChance -= 5;}
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
                        if(global.event[0] == 1) {
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
                        global.currentLocation = 5;
                        if(timeOfDayString() != "Night") {
                            sendMessage("You are at the shop");
                            sendDelayMessage("The shop is currently hiring",60);
                        }
                        else {
                            sendMessage("The shop is currently closed");
                        }
                        break;
                    case "murder scene":
                        break;
                    case "elder":
                        if(timeOfDayString() != "Night") {
                            global.currentLocation = 7;
                            sendMessage("You are at the elder's house");
                        }
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
                        if(global.timeOfDay > 3) {
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
