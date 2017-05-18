///commandAction(string)
var str = argument0;
var keyWord = "";
sendMessage("-------------------------");
if(!gameStarted){ 
    if(getName) {
        switch(string_lower(str)) {
            case "yes":
                getName = !getName;
                repeat(60) sendDelayMessage("",2);
                sendPigenDelayMessage("",2);
                sendPigenDelayMessage("TUNITY FOR CROQUET THE MOUSE WAS SHE FIRST SENTENCE OF HEARTS WHO SAID THE LIST AWAY WENT STATE MUCH FRIGHTED TO HER OR THE END",60);
                sendPigenDelayMessage(string_upper(playerName)+" HAVE MADE THE PACT WITH THE DEVIL",60);
                sendPigenDelayMessage("BECAUSE OF YOUR INSANITY YOU HAVE MADE THE PACT WITH THE DEVEL SO THAT YOU CAN BE SANE AND KEEP YOUR FAMILY",60);
                sendPigenDelayMessage("YOU MUST KILL TO MAINTAIN THIS POWER",60);
                sendPigenDelayMessage("IF YOU WERE TO BE EXORICISED YOU WILL DIE",60);
                sendPigenDelayMessage("IN THAT ATTERING TO LOOKING HERS BEGGED SINCE SHOOK UP THE CEILING THE BANK AND THAT THE MET IN SAID TO DO THE GREAT SHE RIGHT WHICH WAY WHITE RABBIT BLEW THREE",60);
                sendPigenDelayMessage("NOW GO PERFORM YOUR TASK",120);
                repeat(60) sendDelayMessage("",2);
                sendDelayMessage("You live with your family in a distant village",90);
                sendDelayMessage("Everything seems very calm",90);
                sendDelayMessage(timeOfDayString()+" of the "+ordinalNumber(days)+" day",90);
                sendDelayMessage("You are at your house",90);
                sendDelayMessage("[TUTORIAL]",60);
                sendDelayMessage("[When you are at home, talking to your family can provide some information]",60);
                sendDelayMessage("[Type [talk] to talk to them]",60);
                sendDelayMessage("[You can only sleep at home, you can sleep at any time of day]",60);
                sendDelayMessage("[Type [sleep] to sleep]",60);
                gameStarted = true;
                break;
            case "no":
                sendMessage("Enter a different name");
                break;
            default:
                playerName = str;
                sendMessage("Is "+str+" you name?");
                sendDelayMessage("[Type [yes] or [no]]",30);
                break;
        }
    }
    else {
        if(string_lower(str) == "start") {
            repeat(messageMaxSize) sendDelayMessage("",1);
            sendDelayMessage("This game is a text-based adventure",60);
            sendDelayMessage("Use your imagination",60);
            sendDelayMessage("For a list of usable commands, type [commands]",120);
            sendDelayMessage("Enter your name",90);
            getName = true;
        }
        else {
            sendMessage("Command ["+str+"] is invalid");
        }
    }
}
else {
    switch(string_lower(str)) {
        case "leave":
            if((currentLocation mod 2) == 1) {
                switch(currentLocation) {
                    case 1: case 3: case 5: case 7: case 9: case 11:
                        currentLocation = 0;
                        sendMessage("You are outside");
                        if(currentLocation == 11) {breakin = false;}
                        if(days == 1 && timeOfDayString() == "Morning") {
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[You can go to various locations in town or see what other things you can do]",60);
                            sendDelayMessage("[Type [commands] to see list of available commands]",60);
                        }
                        if(days == 2) {
                            if(event[0] == 1 && timeOfDayString() != "Night") {
                                sendDelayMessage("There is a commotion in town",60);
                            }
                        }
                        break;
                    default:
                        show_error("Location "+string(currentLocation)+" does not exists",true);
                        break;
                }
            }
            break;
        case "talk":
            if(currentLocation == 1) {
                sendMessage("You talked to your family");
                sendDelayMessage("They said that the shop and tavern is looking for workers",60);
                if(event[2] == 1) {
                    familyAlive[0] = false;
                    alive--;
                    sendDelayMessage("Your son did not came back last night",60);
                    sendDelayMessage("You became anxious",60);
                    break;
                }
                if(event[0] == 1) {
                    sendDelayMessage("They said someone was murdered last night",90);
                    sendDelayMessage("You decide to investigate the murder",90);
                    if(days == 2) {
                        sendDelayMessage("[TUTORIAL]",60);
                        sendDelayMessage("[You can now investigate about the murder]",90);
                        sendDelayMessage("[by typing the command [investigate] in various locations]",90);
                    }
                    break;
                }
                /*else {
                    sendDelayMessage("There is nothing to catch-up on",90);
                }*/
            }
            break;
        case "work":
            if(timeOfDayString() != "Night") {
                if(currentLocation == 3 || currentLocation == 5) {
                    sendMessage("You worked for the rest of the day");
                    if(stress < 150)  {
                        stress += 25;
                        getStressLevel();
                    }
                    if(stress > 120) {
                        timeOfDay ++;
                        money += 2;
                        sendDelayMessage("You are too stressed to work, so you left work early.",60);
                        sendDelayMessage("You earned 2 golds",60);
                        sendDelayMessage("It is "+string(timeOfDayString()),60);
                        commandAction("leave");
                    }
                    else {
                        timeOfDay = 3;
                        numMovement = 0;
                        money += 5;
                        sendDelayMessage("You earned 5 golds",60);
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
            sendMessage("You are at "+string(ds_list_find_value(locationName,currentLocation)));
            break;
        case "game info":
            sendMessage(timeOfDayString()+" of the "+ordinalNumber(days)+" day");
            sendMessage(string(money)+" golds");
            sendMessage(getStressLevel());
            if(ds_list_size(inventory) > 0) {
                sendMessage("Inventory:");
                for(var i = 0; i < ds_list_size(inventory); i ++) {
                    assert(is_string(ds_list_find_value(inventory,i)));
                    sendMessage("   "+ds_list_find_value(inventory,i));
                }
            }
            break;
        case "notes":
            if(ds_list_size(notes) > 0) {
                for(var i = 0; i < ds_list_size(notes); i++) {
                    if(ds_list_find_value(notes,i) == string_upper(playerName)) {
                        sendPigenMessage("  "+ds_list_find_value(notes,i));
                    }
                    else {
                        sendMessage(">  "+ds_list_find_value(notes,i));
                    }
                }
            }
            else {
                sendMessage("There is no important infomration so far");
            }
            break;
        case "investigate":
            switch(currentLocation) {
                case 0: //Outside
                    sendMessage("You asked a guard that was nearby");
                    sendDelayMessage("-------------------------",90);
                    if(event[0] == 1) {
                        if(!checkInventory("Priest's paper") && !checkInventory("Encrypted Message") && !checkInventory("Decrypted Message")) {
                            sendDelayMessage("Guard: Someone got murdered last night. That's all I know. If you need to know more, ask the elder",60);
                        }
                    }
                    if (event[2] == 1 && !familyAlive[0]) {
                        sendDelayMessage("You spend the whole day to look for your son.",60);
                        sendDelayMessage("You still do not know where is his whereabout",60);
                        sendDelayMessage("You: I should find the elder",60);
                        timeOfDay = 3;
                        sendDelayMessage("It is "+string_lower(timeOfDayString())+" of the "+ordinalNumber(days)+" day",90);
                    }
                    else {
                        sendDelayMessage("They said there is nothing to be worried about",90);
                    }
                    break;
                case 3: 
                    sendMessage("You asked the bartender in the tavern");
                    sendDelayMessage("-------------------------",90);
                    if(event[0] == 1) {
                        locationInvestigated[3] = true;
                        sendDelayMessage("You: What can you tell me about the man who was murdered?",90);
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Bartender: Not much I'm afraid. He arrived here recently. Strange man, "+
                            "but he did pay for this room so I did not pay much attention to him",90);
                        discover++;
                    }
                    else {
                        sendDelayMessage("There weren't anything useful",60);
                    }
                    break;
                case 4:
                    if(event[0] == 1) {
                        if(timeOfDayString() != "Night") {
                            sendDelayMessage("There is too many people looking, maybe return here at another time",60);
                        }
                        else if(!locationInvestigated[4]){
                            sendMessage("You look around at the murder scene");
                            sendDelayMessage("You found a small piece of paper with a message in it",60);
                            noteUpdateMessage();
                            ds_list_add(notes,"Message found on priest: "+addSpace(35)+
                                "HIQSR TSWWIWWMSR"+addSpace(44)+
                                "XEVKIX: QEPI"+addSpace(48)+
                                "SGGYTEXMSR: JVIIPERGI"+addSpace(39)+
                                "PMZIW AMXL E JEQMPC"+addSpace(41)+
                                "IBGSVGMWI SV OMPP");
                            ds_list_add(inventory,"Priest's paper");
                            locationInvestigated[4] = true;
                        }
                        else {
                            sendDelayMessage("You look around at the murder scene",60);
                            sendDelayMessage("There weren't anything useful",60);
                        }
                    }
                    break;
                case 5:
                    sendMessage("You asked the shopkeeper some informations");
                    sendDelayMessage("-------------------------",90);
                    if(event[0] == 1) {
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
                        discover++;
                        if(!locationInvestigated[5] && event[0] == 1) {
                            sendDelayMessage("[System: Your notes have been updated]",90);
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[Important informations will be written in game notes]",60);
                            sendDelayMessage("[To access them, type [notes]]",60);
                            ds_list_add(notes,"The shopkeeper have a silver dagger");
                        }
                        locationInvestigated[5] = true;
                    }
                    else {
                        sendDelayMessage("There wasn't anything useful",90);
                    }
                    break;
                case 7: 
                    if(event[0] > 0) {
                        locationInvestigated[7] = true;
                        switch(days) {
                            case 2: 
                                sendMessage("You asked the village elder about the murder");
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("You: Do you know if the murder victim have any enemies?",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("Elder: No, I do not. Forgive me young one. The shopkeeper might know, however."+
                                "Why don't you head over there to see if they know anything",60);
                                break;
                            case 3:
                                sendMessage("You asked the village elder about the murder");
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("You: Do you have any new informations about the person that was murdered yesterday?",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("Elder: Yes, we got some information about the victim",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("Elder: The man is a foreign priest. We tends to see him around when he is on vacation "+
                                    "but he appears to be here for work.",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("You: Work?",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("Elder: He hunt demons, there have been several cases happened in the surrounding villages",90);
                                noteUpdateMessage();
                                ds_list_add(notes,"The first victom is a priest that work as a demon hunter.");
                                break;
                            case 4:
                                sendMessage("You come to the elder's house");
                                if(!checkInventory("Guard's Message") && checkInventory("Decrypted Message")) {
                                    sendDelayMessage("You: Elder, I have some information about the priest that was murdered",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: Yes, what do you know?",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("You: It looks like the priest is here for work, excorcising someone who is possessed.",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: I see. Lets assume his target is here in this town, is there a description?",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("You: Yes, his target is a male freelancer, who lives with a family",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: Thank you, I will keep an eye out",60);
                                    sendDelayMessage("Elder: Anyway, we got some bad news",60);
                                }
                                else {
                                    sendDelayMessage("Elder: Ah, there you are. We got some bad news",60);
                                }
                                sendDelayMessage("Elder: One of our guards is killed, he left a dying message about the murderer",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("You: What is the message?",60);
                                sendDelayMessage("-------------------------",60);
                                sendDelayMessage("Elder: He wrote it on the ground and we made a copy of it. It seems to be another secret message. "+
                                    "Go over to the scholar and see if they can solve it",60);
                                noteUpdateMessage();
                                sendDelayMessage("-------------------------",60);                                    
                                sendDelayMessage("You: I will get on that, elder.",60);
                                ds_list_add(inventory,"Guard's Encrypted Message");
                                ds_list_add(notes,"Guard's Message");
                                ds_list_add(notes,string_upper(playerName));
                                break;
                            case 5:
                                if(timeOfDayString() == "Night") {
                                    sendDelayMessage("You: Elder, my son have not returned yet. Do you know where he is?",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: I'm afraid not, my apologies. Have you asked the guards?",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("You: Yes, I asked the whole town",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: Hm...I'm afraid there is nothing I can do. I will send a message to neighboring villages to see if they see the boy.",60);
                                    /*EVENT: MISSING SON*/
                                }
                                break;
                            default:
                                if(locationInvestigated[4]) {
                                    sendMessage("You asked the village elder about the message");
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("You: I've found this piece of paper that contained a message. "+
                                        "Do you know how to crack the messge?",60);
                                    sendDelayMessage("-------------------------",60);
                                    sendDelayMessage("Elder: I'm afraid not. Perhaps consult with the town's scholar, they might know something. "+
                                        "They should be in the library.",60);
                                }
                                break;
                        }
                    }
                    else {
                        sendDelayMessage("There wasn't anything useful",90);
                    }
                    break;
                case 9:
                    sendMessage("You asked the village's scholar for some information");
                    sendDelayMessage("-------------------------",60);
                    if(checkInventory("Priest's paper")) {
                        sendDelayMessage("You: I've found this message, what this this mean?",60);
                        sendDelayMessage("You gave the scholar the piece of paper",60);
                        ds_list_delete(inventory,ds_list_find_index(inventory,"Priest's paper"));
                        sendDelayMessage("Scholar: This seems to be an encrypted message, I've read about this type of encryption somewhere"+
                            ", but I forgot where the book is. You're welcome to look around",60);
                        ds_list_add(inventory,"Encrypted Message");
                    }
                    else if (checkInventory("Encrypted Message")) {
                        if (!locationInvestigated[9]) {
                            isReading = true;
                            sendDelayMessage("The scholar points you to some books on secret messages",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("Pigen Cipher",60);
                            sendDelayMessage("A simple geometric subtitution cipher which exchange letters for symbols which are "+
                                "fragments of a grid",60);
                            sendDelayMessage("Plain Text:",60);
                            sendDelayMessage("    ABCDEFGHIJKLMNOPQRSTUVWXYZ",60);
                            sendDelayMessage("Cipher Text:",60);
                            sendPigenDelayMessage("  ABCDEFGHIJKLMNOPQRSTUVWXYZ",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("Continue reading?"+addSpace(43)+"[Type [yes] or [no]]",60);
                            sendDelayMessage("-------------------------",60);
                            locationInvestigated[9] = true;
                        }
                        else {
                            sendDelayMessage("You spend a few hours trying to decrypt the message",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("You have decypted the message",60);
                            noteUpdateMessage();
                            ds_list_replace(inventory,ds_list_find_index(inventory,"Encrypted Message"),"Decrypted Message");
                            timeOfDay += 2;
                            if(timeOfDay >= 4) {
                                timeOfDay = timeOfDay mod 4;
                                days ++;
                            }
                            ds_list_replace(notes,ds_list_find_index(notes,"Message found on priest: "+addSpace(35)+
                                    "HIQSR TSWWIWWMSR"+addSpace(44)+
                                    "XEVKIX: QEPI"+addSpace(48)+
                                    "SGGYTEXMSR: JVIIPERGI"+addSpace(39)+
                                    "PMZIW AMXL E JEQMPC"+addSpace(41)+
                                    "IBGSVGMWI SV OMPP"),"Message found on priest: "+addSpace(35)+
                                    "DEMON POSSESSION"+addSpace(44)+
                                    "TARGET: MALE"+addSpace(48)+
                                    "OCCUPATION: FREELANCE"+addSpace(39)+
                                    "LIVES WITH A FAMILY"+addSpace(41)+
                                    "EXCORCISE OR KILL");
                            sendDelayMessage("It is "+string_lower(timeOfDayString())+" of the "+ordinalNumber(days)+" day",90);
                        }
                    }
                    else if (checkInventory("Guard's Encrypted Message")) {
                            sendDelayMessage("You spend a few hours trying to decrypt the message",60);
                            sendDelayMessage("-------------------------",60);
                            repeat(25) sendDelayMessage("",1);
                            sendPigenDelayMessage("JURY IN ALL THESE WORDS DRINK ME BEAUTIFULLY PAINTING MORE NOR LESS SAID THE BABY—A LAST RESOURCE SHE GAVE ONE "+
                                "SHE REMAINED TO PUT THE SIDE A RUSH AT THEM SOMETHING IS SO OUTOFTHEBOX UPSETTLED INTO A PACK ONCE TO BE",60);
                            sendPigenDelayMessage("IM NOT PROCESSION ANOTHER LATER",60);
                            sendPigenDelayMessage(string_repeat("AH",30),60);
                            sendPigenDelayMessage("MORTAL, LET ME REMIND YOU OF YOUR DUTY",60);
                            sendPigenDelayMessage("KILL WHOEVER YOU SEE",60);
                            sendPigenDelayMessage("THIS SANITY IS YOURS",60);
                            sendPigenDelayMessage("CONSEQUENCES WILL HAPPEN IF YOU STOP",60);
                            sendPigenDelayMessage("YOU HAVE BEEN WARNED",60);
                            sendPigenDelayMessage("A BARROW ESCAPE WHEN IT IM A I DONT WANT TO SOMEBODY MIND SHE OF CONVERSATION SHE WOULD BEND OF HER HAS JUST BEEN "+
                                "ANYTHING OR A WORLD GO WITHOUT A THOUSAND THE CATERPILLAR THE ENTRANCE OF HER OF TEARS I SHALL BE A GOOD NEAR THE PRIZES QUITE KIDGLOVES "+
                                "A MARY ANN ANOTHER SIDE OF THE GARDEN AMONG WORDS HE STARTLED TURNING IT IN LARGE AS TOO SMALL BUT IT AFTER WERE THE DUCK",60);
                            sendPigenDelayMessage("FOR THE CORNER OF THIS MOMENT A TINY GOLDEN KEY WAS LABEL WITH HIS MOMENT AIR ITS—HOLD YOU LIKE THE BRASS PLATE TO SEE IT "+
                                "TRYING EVERY EASY TO WINK WITH A PLEASE YOUR OR SOME OF THE GRASS BUT THEY WERE COULD NO IDEA WHAT THE FANCIED SOFTLY AFTER WERE THROUGHT HER HEAD MUST BEGIN",60);
                            sendPigenDelayMessage("ALICE GUESS THAT SHE MIGHT WHAT IT WAS IN REPLIED HEDGE IN AND TWO OR THREE WHAT LAY CROQUET WITH WONT IT BE NERVOUS OR SHE LOOKED THE RABB",180);
                            repeat(25) sendDelayMessage("",1);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("You: What was that?",60);
                            sendDelayMessage("You: Something is wrong with me...",60);
                            sendDelayMessage("You: I must be loosing sleep",60);
                            sendDelayMessage("-------------------------",60);
                            sendDelayMessage("You have decypted the message",60);
                            sendDelayMessage("You: Huh?",60);
                            sendDelayMessage("You: This can't be right",60);
                            sendDelayMessage("You: Why does the message spells out my name?",60);
                            noteUpdateMessage();
                            ds_list_replace(inventory,ds_list_find_index(inventory,"Guard's Encrypted Message"),"Guard's Decrypted Message");
                            timeOfDay += 2;
                            if(timeOfDay >= 4) {
                                timeOfDay = timeOfDay mod 4;
                                days ++;
                            }
                            ds_list_delete(notes,ds_list_find_index(notes,string_upper(playerName)));
                            ds_list_replace(notes,ds_list_find_index(notes,"Guard's Message"),"Guard's Message"+addSpace(45)+playerName);
                            sendDelayMessage("It is "+string_lower(timeOfDayString())+" of the "+ordinalNumber(days)+" day",90);
                    }
                    else {
                        sendDelayMessage("There weren't anything useful",60);
                    }
                    break;
                case 11:
                    if(!checkInventory("silver dagger") && locationInvestigated[5]) {
                        locationInvestigated[11] = true;
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
            if(event[0] == 1) {
                sendMessage("investigate");
            }
            switch(currentLocation) {
                case 0: case 4:
                    sendMessage("go home");
                    sendMessage("go to:");
                    sendMessage("   tavern");
                    sendMessage("   library");
                    sendMessage("   shop");
                    sendMessage("   elder");
                    if(event[0] == 1) {
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
                    if(locationInvestigated[5]) {
                        sendMessage("break in");
                    }
                    sendMessage("leave");
                    break;
                case 7:
                    sendMessage("leave");
                    break;
                case 9:
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
            if(yesNoPrompt) {
                if(currentLocation == 11 && !checkInventory("Silver Dagger")) {
                    if(locationInvestigated[11]){
                        sendMessage("You took the silver dagger");
                        ds_list_add(inventory,"Silver Dagger");
                        yesNoPrompt = false;
                    }
                }
            }
            if(isReading) {
                readingPage++;
                switch(readingPage) {
                    case 1: 
                        sendDelayMessage("-------------------------",60);
                        sendDelayMessage("Caesar Cipher",60);
                        sendDelayMessage("One of the simplist method of encryption. To encrypt a message, "+
                            "replace every character in the message with another character located in a fixed "+
                            "number down the alphabet.",60);
                        sendDelayMessage("  Example: 13 character shifts",60);
                        sendDelayMessage("      Plain text: To be or not to be",60);
                        sendDelayMessage("      Encrypted text: Gb or be abg gb or",60);
                        commandAction("no");
                        event[1]++;
                        break;
                }
            }
            break;
        case "no":
            if(yesNoPrompt) {
                if(currentLocation == 11 && !checkInventory("Silver Dagger")) {
                    if(locationInvestigated[11]){
                        sendMessage("You left the dagger alone");
                        yesNoPrompt = false;
                    }
                }
            }
            if(isReading) {
                readingPages = 0;
            }
            break;
        case "break in":
            if(currentLocation == 5) {
                if(!breakin) {
                    if(irandom(2) == 0) {
                        sendDelayMessage("You are inside the shopkeeper's house",60);
                        currentLocation = 11;
                        breakin = true;
                        yesNoPrompt = true;
                    }
                    else {
                        sendDelayMessage("You got caught while trying to break into the house of the shopkeeper",90);
                        sendDelayMessage("You spent 1 day in jail",90);
                        if(money > 0) {
                            sendDelayMessage("All of your money was confiscated",90);
                        }
                        currentLocation = 0;
                        timeOfDay = 0;
                        numMovement = 0;
                        money = 0;
                        days++;
                        newDay();
                        sendDelayMessage(timeOfDayString()+" of the "+ordinalNumber(days)+" day",90);
                        sendDelayMessage("You are outside",90);
                    }
                }
            }
            break;
        case "drink":
            if(currentLocation == 3 && timeOfDayString() == "Night") { 
                if(money > 0) {
                    sendMessage("You ordered a drink and gave the bartender a coin");
                    sendDelayMessage("You have "+string(--money)+" coin(s) left",60);
                    if(stress > 0) {stress -= 20;}
                    if(drunk < 100) {drunk += 20;}
                    switch(drunk) {
                        case 60:
                            sendDelayMessage("You start to feel dizzy",60);
                            break;
                        case 80:
                            sendDelayMessage("You are drunk",60);
                            break;
                        case 100:
                            sendDelayMessage("You are very drunk",60);
                            sendDelayMessage("You past out in the tavern",90);
                            timeOfDay = 0;
                            days++;
                            newDay();
                            numMovements = 0;
                            currentLocation = 0;
                            drunk -= 100;
                            sendDelayMessage(timeOfDayString()+" of the "+ordinalNumber(days)+" day",60);
                            sendDelayMessage("You are outside of the tavern",60);
                            if(money > 0) {
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
            currentLocation = 1;
            if(event[2] == 1 && timeOfDayString() == "Night") {
                sendDelayMessage("You are close to your home",60);
                sendDelayMessage("Suddenly you notice a body laying on the ground",60);
                sendDelayMessage("You decide to walk over to the body and investigate",60);
                sendDelayMessage("You: No...",60);
                sendDelayMessage("You: It can't be",60);
                sendDelayMessage("The body is of your son",60);
                sendDelayMessage("Next to him is a silver dagger",60);
                var foundNote = false;
                for(var i = 0; i < ds_list_size(notes); i ++) {
                    if(ds_list_find_value(notes,i) == "The shopkeeper have a silver dagger") {
                        foundNote = true;
                        break;
                    }
                }
                if(foundNote) {
                    var stoleDagger = false;
                    for(var i = 0; i < ds_list_size(messageHistory); i++) {
                        if(ds_list_find_value(messageHistory,i) == "You took the silver dagger") {
                            stolenDagger = true;
                            break;
                        }
                    }
                    if(stolenDagger) {
                        sendDelayMessage("You: This can't be the same dagg-",60);
                        sendDelayMessage("You check your pockets",60);
                        sendDelayMessage("You: This...",60);
                        sendDelayMessage("You: This is impossible!",60);
                    }
                    else {
                        sendDelayMessage("You: What is this?",60);
                        ds_list_add(inventory,"Silver Dagger");
                        sendDelayMessage("You: A silver dagger?",60);
                        sendDelayMessage("You: Hm...",60);
                    }
                }
                sendDelayMessage("You look around the body",60);
                sendDelayMessage("Your son is laid on a pentagram that is drawn in blood",60);
                sendDelayMessage("There is something written on near the pentagram",60);
                sendDelayMessage("It saids",60);
                sendPigenDelayMessage("I PRAISE THE DEVIL",60);
                sendDelayMessage("",120);
                sendDelayMessage("I need to head home...",120);
            }
            else {
                sendMessage("You are at home");
            }
            break;
        case "sleep":
            if(currentLocation == 1) {
                sendMessage("You went to sleep");
                timeOfDay = 0;
                days++;
                newDay();
                numMovements = 0;
                drunk -= 80;
                if(days > 7) {
                    if (dreamChance < 100) {
                        dreamChance += 3+(days-7);
                    }
                }
                sendDelayMessage(timeOfDayString()+" of the "+ordinalNumber(days)+" day",90);
                if(event[2] == 0) {
                    if(days > 3) {
                        sendDelayMessage("You recall a dream from last night",90);
                        sendDelayMessage("Everything were in black and white",90);
                        sendDelayMessage("A body in laying infront of you",90);
                        sendDelayMessage("Everything else is a blur...",90);
                        //ds_list_delete(inventory,ds_list_find_index(inventory,"Silver Dagger"));
                    }
                    //if(dreamChance > 5) {dreamChance -= 5;}
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
                        currentLocation = 3;
                        sendMessage("You are at the tavern");
                        if(days == 1) {
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[You can work at the tavern, in exchange for some stress]",60);
                            sendDelayMessage("[Type [work] to work]",60);
                            sendDelayMessage("[At night, you can drink to reliefsome stress in exchange for 1 gold]",60);
                            sendDelayMessage("[Type [drink] to drink]",60);
                        }
                        if(event[0] == 1) {
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
                        currentLocation = 5;
                        if(days == 1) {
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[You can work at the shop, in exchange for some stress]",60);
                            sendDelayMessage("[Type [work] to work]",60);
                        }
                        if(timeOfDayString() != "Night") {
                            sendMessage("You are at the shop");
                            sendDelayMessage("The shop is currently hiring",60);
                        }
                        else {
                            sendMessage("The shop is currently closed");
                        }
                        break;
                    case "murder scene":
                        currentLocation = 4;
                        if (event[0] == 1) {
                            sendMessage("You are at the murder scene");
                        }
                        break;
                    case "library":
                        currentLocation = 9;
                        if(days == 1) {
                            sendDelayMessage("[TUTORIAL]",60);
                            sendDelayMessage("[The library can provide some hints with puzzles]",60);
                            sendDelayMessage("[Type [investigate] look for clue]",60);
                        }
                        sendMessage("You are at the library");
                        sendDelayMessage("It is very quite",60);
                        break;
                    case "elder":
                        currentLocation = 7;
                        sendMessage("You are at the elder's house");
                        if(timeOfDayString() != "Night") {
                            if(days == 1) {
                                sendDelayMessage("[TUTORIAL]",60);
                                sendDelayMessage("[The elder can provide clues to where you should go]",60);
                                sendDelayMessage("[Type [investigate] to ask for clues]",60);
                            }
                        }
                        break;
                    default:
                        moved = false
                        sendMessage("Location ["+string(subCommand)+"] does not exists");
                        break;
                }
                if(moved) {
                    if(numMovements < 3) {
                        numMovements++
                    }
                    else {
                        numMovements = 0;
                        timeOfDay++;
                        if(timeOfDay > 3) {
                            sendMessage("It is a new day");
                            timeOfDay = 0;
                            days++;
                            newDay();
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
