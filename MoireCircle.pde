class MoireCircle
{
  /** The radius of the inner most circle */
  public int innerRadius = 10;
  
  /** The amount of room between concentric circles */
  public int lineSpace = 40;
  
  /** The width of each of the concentric circles */
  public int lineWidth = 7;
  
  /** The color of each circle */
  public color lineColor = color(50, 50, 50);
  
  /** Where are we? */
  public PVector position = new PVector(screenWidth/2, screenHeight/2);
  
  /** How fast are we moving? */
  public PVector velocity = new PVector(0, 0);
  
  /** What's the fastest we can go? */
  public int maxVelocity = 8;
  
  /** What are the minimum bounds the circles should move around in? */
  public PVector minBound = new PVector(0, 0);
  
  /** What are the maximum bounds the circles should move around in? */
  public PVector maxBound = new PVector(width, height);  
    
  /** Temporary variable used to figure out the corner we're furthest from and caluculate how many concentric circles to draw */
  private PVector furthestCorner = new PVector();
  
  /** The radius of the largest circle */
  private float maxRadius;
  
  /** The number of concentric circles to draw */
  private int numCircles;
  
  /**
   * Get crazy
   */
  void randomise()
  {
    position.x = random(0, width);
    position.y = random(0, height);
    
    velocity.x = random(0, maxVelocity);
    velocity.y = random(0, maxVelocity);
    velocity.limit(maxVelocity);
  }
  
  /**
   * Fill the screen with concentric circles from our current position
   */
  void drawMoire()
  {
    stroke(lineColor);
    strokeWeight(lineWidth);
  
    // draw the concentric circles. only draw ones that will appear on the screen
    numCircles = getNumCirclesToDraw();
  
    for (int i = 0; i < numCircles; i++)
    {
      ellipse(position.x, position.y, innerRadius + (i * lineSpace), innerRadius + (i * lineSpace));
    }
  }
  
  /**
   * For the current position and line spacing, how many concentric circles should be draw on the screen?
   */ 
  private int getNumCirclesToDraw()
  {
    // the max radius of the circles is always relative to a corner of the screen
    // figure out which is the furthest corner from our position
    if (position.x < width/2)
    {
      furthestCorner.x = width;
    }
    else
    {
      furthestCorner.x = 0;
    }
    
    if (position.y < height/2)
    {
      furthestCorner.y = height;
    }
    else
    {
      furthestCorner.y = 0;
    }
    
    maxRadius = PVector.dist(position, furthestCorner);
    
    return ceil(maxRadius/lineSpace) * 2;
  }
  
  /**
   * High level update method. This could delegate down to specific types of motion: linear, sinusoidal, etc
   */
  void updateMoire()
  {
    updateWithBounceMovement();
  }
  
  /**
   * A nice regular bounce at the min and max bounds
   */
  void updateWithBounceMovement()
  {
    position.x = constrain(position.x + velocity.x, minBound.x, maxBound.x);
    if ( (position.x == minBound.x) || (position.x == maxBound.x) )
    {
        velocity.x *= -1;
    }
    
    position.y = constrain(position.y + velocity.y, minBound.y, maxBound.y);
    if ( (position.y == minBound.y) || (position.y == maxBound.y) )
    {
        velocity.y *= -1;
    }
  }
}
