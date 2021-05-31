/**
 * Classe Braille modélisant l'alphabet braille et permettant à partir d'un Cube d'obtenir un charactère en braille.
 * Cette classe servira à déterminer le caractère en braille sur un cube.
 * @author Felix Dupeysset
 *
 */

class Braille {

  Map<String, Character> dicoBraille;
  float seuil = 0.98;


  Braille() {
    dicoBraille = rempliDictionnaire();
    //decodeBraille();
  }
  /**
   * Rempli un dictionnaire de braille
   * permet de transformer une chaine de String de binaire en charactère braille
   * @return le dictionnaire rempli de type Map<String, Character>
   */
  Map<String, Character> rempliDictionnaire() {
    Map<String, Character> dico = new Hashtable<String, Character>(); 

    dico.put("010111", '0');
    dico.put("100001", '1');
    dico.put("101001", '2');
    dico.put("110001", '3');
    dico.put("110101", '4');
    dico.put("100101", '5');
    dico.put("111001", '6');
    dico.put("111101", '7');
    dico.put("101101", '8');
    dico.put("011001", '9');

    dico.put("100000", 'a');
    dico.put("101000", 'b');
    dico.put("110000", 'c');
    dico.put("110100", 'd');
    dico.put("100100", 'e');
    dico.put("111000", 'f');
    dico.put("111100", 'g');
    dico.put("101100", 'h');
    dico.put("011000", 'i');
    dico.put("011100", 'j');
    dico.put("100010", 'k');
    dico.put("101010", 'l');
    dico.put("110010", 'm');
    dico.put("110110", 'n');
    dico.put("100110", 'o');
    dico.put("111010", 'p');
    dico.put("111110", 'q');
    dico.put("101110", 'r');
    dico.put("011010", 's');
    dico.put("011110", 't');
    dico.put("100011", 'u');
    dico.put("101011", 'v');
    dico.put("011101", 'w');
    dico.put("110011", 'x');
    dico.put("110111", 'y');
    dico.put("100111", 'z');

    return dico;
  }
 /**
   * Transforme le pourcentage en pixel de chaque zone en binaire puis forme une chaine
   * Recherche ensuite dans le dictionnaire le caractère correspondant à la chaine binaire
   * param monCube de type Cube 
   * @return le character du cubarithme
   */
  Character decodeCube(Cube monCube) {

    Character sortie = '@';

    String chaine = ""+ 
      zoneEnString(monCube.s1, monCube.n1)+zoneEnString(monCube.s2, monCube.n2)+
      zoneEnString(monCube.s3, monCube.n3)+zoneEnString(monCube.s4, monCube.n4)+
      zoneEnString(monCube.s5, monCube.n5)+zoneEnString(monCube.s6, monCube.n6);
    
    
    if (dicoBraille.containsKey(chaine)) {
      sortie = dicoBraille.get(chaine);
    }
    
    
    return sortie;
  }
 /**
   * Détermine si une zone est colorié avec le pin du braille
   * param nNoir de type float 
   * param nNPixel de type int 
   * @return "1" si le nombre de pixel noir < seuil, sinon "0"
   */
  String zoneEnString(float nNoir, int nPixel) {
    if (nNoir / nPixel < seuil) {
      return "1";
    } else {
      return "0";
    }
  }

  void printScoreChaqueCase(Cube monCube) {
    println();
    println();
    println();
    println();
    println();
    println(monCube.s1/monCube.n1, monCube.s2/monCube.n2);//,"      s1:",s1,"n1:",n1,"      s2:",s2,"n2:",n2);
    println(monCube.s3/monCube.n3, monCube.s4/monCube.n4);//,"      s3:",s3,"n3:",n3,"      s4:",s4,"n4:",n4);
    println(monCube.s5/monCube.n5, monCube.s6/monCube.n6);//,"      s5:",s5,"n5:",n5,"      s6:",s6,"n6:",n6);
  }
  
   void printZneStrng(Cube monCube) {
    println();
    println();
    println();
    println();
    println();
    println( zoneEnString(monCube.s1, monCube.n1), zoneEnString(monCube.s2, monCube.n2));
    println(zoneEnString(monCube.s3, monCube.n3), zoneEnString(monCube.s4, monCube.n4));
    println( zoneEnString(monCube.s5, monCube.n5), zoneEnString(monCube.s6, monCube.n6));
  }
}
