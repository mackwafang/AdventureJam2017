///getStressLevel() returns string
if(global.stress >= 75) {return "You are starting to feel a bit stressed";}
else if(global.stress >= 150) {return "You are very stressed";}
return "You are not stressed";
