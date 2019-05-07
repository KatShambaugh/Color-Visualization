/**
 * Image
 * 
 * An Image object, which functions as a data point
 */
public class Image {
  String s;
  int x, y;
  color c;
  boolean over = false;
  PImage img;
  float brightness = 0.0;
  int[] hist = new int[256];

  /**
   * Creates an Image object, links its image file,
   * and documents the brightness frequency
   * @param name the name of the image file
   */
  public Image(String name) {
    s = name;
    try {
      img = loadImage("/Users/kateshambaugh/Documents/Processing/Data_Visualization/Images/" + name);
      img.resize(20, 20); //resized smaller here to save memory
      image(img, 0, 0);
      for (int i = 0; i < img.width; i++) { //creates array of brightness level frequency
        for (int j = 0; j < img.height; j++) {
          int bright = int(brightness(get(i, j)));
          hist[bright]++; 
        }
      }
      colorSorter();
    }
    catch (NullPointerException n) {
      System.out.println(s);
    }
  }
  
  /**
   * Gets average color of the picture
   * and the brightness.
   */
  private void colorSorter(){
    img.loadPixels();
    int r = 0, g = 0, b = 0;
    for (int i = 0; i < img.pixels.length; i++) {
        c = img.pixels[i];
        r += c >>16&0xFF;
        g += c >>8&0xFF;
        b += c &0xFF;
    }
    r /= img.pixels.length;
    g /= img.pixels.length;
    b /= img.pixels.length;
    c = color(r, g, b);
    brightness = brightness(c); 
  }
  
  /**
   * Returns brightness
   * @return the brightness as a float
   */
  public float getBrightness() {
    return brightness;
  }
 
  /**
   * Checks if the mouse is over the Image
   * @param px current mouse x position
   * @param py current mouse y position
   */
  void rollover(float px, float py) {
    if ((px >= x) && (px <= x + 14) && (py >= y) && (py <= y + 14)) {
      over = true; 
    } else {
      over = false;
    }
  }
  
  /**
   * Displays the Image as a rectangle,
   * displays the larger image and histogram
   * when Image is clicked on
   * @param x x position to display at
   * @param y y position to display at
   */
  public void display(int x, int y) {
    try {
      this.x = x;
      this.y = y;
      fill(c);
      rect(x, y, 14, 14);
      if ((over) && (mousePressed)) {
        img = loadImage("/Users/kateshambaugh/Documents/Processing/Data_Visualization/Images/" + s);
        img.resize(400,400);
        image(img, 270, 210); 
        int max = max(hist);
        for (int i = 0; i < img.width; i += 2) {
          int pix = int(map(i, 0, img.width, 0, 255));
          int yHist = int(map(hist[pix], 0, max, 610, 210));
          line(i + 710, 610, i + 710, yHist);
        }
      }
    } catch (NullPointerException n){
    }
  }
}
