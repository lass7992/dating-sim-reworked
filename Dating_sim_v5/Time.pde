void pass_time(){
  if( time < 23){
    time ++;
  }else{
    time = 0;
  }
  
  girl_active = false;
  active_girl = new String[0];

  for (Map.Entry<String,girl> girlEntry : Girls_classes.entrySet()) {
    girlEntry.getValue().check_girls();
  }
}
