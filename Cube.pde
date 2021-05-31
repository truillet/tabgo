import java.util.Hashtable; 
import java.util.Map; 
/**
 * Classe Cube modélisant le cube dans l'espace ainsi que son caractère en braille.
 * Cette classe servira à déterminer si un cube répond aux caractéristiques recherchés.
 *  p1-----m1---->p2  
 *  |  s1  |  s2  |
 *  d1------m2-----d2
 *  |  s3  c  s4  |
 *  d4------m3-----d3
 *  |  s5  |  s6  |
 *  p4<----m4-----p3
 *
 *@author Felix Dupeysset
 *
 */


class Cube {
  int seuilBrightness = 180;  

  PVector p1, p2, p3, p4;

  PVector min, max;

  PVector m1, m2, m3, m4;

  PVector d1, d2, d3, d4;

  PVector c;

  float s1, s2, s3, s4, s5, s6;
  int   n1, n2, n3, n4, n5, n6;

  float largeur, hauteur;

  Character monCharacter;

  Cube( PVector rp1, PVector rp2, PVector rp3, PVector rp4) {
    p1 = rp1;  
    p2 = rp2;
    p3 = rp3;
    p4 = rp4;
    
    monCharacter = '@';
  }

  public Character getValue(){
    return this.monCharacter;
  }
  
  boolean estValide(PImage src) {
    if (diagonalePerpendiculaire()&&diagonaleEgales() && centreSymetrie() && orientationHoraire() && coteEgaux()){
      calculCoordoneesPoints();
      calculScore(src);
      return couleurValide();
    }
    return false;
  }
  
  /**
   * Détermine si les diagonales du cube sont de même longueur
   * permet d'éviter les rectangles
   * @return true si cette différence < approximation de l'Hypoténuse, sinon false
   */
  boolean diagonaleEgales() {
    return abs(dist(p1.x, p1.y, p3.x, p3.y)-dist(p2.x, p2.y, p4.x, p4.y)) < dist(p1.x, p1.y, p3.x, p3.y)*.2+dist(p1.x, p1.y, p3.x, p3.y)*.2;
  }
  
  /**
   * Détermine si il y a un centre de symétrie 
   * en sortie que des parallélogramme
   * @return true si centre de symétrie, sinon false
   */
  boolean centreSymetrie() {
    return abs(abs((p2.y - p1.y)) - abs((p4.y - p3.y)))< 15 && abs((p2.x - p1.x)) - abs((p4.x - p3.x)) < 15 && abs(abs((p3.y - p2.y)) - abs((p1.y - p4.y)))< 15 && abs(abs((p3.x - p2.x)) - abs((p1.x - p4.x)))< 15;
  }
  
  /**
   * Détermine si les diagonales du cube sont perpendiculaire 
   * 
   * @return true si perpendiculaire, sinon false
   */
  boolean diagonalePerpendiculaire() {
    PVector v1 = new PVector(p3.x-p1.x, p3.y-p1.y);
    PVector v2 = new PVector(p4.x-p2.x, p4.y-p2.y); 
    float a = PVector.angleBetween(v1, v2);
   
    return (abs(90-abs(degrees(a)))<15);
  }
    /**
   * Détermine si la différence de la moyenne de la taille des côtés opposés sont de même longueurs
   * permet d'éviter les rectangles
   * @return true si cette différence <25, sinon false
   */
   boolean coteEgaux() {
    float d1 = abs(dist(p1.x, p1.y, p2.x, p2.y))+abs(dist(p3.x, p3.y, p4.x, p4.y))/2;
    float d2 = abs(dist(p1.x, p1.y, p4.x, p4.y))+abs(dist(p2.x, p2.y, p3.x, p3.y))/2;
    return abs(d1-d2) < 25;
  }

  /**
   * Détermine si le cube est bien en majeur partie de couleur noire
   * permet d'éviter un cube qui n'est pas un cubarithme (exemple : deux cubarithmes proches)
   * @return true si >75% des pixels du cubes sont au dessus du seuil, sinon false
   */
  boolean couleurValide() {
    return (s1+s2+s3+s4+s5+s6)/(n1+n2+n3+n4+n5+n6) >0.75;
  }

  /**
   * Détermine si les points du cubes sont bien ordonnés dans le sens horaire
   * permet d'éviter les cubes mal orientés
   * @return true si ordonnés, sinon false
   */
  boolean orientationHoraire() {
    return p3.x >= p1.x && p1.y <= p3.y && p2.x >= p4.x &&  p2.y <= p4.y;
  }
  
 /**
   * Détermine les nombreux points nécessaires aux calculs et pour les représenter
   * points : min,max,d1,d2,d3,d4,m1,m2,m3,m4,c
   * données : largeur,hauteur
   * @return true si ordonnés, sinon false
   */
  
  void calculCoordoneesPoints() {
    min = new PVector(min(min(p1.x, p2.x, p3.x), p4.x), min(min(p1.y, p2.y, p3.y), p4.y));
    max = new PVector(max(max(p1.x, p2.x, p3.x), p4.x), max(max(p1.y, p2.y, p3.y), p4.y));

    d1 = new PVector(p1.x+(p4.x-p1.x)/3, p1.y+(p4.y-p1.y)/3);
    d4 = new PVector(p1.x+((p4.x-p1.x)/3)*2, p1.y+((p4.y-p1.y)/3)*2);

    d2 = new PVector(p2.x+(p3.x-p2.x)/3, p2.y+(p3.y-p2.y)/3);
    d3 = new PVector(p2.x+((p3.x-p2.x)/3)*2, p2.y+((p3.y-p2.y)/3)*2);

    m1 = new PVector(p1.x+(p2.x-p1.x)/2, p1.y+(p2.y-p1.y)/2);
    m4 = new PVector(p4.x+(p3.x-p4.x)/2, p4.y+(p3.y-p4.y)/2);

    m2 = new PVector(m1.x+(m4.x-m1.x)/3, m1.y+(m4.y-m1.y)/3);
    m3 = new PVector(m1.x+((m4.x-m1.x)/3)*2, m1.y+((m4.y-m1.y)/3)*2);



    largeur = max.x - min.x;
    hauteur = max.y - min.y;
    c = new PVector(min.x+largeur/2, min.y+hauteur/2);
  }
 
 /**
   * Calcul le nombre de pixel au dessus d'un seuil pour chaque zone
   *  on parcourt tous les pixels du cube, on compte le nombre de pixel par zone 
   *  ainsi que le nombre de pixels au dessus d'un seuil.
   */
  void calculScore(PImage src) {
    int seuil = seuilBrightness;

    for (int i = (int)min.x; i < max.x; i++) {
      for (int j =(int)min.y; j< max.y; j++) { 

        //ZONE S1
        if (pixelAppartientPolygon(i, j, p1, m1, m2, d1)) {
          n1++;    
          if (brightness(src.pixels[i + j*src.width]) < seuil)s1++;
        }

        //ZONE S2
        if (pixelAppartientPolygon(i, j, m1, p2, d2, m2)) {
          n2++;      
          if (brightness(src.pixels[i + j*src.width]) < seuil)s2++;
        }

        //ZONE S3
        if (pixelAppartientPolygon(i, j, d1, m2, m3, d4)) {
          n3++;        
          if (brightness(src.pixels[i + j*src.width]) < seuil)s3++;
        }

        //ZONE S4
        if (pixelAppartientPolygon(i, j, m2, d2, d3, m3)) {
          n4++;       
          if (brightness(src.pixels[i + j*src.width]) < seuil)s4++;
        }

        //ZONE S5
        if (pixelAppartientPolygon(i, j, d4, m3, m4, p4)) {
          n5++;           
          if (brightness(src.pixels[i + j*src.width]) < seuil) {
            s5++;
          }
        }
        //ZONE S6
        if (pixelAppartientPolygon(i, j, m3, d3, p3, m4)) {
          n6++;    
          if (brightness(src.pixels[i+j*src.width]) < seuil)s6++;
        }
      }
    }
  }
  /**
     * Détermine si un pixel appartient à une zone représentée par 4 points
     * @param x de type int correspond au coordonee x du pixel 
     * @param y de type int correspond au coordonee y du pixel
     * @param HautGauche de type PVector correspond au point en Haut à Gauche de notre zone
     * @param HautDroite de type PVector correspond au point en Haut à Droite de notre zone
     * @param BasDroite de type PVector correspond au point en Bas à Droite de notre zone
     * @param BasGauche de type PVector correspond au point en Bas à Gauche de notre zone
     * @return true si le pixel appartient à la zone,sinon false
     */
  boolean pixelAppartientPolygon(int x, int y, PVector HautGauche, PVector HautDroite, PVector BasDroite, PVector BasGauche) {
    boolean valide = true;
    
    valide = -(HautGauche.y-HautDroite.y) * x + (HautGauche.x-HautDroite.x) * y + -(-(HautGauche.y-HautDroite.y) * HautDroite.x + (HautGauche.x-HautDroite.x) * HautDroite.y)<=0;

    valide = valide && -(HautDroite.y-BasDroite.y) * x + (HautDroite.x-BasDroite.x) * y + -(-(HautDroite.y-BasDroite.y) * BasDroite.x + (HautDroite.x-BasDroite.x) * BasDroite.y)<=0;

    valide = valide && -(BasDroite.y-BasGauche.y) * x + (BasDroite.x-BasGauche.x) * y + -(-(BasDroite.y-BasGauche.y) * BasGauche.x + (BasDroite.x-BasGauche.x) * BasGauche.y)<=0;

    valide = valide && -(BasGauche.y-HautGauche.y) * x + (BasGauche.x-HautGauche.x) * y + -(-(BasGauche.y-HautGauche.y) * HautGauche.x + (BasGauche.x-HautGauche.x) * HautGauche.y)<=0;

  


    return valide;
  }
  
  void setCharacter(Character monChar){
    monCharacter = monChar;
  }


 /**
     * Dessine des cercles aux points particuliers du cube
     */

  void dessineCercle() {
    stroke(0, 0, 255);
    circle(src.width+300+d1.x, d1.y, 30);
    circle(src.width+300+d2.x, d2.y, 30);

    circle(src.width+300+d3.x, d3.y, 30);
    circle(src.width+300+d4.x, d4.y, 30);
  }

  void dessinePoint() {
    stroke(255, 0, 0);
    strokeWeight(3);
  }
     
     /**
     * Dessine le cube
     */
  void dessineCube() {
    stroke(255, 0, 0);
    int decallage = 0;
    strokeWeight(1);
    line(decallage+p1.x, p1.y, decallage+p2.x, p2.y);
    line(decallage+p1.x, p1.y, decallage+p4.x, p4.y);
    line(decallage+p2.x, p2.y, decallage+p3.x, p3.y);
    line(decallage+p4.x, p4.y, decallage+p3.x, p3.y);
    textSize(50);
    fill(255, 255,255);
     textSize(50);
    
    fill(207,181,59);
    noStroke();
    
    circle(decallage+c.x, c.y,30);
    fill(255, 255, 255);
    text(monCharacter, decallage+c.x, c.y+100);
  }
 
 /**
     * Dessine le cube d'une manière plus complète
     */
  void dessineCubeComplet() {

    textSize(50);
    fill(255, 255, 255);
    //text("1", p1.x, p1.y);
   // text("2", p2.x, p2.y);
   // text("3", p3.x, p3.y);
   // text("4", p4.x-30, p4.y);

    stroke(255, 215, 0);
    line(min.x, min.y, max.x, min.y);
    line(max.x, min.y, max.x, max.y);
    line(max.x, max.y, min.x, max.y);
    line(min.x, max.y, min.x, min.y);
    stroke(127, 255, 212);
    line(m1.x, m1.y, m4.x, m4.y);
    line(d1.x, d1.y, d2.x, d2.y);
    line(d3.x, d3.y, d4.x, d4.y);
  }

 /**
     * Print les positions du cubes
     */
  void printPos() {
    println("coin 1 :", (int) p1.x, "|", (int) p1.y, " coin 2 :", (int)p2.x, "|", (int)p2.y, " coin 3 :", (int)p3.x, "|", (int)p3.y, " coin 4 :", (int)p4.x, "|", (int)p4.y);
    println("");
  }
 /**
     * Print l'écart en hauteur des points
     */
  void printEcartHauteur() {
    println("1-2 | 3-4:", (p2.y - p1.y), "|", (p4.y - p3.y), "=>", abs((p2.y - p1.y) * 0.95) < abs((p4.y - p3.y)));
    println("2-3 | 4-1:", (p3.y - p2.y), "|", (p1.y - p4.y), "=>", abs((p2.y - p1.y) * 1.15) > abs((p4.y - p3.y)));
    println("");
  }
}
