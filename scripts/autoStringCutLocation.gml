///autoStringCutLocation(string,length)
/*
    cut off the string if the string is longer than length
    return the location where it should be cut, return 0 otherwise
*/
var str = argument0;
var length = argument1;
for(var i = length; i >= 1; i--) {
    if(string_char_at(str,i) == " " || i == string_length(str)) {
        return i;
    }
}
return 0;