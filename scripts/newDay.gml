///newDay()
for(var i = 0; i < array_length_1d(locationInvestigated); i++) {
    locationInvestigated[i] = false;
}
switch(days) {
    case 2:
        event[0] = 1;
        break;
    case 3:
        event[1] = 1;
        break;
    case 5: 
        event[2] = 1;
        if (checkInventory("Silver Dagger")) {
            //ds_list_replace(inventory,ds_list_find_index(invenntory,"Silver Dagger"),"Bloody Silver Dagger");
            ds_list_delete(inventory,ds_list_find_index(inventory,"Silver Dagger"));
        }
        break;
}
