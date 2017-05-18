///checkInventory(item name)
var name = argument0;
for(var i = 0; i < ds_list_size(inventory) ;i++) {
    if(string_lower(ds_list_find_value(inventory,i)) == string_lower(name)) {
        return true;
    }
}
return false;