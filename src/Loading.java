import processing.core.*;


public class Loading extends PApplet {

public static float SPACING = PI / 20.0f;
public static float SIZE = 50f;
public static float RADIAL_SPACING = 0.10f;
public static float SPEED_FACTOR = 0.3f;
float[] rotation_offset = {0f, PI, -HALF_PI, HALF_PI, 3 / 2f * PI};
float[] rotations = {0.15f, -0.11f, -0.19f, -0.08f, 0.12f};
int[] num_circles = {5,6,10,3,6};
float[] circle_size = {3f, 4f, 3f, 2.5f, 2f};
float[] randoms = {2, 1, 10, -7, 3};
float[] current_direction = {0f,0f,0f,0f,0f};
int[] colors = {color(233, 233, 0), color(233, 0, 0), color(0, 233, 0), color(0, 0, 233), color(0, 233, 233) };
float time_element = 0;

public void setup() {
  frameRate(60);
  if (frame != null) {
    frame.setResizable(true);
  }
}

public void draw() {
  drawBackground();
  float radius = SIZE;
  for( int i = 0; i < rotation_offset.length && radius > circle_size[i]; ++i ) {
    //drawGuide( radius );
    drawCircles( radius, rotation_offset[i], num_circles[i], circle_size[i], colors[i], current_direction[i]);
    radius -= circle_size[i] * 2 + SIZE * RADIAL_SPACING;
  }
  rotation_offset = rotateCircles( rotation_offset, rotations, randoms );
  time_element += 0.1;
}

public float timeFunction( float time, float random_factor ) {
  return (float)( 2 * Math.sin(time / random_factor / 10) - Math.pow(Math.cos(time / random_factor / 10), 15));
}

public float[] rotateCircles( float[] rotation_offsets, float[] rotations, float[] randoms ) {
  for( int i = 0; i < rotation_offsets.length; ++i ) {
    float gain = rotations[i] * SPEED_FACTOR * timeFunction(time_element, randoms[i]);
    current_direction[i] = gain;
    rotation_offsets[i] = (rotation_offsets[i] + gain ) % (2 * PI);
  }
  return rotation_offsets;
}

/** 
 * Draw a background.  This ensures that the circles are cleared each round
 */
public void drawBackground() {
  background( 50 );
}

public void drawGuide( float radius ) {
  noFill();
  stroke(0, 50);
  ellipseMode(RADIUS);
  ellipse(width / 2f, height / 2f,radius,radius);
}

/**
 * Draw some circles at some radius from the center of the display.
 * Rotate clockwise unless the rotation_direction is negative
 */
public void drawCircles( float radius, float rotation_offset, int number_circles, float circle_radius, int colors, float current_direction) {
  noStroke();
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
    fill(0);
    int picked_index = (int)((current_direction + .05f) / .1f * number_circles); //+ number_circles / 2.0f);
    /*
     *if (i == 0 && number_circles == 5) {
     *  System.out.println("current_Direction " + current_direction);
     *  System.out.println("dir " + picked_index);
     *}
     */
    float percent_trans = Math.abs(picked_index - i) / (float) (number_circles);
    if( percent_trans > 1 ) {
      percent_trans = 1;
    }
    int transparency = 255 - (int) (percent_trans * 255);
    fill(colors, transparency);
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

}
