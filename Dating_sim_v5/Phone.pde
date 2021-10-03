void new_contact(String girl){
  active_girl_phone = girl;
  active_girl_phone_img = loadImage("Assets/Girls/" + active_girl_phone + "/default/happy/sprite.png");
  active_girl_phone_img.resize(150,550);

 
  girl girlValue = Girls_classes.get(girl);
  if(girlValue != null){
    active_Relationship_stat = girlValue.relationship_stat;
    active_mood_stat = girlValue.mood_stat;
  }
}



void draw_phone_contact(){
  if(active_girl_phone != "NONE"){
      image(active_girl_phone_img,620,80);
      fill(0,0,0);
      rect(360,130,200,30);  
      rect(360,200,200,30);
      
      fill(255-255*(float(active_Relationship_stat)),255*(float(active_Relationship_stat)/100),0);              //relationship
      rect(365,135,190*(float(active_Relationship_stat)/100),20);
      
      fill(255-255*(float(active_mood_stat)/100),255*(float(active_mood_stat)/100),0);
      rect(365,205,190*(float(active_mood_stat)/100),20);              //mood
  }
}
