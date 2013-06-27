
public static float SPACING = PI / 29.0f;
public static float SIZE = 100f;
public static float RADIAL_SPACING = 0.10f;
public static float SPEED_FACTOR = 0.3f;
float[] rotation_offset = {0f, PI, -HALF_PI, HALF_PI, 3 / 2f * PI};
float[] rotations = {0.15f, -0.07f, 0.15f, -0.08f, 0.12f};
int[] num_circles = {5,6,10,39,5};
float[] circle_size = {3f, 4f, 3f, 6f, 2f};


public void setup() {
  frameRate(30);
  size( 500, 500 );
}

public void draw() {
  drawBackground();
  float radius = SIZE;
  for( int i = 0; i < rotation_offset.length; ++i ) {
    drawCircles( radius, rotation_offset[i], num_circles[i], circle_size[i]);
    radius -= circle_size[i] * 2 + SIZE * RADIAL_SPACING;
  }
  rotation_offset = rotateCircles( rotation_offset, rotations );
}

public float[] rotateCircles( float[] rotation_offsets, float[] rotations ) {
  for( int i = 0; i < rotation_offsets.length; ++i ) {
    rotation_offsets[i] = (rotation_offsets[i] + rotations[i] * SPEED_FACTOR) % (2 * PI);
  }
  return rotation_offsets;
}

/** 
 * Draw a background.  This ensures that the circles are cleared each round
 */
public void drawBackground() {
  background( 50 );
}

/**
 * Draw some circles at some radius from the center of the display.
 * Rotate clockwise unless the rotation_direction is negative
 */
public void drawCircles( float radius, float rotation_offset, int number_circles, float circle_radius) {
  float center_x = width / 2.0f;
  float center_y = height / 2.0f;
  float circle_x, circle_y;
  int segments_between_circles = number_circles - 1;
  // The small subtraction on the end is to deal with float point errors on
  // rounding
  float radians_in_arc = number_circles * ((circle_radius * 2f)/radius + SPACING);
  float radians_between_circles = (float) (radians_in_arc / (float) segments_between_circles - 0.1);
  float arc_length = radians_in_arc * radius;

  float degree = rotation_offset;

  for( int i = 0; i<number_circles && degree < PI * 2f - radians_between_circles + rotation_offset; ++i) {
    circle_x = (float) (center_x + radius * Math.cos( degree ));
    circle_y = (float) (center_y + radius * Math.sin( degree ));
    drawCircle( circle_radius, circle_x, circle_y );
    degree += radians_between_circles;
  }

}

/**
 * draw a cool looking circle at the point given with the given radius
 */
public void drawCircle( float radius, float x, float y ) {
  ellipseMode(RADIUS);
  ellipse(x,y,radius,radius);
}
