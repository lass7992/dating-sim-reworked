String [] achive_array = new String[0];
int achive_counter = 0;

void achive_drawing(){
  if(achive_counter < 125 && achive_array.length > 0){
    int i;
    if(achive_counter < 25){i = achive_counter;}else if(achive_counter < 100){i = 25;} else{i = 125-achive_counter;}
    strokeWeight(5);    
    textAlign(CENTER, CENTER);
    textSize(15*scale_x);
    fill(255,255,255);
    rect(screen_x/2 -200*scale_x ,i*2*scale_y -50*scale_y  ,400*scale_x,50*scale_y);

    fill(0,0,0);
    text(achive_array[0].substring(0, achive_array[0].indexOf("$"))  ,screen_x/2 -100*scale_x   ,i*2*scale_y+8*scale_y-50*scale_y);
    text(achive_array[0].substring(achive_array[0].indexOf("$")+1)  ,screen_x/2                ,i*2*scale_y+25*scale_y-50*scale_y);
    strokeWeight(2);
    achive_counter += 2;
  }else if(achive_counter >= 100){achive_counter = 0; achive_array = subset(achive_array,1);}
}

void add_achive(String acc){
  String [] earned_archive = loadStrings("Save/profile/achive.txt");
  
  try{
    boolean not_earned = true;
    for(int i = 0; i< earned_archive.length;i++){
      if(earned_archive[i].equals(acc)){
        not_earned = false;
      }
    }
    if(not_earned == true){
      String [] achive = loadStrings("Assets/achivements/" + acc +"/acc.txt");
      achive_array = (String[])append(achive_array,achive[0]);
      
      
       //sørger for at adde achivementet til profilen
      PrintWriter output = createWriter("Save/profile/achive.txt"); 
      for(int i = 0; i < earned_archive.length;i++){
        output.println(earned_archive[i]);
      }
      output.println(acc);
      output.flush();
      output.close();
    }
  }catch(java.lang.RuntimeException e){
    String [] achive = loadStrings("Assets/achivements/" + acc +"/acc.txt");
    achive_array = (String[])append(achive_array,achive[0]);
    
    PrintWriter output = createWriter("Save/profile/achive.txt"); 
    output.println(acc);
    output.flush();
    output.close();
  }
}
