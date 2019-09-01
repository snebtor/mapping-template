import java.io.BufferedWriter;
import java.io.FileWriter;
import netP5.*;


// Pressing 'w' stores the coordinates of current shapes
// Pressing 'r' loads the shapes previously saved in polygons.txt
// pressing any other key applies texture on polygons


PGraphics pg;
//PImage 


boolean scene1 = true;
boolean scene2 = false;
boolean scene3 = false;
boolean scene4 = false;
boolean scene5 = false;
boolean scene6 = false;
boolean scene7 = false;
boolean whiteline = false;
boolean blackline = true;




class Vertx {
 int x, y;
 Vertx(int xV, int yV) {
   x = xV;
   y = yV;
 }
} 

Vertx[]vertices;
Vertx vx1, vx2, vx3, vx4;
boolean firstpress, polygonClosed, editMode, applytex;
int x1, y1, x2, y2, a, verticesIndex;
float xoff, yoff,val1,val2;


int r1, r2, r3;

 
float time_passed;



void settings() {
  //fullScreen(P3D,SPAN); // use this one for multiple screens
  fullScreen(P3D);
}


void setup() {
  //fullScreen(P3D);
  frameRate(25);
  cursor(CROSS);
  //noCursor();
  
  pg = createGraphics(340, 340);
  

  
  
  pg = createGraphics(340, 340); // pg is the name of the window that is mapped
  textureMode(NORMAL);
  vertices = new Vertx[0];
    firstpress = editMode = true;
    polygonClosed = applytex = false;
    verticesIndex = 0;
    a = 0;
    smooth();
    background(0);
    
}

void draw() {
   
 
   
   //area for prototyping

  //
  if (scene1)pagina1(); //agregar animaciones
  if (scene2) ;
  if (scene3) ;
  if (scene4) ;
   if (scene5);
   if (scene6);
   if (scene7);
  
  
  //paint the pg image in the intro window
  image(pg, 10, 10,100,100); 
  fill(255);
  
  text("EDITMODE: ON:", width-400,10);
  text("TO SAVE PRESS W; TO RELOAD PRESS R", width-400,30);
  text("CLICK 4 POINTS TO CREATE A POLYGON AND PRESS SPACE TO PLAY", width-400,50);
  
  
  xoff += random(-0.6,0.6);
  
  //ADD GEOMETRY CREATION TOOL )No network
  if (applytex == true && vertices.length != 0) {
    background(0);
    
    for (int i=0; i<vertices.length; i=i+4) {      
      noStroke();
      
        //shape 1
      beginShape();
      texture(pg);
      vertex(vertices[i].x, vertices[i].y, 0, 0); 
      vertex(vertices[i+1].x, vertices[i+1].y, 1, 0); 
      vertex(vertices[i+2].x, vertices[i+2].y, 1, 1); 
      vertex(vertices[i+3].x, vertices[i+3].y, 0, 1); 
      endShape(CLOSE);    
    } 
  }  
}


void mousePressed() {
   
   applytex = false;
  if (firstpress == true){
    x1 = mouseX;
    y1 = mouseY;
    x2 = x1;
    y2 = y1;
    firstpress = false;
    
    vertices = (Vertx[]) expand(vertices, verticesIndex+1);
    vertices[verticesIndex] = new Vertx(x1, y1);   
  }else{
    x1 = x2;
    y1 = y2;
    x2 = mouseX;
    y2 = mouseY;

    //verticesIndex++;
    if (verticesIndex % 4 > 0 || polygonClosed == true) {
      vertices = (Vertx[]) expand(vertices, verticesIndex+1);
      vertices[verticesIndex] = new Vertx(x2, y2);
      polygonClosed = false;
    } else {
      polygonClosed = true;
      firstpress = true;
    }
  }
}

void mouseReleased(){
  if (verticesIndex % 4 == 0 && firstpress == true) {
    x2 = vertices[vertices.length-4].x;
    y2 = vertices[vertices.length-4].y;
    verticesIndex--;
    
  }
    verticesIndex++;
   // noStroke();
    stroke(225);
    //strokeWeight(1);
    line(x1, y1, x2, y2);
}

void keyPressed() {
  if (key == 'w') {   // write to file
    String points = "";
    for (int i = 0; i < vertices.length; i++) {
        String p1 = str(vertices[i].x);
        String p2 = str(vertices[i].y);
        points += p1 + "," + p2 + ";";       
    }
    String[] list = split(points, ';');
    // Writes the strings to a file, each on a separate line
     saveStrings("points.txt", list);    
  
  } else if (key == 'r') {
    String[] points = loadStrings("points.txt");

    vertices = (Vertx[]) expand(vertices, points.length-1);
    verticesIndex = points.length-1;
    
    for (int i = 0 ; i < points.length-1; i++) {      
      String[] list = split(points[i], ',');
      println("we are at index:  " + i);
      println(list[0]);
      println(list[1]);
      int px = Integer.parseInt(list[0]); 
      int py = Integer.parseInt(list[1]); 
      vertices[i] = new Vertx(px, py);   
    }
    
    applytex = true;
  
  } else {
    // apply texture to polygon(s)
    applytex = true;
  }
  
  if ( key == '1' )scene1 = !scene1;
  if ( key == '2' )scene2 = !scene2;
  if ( key == '3' )scene3 = !scene3;
  if ( key == '4' )scene4 = !scene4;

    if ( key == '5' )scene5 = !scene5;
     if ( key == '6' )scene6 = !scene6;
     if ( key == '7' )scene7 = !scene7;
  
  if ( key == 'a' )whiteline=!whiteline;
  if ( key == 's' )blackline=!blackline;
  
}
