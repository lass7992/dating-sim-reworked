String [] load_dialog(String location, String dia, String ver){
  dialog_location = location;
  dialog_dia = dia;
  dialog_ver = ver;

  
  String [] dialog_file;
  
  if(location.equals("story") || location.equals("triggers") || location.equals("Controlling")){
      dialog_file = loadStrings("Dialog/" + location + "/" + dia + "/" + ver +  "/dialog.txt"); 
  }else{
      int temp = round(random(0,int(listFiles("Dialog/" + location + "/" + dia + "/" + ver).length)-1));
      print(temp);
      dialog_file = loadStrings("Dialog/" + location + "/" + dia + "/" + ver +"/" + temp  +".txt");               // GØR SÅLEDES AT den har en randomisering i dialogen :?
  } 
   
  active_girl_dialog = dialog_file[0];
  clothing_dialog = dialog_file[1];
  current_mood = dialog_file[2];
  set_girl_dialog(active_girl_dialog, clothing_dialog, current_mood);
  dialog_file =  subset(dialog_file, 3, dialog_file.length-3);
  dialog_active = true;
  dialog_nr = 0;
  
  
  
  return(dialog_file);
}


String [][] load_location(String location){
  String [][] location_array = new String[0][0];
  
  String [] location_file = loadStrings("backgrounds/" + location +  "/Data.txt");
  
  
  for(int i = 0; i < location_file.length; i++){
    int x = 0;
     
     location_array = (String[][])append(location_array,new String[0]);
     
     for(int q = 0; q < 5; q++){     
       location_array[i] = (String[])append(location_array[i],location_file[i].substring(x, location_file[i].indexOf("|",x)));
       x = location_file[i].indexOf("|",x)+1;
     }
   
 }  

  return(location_array);
}



int [] load_pos(String girl, String loc){
  int [] pos = new int[4];
  String [] location_file = loadStrings("Assets/Girls/" + girl +  "/Data/location/" + loc + "/data.txt");
  
  pos[0] = int(location_file[0]);
  pos[1] = int(location_file[1]);
  pos[2] = int(location_file[2]);
  pos[3] = int(location_file[3]);
  
  
  
  return(pos);
}


void save_game(int nr){
  JSONObject json;

  if(menu_active == false){ //<>// //<>// //<>// //<>// //<>// //<>// //<>//
    saveFrame("Save/" + nr +"/save_pic.png");
  }else{
    PImage img_file = loadImage("Save/save_pic.png"); //<>// //<>// //<>// //<>// //<>// //<>//
    img_file.save("Save/" + nr + "/save_pic.png");
    loadMenuButtons[nr].image = img_file;
  }
  

  json = new JSONObject();
  json.setString("name",name);
  json.setFloat("akward_stat",awkward_stat);
  json.setInt("time",time);
  json.setInt("dage",dage);
  json.setString("active_location",active_location);

  json.setString("dialog_location",dialog_location);
  json.setString("dialog_dia",dialog_dia);
  json.setString("dialog_ver",dialog_ver);
  json.setInt("dialog_nr",dialog_nr);
  json.setString("active_girl_dialog",active_girl_dialog);
  json.setString("clothing_dialog",clothing_dialog);


  JSONArray girlsJsonArray = new JSONArray();

  int counter = 0;

  for (Map.Entry<String,girl> girlEntry : Girls_classes.entrySet()) {
      JSONObject girl = new JSONObject();
      girl girlValue = girlEntry.getValue();

      girl.setString("name",girlValue.name);
      girl.setInt("mood",girlValue.mood_stat);
      girl.setInt("relationship",girlValue.relationship_stat);
      girl.setInt("maxRelationship",girlValue.max_relationship);
      girl.setInt("story",girlValue.story); //<>// //<>// //<>// //<>//

      girlsJsonArray.setJSONObject(counter,girl);
      counter+= 1; //<>// //<>// //<>// //<>//
  }
  json.setJSONArray("Girls", girlsJsonArray); //<>// //<>// //<>// //<>// //<>// //<>//

  
  saveJSONObject(json,"Save/"+ nr + "/data.json"); //<>// //<>// //<>// //<>// //<>//
}

void load_game(int nr){
  menu_active = false;
  dialog_active = false;

      try{
          JSONObject saveJson = loadJSONObject("Save/"+ nr +"/data.json");
          name = saveJson.getString("name");
          awkward_stat = saveJson.getFloat("awkward_stat");
          time = saveJson.getInt("time");
          dage = saveJson.getInt("dage");
          active_location = saveJson.getString("active_location");

          if(saveJson.getInt("dialog_nr",-100) != -100){
            dialog_active = true;
            dialog_text = load_dialog(saveJson.getString("dialog_location"),saveJson.getString("dialog_dia"),saveJson.getString("dialog_ver"));
            dialog_nr = saveJson.getInt("dialog_nr",0);
            active_girl_dialog = saveJson.getString("active_girl_dialog","BLANK");
            clothing_dialog = saveJson.getString("clothing_dialog","default");
          }
          
         JSONArray girlArray = saveJson.getJSONArray("Girls");
         for(int i = 0; nr < girlArray.size(); nr++){
          JSONObject girl = girlArray.getJSONObject(i);
     
          girl girlValue = Girls_classes.get(girl.getString("name"));
          
          girlValue.mood_stat = girl.getInt("mood");
          girlValue.relationship_stat = girl.getInt("relationship");
          girlValue.max_relationship = girl.getInt("maxRelationship");
          girlValue.story = girl.getInt("story");
        }
      }catch(java.lang.RuntimeException e){
        print("There were an error");
        menu_type = "menu";
      }



    String [] load_file = loadStrings("Save/" + nr + "/save.txt");



      menu_active = false;
      dialog_active = true;
      
      active_location = "living_room";
      active_background = loadImage("backgrounds/" + "living_room" + "/background.png");
      
      dialog_text = load_dialog("story", "Start","0");   
      
     

}



void resize_images(){
  try{
      ur.resize(int(ur.width*scale_x),int(ur.height*scale_y));
      map_icon.resize(int(map_icon.width*scale_x),int(map_icon.height*scale_y));
      phone_icon.resize(int(phone_icon.width*scale_x),int(phone_icon.height*scale_y));
      dialog_bar.resize(int(screen_x/1.5),int(screen_y/6));
      awkward_meter_img.resize(int(awkward_meter_img.width*scale_x),int(awkward_meter_img.height*scale_y));
      
      
      
   } catch(java.lang.RuntimeException e){}
   
   loading_status = 101;
}
