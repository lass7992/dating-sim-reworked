class info_text{
  int y_pos, counter = 0;
  String text;

  int speed = 1;
  
  info_text(String temp_text){
    y_pos = 100;
    if(info_text_instances.length > 0){
      if(info_text_instances[info_text_instances.length-1].y_pos > 95){
        y_pos = info_text_instances[info_text_instances.length-1].y_pos + 30;
      }
    }
    text = temp_text;
    
  }
  
  void update(){
    draw_();
    counter += 1;
    y_pos -= speed;
    
    if(counter >= 100){
      info_text_instances = (info_text[] )subset(info_text_instances, 1);
    }
  
    
  }
  void draw_(){

    overlay.pushMatrix();
      overlay.beginDraw();
      overlay.fill(0,0,0, 255-255*(float(counter)/60));
      overlay.textSize(25*scale_x); 
      overlay.textAlign(RIGHT, CENTER);      
      overlay.text(text, screen_x-80,y_pos); 
      overlay.textSize(25*scale_x);
      overlay.fill(255,255,255, 255-255*(float(counter)/100));
      overlay.text(text, screen_x-80,y_pos); 
      overlay.endDraw();
    overlay.popMatrix();
    
  }
}





class Location
{
  PImage image; //Dette burde nok være et array så man kan have flere baggrunde på en lokaltion -> i forhold til tid
  LocationObject[] navigationObjects;
  LocationObject[] girls;
  String name;


  PImage getImage()
  {
    return image;
  }

  Location(String tempName){
    name = tempName;
    image = loadImage("backgrounds/" + tempName + "/background.png");

    try{
      JSONObject presets = loadJSONObject("backgrounds/"+ tempName + "/data.json");
      
      if(presets != null){
    
    
        JSONArray navigationArray = presets.getJSONArray("Navigation");
        navigationObjects = new LocationObject[navigationArray.size()];
    
        for(int i = 0;i < navigationArray.size(); i++){
          JSONObject navigation = navigationArray.getJSONObject(i);
          navigationObjects[i] = new LocationObject();
          navigationObjects[i].name = navigation.getString("name");
          navigationObjects[i].startTime = navigation.getInt("StartTime");
          navigationObjects[i].endTime = navigation.getInt("EndTime");
          navigationObjects[i].x = navigation.getInt("x");
          navigationObjects[i].y = navigation.getInt("y");
          navigationObjects[i]._width = navigation.getInt("width");
          navigationObjects[i]._height = navigation.getInt("height");
        }
    
    
        JSONArray girlsJson = presets.getJSONArray("Girls");
        girls = new LocationObject[girlsJson.size()];
    
        for(int i = 0;i < girlsJson.size(); i++){
          JSONObject girlJson = girlsJson.getJSONObject(i);
          girls[i] = new LocationObject();
          girls[i].name = girlJson.getString("name");
          girls[i].startTime = girlJson.getInt("StartTime");
          girls[i].endTime = girlJson.getInt("EndTime");
          girls[i].x = girlJson.getInt("x");
          girls[i].y = girlJson.getInt("y");
          girls[i]._width = girlJson.getInt("width");
          girls[i]._height = girlJson.getInt("height");
        }
          //TODO DET SKAL LAVES ET ELLER ANDET MED TRIGGERNE HER o.o
      }else{
        navigationObjects = new LocationObject[0];
        girls = new LocationObject[0];
      }
    }catch(Exception e)
    {
      println(e+ "\n");

      println("Lokationfejlede" + tempName+ "\n"+ "\n");
    }
  }


  void _update()
  {
    //Tjekker om jeg trykker på ting o.o

    for(int i = 0; i < navigationObjects.length ; i++){ //Dette skal gøres således at der kan være flere forskellige versioner af billederne istedet for at den skal være dynamisk
      if(navigationObjects[i].image == null){
        navigationObjects[i].image = loadImage("backgrounds/" + name + "/Objects/Objects/"+navigationObjects[i].name + ".png");
        navigationObjects[i].resizeImage();
      }
    }


    for(int i = 0; i < girls.length ; i++){
      if(girls[i].lastUpdatedTime != time && girls[i].startTime < time && girls[i].endTime > time)
      {
        //Kigger igennem alle mapperne og finder det tidspunkt der passer med bedst. (altså den time der er tættest på)
        File[] girlTimeStrings = listFiles("backgrounds/"+name+"/Objects/Girls/"+girls[i].name);
        for(int j = girlTimeStrings.length-1; i >= 0; j--){
          if( Integer.valueOf(girlTimeStrings[j].getName()) <= time)
          {
            girl currentGirl = Girls_classes.get(girls[i].name);

            //Kigger igennem alle billederne i mappen og finder den der passer bedst med relationship.

            File[] girlStoryStrings = listFiles("backgrounds/"+name+"/Objects/Girls/"+girls[i].name + "/" + girlTimeStrings[j].getName() );
            for(int k = girlStoryStrings.length-1; k >= 0; k--){
              Integer girlStoryValue = parseIntOrNull(split(girlStoryStrings[k].getName(),'.')[0]);
              if(girlStoryValue == null) //<>//
              {
                continue;
              }
              
              if(girlStoryValue<= currentGirl.story){
                if(girls[i].ActiveImageName != girlTimeStrings[j].getName() + "|" + girlStoryStrings[k].getName() ){
                  girls[i].image = loadImage(girlStoryStrings[k].toString());

                  //IF glow exist use that
                  String glowPath = girlTimeStrings[j] + "/"+ girlStoryValue  + "glow.png";
                  File f = dataFile(glowPath);
                  if(f.exists()){
                    girls[i].glow = loadImage(glowPath);
                    girls[i].resizeImage();
                  }

                  girls[i].ActiveImageName = girlTimeStrings[j].getName() + "|" + girlStoryStrings[k].getName();
                }
                break;
              }
            }
            break;
          }
        }
      }
    }


    _draw();
  }

  void _draw()
  {
    for(int i = 0; i < navigationObjects.length ; i++){
      navigationObjects[i].draw();
    }

    for(int i = 0; i < girls.length ; i++){
      girls[i].draw(); //<>//
    }
  }
}
