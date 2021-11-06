class ClickableObj {
    int x;
    int y;
    //Dette kan godt reworkes til at få bedre
    int width;
    int height;



    boolean Clicked(){
        if(can_press == true 
            && mouseX > int(x*scale_x - (width*scale_x)/2)
            && mouseX < int(x*scale_x + (width*scale_x)/2)
            && mouseY > int(y*scale_y- (height*scale_y)/2)
            && mouseY < int(y*scale_y + (height*scale_y)/2)
        ){
            return true;
        }

        return false;
    }

    boolean ClickedAction(){
        if(can_press == true 
            && mouseX > int(x*scale_x - (width*scale_x)/2)
            && mouseX < int(x*scale_x + (width*scale_x)/2)
            && mouseY > int(y*scale_y- (height*scale_y)/2)
            && mouseY < int(y*scale_y + (height*scale_y)/2)
        ){
            ClickAction();
            return true;
        }

        return false;
    }

    void ClickAction()
    {
    }
    
    void draw()
    {
    }
}


class LocationObject {
    private PImage image;
    PImage glow;
    int x,y,_width,_height;
    int startTime;
    int endTime;
    String name;
    int lastUpdatedTime = -10;
    String ActiveImageName;

    LocationObject()
    {
        
    }

    LocationObject(PImage image, int tempx,int tempy,int tempWidth,int tempHeight,PImage newImg, int tempStartTime, int tempEndTime)
    {
        setPos(tempx,tempy,tempWidth,tempHeight);
        setImage(newImg);
        startTime = tempStartTime;
        endTime =tempEndTime;
    }



    void newLocation(int tempx,int tempy,int tempWidth,int tempHeight,PImage newImg)
    {
        setPos(tempx,tempy,tempWidth,tempHeight);
        setImage(newImg);
    }

    void setPos(int tempx,int tempy,int tempWidth,int tempHeight)
    {
        x = tempx;
        y = tempy;
        width = tempWidth;
        height = tempHeight;
    }

    void setImage(PImage newImg)
    {
        image = newImg;
        image.resize((int)(_width*scale_x),(int)(_height*scale_y));
    }

    boolean mouseOver()
    {
      println("x:" + int(mouseX-x*scale_x));
      println("y:" + int(mouseY-y*scale_y));
                  
      if(alpha(image.get(int(mouseX-x*scale_x) , int(mouseY-y*scale_y))) > 1){      
        return true;
      }
      return false;
    }
    
    void draw()
    {
      if(image != null && startTime < time && endTime > time){

        if(mouseOver())
        {
            println("over");

            overlay.beginDraw();
            overlay.rect(x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);
            //overlay.image(glow, x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);      
            overlay.endDraw();
        }
 //<>//

        clicklay.beginDraw();
        clicklay.image(image, x*scale_x , y*scale_y);       //<>// //<>// //<>// //<>//
        clicklay.endDraw(); 
      }
    }
}
