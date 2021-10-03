void set_location(String location){
  println(location);
  active_location = location;
  active_background = loadImage("backgrounds/" + location + "/background.png");
  active_background.resize(screen_x,screen_y);
  location_data = load_location(location);




  girl_active = false;
  active_girl = new String[0];

  for (Map.Entry<String,girl> girlEntry : Girls_classes.entrySet()) {
    girlEntry.getValue().check_girls();
  }

  try{
    if(Current_sound_name.equals(location) == false){
      Current_sound.stop();
      for(int i = 0; i < music_sounds_names.length; i++){
        if(music_sounds_names[i].equals(location)){
          Current_sound = music_sounds[i];
          Current_sound_name = music_sounds_names[i];
          break;
        }
      }
    }  
  } catch(java.lang.RuntimeException e){}
  
  
  //ser om man må være ved stedet
  if(dialog_active != true){
    try{
      String [] file = loadStrings("backgrounds/" + active_location + "/lim.txt");
      girl tempGirl = Girls_classes.get(file[0]);
      if(tempGirl != null){
        if(tempGirl.story < int(file[1])){
          dialog_text = load_dialog("triggers",file[2],file[3]);
        }
      }
    } catch(java.lang.RuntimeException e){println(e);}
  }
} 
