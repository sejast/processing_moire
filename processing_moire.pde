/**
 * Simple demostration of moire interference 
 *
 * Author: Phil Chan
 */
int screenWidth = 800;
int screenHeight = 500;

color backgroundColor = color(255);

int numCircles = 2;
ArrayList<MoireCircle> circles = new ArrayList<MoireCircle>(numCircles);

void setup()
{
  size(screenWidth, screenHeight);

  // noSmooth();  // turn off anti-aliasing to run faster
  noFill();
  
  // create our circles
  for (int i = 0; i < numCircles; i++)
  {
    circles.add(new MoireCircle());
    circles.get(i).randomise();
  }
  
  // setupMoireCross();
}

void setupMoireCross()
{
  int numCirclesInCross = 5;
  
  circles = new ArrayList<MoireCircle>(numCirclesInCross);
  
  for (int i = 0; i < numCirclesInCross; i++)
  {
    circles.add(new MoireCircle());
    circles.get(i).lineWidth = 5;
  }
  
  // central circle
  circles.get(0).lineColor = color(170, 170, 170);
  
  // horizontals
  circles.get(1).velocity.x = -4;
  circles.get(2).velocity.x = 4;
  
  // verticals
  circles.get(3).velocity.y = 3;
  circles.get(4).velocity.y = -3;
}

void draw()
{
  background(backgroundColor);
  
  for (MoireCircle circle: circles)
  {
    circle.updateMoire();
    circle.drawMoire();
  }
    
  // println(frameRate);
  // saveFrame("frames/#####.tif");
}

