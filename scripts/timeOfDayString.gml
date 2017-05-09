///timeOfDayString()
var time = global.timeOfDay;
switch(time) {
    case 0: 
        return "Morning";
    case 1: 
        return "Midday";
    case 2: 
        return "Afternoon";
    case 3:
        return "Night";
    default:
        show_error(string(time)+" is not a valid time",true);
        break;
}