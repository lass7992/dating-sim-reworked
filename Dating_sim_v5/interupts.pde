void mouseReleased(){
  if(mouseButton == RIGHT && menu_active != true && loading_status > 100){
    menu_type = "save";
    menu_active = true;
    saveFrame("Save/save_pic.png");
    Current_sound = Menu_sound;
    
  }else if (mouseButton == LEFT){
    
    if(dialog_active == true && qust_active != true && dialog_next > 2){
      print(text_done);
      if(text_done == 3){
        dialog_char_at = 0;
        dialog_nr ++;
        dialog_next = 0;
        text_done = 0;
        dialog_fade_at = 0;
        black_screen = false;
      }else{
        text_done = 2;
      }
    }
    

    
    if(dialog_active != true && menu_active != true && phone_active != true && can_press == true){
    
      if(mouseclickable == true){
        if(mouseclick[0].equals("Girl")){
          girl currentGirl = Girls_classes.get(mouseclick[1]);
          if(currentGirl != null){
            currentGirl.pressed();
          }
        }
      }
  
      
  
      if(location_data != null){
        for(int i = 0; i < location_data.length; i++){   // sleep og tjavs
          if(can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
            if(location_data[i][4].equals("sleep")){
              transition = true;
              can_press = false;
              black_counter = 0;
              new_time = 8;
              new_location = active_location;
              transit_text = "dag: " + dage;
            }else if(time < 21 ){
              new_time = time;
              new_location = location_data[i][4];
              can_press = false;
              black_counter = 0;
              transition = true;
              transit_text = location_data[i][4];
            }
          }
        } 
      }
      
      // Past Time
      if(can_press == true && mouseX > 10*scale_x && mouseX < 110*scale_x && mouseY > 10*scale_y && mouseY < 110*scale_y && time < 21){
          pass_time();
          can_press = false;
      }
          // map
      if(can_press == true && mouseX > 120*scale_x && mouseX < 220*scale_x && mouseY > 10*scale_y && mouseY < 110*scale_y && time < 21){
          set_location("map");
          can_press = false;
      }
      if(can_press == true && mouseX > screen_x-screen_x/15 && mouseX < screen_x-screen_x/15+(100*scale_x) && mouseY > 10*scale_y && mouseY < 110*scale_y){
          last_location = active_location;
          set_location("phone/Screen");
          can_press = false;
          phone_active = true; 
      }
    }
    if(phone_active == true && can_press == true){
      if(can_press == true && mouseX > 830*scale_x && mouseX < 1280*scale_x && mouseY > 0 && mouseY < 800*scale_y){   /// trykker ude for skærmen
          phone_active = false;
          can_press = false;
          active_girl_phone = "NONE";
          set_location(last_location);
        }
       if(can_press == true && mouseX > 0 && mouseX < 350*scale_x && mouseY > 0 && mouseY < 800*scale_y){    //// trykker ude for skærmen
          phone_active = false;
          can_press = false;
          active_girl_phone = "NONE";
          set_location(last_location);
       }
      
       for(int i = 0; i < location_data.length; i++){
        if(active_girl_phone == "NONE" && can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
          set_location("phone/" +location_data[i][4]);
          new_contact("Amy");
          can_press = false;
        }else if(can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
          new_contact(location_data[i][4]);
        }
        
      } 
    }
    
    can_press = true;
  }
}

void keyPressed(){  
  if(key== CODED){
    if(keyCode==CONTROL){
      skip = true;
    }
  }
}

void keyReleased(){
  keybord_ready = true;
  
  if(key== CODED){
    if(keyCode==CONTROL){
      skip = false;
    }
  }
}





Boolean mouse_over(){
  Boolean mouse = false;
  if(location_data != null){
  
    for(int i = 0; i < location_data.length; i++){
      if(can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
        mouse = true;
      }
    } 
    if(phone_active == true && can_press == true){
      if(can_press == true && mouseX > 830*scale_x && mouseX < 1280*scale_x && mouseY > 0 && mouseY < 800*scale_y){   /// trykker ude for skærmen
        mouse = true;
      }
      if(can_press == true && mouseX > 0 && mouseX < 350*scale_x && mouseY > 0 && mouseY < 800*scale_y){    //// trykker ude for skærmen
        mouse = true;
      }
      for(int i = 0; i < location_data.length; i++){
        if(active_girl_phone == "NONE" && can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
          mouse = true;
        }else if(can_press == true && mouseX > int(location_data[i][0])*scale_x && mouseX < int(location_data[i][0])*scale_x + int(location_data[i][2])*scale_x && mouseY > int(location_data[i][1])*scale_y && mouseY < int(location_data[i][1])*scale_y + int(location_data[i][3])*scale_y){
          mouse = true;
        }
      }
    }
  }

  if(alpha(clicklay.get(mouseX,mouseY)) > 5){
    mouse = true;
  }


  
  return(mouse);
}


void exit() {
 if(game_startet == true){  save_game(0);}
  exit = true;
}
