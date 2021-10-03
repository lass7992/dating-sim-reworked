String name_creater(){
  String temp = "";
  if(keyPressed && keybord_ready == true){
    if(key == ENTER){
      dialog_nr += 1;
      keybord_ready = false;
    }else if((key <= 'z' && key >= 'a') || key == ' '){
      temp = str(key);
      keybord_ready = false;
    }
  }
  
  
  return(temp);
}
