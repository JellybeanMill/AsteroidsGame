SpaceShip shipMagellan;
float decelspd = 0.1;
//input variables
boolean keyW = false;
boolean keyA = false;
boolean keyS = false;
boolean keyD = false;
//your variable declarations here
public void setup() 
{
  size(1000,600);
  shipMagellan = new SpaceShip();
}
public void draw() 
{
  background(0);
  shipMagellan.rotate();
  shipMagellan.show();
  shipMagellan.move();
  if (keyPressed==false) {shipMagellan.accelerate(-16);}
}
public void mousePressed()
{
}
public void keyPressed()
{
	if ((key == 'w')||(key=='W')) {keyW = true;}
	if ((key == 's')||(key=='S')) {keyS = true;}
	if ((key == 'a')||(key=='A')) {keyA = true;}
	if ((key == 'd')||(key=='D')) {keyD = true;}
}
public void keyReleased()
{
	if ((key == 'w')||(key=='W')) {keyW = false;}
	if ((key == 's')||(key=='S')) {keyS = false;}
	if ((key == 'a')||(key=='A')) {keyA = false;}
	if ((key == 'd')||(key=='D')) {keyD = false;}
}
class SpaceShip extends Floater  
{
    public SpaceShip()
    {
        corners = 26;
        xCorners = new int[corners];
        yCorners = new int[corners];
        int [] xCornersTemp = {16,8,4,2,2 ,6 ,6 ,-6,-6,-2,-2,-4,-8,-8,-4,-2, -2, -6, -6,  6,  6,  2, 2, 4, 8,16};
        int [] yCornersTemp = {2 ,4,8,8,10,10,14,14,10,10, 8, 8, 4,-4,-8,-8,-10,-10,-14,-14,-10,-10,-8,-8,-4,-2};
        xCorners = xCornersTemp;
        yCorners = yCornersTemp;
        myColor = color(255);
        myCenterX = 500;
        myCenterY = 300;
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 0;
    }
    public void setX(int x) {myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX (double x){myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY (double y){myDirectionY = y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection = degrees;}
    public double getPointDirection(){return myPointDirection;}
    public void accelerate(int inputDir)
    {
      	if (inputDir>=0)
      	{
        	double dRadians =inputDir*(Math.PI/180);
        	myDirectionX = (Math.cos(dRadians))*3;    
        	myDirectionY = (Math.sin(dRadians))*3;
    	}
    	else
    	{
    		if (myDirectionX != 0)
    		{
    			if (myDirectionX>0) {myDirectionX-=0.05;}
    			if (myDirectionX<0) {myDirectionX+=0.05;}
    		}
    		if (myDirectionY != 0)
    		{
    			if (myDirectionY>0) {myDirectionY-=0.05;}
    			if (myDirectionY<0) {myDirectionY+=0.05;} 
    		}
    	}
    }
    public void rotate(){myPointDirection=((-Math.atan2(mouseX-myCenterX, mouseY-myCenterY))*180/PI)+90;}
    public void move ()   //move the floater in the current direction of travel
    {    
        myCenterX += myDirectionX;    
        myCenterY += myDirectionY;
        if(myCenterX >width+20)
        {     
            myCenterX = 0;    
        }    
        else if (myCenterX<-20)
        {     
            myCenterX = width;    
        }    
        if(myCenterY >height+20)
        {    
            myCenterY = 0;    
        }   
        else if (myCenterY < -20)
        {     
    		myCenterY = height;
        }   
    }   
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

