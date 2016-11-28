//NESSESSARY OBJECT DECLARATIONS
SpaceShip shipMagellan;
Bullet [] bulletList;
CancerHead mainCancerHead;
ArrayList <Asteroid> asteroidList = new ArrayList <Asteroid>();
//INPUT VARIABLES
boolean keyW = false;
boolean keyA = false;
boolean keyS = false;
boolean keyD = false;
boolean keySpace = false;
//GLOBAL VARIABLES
float speedCont = 5;
int bulletListLength = 0;
int frameCounter = 0;
int shipHealth = 100;
//SCREENS
boolean titleScreen = true;
boolean bossSelectScreen = false;
boolean cancerEnterScreen = false;
boolean cancerBossScreen = false;
boolean deathScreen = false;
//BUTTONS
Button aquariusStart;
Button piscesStart;
Button ariesStart;
Button taurusStart;
Button geminiStart;
Button cancerStart;
Button leoStart;
Button virgoStart;
Button libraStart;
Button scorpioStart;
Button sagittariusStart;
Button capricornStart;
public void setup() 
{
	size(1000,600);
	shipMagellan = new SpaceShip();
	bulletList = new Bullet[300];
	cancerStart = new Button("CANCER",20,875,150,150,150);
}
public void draw() 
{
	if(titleScreen==true){titleDraw();}
	else if(bossSelectScreen==true){bossSelectDraw();}
	else if(deathScreen == true){deathScreenDraw();}
	else if(cancerBossScreen == true){cancerBossDraw();}
}
public void mouseClicked()
{
	if(titleScreen==true)
	{
		titleScreen=false;
		bossSelectScreen=true;
		frameCounter=0;
	}
	if(bossSelectScreen==true&&cancerStart.isHovering()==true)
	{
		bossSelectScreen=false;
		cancerEnterDraw();
		cancerBossScreen=true;
	}
}
public void titleDraw()
{
	background(0);
	textAlign(CENTER,CENTER);
	fill(255);
	textSize(20);
	text("Click anywhere to start",500,500);
}
public void bossSelectDraw()
{
	background(0);
	cancerStart.show();
}
public void shipMove()
{
	frameCounter++;
	if(shipHealth>0)
	{
		if (mousePressed==true&&frameCounter%6==0){fireBullet();}
		if (frameCounter>=600){frameCounter=0;}
		for (int i=0;i<bulletListLength;i++)
		{
			bulletList[i].move();
			bulletList[i].rotate();
			if (bulletList[i].getDead()==false)
			{
				bulletList[i].show();
			}
		}
		shipMagellan.rotate();
		shipMagellan.move();
		shipMagellan.show();
		shipMagellan.accelerate();
	}
	loadBar();
    if(shipHealth<=0)
    {
    	deathScreen=true;
    	shipHealth=0;
    }
}
public void cancerEnterDraw()
{
	for(int i =0;i<5;i++)
	{
		asteroidList.add(new Asteroid(4,(int)(Math.random()*1360)-180,-80));
	}
	mainCancerHead = new CancerHead();
}
public void cancerBossDraw()
{
	background(0);
	if (frameCounter%100==0){generateAsteroids();}
	for (int i=0;i<asteroidList.size();i++)
	{
		asteroidList.get(i).move();
		asteroidList.get(i).rotate();
		if (asteroidList.get(i).getDead()==false)
		{
			asteroidList.get(i).show();
		}
	}
	shipMove();
	if(shipHealth>0)
	{
		hitSomethingCancer();
	}
	mainCancerHead.show();
	destroyAsteroids();
}
public void deathScreenDraw()
{
	if(cancerBossScreen==true){cancerBossDraw();}
	if(frameCounter>=6){frameCounter=0;}
	fill(255);
	textSize(100);
	textAlign(CENTER,CENTER); 
	text("YOU DIED",500,275);
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
	stroke(0,0,255);
	noFill();
	rect(810,579,181,11);
	stroke(255);
	rect(9,579,181,11);
	noStroke();
	fill(0,0,255);
	rect(811,580,shipMagellan.getWarpPoint(),10);
	fill(255);
	rect(10,580,(int)(shipHealth*1.8),10);
}
public void hitSomethingCancer()
{
	//BULLET ASTEROID CONTACT
	for (int loop1=0;loop1<bulletListLength;loop1++)
	{
		for (int loop2=0;loop2<asteroidList.size();loop2++)
		{
			if (dist(bulletList[loop1].getX(),bulletList[loop1].getY(),asteroidList.get(loop2).getX(),asteroidList.get(loop2).getY())<=(asteroidList.get(loop2).getSize()*15))
			{
				if(bulletList[loop1].getFuel()/10<asteroidList.get(loop2).getFuel())
				{
					asteroidList.get(loop2).setFuel(asteroidList.get(loop2).getFuel()-((int)(bulletList[loop1].getFuel()/asteroidList.get(loop2).getSize())));
					bulletList[loop1].setFuel(0);
				}else
				{
					bulletList[loop1].setFuel(bulletList[loop1].getFuel()-(asteroidList.get(loop2).getFuel()*asteroidList.get(loop2).getSize()));
					asteroidList.get(loop2).setFuel(0);				}
			}
		}
	}
	//SHIP ASTEROID CONTACT
	for (int loop1=0;loop1<asteroidList.size();loop1++)
	{
		if(dist(asteroidList.get(loop1).getX(),asteroidList.get(loop1).getY(),shipMagellan.getX(),shipMagellan.getY())<=(asteroidList.get(loop1).getSize()*13)+8&&asteroidList.get(loop1).getDead()==false)
		{
			shipHealth-=asteroidList.get(loop1).getSize();
			asteroidList.get(loop1).setFuel(0);
		}
	}
	//BULLET BOSS HEAD CONTACT
	for (int lp1=350;lp1<650;lp1++)
	{
		for(int lp2=0;lp2<bulletListLength;lp2++)
		{
			if(dist(lp1,60,bulletList[lp2].getX(),bulletList[lp2].getY())<52&&bulletList[lp2].getDead()==false)
			{
				mainCancerHead.setHealth(mainCancerHead.getHealth()-1);
				bulletList[lp2].setDead(true);
			}
		}
	}
}
public void generateAsteroids()
{
	int [] astdSizeCount = new int[4];
	for (int lp1=0;lp1<asteroidList.size();lp1++){astdSizeCount[asteroidList.get(lp1).getSize()-1]++;}
	if(astdSizeCount[0]<=2&&asteroidList.size()<=64){asteroidList.add(new Asteroid(4,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[1]<=4&&asteroidList.size()<=64){asteroidList.add(new Asteroid(3,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[2]<=8&&asteroidList.size()<=64){asteroidList.add(new Asteroid(2,(int)(Math.random()*1200)-100,-100));}
	if(astdSizeCount[3]<=16&&asteroidList.size()<=64){asteroidList.add(new Asteroid(1,(int)(Math.random()*1200)-100,-100));}
}
public void destroyAsteroids()
{
	for(int lp1=0;lp1<asteroidList.size();lp1++)
	{
		if(asteroidList.get(lp1).getDead()==true)
		{
			asteroidList.remove(lp1);
			lp1--;
		}
	}
}
class SpaceShip extends Floater  
{
	private int warpPoint,counter;
	private boolean shipSpecial;
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
        shipSpecial=false;
        counter=0;
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
    public void rotate(){myPointDirection=(Math.atan2(mouseY-myCenterY,mouseX-myCenterX))/PI*180;}
    public void move ()
    {
    	myCenterX += myDirectionX;
        myCenterY += myDirectionY;
        if(myCenterX>width-20) {myCenterX = width-20;}    
        else if(myCenterX<20){myCenterX = 20;}    
        if(myCenterY>height-20){myCenterY = height-20;}   
        else if (myCenterY<20){myCenterY = 20;}
        if (keySpace == true&&warpPoint>=180)
        {
			shipSpecial=true;
        	warpPoint = 0;
        }
    	if (warpPoint>=180){warpPoint = 180;}
    	else{warpPoint++;}
    	if(shipSpecial==true)
    	{
    		if(cancerBossScreen==true)
    		{
    			powerSurge();
    		}
    	}
    }
    public void powerSurge()
    {
		for(int lp1=0;lp1<asteroidList.size();lp1++)
		{
			if(dist(asteroidList.get(lp1).getX(),asteroidList.get(lp1).getY(),(float)myCenterX,(float)myCenterY)<=(60-counter)*5)
			{
				asteroidList.get(lp1).setDead(true);
			}
		}
    	counter++;
		noStroke();
		fill(0,200,0);
		ellipse((float)myCenterX,(float)myCenterY, (60-counter)*5, (60-counter)*5);
		if(counter==61)
		{
			counter=0;
			shipSpecial=false;
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
    public void setDead(boolean inputStatus){isDead=inputStatus;}
    public boolean getDead() {return isDead;}
    public int getFuel() {return fuelPoint;}
    public void setFuel(int inputFuel) {fuelPoint = inputFuel;}
    public void rotate()
    {
    	myPointDirection += 1;
    	if (myPointDirection>=360) {myPointDirection=0;}
    }
    public void accelerate()
    {
    	double dRadians =shipMagellan.getPointDirection()*(Math.PI/180);
    	myDirectionX = (speedCont*5 * Math.cos(dRadians));
    	myDirectionY = (speedCont*5 * Math.sin(dRadians));
    }
    public void move()
    {
    	myCenterX+=myDirectionX;
    	myCenterY+=myDirectionY;
    	if (myCenterX<-20) {isDead=true;}
    	if (myCenterX>width+20) {isDead=true;}
    	if (myCenterY<-20) {isDead=true;}
    	if (myCenterY>height+20) {isDead=true;}
    	fuelPoint-=1;
    	if (fuelPoint >=0) {myColor = color(0,fuelPoint,0);}
    	else {isDead =true;}
    }
}
class CancerHead
{
	private int myHealth,cdLine,cdSpray,counter;
	private boolean abLine,abSpray;
	public CancerHead()
	{
		myHealth=3600;
		cdLine=0;
		cdSpray=0;
		counter=0;
	}
	public void setHealth(int inputHealth){myHealth=inputHealth;}
	public int getHealth(){return myHealth;}
	public void show()
	{
		stroke(255,0,255);
		fill(255,0,255);
		rect(300,10,400,100,50);
		stroke(255);
		fill(255);
		rect(319,54,362,12);
		stroke(255,0,255);
		fill(255,0,255);
		rect(320,55,(int)(myHealth*0.1),10);
		cdLine++;
		cdSpray++;
		if((cdLine*Math.random())>600&&abSpray==false){abLine=true;}
		if(abLine==true){fireLine();}
	}
	public void fireLine()
	{
		counter++;
		stroke(255,0,0);
		line(500,110,shipMagellan.getX(),shipMagellan.getY());
		if((counter-60>=0)&&(counter%12==0)){asteroidList.add(new Asteroid(2,500,110,true));}
		if(counter>=125)
		{
			abLine=false;
			cdLine=0;
			counter=0;
		}
	}
}
class Asteroid extends Bullet
{
	int astdSize;
	boolean astdSpecial;
	public Asteroid(int inputSize, double inputX, double inputY)
	{
		corners = 8;
		astdSize = inputSize;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = astdSize*15;
		yCorners[0] = 0;
		xCorners[1] = astdSize*10;
		yCorners[1] = astdSize*10;
		xCorners[2] = 0;
		yCorners[2] = astdSize*15;
		xCorners[3] = astdSize*-10;
		yCorners[3] = astdSize*10;
		xCorners[4] = astdSize*-15;
		yCorners[4] = 0;
		xCorners[5] = astdSize*-10;
		yCorners[5] = astdSize*-10;
		xCorners[6] = 0;
		yCorners[6] = astdSize*-15;
		xCorners[7] = astdSize*10;
		yCorners[7] = astdSize*-10;
		myCenterX = inputX;
		myCenterY = inputY;
		myColor = color(255,0,0);
		myPointDirection=0;
		fuelPoint = 225;
		isDead=false;
		astdSpecial=false;
		accelerate();
	}
	public Asteroid(int inputSize, double inputX, double inputY,boolean inputStatus)
	{
		corners = 8;
		astdSize = inputSize;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = astdSize*15;
		yCorners[0] = 0;
		xCorners[1] = astdSize*10;
		yCorners[1] = astdSize*10;
		xCorners[2] = 0;
		yCorners[2] = astdSize*15;
		xCorners[3] = astdSize*-10;
		yCorners[3] = astdSize*10;
		xCorners[4] = astdSize*-15;
		yCorners[4] = 0;
		xCorners[5] = astdSize*-10;
		yCorners[5] = astdSize*-10;
		xCorners[6] = 0;
		yCorners[6] = astdSize*-15;
		xCorners[7] = astdSize*10;
		yCorners[7] = astdSize*-10;
		myCenterX = inputX;
		myCenterY = inputY;
		myColor = color(255,0,0);
		myPointDirection=0;
		fuelPoint = 225;
		isDead=false;
		astdSpecial=inputStatus;
		accelerate();
	}
	public void setSize(int inputSize){astdSize=inputSize;}
	public int getSize() {return astdSize;}
	public void setDead (boolean inputDead){isDead=inputDead;}
	public void accelerate()
    {
    	double dRadians;
    	if(astdSpecial==true)
    	{
    		dRadians = (atan2(shipMagellan.getY()-60,shipMagellan.getX()-500));
			myDirectionX = 3*(speedCont/astdSize * Math.cos(dRadians));
			myDirectionY = 3*(speedCont/astdSize * Math.sin(dRadians));
    	}
    	else
    	{
			dRadians =((int)(Math.random()*361))*(Math.PI/180);
			myDirectionX = (speedCont/astdSize * Math.cos(dRadians));
			myDirectionY = (speedCont/astdSize * Math.sin(dRadians));
		}
    }
    public void move()
    {
    	myCenterX+=myDirectionX;
    	myCenterY+=myDirectionY;
    	if (myCenterX<-80) 
    	{
    		myCenterX=width+80;
    		if(astdSpecial==true){isDead=true;}
    		else{fuelPoint=225;}
    	}
    	else if (myCenterX>width+80) 
    	{
    		myCenterX=-80;
    		if(astdSpecial==true){isDead=true;}
    		else{fuelPoint=225;}
    	}
    	if (myCenterY<-80) 
    	{
    		myCenterY=width+80;
    		if(astdSpecial==true){isDead=true;}
    		else{fuelPoint=225;}
    	}
    	else if (myCenterY>width+80)
    	{
    		myCenterY=-80;
    		if(astdSpecial==true){isDead=true;}
    		else{fuelPoint=225;}
    	}
    	if (fuelPoint<=0)
    	{
    		isDead=true;
    		if(astdSpecial==true)
    		{
    			asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY,true));
    		}
    		else if(astdSize>1)
    		{
    			asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY));
    			asteroidList.add(new Asteroid(astdSize-1,myCenterX,myCenterY));
    		}
    	}
    	else{myColor = color(255,255-fuelPoint,0);}
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
class Button
{
	private int myX, myY, myWidth, myLength, myTextSize, myStrokeColorNormal, myStrokeColorHover, myFillColorNormal, myFillColorHover;
	private float myHoverConstant;
	private String myText;
	private int [] hoverRange;
	private boolean hovering, clickable;
	public Button(String inputText, int inputTextSize, int inputX, int inputY, int inputWidth, int inputLength)
	{
		myText=inputText;
		myTextSize=inputTextSize;
		myX=inputX;
		myY=inputY;
		myWidth=inputWidth;
		myLength=inputLength;
		myStrokeColorNormal = color(255,255,255);
		myFillColorNormal = color(0,0,0);
		myStrokeColorHover=myStrokeColorNormal;
		myFillColorHover=myFillColorNormal;
		myHoverConstant=1.1;
		hovering=false;
		clickable=true;
	}
	public void show()
	{
		if(clickable==false){myFillColorNormal=color(220,220,220);}
		if(mouseX>myX-(myWidth*0.5)&&mouseX<myX+(myWidth*0.5)&&mouseY>myY-(myLength*0.5)&&mouseY<myY+(myLength*0.5)&&clickable==true)
		{
			println("ran");
			hovering=true;
			stroke(myStrokeColorHover);
			fill(myFillColorHover);
			rect(myX-(0.5*myWidth*myHoverConstant),myY-(0.5*myLength*myHoverConstant),myWidth*myHoverConstant,myLength*myHoverConstant);
			fill(myStrokeColorHover);
			textSize((int)(myTextSize*myHoverConstant));
			textAlign(CENTER,CENTER);
			text(myText,myX,myY);
		}
		else
		{
			hovering=false;
			stroke(myStrokeColorNormal);
			fill(myFillColorNormal);
			rect(myX-(0.5*myWidth),myY-(0.5*myLength),myWidth,myLength);
			fill(myStrokeColorNormal);
			textSize(myTextSize);
			textAlign(CENTER,CENTER);
			text(myText,myX,myY);		
		}
	}
	public boolean isHovering(){return hovering;}
}