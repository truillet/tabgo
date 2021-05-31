
import java.util.List;
import java.util.Comparator; 
import java.util.LinkedList;

/**
 * Classe modélisant la liste des TopCodes 
 *
 */
 

class TopCodesP{ 
  LinkedList<TopCode> codes;  
  
  LinkedList<TopCode> getCodes(){
    return triCodes(this.codes); 
  } 
  
  void setCodes(LinkedList<TopCode> c){
    this.codes = c; 
  } 
  
  boolean memeOrdonnee(TopCode tc, TopCode tc2) {
    
    double y1 = tc.getCenterY();       
    double y2 = tc2.getCenterY();
    double height = ((tc.getDiameter()+tc2.getDiameter())/2)*0.8;
    
    if (y1 - height <= y2 && y2 <= y1 + height) {
      return true;
    }
    else {
      return false;
    }
  }
 
  
LinkedList<TopCode> findTopCodes(List<TopCode> codesF){
  LinkedList<TopCode>  topeCodes = new LinkedList<TopCode>();
  if (codesF != null) {
    for (TopCode top : codesF) {
      topeCodes.add(top);  
    }
  }
  
  this.codes = topeCodes; 
  
  return triCodes(topeCodes); 
}

  

  boolean estSuperieur(TopCode tc, TopCode tc2) {
    if (memeOrdonnee(tc, tc2)) {
      return (tc.getCenterX()> tc2.getCenterX());
    }
    else {
      return (tc.getCenterY() > tc2.getCenterY());
    }
  } 
  
  LinkedList<TopCode> triCodes (LinkedList<TopCode> listeTopCodes){
    boolean tab_en_ordre = false;
    int taille = listeTopCodes.size();
    
    //Tant que la liste n'est pas ordonée 
    while (!tab_en_ordre) {
          tab_en_ordre = true;
          for(int i=0 ; i < taille-1 ; i++) {
            TopCode tc1 = listeTopCodes.get(i);
            TopCode tc2 = listeTopCodes.get(i+1);
              if(estSuperieur(tc1,tc2)) {
                listeTopCodes.set(i, tc2);
                listeTopCodes.set(i+1,tc1);
                  
                  tab_en_ordre = false;
              }
          }
          taille--;
      }
    this.codes = listeTopCodes; 
   return listeTopCodes;
  
}   
  
}
