void set_girl_dialog(String girl, String clothing, String mood){

  
  active_girl_dialog = girl; //<>//
  active_girl_pos = load_pos(girl, active_location); //<>//

    try{
      active_girl_img_dialog = loadImage("Assets/Girls/" + girl + "/" + clothing + "/" + mood + "/sprite.png");
      active_girl_img_dialog.resize(int((active_girl_pos[2] * 2)*scale_x), int((active_girl_pos[3] * 2)*scale_y));
    }
    catch(java.lang.RuntimeException e){
      println(e);
    }

}
