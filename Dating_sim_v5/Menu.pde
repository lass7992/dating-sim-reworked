menuButton[] menuButtons;




void menu(){
  //background
  background(#FFA2F9);
    //Draws hearts
  for(int i = 0; i < hearts.length;i++){
    hearts[i][4] -= hearts[i][1];
    tint(hearts[i][2],20,20,hearts[i][2]);
    image(heart_img[hearts[i][0]],hearts[i][3],hearts[i][4]);
    noTint();
    if(hearts[i][4] < -100){
      hearts[i][0] = round(random(0,3));
      hearts[i][1] = round(random(1,8));
      hearts[i][2] = round(random(50,255));
      hearts[i][3] = round(random(0,screen_x));
      hearts[i][4] = screen_y;
    }
  }
    //draws girls
 image(background_girls,20*scale_x,screen_y-(650*scale_y));

  
  if(menu_font == null)
  {
    return;
  }
  pushMatrix();
    //rects
    fill(255,255,255,200);strokeWeight(10); line((1000-150)*scale_x,(350-20)*scale_y , (780-150)*scale_x,(640-20)*scale_y); 
    textFont(menu_font);
    textSize(48*scale_x); 
    textAlign(CENTER, CENTER);

    for(int i = 0; i < menuButtons.length; i++)
    {
      menuButtons[i].draw();
    }
  popMatrix();
  
  //Start game
  if(mousePressed == true && menuButtons[0].Clicked()){
    
    menu_active = false;
    dialog_active = true;
    active_location = "amy_room";    
    dialog_text = load_dialog("story", "Start","0");

    can_press = false;
    mousePressed = false;
    game_startet = true;
    hearts = null;
    heart_img = null;
  }
   
    //continue game
  if(mousePressed == true && menuButtons[1].Clicked()){
    
  }

    //load game
  if(mousePressed == true && menuButtons[2].Clicked()){
   menu_type = "load"; 
   can_press = false;
   mousePressed = false;
  }
      //settings
  if(mousePressed == true && menuButtons[3].Clicked()){
     active_background = null;
     menu_type = "settings"; 
     can_press = false;
     mousePressed = false;
  }
    //exit
  if(mousePressed == true && menuButtons[4].Clicked()){
    exit = true;
    exit();
    return;
  }

} 


loadMenuButton[] loadMenuButtons;
void load_menu(){

  if(loadMenuButtons == null){
    loadMenuButtons = new loadMenuButton[5];

    for(int i =0; i < loadMenuButtons.length; i++){
      int padding = 200;
      loadMenuButtons[i] = new loadMenuButton( (int)((padding + i * (screen_x-padding*2)/(loadMenuButtons.length-1))/scale_x), (int)(((screen_y)/2)/scale_y), (int)(220/scale_x), (int)(150/scale_y), "save "+i, loadImage("save/" + i + "/save_pic.png"));
    }
  }

    for(int i =0; i < loadMenuButtons.length; i++){
      loadMenuButtons[i].draw();

      //starter det loadedgame
      if(can_press == true && mousePressed == true && loadMenuButtons[i].Clicked()){
        load_game(i);
      }
    }



  fill(100,100,0);
  rect(screen_x/2-100,screen_y-screen_y/10,200,50);
  fill(255,255,255);
  text("back",screen_x/2,screen_y-screen_y/10+25);
  if(can_press == true && mousePressed == true && mouseX < screen_x/2-100+200 && mouseX > screen_x/2-100 && mouseY < screen_y-screen_y/10 + 50 && mouseY > screen_y-screen_y/10){
    menu_type = "menu";
  } 
  
}

void save_menu(){
 if(loadMenuButtons == null){
    loadMenuButtons = new loadMenuButton[5];

    for(int i =0; i < loadMenuButtons.length; i++){
      int padding = 200;
      loadMenuButtons[i] = new loadMenuButton(padding + i * (screen_x-padding*2)/(loadMenuButtons.length-1), (int)((screen_y)/2), 220, 150, "save "+i, loadImage("save/" + i + "/save_pic.png"));
    }
  }

  for(int i =0; i < loadMenuButtons.length; i++){
    loadMenuButtons[i].draw();


    //Saves the game
    if(can_press == true && mousePressed == true){
      if(loadMenuButtons[i].Clicked()){
        print("collision");
        can_press = false;
        save_game(i);
      }
    }
  }

  fill(100,100,0);
  rect(screen_x/2-100,screen_y-screen_y/10,200,50);
  fill(255,255,255);
  text("back",screen_x/2,screen_y-screen_y/10+25);
  if(can_press == true && mousePressed == true && mouseX < screen_x/2-100+200 && mouseX > screen_x/2-100 && mouseY < screen_y-screen_y/10 + 50 && mouseY > screen_y-screen_y/10){
    if(game_startet == true){
      menu_active = false;
    }else{menu_type = "menu";}
  } 
}







//variabler til settings
boolean text_speed_pressed = false;
boolean volume_pressed = false;
boolean screen_scrool_pressed = false;
settingsChecker[] settingsCheckers;



import java.io.File;


void settings_menu(){   //Denne kunne godt laves lidt mere POG. 
  if(settingsCheckers == null)
  {
    settingsCheckers = new settingsChecker[4];
    settingsCheckers[0] = new settingsChecker(600,400,50,50,"skip",skip);
    settingsCheckers[1] = new settingsChecker(600,500,50,50,"lyd",lyd);
    settingsCheckers[2] = new settingsChecker(600,600,50,50,"fullscreen",full);

    //Deletedata checker
    settingsCheckers[3] = new settingsChecker(1200,600,50,50,"Delete data",false);
  }

  background(255,255,255);
  //lyd toggle
  for(int i = 0; i < settingsCheckers.length-1; i++){
    settingsCheckers[i].draw();

    if(can_press == true && mousePressed == true){
      settingsCheckers[i].ClickedAction();
    }
  }
  fill(0,0,0); textSize(18*scale_x); text("restart to apply fullscreen",600*scale_x,630*scale_y);

  //sletter alt data hvis man trykker på denne
  settingsCheckers[3].draw();
  if(can_press == true && mousePressed == true){
    if(settingsCheckers[3].Clicked()){
      PrintWriter output = createWriter("Save/profile/achive.txt"); 
      output.flush();
      output.close();
    } 
  }
      //DETTE KUNNE NOK GODT GØRES BEDRE.
  //back
  textAlign(CENTER, CENTER); fill(255,255,255);  rect(10*scale_x,10*scale_y,150*scale_x,50*scale_y);fill(0,0,0); textSize(40*scale_x);text("BACK",10*scale_x+75*scale_x,10*scale_y+20*scale_y);textSize(25*scale_x);
  if(can_press == true && mousePressed == true && mouseX < 10*scale_x+150*scale_x && mouseX > 10*scale_x && mouseY < 10*scale_y+50*scale_y && mouseY > 10*scale_y){
    PrintWriter output = createWriter("save/profile/data.txt"); 
    output.println(lyd); // 1 = lyd_enabled
    output.println(text_speed); // 2 = text_speed
    output.println(volume); // 3 = volume
    output.println(full); // 4 = fullscreen
    output.println(screen_x); // 5 = screen_x
    output.println(screen_y); // 6 = screen_y
    output.println(skip);  // 7 = skip

    
    
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    active_background = null;
    menu_type = "menu";

    scale_x = float(screen_x) /1280;
    scale_y = float(screen_y) / 720;
    if(width!= screen_x && loading_status > 100){
      loading_status = 0;
      thread("resize_images");
          //scaler menuen
      background_girls = loadImage("Assets/menu/piger.png");
      background_girls.resize(0,int(650*scale_y));
    }
    surface.setSize(screen_x, screen_y);
  } 
  
            //DISSE KUNNE GODT OPDATERES OG LAVES TIL KLASSER :?
  // scrollers
  float [] array;
    //text_speed
  
  array = scroller(text_speed_pressed,800,400,"Text_speed",text_speed,3,0.5);
  text_speed_pressed = boolean(int(array[0]));
  if(text_speed_pressed == true){text_speed = array[1];}

  
  //vomumen
  array = scroller(volume_pressed,800,500,"Volume",volume,100,0);
  volume_pressed = boolean(int(array[0]));
  if(volume_pressed == true){  volume = array[1]; try{Current_sound.amp((volume)/100); } catch(java.lang.RuntimeException e){}}


  
    //screen_size
  array = scroller(screen_scrool_pressed,800,600,"screen size x",screen_x,1920,600);
  screen_scrool_pressed = boolean(int(array[0]));
  if(screen_scrool_pressed == true){screen_x = int(array[1]); screen_y = (screen_x/16)*9;}
  
}




float [] scroller(boolean pressed, float x,float y,String text , float temp, float max, float min){  
  float local_text_speed_x = x+temp/(max)*(150 + min*(150/max))-min*(150/(max));
  pushMatrix();
    textAlign(CENTER, CENTER);
    text((text + ": " + nfc(temp,1)),(x+92)*scale_x,(y-20)*scale_y);
    fill(0);
    rect((x)*scale_x,(y+15)*scale_y,(150)*scale_x,2);
    fill(200,0,0);
    rect((local_text_speed_x-5)*scale_x,(y)*scale_y,(10)*scale_x,(30)*scale_y);
  popMatrix();
  
    
  if(can_press == true && mousePressed == true && mouseX < (local_text_speed_x+10)*scale_x && mouseX > (local_text_speed_x)*scale_x && mouseY < (y+30)*scale_y && mouseY > y*scale_y){
    pressed = true;
    can_press = false;
  }
  if(pressed == true){
    if(mousePressed != true){
      pressed = false;  
    }else{
      temp = max * ((mouseX-(x*scale_x) + min*((150*scale_x)/max))/((150*scale_x) + min*(150/max)));
      if(temp > max){temp = max;}else if(temp < min){temp = min;}
    }
  }
  float [] array = {float(int(pressed)),temp};
  return(array);
}

//MenuClasses
class settingsChecker extends ClickableObj
{
  String text;
  boolean value;


  settingsChecker(int tempx, int tempy, int tempwidth, int tempheight, String tempText, boolean tempValue)
  {
    x = tempx;
    y = tempy;
    width = tempwidth;
    height = tempheight;
    text = tempText;
    value = tempValue;
  }


  void draw(){
      //
    textAlign(RIGHT, CENTER);
    fill(200,0,0);
    text(text, (x-30)*scale_x,y*scale_y);
    fill(255,255,255);
    rect((x-width/2)*scale_x, (y-height/2)*scale_y, width*scale_x, height*scale_y);
    if(value == true)
    {
      pushMatrix(); 
      stroke(200,0,0); strokeWeight(5);  
      line((x-(width/2-2))*scale_x, (y-(height/2-2))*scale_y , (x+(width/2-2))*scale_x, (y+(height/2-2))*scale_y); 
      line((x-(width/2-2))*scale_x, (y+(height/2-2))*scale_y , (x+(width/2-2))*scale_x, (y-(height/2-2))*scale_y); 
      stroke(0); strokeWeight(2);  
      popMatrix();  
    }

  }

  void ClickAction(){
    value = !value;
    can_press = false;
  }

}

class menuButton extends ClickableObj
{
  String text;


  menuButton(int tempx, int tempy, int tempwidth, int tempheight, String tempText)
  {
    x = tempx;
    y = tempy;
    width = tempwidth;
    height = tempheight;
    text = tempText;
  }

  void draw(){
    fill(255,255,255,200);

    strokeWeight(5);
    rect((x-width/2)*scale_x,(y-20)*scale_y,width*scale_x,height*scale_y);  
    strokeWeight(2);
    
    fill(100,00,00);
    text(text, x*scale_x, y*scale_y); 
  }
}

class loadMenuButton extends ClickableObj
{
  PImage image;
  String text;

  loadMenuButton(int tempx, int tempy, int tempwidth, int tempheight, String tempText, PImage tempImage)
  {
    x = tempx;
    y = tempy;
    width = tempwidth;
    height = tempheight;
    image = tempImage;
    text = tempText;
  }

  void draw(){
    pushMatrix();
      translate(x*scale_x, y*scale_y);
      textSize(26); 
      textAlign(CENTER, CENTER);
      fill(255,255,255);
      text(text, 40*scale_x,(-height/2-20)*scale_y);
      try{
        image(image,(-width/2)*scale_x,(-height/2)*scale_y,width*scale_x,height*scale_y);
      }catch(java.lang.RuntimeException e){
        rect((-width/2)*scale_x,(-height/2)*scale_y,width*scale_x,height*scale_y);
      }
    popMatrix();
  }
}
