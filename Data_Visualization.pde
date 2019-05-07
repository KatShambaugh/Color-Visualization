import java.util.ArrayList;
import java.util.List;

/**
 * Data Visualization
 * 
 * Loads all data from csv and governs display
 */
Table table;
List<Image> images = new ArrayList();

/**
 * Sets up the window and calls to load the data.
 */
void setup() {
  size(1420, 808);
  loadData(); 
}

/**
 * Calls display on each image object 
 */
void draw() {
  background(255);
  int x = 0;
  int y = 0;
  for (Image i : images) {
    i.display(x, y);
    i.rollover(mouseX, mouseY);
    x = x + 14;
    if (x > 1408) { //wraps it around screen
      y = y + 14;
      x = 0;
    }
    if ((y >= 200) && (y < 600)) { //keeps middle section clear for later
      y = y + 401;
    }
  }
}

/**
 * Loads the data from the csv into a table object,
 * creates new Images objects and adds them to the
 * ArrayList in order of decreasing brightness.
 */
public void loadData() {
  table = loadTable("data.csv", "header");
  for (TableRow row : table.rows()) {
    String s = row.getString("name");
    Image img = new Image(s);
    float brightness = img.getBrightness(); //Will be used to sort photos
    if (images.isEmpty()) {
      images.add(0, img);
    } else if (images.size() == 1) {
      if (brightness < images.get(0).getBrightness()) {
        images.add(1, img);
      } else {
        images.add(0, img);  
      }
    } else {
      Image current = images.get(0);
      int count = 0;
      while ((brightness < current.getBrightness()) && (count < images.size() - 1)) {
        current = images.get(count + 1);
        count++;
      }
      images.add(count, img);
    }
    System.out.println(images.size()); //Used to show user that program is loading
  }
}
