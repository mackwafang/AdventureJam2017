///autoStringCut(string,length)
/*
    cut off the string if the string is longer than length
    return the string after being cut, return the argument otherwise
*/
var str = argument0;
var length = argument1;
for(var i = length; i >= 1; i--) {
    if(string_char_at(str,i) == " " || i == string_length(str)) {
        return string_copy(str,1,i);
    }
}
return str;