//DENNE SER UD TIL AT BRUGE NOGET GAMMET KODE UPDATER PLZ til at bruge //_active_location = tempLocation; i stedet.
 
void set_location(Location newLocation){
  _active_location = newLocation;

  girl_active = false;
  active_girl = new String[0];

  _active_location.testTriggers();

// //ser om man må være ved stedet
//   if(dialog_active != true){
//     try{
//       String [] file = loadStrings("backgrounds/" + active_location + "/lim.txt");
//       girl tempGirl = Girls_classes.get(file[0]);
//       if(tempGirl != null){
//         if(tempGirl.story < int(file[1])){
//           dialog_text = load_dialog("triggers",file[2],file[3]);
//         }
//       }
//     } catch(java.lang.RuntimeException e){println(e);}
//   }
}


void set_location(String location){

  Location tempLocation = Locations.get(location);
  if(tempLocation != null){
    set_location(tempLocation);
  }
} 
