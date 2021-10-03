
//profile data
Boolean lyd = true;
float text_speed = 1;
float volume = 100;
int screen_x = 1280;
int screen_y = 720;

boolean full;
Boolean skip = false;


int skip_tick = 0;

//game data
float scale_x;
float scale_y;

Boolean exit = false;
int loading_status = 0;

boolean game_startet = false;

// mouse clickable
boolean mouseclickable = false;
String [] mouseclick = new String[0];



  //backgorund

HashMap<String, Location> Locations;
PImage active_background;

  //surface
PGraphics overlay;  //øverste lag
PGraphics clicklay; //click laget

//Game Save Data
String name = "Player";
float awkward_stat = 0;

      
PGraphics save_img;

String  dialog_location;
String  dialog_dia;
String  dialog_ver;

  //time  
int time = 6;
int dage = 0;

//interupts
boolean keybord_ready = true;
Boolean can_press = true;


//menu
boolean menu_active = true;
String menu_type = "menu";
int [][] hearts;
PImage [] heart_img;
PImage background_girls;




//location
Location _active_location;
String active_location;

String [][] location_data;

String new_location;
String transit_text;
int new_time;
boolean transition = false;

//Girl
HashMap<String, girl> Girls_classes;



boolean girl_active = false;
String [] active_girl = new String[0];
PImage [] active_girl_img = new PImage[0];
String [] clothing = new String[0];


//Classes
info_text [] info_text_instances = new info_text[0];
  




  

//dialog
int text_done = 1;    // if 1 then the text is not done. if 2 then the text is skippet. if 3 the text is done
float dialog_char_at = 0;
float dialog_fade_at = 0;
int dialog_next = 0;
boolean dialog_active;
int dialog_nr;
String dialog_name;
String [] dialog_text;
String current_mood = "default";
Boolean qust_active = false;
String active_girl_dialog;
PImage active_girl_img_dialog;
String clothing_dialog;
int [] active_girl_pos;

int girl_slide = -100;

  //black screen
Boolean  black_screen = false;
float black_counter = 0;
String balck_text;
String black_screen_dir; 




  //fonts
PFont Dialog_font;
PFont Dialog_italic;
PFont Dialog_bold;
PFont Question_font;
PFont menu_font;




//Phone
String last_location;
Boolean phone_active = false;
String active_girl_phone = "NONE";
PImage active_girl_phone_img;

int active_Relationship_stat;
int active_mood_stat;


//assets
PImage ur;
PImage dialog_bar;
PImage map_icon;
PImage phone_icon;
PImage awkward_meter_img;
PImage Arrow_cursor;
PImage Hand_cursor;




//lyde
import processing.sound.*;
String [] music_sounds_names = new String [0];
SoundFile [] music_sounds = new SoundFile[0];
SoundFile Menu_sound;
String Current_sound_name = "menu";
SoundFile Current_sound;
