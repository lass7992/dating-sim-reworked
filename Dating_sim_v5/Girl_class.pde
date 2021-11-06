class girl extends LocationObject{ //Lav en ekstra klasse der håndtere det med glow o.o
//  PImage girl_img;
//  PImage glow;
//  int [] pos = new int[0];



  String [] preset_location;
  String location;
  String name;
  String[][] clothing_preset = new String[0][0];
  String clothing = "default";
  String mood = "happy";
  int story = 0;
  int max_relationship = 20;
  String [] story_parameters = new String[4];
  

//STATS
  int relationship_stat = 0;
  int mood_stat = 50;


  girl(String name_){
    name = name_;
    load_preset();    
    load_story();
  }
  
  void load_preset(){     //// load lige presettet ind
    preset_location = new String[24];
    
    String [] file = loadStrings("Assets/Girls/" + name + "/Data/preset.txt");  //Ændre dette til JSON 

    
    for(int i = 0; i < preset_location.length;i++){
      preset_location[i] = file[i];
    }
    
    
      // loader de forskelige sæt tøj                                                                  //TODO Clothes presets skal bare laves om til en DICTONARY 
    String[] Cloth = loadStrings("Assets/Girls/" + name + "/Data/location_cloth.txt"); 
    for(int i = 0; i< Cloth.length; i++) {
      clothing_preset = (String[][])append(clothing_preset, new String[0]);
      clothing_preset[i] = (String[])append(clothing_preset[i], Cloth[i].substring(0,Cloth[i].indexOf("|",0)));
      clothing_preset[i] = (String[])append(clothing_preset[i], Cloth[i].substring(Cloth[i].indexOf("|")+1));    
    }
  }
  
  
  void check_girls(){    
    if(preset_location[time].equals(active_location)){
      for(int i = 0; i< clothing_preset.length; i++) {
        try{
          if(clothing_preset[i][0].equals(active_location)){
            clothing = clothing_preset[i][1];
          }
        } catch(java.lang.RuntimeException e){
          print(name);
        }
      }
      story_checker();
      
      
      
      // hvis der er en fil til et billede så tager den den
      String [] location_file = loadStrings("Assets/Girls/" + name + "/lok/" + active_location + "/data.txt");
      if(location_file != null){
          
          x = int(location_file[0]);
          y = int(location_file[1]);
          _width = int(location_file[2]);
          _height = int(location_file[3]);

        //image = loadImage("Assets/Girls/" + name + "/lok/" + active_location + "/sprite.png");
        
        try{
        //  glow = loadImage("Assets/Girls/" + name + "/lok/" + active_location + "/glow.png");
        }catch(java.lang.RuntimeException e){
        //  glow = null;
        }
      
      }else{     //elllers hvis der ikke er noget billede til tingen så gør den således
        print("fail : ");
        //pos = load_pos(name, active_location); 
      //  image = loadImage("Assets/Girls/" + name + "/" + clothing + "/" + mood + "/sprite.png");
      }
      
      girl_active = true;

    }
    
  }

  void pressed(){
    dialog_text = load_dialog(active_location, name, "0");
  }
  
  void draw_(){
    if(preset_location[time].equals(active_location)){
      //hvis filen for lokalition findes
      String [] location_file = loadStrings("Assets/Girls/" + name + "/lok/" + active_location + "/data.txt");
      if(location_file != null){
          x = int(location_file[0]);
          y = int(location_file[1]);
          _width = int(location_file[2]);
          _height = int(location_file[3]);
      }else{
        //pos = load_pos(name, active_location);
      }
      
      if(true){//alpha(image.get(int(mouseX-x*scale_x) , int(mouseY-y*scale_y))) > 1){      
        mouseclickable = true;
        mouseclick = new String[2];
        mouseclick[0] = "Girl";
        mouseclick[1] = name;
        if(glow != null){
          overlay.beginDraw();
          overlay.image(glow, x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);      
          overlay.endDraw();
        }
      }
      clicklay.beginDraw();
      //clicklay.image(image, x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);      
      clicklay.endDraw();
    }
  }
  
  void story_checker(){
    println(story_parameters[0]);
    println(active_location);
    println(int(story_parameters[1]));
    println(relationship_stat);
    
    if(active_location.equals(story_parameters[0]) && relationship_stat >= int(story_parameters[1])){
      for(int i = 0; story_parameters[2].indexOf("|",i+1) != -1; i = story_parameters[2].indexOf("|",i+1)){
        if (story_parameters[2].indexOf("$") == -1){
           dialog_text = load_dialog("story", name, str(story));
           story++;
           max_relationship = int(story_parameters[3]);
           load_story();
        }else if(int(story_parameters[2].substring(i+1,story_parameters[2].indexOf("|",i+1))) == time){
           dialog_text = load_dialog("story", name, str(story));
           story++;
           max_relationship = int(story_parameters[3]);
           load_story();
        }
      }
      
    }
  
  }

  void load_story(){
    try{
      String[] file = loadStrings("Dialog/story/" + name + "/" + str(story) + "/data.txt");
      story_parameters[0] = file[0];
      story_parameters[1] = file[1];
      story_parameters[2] = file[2];
      story_parameters[3] = file[3];
    } catch(java.lang.RuntimeException e){
        story_parameters[0] = "lol";
        story_parameters[1] = "500";
        story_parameters[2] =  ":P";
        story_parameters[2] = "40";
    }

  }
}
