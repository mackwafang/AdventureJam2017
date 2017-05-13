///ordinalNumber(value)
/*
    Return the ordinal order of a value
*/
var value = argument0;
if(value < 20) {
    switch(value mod 20) {
        case 1:
            return string(value)+"st";
        case 2: 
            return string(value)+"nd";
        case 3:
            return string(value)+"rd";
        default:
            return string(value)+"th";
    }    
}
else {
    switch(value mod 10) {
        case 1:
            return string(value)+"st";
        case 2: 
            return string(value)+"nd";
        case 3:
            return string(value)+"rd";
        default:
            return string(value)+"th";
    }
}