void mood_change(int x, String girl){ //<>//
    girl currentGirl = Girls_classes.get(girl); //<>//

  if(currentGirl != null){
    currentGirl.mood_stat += x;
    if(currentGirl.mood_stat < 0){ currentGirl.mood_stat = 0;}
  }
}

void relationship_change(int x, String girl){ 
  girl currentGirl = Girls_classes.get(girl);

  if(currentGirl != null){
    if(currentGirl.relationship_stat+x <= currentGirl.max_relationship){
      currentGirl.relationship_stat += x;        
    }
    else if(currentGirl.relationship_stat < 0)
    { 
      currentGirl.relationship_stat = 0;
    }
    else
    { 
      currentGirl.relationship_stat = currentGirl.max_relationship;
    }
  }
}
