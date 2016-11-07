SpaceShip shipMagellan;
Bullet [] bulletList;
ArrayList <Asteroid> asteroidList = new ArrayList <Asteroid>();
//input variables
boolean keyW = false;
boolean keyA = false;
boolean keyS = false;
boolean keyD = false;
boolean keySpace = false;
//your variable declarations here
float speedCont = 5;
int bulletListLength = 0;
int frameCounter = 0;
public void setup() 
{
	size(1000,600);
	shipMagellan = new SpaceShip();
	bulletList = new Bullet[300];
	for(int i =0;i<30;i++)
	{
		asteroidList.add(new Asteroid());
		asteroidList.get(i).accelerate();
	}
}
public void draw() 
{
	background(0);
	frameCounter++;
	if (mousePressed == true&&frameCounter%3==0){fireBullet();}
	if (frameCounter>=60){frameCounter=0;}
	for (int i=0;i<bulletListLength;i++)
	{
		bulletList[i].move();
		bulletList[i].rotate();
		bulletList[i].show();
	}
	for (int i=0;i<asteroidList.size();i++)
	{
		asteroidList.get(i).move();
		asteroidList.get(i).rotate();
		asteroidList.get(i).show();
	}
	shipMagellan.rotate();
	shipMagellan.show();
	shipMagellan.move();
	shipMagellan.accelerate();
	loadBar();
}
public void fireBullet()
{
	int bulletNum=1024;
	for(int i=0;i<bulletListLength;i++)
	{
		if(bulletList[i].getDead()==true) {bulletNum = i;}
	}
	if (bulletNum!=1024)
	{
		bulletList[bulletNum] = new Bullet();
		bulletList[bulletNum].accelerate();
	}
	else
	{
		bulletList[bulletListLength] = new Bullet();
		bulletList[bulletListLength].accelerate();
		bulletListLength+=1;
	}
}
public void keyPressed()
{
	if ((key == 'w')||(key=='W')) {keyW = true;}
	if ((key == 's')||(key=='S')) {keyS = true;}
	if ((key == 'a')||(key=='A')) {keyA = true;}
	if ((key == 'd')||(key=='D')) {keyD = true;}
	if ((key == ' ')) {keySpace = true;}
}
public void keyReleased()
{
	if ((key == 'w')||(key=='W')) {keyW = false;}
	if ((key == 's')||(key=='S')) {keyS = false;}
	if ((key == 'a')||(key=='A')) {keyA = false;}
	if ((key == 'd')||(key=='D')) {keyD = false;}
	if ((key == ' ')) {keySpace = false;}
}
public void loadBar()
{
	stroke(255);
	fill(0);
	rect(9,9,181,11);
	noStroke();
	fill(255);
	rect(10,10,shipMagellan.getWarpPoint(),10);
}
public void killAsteroid()
{
	for (int loop1=0;loop1<bulletListLength;loop1++)
	{
		for (int loop2=0;loop2<asteroidList.size();loop2++)
		{
			if (dist(bulletList[loop1].getX(),bulletList[loop1].getY(),asteroidList.get(loop2).getX(),asteroidList.get(loop2).getX())<=20)
			{

			}
		}
	}
}
class SpaceShip extends Floater  
{
	private int warpPoint;
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
        warpPoint = 0;
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
    public int getWarpPoint() {return warpPoint;}
    public void accelerate()
    {
      	if (keyW==true) {myDirectionY=-speedCont;}
      	if (keyA==true) {myDirectionX=-speedCont;}
      	if (keyS==true) {myDirectionY= speedCont;}
      	if (keyD==true) {myDirectionX= speedCont;}
      	if (keyW==false&&keyS==false&&myDirectionY!=0)
      	{
      		if (myDirectionY>0) {myDirectionY-=speedCont*0.05;}
      		if (myDirectionY<0) {myDirectionY+=speedCont*0.05;}
      		if (abs((float)myDirectionY)<speedCont*0.05) {myDirectionY=0;}
      	}
      	if (keyA==false&&keyD==false&&myDirectionX!=0)
      	{
      		if (myDirectionX>0) {myDirectionX-=speedCont*0.05;}
      		if (myDirectionX<0) {myDirectionX+=speedCont*0.05;}
			if (abs((float)myDirectionX)<speedCont*0.05) {myDirectionX=0;}
      	}
    }
    public void rotate(){myPointDirection=((-Math.atan2(mouseX-myCenterX, mouseY-myCenterY))*180/PI)+90;}
    public void move ()
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
        if (keySpace == true&&warpPoint>=180)
        {
        	double dRadians =myPointDirection*(Math.PI/180);
        	if (dist((int)(myCenterX+(75*Math.cos(dRadians))),(int)(myCenterY+(75*Math.sin(dRadians))),(int)myCenterX,(int)myCenterY)<dist(mouseX,mouseY,(int)myCenterX,(int)myCenterY))
        	{
        		myCenterX += 125*Math.cos(dRadians);
        		myCenterY += 125*Math.sin(dRadians);
			}else
			{
				myCenterX = mouseX;
				myCenterY = mouseY;
			}
        	warpPoint = 0;
        }
    	if (warpPoint>=180)
    	{
    		warpPoint = 180;
    	}else
    	{
    		warpPoint++;
    	}

    }   
}
class Bullet extends Floater
{
	protected int fuelPoint;
	protected boolean isDead;
	public Bullet()
	{
        corners = 8;
        xCorners = new int[corners];
        yCorners = new int[corners];
        int [] xCornersTemp = {0,1,3, 1, 0,-1,-3,-1};
        int [] yCornersTemp = {3,1,0,-1,-3,-1, 0, 1};
        xCorners = xCornersTemp;
        yCorners = yCornersTemp;
        myColor = color(0,255,0);
        myCenterX = shipMagellan.getX();
        myCenterY = shipMagellan.getY();
        myDirectionX = 0;
        myDirectionY = 0;
        myPointDirection = 0;
        fuelPoint = 225;
        isDead = false;
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
    public boolean getDead() {return isDead;}
    public void rotate()
    {
    	myPointDirection += 1;
    	if (myPointDirection>=360) {myPointDirection=0;}
    }
    public void accelerate()
    {
    	double dRadians =shipMagellan.getPointDirection()*(Math.PI/180);
    	myDirectionX = (speedCont*1.25 * Math.cos(dRadians));
    	myDirectionY = (speedCont*1.25 * Math.sin(dRadians));
    }
    public void move()
    {
    	myCenterX+=myDirectionX;
    	myCenterY+=myDirectionY;
    	if (myCenterX<-20) {myCenterX=width+20;}
    	if (myCenterX>width+20) {myCenterX=-20;}
    	if (myCenterY<-20) {myCenterY=width+20;}
    	if (myCenterY>width+20) {myCenterY=-20;}
    	fuelPoint-=1;
    	if (fuelPoint >=0) {myColor = color(0,fuelPoint,0);}
    	else {isDead =true;}
    }
}
class Asteroid extends Bullet
{
	public Asteroid()
	{
		corners = 8;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = (int)(Math.random()*20)+1;
		yCorners[0] = (int)(Math.random()*20)+1;
		xCorners[1] = (int)(Math.random()*20)+1;
		yCorners[1] = (int)(Math.random()*20)+1;
		xCorners[2] = (int)(Math.random()*20)-21;
		yCorners[2] = (int)(Math.random()*20)+1;
		xCorners[3] = (int)(Math.random()*20)-21;
		yCorners[3] = (int)(Math.random()*20)+1;
		xCorners[4] = (int)(Math.random()*20)-21;
		yCorners[4] = (int)(Math.random()*20)-21;
		xCorners[5] = (int)(Math.random()*20)-21;
		yCorners[5] = (int)(Math.random()*20)-21;
		xCorners[6] = (int)(Math.random()*20)+1;
		yCorners[6] = (int)(Math.random()*20)-21;
		xCorners[7] = (int)(Math.random()*20)+1;
		yCorners[7] = (int)(Math.random()*20)-21;
		myColor = color(255,0,0);
		myPointDirection=0;
		fuelPoint = (int)(Math.random()*30)+20;
		isDead=false;
	}
	public void accelerate()
    {
    	if(Math.random()>0.5)
    	{
    		if(Math.random()>0.5)
    		{
    			myCenterX=(int)(Math.random()*640)-19;
    			myCenterY=-10;
    		}else
    		{
    			myCenterX=(int)(Math.random()*640)-19;
    			myCenterY=610;
    		}
    	}else 
    	{
    		if(Math.random()>0.5)
    		{
    			myCenterY=(int)(Math.random()*640)-19;
    			myCenterX=-10;
    		}else
    		{
    			myCenterY=(int)(Math.random()*640)-19;
    			myCenterX=1010;
    		}
    	}
		double dRadians =((int)(Math.random()*361))*(Math.PI/180);
		myDirectionX = (speedCont*0.75 * Math.cos(dRadians));
		myDirectionY = (speedCont*0.75 * Math.sin(dRadians));
    }
    public void move()
    {
    	myCenterX+=myDirectionX;
    	myCenterY+=myDirectionY;
    	if (myCenterX<-20) {myCenterX=width+20;}
    	if (myCenterX>width+20) {myCenterX=-20;}
    	if (myCenterY<-20) {myCenterY=width+20;}
    	if (myCenterY>width+20) {myCenterY=-20;}
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