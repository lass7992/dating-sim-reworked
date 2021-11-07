void run_dialog(){
  boolean speak = true;
  boolean hud = true;
  boolean dialog_draw_girl = true;

  if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("END")){
    new_location = active_location;
    dialog_active = false;
    time += int(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    set_location(active_location);
    speak = false;
   
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("jump")){     /// hvis det er et spørgsmål
    dialog_nr  = int(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    speak = false;  
    hud = false; 
  
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("space")) {  
      speak = false;
      dialog_next += 1;
      text_done = 3;
      if(skip == true){dialog_nr++;}
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("func")) {  
        if(name.equals("Player")){name = "";}
    if(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1).equals("name")){    // hvis funktionen er lig med navn
      name += name_creater();
      speak = false;
      hud = false;
      image(dialog_bar,0,screen_y-screen_y/6,screen_x/1.3,screen_y/6);
      pushMatrix();
        fill(255,255,255);      
        textSize(25*scale_x);
        rect(screen_x/6+textWidth(name), screen_y-screen_y/9,10*scale_x,20*scale_y); //writing block
        text(name , screen_x/6, screen_y-screen_y/10); // text
        textSize(15*scale_x);
        text("skriv dit navn" , screen_x/6, screen_y-screen_y/8); // infotext
      
      popMatrix();
      
    } else{  // ellers
    
    }
    
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("relationship")) {
    int change = int(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    relationship_change(change, active_girl_dialog);
    info_text_instances = (info_text[])append(info_text_instances, new info_text("Relationship " + active_girl_dialog + " " + str(change)));    
    speak = false;
    dialog_nr ++;
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("mood")) { 
    int change = int(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    mood_change(change, active_girl_dialog);
    info_text_instances = (info_text[])append(info_text_instances, new info_text("Mood " + active_girl_dialog + " " + str(change)));
    speak = false;
    dialog_nr ++;
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("awkward")) { 
    awkward_stat += int(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    info_text_instances = (info_text[])append(info_text_instances, new info_text("awkward += "+ dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1)));
    speak = false;
    dialog_nr ++;
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("text")) { 
    info_text_instances = (info_text[])append(info_text_instances, new info_text(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1)));
    speak = false;
    dialog_nr ++;
  
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("loc")) {
    set_location(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    speak = false;
    dialog_nr ++;
    set_girl_dialog(active_girl_dialog, clothing_dialog, current_mood); 
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("achive")) {
    add_achive(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1));
    speak = false;
    dialog_nr ++;
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("girl")) {
    dialog_draw_girl = false;
    
    
    if(text_done == 2){ girl_slide = 100; set_girl_dialog(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1), "default", "happy");}
    
    if(girl_slide < 10 && girl_slide > -10){
      set_girl_dialog(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1), clothing_dialog, "happy");        // lav lige således at man kan skifte tøj også
      if(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1).equals("BLANK")||dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1).equals("Player")){
        girl_slide = 100; set_girl_dialog("BLANK", "BLANK", "BLANK");
      }else{
        girl_slide = 5; set_girl_dialog(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1), clothing_dialog, "happy");
      }
      
    }
    if(girl_slide < 100){
      girl_slide += text_speed*5;
      if(skip == true){
      girl_slide += 20;
      }
    }
    if(girl_slide >= 100){
      dialog_nr ++;
      girl_slide = -100;
    }
    speak = false;
    
    image(active_girl_img_dialog, screen_x-int((screen_x-(screen_x/1.2-(active_girl_pos[2]*scale_x)))*(float(abs(girl_slide))/100)) ,screen_y/1.5-(active_girl_pos[3]*scale_y), (active_girl_pos[2] * 2)*scale_x , (active_girl_pos[3] * 2)*scale_x);
    
    
  }else if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("question")){     /// hvis det er et spørgsmål
    speak = false;  
    hud = false;
    dialog_question();     
  }
  
  if(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|")).equals("black")) {  
    speak = false;
    if(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1,dialog_text[dialog_nr].indexOf("$")).equals("in")){ 
      black_screen = true;
      black_screen_dir = "down"; 
      black_counter = 0;
      balck_text = dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("$")+1); 
      
    }else if(dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1,dialog_text[dialog_nr].indexOf("$")).equals("out")){
      black_screen = true;
      black_screen_dir = "up"; 
      black_counter = 255;
      balck_text = dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("$")+1);       
    }
  }
  
  
  if(hud == true){
     image(dialog_bar,0,screen_y-screen_y/6,screen_x/1.3,screen_y/6);
  }
  
  if(speak == true){
    if(skip == true && qust_active != true){
      if(text_done >= 2){
        skip_tick+=1; 
        if(skip_tick > 5){ 
          skip_tick = 0; 
          dialog_char_at = 0;
          dialog_nr ++;
          text_done = 0; 
          black_screen = false;
          return;
        }
      } else{text_done = 3;}
    }

    if(current_mood.equals(dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|"))) != true){
      current_mood = dialog_text[dialog_nr].substring(0, dialog_text[dialog_nr].indexOf("|"));
      set_girl_dialog(active_girl_dialog, clothing_dialog, current_mood);
    }
    
     pushMatrix();
      fill(50,50,50,190);

      textFont(Dialog_font);
      
      textSize(30*scale_x); 
      textAlign(LEFT, CENTER);
      fill(255,255,255);
      if(active_girl_dialog.equals("Player") || active_girl_dialog.equals("player") || active_girl_dialog.equals("BLANK")){
        text(name, screen_x/32, screen_y-screen_y/10);     /// hvis det er spilleren
      }else{
        text(active_girl_dialog, screen_x/32, screen_y-screen_y/10);     /// navn
      }
      
      textSize(22*scale_x); 
      

      String temp_text = dialog_text[dialog_nr].substring(dialog_text[dialog_nr].indexOf("|")+1);   
      
      if(temp_text.indexOf("$") != -1){
        if(temp_text.substring(temp_text.indexOf("$")+1 , temp_text.indexOf("$",temp_text.indexOf("$")+1)).equals("ITALIC")){
              textFont(Dialog_italic);
                    textSize(30*scale_x); 
        }else if(temp_text.substring(temp_text.indexOf("$")+1 , temp_text.indexOf("$",temp_text.indexOf("$")+1)).equals("BOLD")){
              textFont(Dialog_bold);
                    textSize(25*scale_x); 
        }
        temp_text = temp_text.substring(temp_text.indexOf("$",temp_text.indexOf("$")+1)+1);
      }
      
      if(temp_text.indexOf("!NAME") != -1){
        temp_text = temp_text.substring(0,temp_text.indexOf("!NAME")) + name +  temp_text.substring(temp_text.indexOf("!NAME")+5);
      }
      
      
      if(text_done == 2){
        dialog_fade_at = 1000;
        dialog_char_at = temp_text.length();
        text_done = 3;
      }
      
      
      PGraphics gradient = createGraphics(100,int(textAscent()+textDescent()));
      gradient.beginDraw();
        for(int i = 0; i < 50; i++){
          gradient.tint(255,255-(255*(float(i)/50)));
          gradient.image(get(int((screen_x/6)+dialog_fade_at-i) , screen_y-screen_y/10-int(textDescent()) , 1 , int(textAscent()+textDescent())), 50-i , 0);
        }  
        for(int i = 0; i < 50; i++){
          gradient.noTint();
          gradient.image(get(int((screen_x/6)+dialog_fade_at+50-i) , screen_y-screen_y/10-int(textDescent()) , 1 , int(textAscent()+textDescent())), 100-i , 0);
        }  
        noTint();
      gradient.endDraw();

            fill(0,0,0);
      text(temp_text.substring(0,round(dialog_char_at)), screen_x/6-2, screen_y-screen_y/10); // text
            fill(255,255,255);
      text(temp_text.substring(0,round(dialog_char_at)), screen_x/6, screen_y-screen_y/10); // text
      
      
      //image(gradient,(screen_x/6)+int(textWidth(temp_text.substring(0,round(dialog_char_at))))-50, (screen_y-screen_y/10)-textDescent() );
      image(gradient,(screen_x/6)+dialog_fade_at-50, (screen_y-screen_y/10)-textDescent() );

    popMatrix();
    
    dialog_fade_at += int(text_speed*10);
    
    if(dialog_char_at < temp_text.length()){
      if(dialog_fade_at >= textWidth(temp_text.substring(0,round(dialog_char_at+1)))){
        dialog_char_at++; 
        if(dialog_char_at < temp_text.length()) {dialog_char_at++;}
      }
    }else if(dialog_fade_at > textWidth(temp_text)+100){text_done = 3; dialog_fade_at = 2000;}
      
  }
  if(dialog_draw_girl ==true){
    draw_girl_dialog(2);
  }
  
  dialog_next += 1;
}


void dialog_question(){
    qust_active = true;
    int temp_qust = 0;
    
    String [] temp_ans = new String[0];
    
    for(int i = 0; dialog_text[dialog_nr].indexOf("|",i) != -1; i++){
     
     i = dialog_text[dialog_nr].indexOf("|",i);
     
     if(dialog_text[dialog_nr].indexOf("|",i+1) != -1){
       
       temp_ans = append(temp_ans, dialog_text[dialog_nr].substring(i+1 , dialog_text[dialog_nr].indexOf("|",i+1)));
       
     }else{
       temp_ans = append(temp_ans, dialog_text[dialog_nr].substring(i+1));
     }
     
  
     temp_qust ++; 
    }

      int temp_x = 0;
      int temp_y = 0;
     //Skriver svarne
     for(int i = 0; i < temp_qust; i++){
       pushMatrix();
        fill(50,50,50,240);
        textSize(40*scale_x); 
        textAlign(CENTER, CENTER);
      
        if(textWidth(temp_ans[i]) > 180*scale_x){temp_x = int(textWidth(temp_ans[i]) - 180*scale_x);}else{temp_x = 0;}
    
        strokeWeight(5); rect(500*scale_x-((200*scale_x+temp_x)/2) , screen_y/2 + (i*100 - (temp_qust/2)*100 - 40)*scale_y,   200*scale_x+temp_x , 80*scale_y);strokeWeight(2);
        fill(255,20,50);

        
  
        text(temp_ans[i], 500*scale_x, screen_y/2 + (i*100 - (temp_qust/2)*100)*scale_y); 
    
    
        popMatrix();
        
        if(mousePressed && mouseX < 500*scale_x-((200*scale_x+temp_x)/2)+200*scale_x+temp_x && mouseX > 500*scale_x-((200*scale_x+temp_x)/2) && mouseY > screen_y/2 + (i*100 - (temp_qust/2)*100 - 40)*scale_y && mouseY < screen_y/2 + (i*100 - (temp_qust/2)*100 - 40)*scale_y+80*scale_y){
          qust_active = false;

          
          int counter = 0;
          for(int q = 0; q < i ; q ++){
            counter = dialog_text[dialog_nr+1].indexOf("|",counter+1);
            println(counter);
          }
          dialog_nr = int(dialog_text[dialog_nr+1].substring(counter+1, dialog_text[dialog_nr+1].indexOf("|",counter+1)));    
        }
     }    
}
