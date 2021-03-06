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
    PImage image;
    PImage glow;
    int x,y,_width,_height;
    int startTime;
    int endTime;
    String name;
    int lastUpdatedTime = -10;
    String ActiveImageName;
    String type;

    boolean noImage = false;

    LocationObject()
    {
        
    }

    LocationObject(PImage image, int tempx,int tempy,int tempWidth,int tempHeight,PImage newImg, int tempStartTime, int tempEndTime, String tempType)
    {
        setPos(tempx,tempy,tempWidth,tempHeight);
        setImage(newImg);
        resizeImage();
        startTime = tempStartTime;
        endTime = tempEndTime;
        type = tempType;
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
        _width = tempWidth;
        _height = tempHeight;

        resizeImage();
    }

    void setImage(PImage newImg)
    {        
        image = newImg;
        resizeImage();
        noImage = false;
    }

    public void resizeImage()
    {
        if(image != null && _width != 0 && _height != 0){
            image.resize((int)(_width*scale_x),(int)(_height*scale_y));
            if(glow != null){
              glow.resize((int)(_width*scale_x),(int)(_height*scale_y));
            }
        }
    }

    boolean mouseOver()
    {
        if(image != null){
            if(alpha(image.get(int((mouseX-x*scale_x)) , int((mouseY-y*scale_y)))) > 1){      
                return true;
            }
            return false;
        }
        else{
            if(mouseX-x*scale_x > 0 && mouseX-x*scale_x < _width*scale_x  && mouseY-y*scale_y > 0 && mouseY-y*scale_y < _height*scale_y){      
                return true;
            }
            return false;
        }
    }
    
    void draw()
    { //<>//
      if(startTime < time && endTime > time){

        if(mouseOver())
        {
            mouseclickable = true;
            mouseclick = new String[2];
            mouseclick[0] = type;
            mouseclick[1] = name;

            if(glow != null){
                overlay.beginDraw();
                overlay.image(image, x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);       
                overlay.endDraw();
            }else{
                rect(x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);
            }
        }

        if(image != null){
            clicklay.beginDraw();
            clicklay.fill(255,255,255,255);
            clicklay.image(image, x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);
            clicklay.endDraw();
        }else{
            clicklay.beginDraw();
            clicklay.fill(0,0,0,0);
            clicklay.rect(x*scale_x , y*scale_y, _width*scale_x , _height*scale_y);
            clicklay.endDraw();
        } 
      } 
    }
}
