public class DetectionCube {
   /**
   * Classe DetectionCube modélisant la liste des points et des Cubes sur mon Image
   * Cette classe servira à rechercher dans mon image la liste des points et des cubes.
   * @author Felix DUPEYSSET
   *
   */
  List<Cube> mesCubes;
  List<Point> mesPoints;
  Braille monBraille;

  private color maCouleur;
  private PImage imageSource;
  private int taille = 150;

  DetectionCube(PImage src) {
    mesCubes = new ArrayList<Cube>();
    mesPoints = new ArrayList<Point>();
    monBraille = new Braille();

    maCouleur = color(68, 101, 126);
    imageSource = src;

    recherche();
    
  }

  public List<Cube> getListCubes(){
    return this.mesCubes;
  }
  
  /**
   * Change la couleur cible
   * @param nouvelleCouleur de type color 
   */
  void setCouleur(color nouvelleCouleur) {
    maCouleur = nouvelleCouleur;
    recherche();
  }
  
  /**
   * Change l'image
   * @param nouvelleImage de type PImage 
   */
  void setImage(PImage nouvelleImage) {
    imageSource = nouvelleImage;
    recherche();
  }
  
  /**
   * Change la taille des segments 
   * @param nouvelleTaille de type int 
   */
  void setTaille(int nouvelleTaille) {
    taille = nouvelleTaille;
    recherche();
  }
  
  /**
   * recherche la liste des points, leur point moyen et des cubes; 
   */
  void recherche() {
    mesPoints = cherchePoint(imageSource, maCouleur);
    for(Point p : mesPoints){
      p.pointMoyen = p.calculPointMoyen(p.mesPixels);
    }
    mesCubes = chercheCube(mesPoints, taille-150, taille+150);
    for (Cube monCube : mesCubes){
      monCube.setCharacter(monBraille.decodeCube(monCube));
    }
  }

  /**
     * Détermine la liste des points dans l'image 
     * @param monImage de type PImage correspond à la zone de recherche des points
     * @param couleurCible de type color correspond à la couleur des pixel recherchée
     * @return une ArrayList de Point, qui sont des amas de PixelScore
     */
  List<Point> cherchePoint(PImage monImage, color couleurCible) {

    List<Point> listePoints = new ArrayList<Point>();
    for (int x = 0; x < monImage.width; x++) {
      for (int y = 0; y < monImage.height; y++ ) {
        int loc = x + y*monImage.width;   
        if (isNearCouleur(couleurCible, loc, monImage)) {
          boolean trouve = false;
          float score = calculScore(x, y, couleurCible, monImage);
          if (calculScore(x, y, color(79, 124, 170), monImage) <score){
            score = calculScore(x, y, color(79, 124, 170), monImage);
          }
          PixelScore monPixel = new PixelScore(x, y, score);

          if (listePoints.size() == 0) {           // si pas encore de point on en crée un et on ajoute le pixel
            listePoints.add(new Point(monPixel));
          } else {                                // on parcourt les point si le pixel est proche on l'agglomere au point

            for (Point monPoint : listePoints) {   
              if (monPoint.isNear(monPixel) || isNearCouleur(color(79, 124, 170),loc,monImage)) {
                monPoint.add(monPixel);
                trouve = true;
              }
            }                                 

            if (!trouve) {                     // si on a pas trouvé de blob proche du point on créé un blob avec le point
              listePoints.add(new Point(monPixel));
              trouve = true;
            }
          }
        }
      }
    }
    
    
    return listePoints;
  }

  /**
     * Détermine la liste des cubes valides dans l'image à partir des points
     * @param listePoints de type ArrayList<Point> correspond à la liste des points déjà trouvés
     * @param tailleMin de type int correspond à la taille minimun des segments (côté du quadrilatere)
     * @param tailleMax de type int correspond à la taille maximun des segments (côté du quadrilatere)
     * @return une ArrayList de Cube, qui sont les cubes valides présent dans l'image
     */
  List<Cube> chercheCube(List<Point> listePoints, int tailleMin, int tailleMax) {
    List<Cube> listeCubes = new ArrayList<Cube>();

    List<Point> trouve = new ArrayList<Point>();


    for (Point point1 : listePoints) {
      trouve.add(point1);
      for (Point point2 : listePoints) {
        if ( !trouve.contains(point2)) {
          trouve.add(point2);

          if (point1.distance(point2) >tailleMin && point1.distance(point2) <tailleMax ) {

            for (Point point3 : listePoints) {
              if ( !trouve.contains(point3)) {
                trouve.add(point3);

                if (point2.distance(point3) >tailleMin && point2.distance(point3) <tailleMax) {

                  for (Point point4 : listePoints) {
                    if ( !trouve.contains(point4)) {
                      trouve.add(point4);

                      if (point3.distance(point4) >tailleMin && point3.distance(point4) <tailleMax) {

                        if (point4.distance(point1) >tailleMin && point4.distance(point1) <tailleMax) {

                          Cube monCube = new Cube(point1.pointMoyen, point2.pointMoyen, point3.pointMoyen, point4.pointMoyen);

                          if (monCube.estValide(imageSource)) {
                            listeCubes.add(monCube);
                          }
                        }
                      }
                      trouve.remove(point4);
                    }
                  }
                }
                trouve.remove(point3);
              }
            }
          }
          trouve.remove(point2);
        }
      }
      trouve.remove(point1);
    }
    return listeCubes;
  }


  /**
     * Détermine le score d'une zone avec pour centre notre pixel proche du bleu
     * @param x de type int correspond au coordonee x du pixel 
     * @param y de type int correspond au coordonee y du pixel
     * @param couleurCible de type color correspond à la couleur des pixel recherchée
     * @param monImage de type PImage correspond à la zone de recherche des points
     * @return une valeur de type float qui correspond à la moyenne de la différence colorimétrique par rapport à notre couleur cible dans la zone autour du pixel
     */
  float calculScore(int x, int y, color couleurCible, PImage monImage) {

    int taille = 8;
    int s =0;
    for (int xrelatif = x-taille; xrelatif<x+taille+1; xrelatif++) {
      for (int yrelatif = y-taille; yrelatif<y+taille+1; yrelatif++) {
        if ( xrelatif >= 0 && yrelatif >= 0 ) {
          int loc = xrelatif + yrelatif*monImage.width;  
          if(loc < monImage.width*monImage.height){
            s+= distanceCouleur(couleurCible, loc, monImage);
          }
        }
      }
    }

    return s /((taille*2+1)*(taille*2+1));
  }


  /**
     * Détermine si deux couleurs sont éloignés à partir de leur valeur red green et blue 
     * @param couleurCible de type color correspond à la couleur des pixel recherchée
     * @param monImage de type PImage correspond à la zone de recherche des points
     * @param loc de type int correspond à un pixel
     * @return true si la couleur au pixel[loc] de l'image monImage est proche de la couleurCible, false sinon
     */
  boolean isNearCouleur(color couleurCible, int loc, PImage monImage) {
    boolean redTest = abs(red(couleurCible) - red(monImage.pixels[loc])) <20;
    boolean greenTest = abs(green(couleurCible) - green(monImage.pixels[loc])) <20;
    boolean blueTest = abs(blue(couleurCible) - blue(monImage.pixels[loc])) <20;

    return redTest && greenTest && blueTest;
  }
 /**
     * Détermine la somme de la différence de chaque valeur red green blue du pixel loc et de la couleurCible
     * @param couleurCible de type color correspond à la couleur des pixel recherchée
     * @param monImage de type PImage correspond à la zone de recherche des points
     * @param loc de type int correspond à un pixel
     * @return une valeur de type float qui correspond à la somme de la différence de chaque valeur red green blue
     */
  float distanceCouleur(color colorTrack, int loc, PImage monImage) {
    return abs(red(monImage.pixels[loc])-red(colorTrack))+ abs(green(monImage.pixels[loc])-green(colorTrack)) +abs(blue(monImage.pixels[loc])-blue(colorTrack));
  }
}
