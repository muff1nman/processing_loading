
public static int NUMBER_CIRCLES = 5;
public static float TRAIL_ARC_SIZE = HALF_PI;
public static float SPACING = PI / 12.0f;
public static float SIZE = 50f;


public void setup() {
  frameRate(30);
  size( 500, 500 );
}

public void draw() {
  drawBackground();
  float[] rotation_offset = {0f, 0f, 0f};
  drawCircles( SIZE, rotation_offset[0] -1 );
  drawCircles( SIZE - 10f, rotation_offset[1], 1 );
  drawCircles( SIZE - 20f, rotation_offset[2], -1 );
}

/** 
 * Draw a background.  This ensures that the circles are cleared each round
 */
public void drawBackground() {
  background( 50 );
}

public void drawCircles( float radius, float rotation_offset ) {
  drawCircles( radius, rotation_offset, 1 );
}

/**
 * Draw some circles at some radius from the center of the display.
 * Rotate clockwise unless the rotation_direction is negative
 */
public void drawCircles( float radius, float rotation_offset, int rotation_direction) {
  float center_x = width / 2.0f;
  float center_y = height / 2.0f;
  float circle_x, circle_y;
  int segments_between_circles = NUMBER_CIRCLES - 1;
  // The small subtraction on the end is to deal with float point errors on
  // rounding
  float radians_between_circles = TRAIL_ARC_SIZE / (float) segments_between_circles - 0.1;
  float arc_length = TRAIL_ARC_SIZE * radius;
  float circle_radius = (arc_length - segments_between_circles * SPACING * radius) / (NUMBER_CIRCLES * 2.0f);

  for( float degree = rotation_offset; degree <= TRAIL_ARC_SIZE + rotation_offset; degree += radians_between_circles ) {
    circle_x = (float) (center_x + radius * Math.cos( degree ));
    circle_y = (float) (center_y + radius * Math.sin( degree ));
    drawCircle( circle_radius, circle_x, circle_y );
  }

  rotation_offset = (rotation_offset + 0.1 * rotation_direction / Math.abs(rotation_direction )) % (2 * PI);

}

/**
 * draw a cool looking circle at the point given with the given radius
 */
public void drawCircle( float radius, float x, float y ) {
  ellipseMode(RADIUS);
  ellipse(x,y,radius,radius);
}
