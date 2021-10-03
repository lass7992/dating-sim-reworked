void Draw_backgorund(){
  if(active_background != null){
    image(active_background ,0,0,screen_x,screen_y);
  }
}

void draw_girl_dialog(float scale){
  image(active_girl_img_dialog, screen_x/1.2-(active_girl_pos[2]*scale_x) ,screen_y/1.5-(active_girl_pos[3]*scale_y), (active_girl_pos[2] * scale)*scale_x , (active_girl_pos[3] * scale)*scale_x);
}

void draw_hud(){
  clicklay.beginDraw();
  clicklay.image(ur,10*scale_x,10*scale_y);
  clicklay.image(map_icon,120*scale_x,10*scale_y);
  clicklay.image(phone_icon,screen_x-screen_x/15,(10)*scale_y);
  clicklay.endDraw();
    
  pushMatrix();              //skriver tiden :?
    overlay.beginDraw();
    overlay.textSize(40); 
    overlay.textAlign(LEFT, CENTER);
    overlay.fill(50,50,50);
    overlay.rect(screen_x/2.02, screen_y/30,screen_x/10, screen_y/20);
    overlay.fill(50,255,50);
    overlay.text(str(time) + ":00", screen_x/2, screen_y/20);   
    overlay.endDraw();
  popMatrix(); 
  
  clicklay.beginDraw();
  //awkward'o meter
  pushMatrix();              //skriver tiden :?
    clicklay.image(awkward_meter_img,0,screen_y-awkward_meter_img.height *screen_y/720,awkward_meter_img.width *screen_x/1280, awkward_meter_img.height*screen_y/720);
    clicklay.stroke(0,0,0);
    clicklay.fill(0,200,0);
    clicklay.translate(screen_x/12.9,screen_y-awkward_meter_img.height/3.5 *screen_y/720);
    clicklay.rotate(2+(awkward_stat));
    clicklay.rect(-5,10,10,50);
  popMatrix(); 
  clicklay.endDraw();

}
void fade_over(){
        can_press = false;
        
        black_counter += text_speed*50;  
        if(black_counter < 255){
        pushMatrix();
          overlay.beginDraw();
          overlay.fill(0,0,0,black_counter);
          overlay.rect(0,0,screen_x,screen_y);
          overlay.fill(255,255,255,black_counter); textSize(60); textAlign(CENTER, CENTER);
          overlay.text(transit_text,screen_x/2,screen_y/2);
          overlay.endDraw();
        popMatrix();
        
        }else if (black_counter < 500){
          dage += 1;
          time = new_time;
          set_location(new_location);
          overlay.endDraw();
          overlay.fill(0,0,0);
          overlay.rect(0,0,screen_x,screen_y);
          overlay.fill(255,255,255,black_counter); textSize(60); textAlign(CENTER, CENTER);
          overlay.text(transit_text,screen_x/2,screen_y/2);
          overlay.endDraw();
          black_counter = 510;

          
        }else{
          if(black_counter > 750){
            can_press = true;
            transition = false;
          }
          pushMatrix();
            overlay.endDraw();
            overlay.fill(0,0,0,750-black_counter);
            overlay.rect(0,0,screen_x,screen_y);
            overlay.fill(255,255,255,750-black_counter); textSize(60); textAlign(CENTER, CENTER);
            overlay.text(transit_text,screen_x/2,screen_y/2);
            overlay.endDraw();
          popMatrix();
        }

}


void fade_out(){
        black_counter += text_speed*10;  
        if(black_counter >= 255){
          black_counter = 255;
          text_done = 3;
          dialog_next = 3;
          if(skip == true){dialog_nr++;black_screen = false;}
        }
        pushMatrix();
          overlay.endDraw();
          overlay.fill(0,0,0,black_counter);
          overlay.rect(0,0,screen_x,screen_y);
          overlay.fill(255,255,255,black_counter); textSize(60); textAlign(CENTER, CENTER);
          overlay.text(balck_text,screen_x/2,screen_y/2);
          overlay.endDraw();
        popMatrix();
}
void fade_in(){
        black_counter -= text_speed*10;  
        if(black_counter <= 5){
          black_counter = 0;
          black_screen = false;
          dialog_nr++;
      }
        pushMatrix();
          overlay.endDraw();
          overlay.fill(0,0,0,black_counter);
          overlay.rect(0,0,screen_x,screen_y);
          overlay.fill(255,255,255,black_counter); textSize(60); textAlign(CENTER, CENTER);
          overlay.text(balck_text,screen_x/2,screen_y/2);
          overlay.endDraw();
        popMatrix();
}
