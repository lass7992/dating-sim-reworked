//TODOES 
//Lav således at dialog ligger under hver background folder, isteder for hvortdan det ligger nu :3
//Lav location objects til en overklasse. Så den kan bruge samme kodetil at tjekke om man trykker på dem o.o
// SKifte presets til JSON i -> girl  -> loadPreset


import java.util.Map;
import processing.sound.*;

void settings() {
  try{
    String [] settings = loadStrings("save/profile/data.txt"); 
    lyd = boolean(settings[0]);
    text_speed = float(settings[1]);
    volume = float(settings[2]);
    if(boolean(settings[3]) == true)
    {
      fullScreen(); full = true ; screen_x = displayWidth; screen_y = displayHeight;
    }
    else 
    {
      screen_x = int(settings[4]); screen_y = int(settings[5]);
    }
    
    skip = boolean(settings[6]);
    
  } catch(java.lang.RuntimeException e){
    print(e);

    
    PrintWriter output = createWriter("save/profile/data.txt"); 
    output.println("true"); // 1 = lyd |  2 = text speed | 3 = volumen | 4 = fullscreen | 5 = screen_x | 6 = screen_y
    output.println(1);
    output.println(100);
    output.println(true);
    output.println(1080);
    output.println(720);
    output.println(false);
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
  }
}



void setup() {  
  scale_x = float(screen_x) /1280;
  scale_y = float(screen_y) / 720;

  surface.setSize(screen_x, screen_y);
  
  frameRate(30);

  // loading settings
  thread( "loading" );
  background(0,0,200);
  textSize(100);


  //sætter overlay op
  overlay = createGraphics(screen_x, screen_y);
  clicklay = createGraphics(screen_x, screen_y);

  //loader menu
  active_background = null;
  
  heart_img = new PImage[4];
  heart_img[0] = loadImage("Assets/menu/hearts/0.png");
  heart_img[0].resize(int(100*scale_x),int(100*scale_x));
  heart_img[1] = loadImage("Assets/menu/hearts/1.png");
  heart_img[1].resize(int(100*scale_x),int(100*scale_x));
  heart_img[2] = loadImage("Assets/menu/hearts/2.png");
  heart_img[2].resize(int(100*scale_x),int(100*scale_x));
  heart_img[3] = loadImage("Assets/menu/hearts/3.png");
  heart_img[3].resize(int(100*scale_x),int(100*scale_x));
  
  background_girls = loadImage("Assets/menu/piger.png");
  background_girls.resize(0,int(650*scale_y));

  hearts = new int[20][5];
  for(int i = 0; i< hearts.length;i++){
    hearts[i][0] = round(random(0,3));
    hearts[i][1] = round(random(1,8));
    hearts[i][2] = round(random(50,255));
    hearts[i][3] = round(random(0,screen_x));
    hearts[i][4] = round(random(screen_y,screen_y+50));
  }


  menuButtons = new menuButton[5];

  menuButtons[0] = new menuButton(1100,350,300,60,"New game" );
  menuButtons[1] = new menuButton(1050,420,300,60, "Continue game");
  menuButtons[2] = new menuButton(1000,490,300,60, "Load game");
  menuButtons[3] = new menuButton(950,560,300,60, "Settings");
  menuButtons[4] = new menuButton(900,630,300,60, "Exit");
}


void draw() {
  //Clear overlay og click lay
  overlay.beginDraw();
  overlay.clear();
  overlay.endDraw();
  clicklay.beginDraw();
  clicklay.clear();
  clicklay.endDraw();
  
  mouseclick = new String[0];
  mouseclickable = false;
  
 //  Drawing background
  Draw_backgorund();
  
  
 // Settingup Sound

  try{
    if(lyd == true){
      if(Current_sound.isPlaying()!= true){
          Current_sound.play();
          Current_sound.amp(volume/100);
       }
    }else if(lyd == false){
      if(Current_sound.isPlaying() == true){
          Current_sound.stop();
       }
    }
  } catch(java.lang.RuntimeException e){}


  // Main routine
  if(menu_active == true){  //if menu is active
    if(menu_type.equals("menu")){ 
      menu();
    }else if(menu_type.equals("load")){
      background(255,0,0);
      load_menu();
    }else if(menu_type.equals("save")){
      background(255,0,0);
      save_menu();
    }else if(menu_type.equals("settings")){
      settings_menu();
    }

  }else if(loading_status < 100){                                                           
    background(0,0,255);
    overlay.beginDraw();
    overlay.textAlign(CENTER);
    overlay.textSize(50*scale_x);
    overlay.text("Loading",screen_x/2,screen_y/2-(100*scale_y));
    overlay.fill(50,50,50);
    overlay.rect(screen_x/2-(205*scale_x),screen_y/2-(5*scale_y),410*scale_x,60*scale_y);
    overlay.fill(0,0,0);
    overlay.rect(screen_x/2-(200*scale_x),screen_y/2,400*scale_x,50*scale_y);
    overlay.fill(255,255,255);
    overlay.rect(screen_x/2-(200*scale_x),screen_y/2,(400*float(loading_status)/100)*scale_x,50*scale_y);
    overlay.endDraw();
  }else{
    can_press = true;

    //Writes info text to screen
    for(int i = 0; i < info_text_instances.length; i++ ){
      info_text_instances[i].update();
    }  

    if(dialog_active != true){                       //REwork here !
        //Her tegnes alle de forskellige elementer på skærmen.
      _active_location.update();

      //    if(girl_active == true){        // hvis en pige er akti så updatere den pigen
      //      for (Map.Entry<String,girl> girlsEntry : Girls_classes.entrySet()) {
      //        girlsEntry.getValue().draw_();
      //      }
      //    }
        
    //   |||||||||||||||||||||||||||| hvis mobilen ikke er aktiv
      if(phone_active == false){
        draw_hud();
        
        if(mouse_over() || mouseclickable == true){
          cursor(Hand_cursor,15,5);
        }else{
          cursor(Arrow_cursor,15,5);
        }
        
        if(transition){
          fade_over();
        }
        if(time >= 21 && active_location.equals("player_room") != true){ dialog_text = load_dialog("Controlling", "time", "late"); }
        
      }else{ // hvis mobilen er aktiv så tegner den den
        draw_phone_contact();
      }
    }else if(dialog_active == true){
      if(black_screen == false){
        run_dialog();
      }
      if(black_screen == true){
        if(black_screen_dir.equals("down")){
          fade_out();
        }else if(black_screen_dir.equals("up"))
          fade_in();
      }
    }
  }
  //println(frameRate);
  
  if(exit == true){
    try{Current_sound.stop();
    } catch(java.lang.RuntimeException e){}
  }
  
  image(clicklay,0,0);
  image(overlay,0,0);
  ///////achivement
  achive_drawing();
}



void loading(){  
  loading_status = 0;
  
  //girl class
  File[] girls = listFiles("Assets/Girls");              

  Girls_classes = new HashMap<String, girl>();  //DEt kan være at dictornarying skal opretees her i stedet :?
  for(int i = 0; i< girls.length; i++) {
    String girlName = girls[i].getName();

    //føjer billeder
    Girls_classes.put(girlName,new girl(girlName));
    loading_status += 1;
  }

    //Locations 
  File[] locationsStrings = listFiles("backgrounds");
  Locations = new HashMap<String, Location>();  //Det kan være at dictornarying skal opretees her i stedet :?
  for(int i = 0; i< locationsStrings.length; i++)
  {
    String locationsName = locationsStrings[i].getName();

    //føjer billeder //<>//
    Locations.put(locationsName,new Location(locationsName)); //<>//
    loading_status += 1;
  }
  _active_location = Locations.get("Amy_room");
  active_background = _active_location.image;
  
   //<>//
//Preload //<>//
  ur = loadImage("Assets/ur.png");
  map_icon = loadImage("Assets/map_icon.png");
  phone_icon = loadImage("Assets/phone.png");
  dialog_bar = loadImage("Assets/dialog.png");
  awkward_meter_img = loadImage("Assets/awkward.png");
  Arrow_cursor = loadImage("Assets/mouse_arrow_img.png");
  Hand_cursor = loadImage("Assets/mouse_hand_img.png");

  
    //texts
  Dialog_font = createFont("Assets/Fonts/teen.regular.ttf",20);
  Dialog_italic = createFont("Assets/Fonts/teen.italic.ttf",20);
  Dialog_bold = createFont("Assets/Fonts/teen.bold.ttf",20);
  Question_font = createFont("Assets/Fonts/quest.ttf",20);
  menu_font = createFont("Assets/Fonts/menu2.ttf",20);
    
    //lyde
  //Menu_sound = new SoundFile(this);
  Menu_sound = new SoundFile(this,"Assets/lyd/menu/sound.mp3");
  Current_sound = Menu_sound;

  File[] music = listFiles("Assets/lyd");              //loader musik
  for(int i = 0; i< music.length; i++) {
    try{
    //føjer billeder
      music_sounds = (SoundFile [])append(music_sounds, new SoundFile(this,"Assets/lyd/" + music[i].getName() + "/sound.mp3"));
      music_sounds_names = (String [])append(music_sounds_names, new String(music[i].getName()));
    } catch(java.lang.RuntimeException e){
      println(e);
    }
    loading_status += 5;
  }

  resize_images();
  
      loading_status = 101;
}
