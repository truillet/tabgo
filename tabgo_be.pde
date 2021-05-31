/*
 * TaBGO - Tangible Blocks Go Online
 * First prototype by Jean-Baptiste Marco (summer 2018)
 * Original code by Léa Berquez (summer 2020)
 * Adapté et amélioré par l'équipe du Bureau d'étude "TabGo" du Pr Philippe TRUILLET 2021 : 
 *  - Changement de la génération du JSON grâce à la librairie GSON
 *  - Nouvelle prise en charge des blocs et TopCode (nouvelle implémentation)
 *  - Amélioration de la détection des cubarithmes
 *  - Ajout du feedback audio
 *
 * Last Revision: 05/2021
 * 
 * utilise OpenCV 4.5 (12/10)
 * nettoyage du code (01/12)
 * création machine à états, changement de nom pour TaBGO (02/12)
 * ajout webcam + mode "T"est (03/12)
 * ajout du feedback audio via la librairie ttslib (05/21)
 *
 * TODO:
 *  modify some paths 
 */


import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.opencv.core.MatOfPoint2f;
import org.opencv.core.RotatedRect;
import org.opencv.imgproc.Imgproc;
import org.opencv.imgproc.Moments;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


import gab.opencv.Contour;
import processing.core.*;
import processing.video.*;

import guru.ttslib.*;


  private PImage src, destination;
  private Capture cam;
  protected Scanner scanner;
  private Gson gson;
  
  public enum FSM { 
      INITIAL, // Etat initial
      CREATION, // création de l'algorithme
    }     

  private FSM mae; // Finite State Machine
  
  private GestionBlocks g;
  private TTS tts;
  private TopCodesP  ts;
  private List<TopCode> codes;
  private DetectionCube maDetect;
  private int indCam;
  private String[] listCams;
  
  public void setting() {
    size(640,480);
  }
  
  public void setup() {
    size(640,480);
    GsonBuilder builder = new GsonBuilder();
    builder.serializeNulls();
    gson = builder.create();
    g = new GestionBlocks();
    tts = new TTS();
    mae = FSM.INITIAL;
    indCam = 0;
    listCams = Capture.list();
    cam = new Capture(this,listCams[0]);
    cam.start();
    
  }
  
  public void draw() {
    switch (mae) {
      case INITIAL:
        image(cam,0,0); 
        fill(0,0,0);
        text("Pour lancer l'exécution, appuyez sur la touche \" espace \"",10,20);
        text("Pour lancer un test, appuyez sur la touche \" T \"",10,40);
        text("Pour changer de caméra, appuyez sur la touche \" C \"",10,60);
        affichage();
        break;
        
      case CREATION: // creation de l'algorithme  
        creation(src);
        mae=FSM.INITIAL;
        break;
      
      default :
        break;
    }
  }
  
  public void captureEvent(Capture c) { // when an image is available
      c.read();
    }

  public void keyPressed(){
   // Temporaire 
   if (mae==FSM.INITIAL){
     switch (key) {
       
       // Pour lancer une image test
       case 'T':
       case 't':
        String im = dataPath("")+"/test_c1.jpg"; 
        src = loadImage(im);
        tts.speak("Starting test");
        mae = FSM.CREATION;
         break;
         
        // Pour changer de caméra
        case 'C':
        case 'c':
          tts.speak("Changing camera");
          indCam++;
          cam.stop();
          cam = new Capture(this,listCams[indCam % listCams.length]);
          cam.start();
          break;
          
       case ' ':
         src = cam.copy();
         tts.speak("Creating File");
         mae = FSM.CREATION;
         break;
       }
    } 
  }

  // creation de l'agorithme 
  public void creation(PImage im){
    FileExecution fe; 
    // Pour détection des cubes
    destination = im.copy();
    
    scanner = new Scanner();
    BufferedImage b = (BufferedImage) src.getNative();
    codes = scanner.scan(b); 
    
    // Récupération des TopCodes 
    println("__DETECTION DES TOPCODES__");
    ts = new TopCodesP(); 
    ts.findTopCodes(codes);   
    println("Nombre TopCodes trouvés : " + ts.getCodes().size()); 
    
    // Detection des cubes
     println("__DETECTION DES CUBES__");
     maDetect = new DetectionCube(src);
     println("Nombre de cubes trouvés : " + maDetect.getListCubes().size());
     
    // Construire l'algorithme 
    println("__CONSTRUCTION DE L'ALGORITHME__");
    FiltrageCubes fc = new FiltrageCubes(); 
    List<Blocks> listBlocks = fc.construitAlgorithme(ts.getCodes(), maDetect.getListCubes(),g);  
    println("Nombre de blocks : " + listBlocks.size()); 
    
    //Génération du JSON
    println("__GENERATION DU JSON__");
    String json = gson.toJson(new MainScratch(listBlocks));
    
    // File Execution pour créer le fichier 
    fe = new FileExecution(); 
    fe.fileE(json,tts);  
  }


  // Affichage des résultats
  public void affichage() {
    destination = cam.copy();
    destination.loadPixels();
    scanner = new Scanner();
    BufferedImage b = (BufferedImage) destination.getNative();
    codes = scanner.scan(b); 
    
    // Affichage des TopCodes
    ts = new TopCodesP(); 
    ts.findTopCodes(codes);  
    for(TopCode tp : codes){
      fill(255,255,255);
      circle(tp.getCenterX(),tp.getCenterY(),tp.getDiameter());
      fill(0,0,0);
      text(tp.getCode(),tp.getCenterX(),tp.getCenterY());
    }
    
    //Affichage des Cubarithmes
    maDetect = new DetectionCube(destination);
    for(Cube cube : maDetect.getListCubes()){
      cube.dessineCube();
    }
  }
