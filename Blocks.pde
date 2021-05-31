import java.util.LinkedHashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/*
* Cette classe comprend tout ce qui est nécessaire pour créer un block sur Scratch et être reconnu par celui-ci lors de la génération du JSON
* @author EBRAN Kenny
*/

public class Blocks {
  private String opcode;
  private String next = null;
  private String parent = null;
  private Map<String,List<Object>> inputs = new LinkedHashMap<String,List<Object>>();
  private Map<String,List<Object>> fields = new LinkedHashMap<String,List<Object>>();
  private boolean shadow;
  private boolean topLevel;
  private int x;
  private int y;
  
  /*
  * Constructeur qui crée une instance d'un Block
  * @param op : opcode du bloc
  */
  public Blocks(String op) {
    opcode = op;
  }
  
  /*
  * Constructeur qui permet de créé un bloc à partir d'un autre. En d'autre terme, fait une copie du bloc passé en paramètre
  * @param b : bloc à copier
  */
  public Blocks(Blocks b) {
    opcode = b.getOpcode();
    fields = b.getFields();
    for(Map.Entry<String, List<Object>> entry : b.getInputs().entrySet()) {
      inputs.put(entry.getKey(), new ArrayList());
    }
  }
  
  public String getOpcode() {
    return opcode;
  }
  public void setOpcode(String opcode) {
    this.opcode = opcode;
  }
  public String getNext() {
    return next;
  }
  public void setNext(String next) {
    this.next = next;
  }
  public String getParent() {
    return parent;
  }
  public void setParent(String parent) {
    this.parent = parent;
  }
  public Map<String,List<Object>> getInputs() {
    return inputs;
  }
  public void setInputs(Map<String,List<Object>> inputs) {
    this.inputs = inputs;
  }
  public int getX() {
    return x;
  }
  public void setX(int x) {
    this.x = x;
  }
  public int getY() {
    return y;
  }
  public void setY(int y) {
    this.y = y;
  }

  public Map<String, List<Object>> getFields() {
    return fields;
  }

  public void setFields(Map<String, List<Object>> fields) {
    this.fields = fields;
  }

  public boolean isShadow() {
    return shadow;
  }

  public void setShadow(boolean shadow) {
    this.shadow = shadow;
  }

  public boolean isTopLevel() {
    return topLevel;
  }

  public void setTopLevel(boolean topLevel) {
    this.topLevel = topLevel;
  }
  
  /*
  * Méthode permettant de savoir si un bloc a des inputs et renvoie le champ de l'input qui est vide, sinon une chaine vide
  * @return le champ de l'input non encore rempli, sinon une chaine vide
  */
  public String hasInput() {
    for(Map.Entry<String, List<Object>> entry : inputs.entrySet()) {
      if(entry.getValue().isEmpty()) {
        return entry.getKey();
      }
    }
    return "";
  }
  
  /*
  * Méthode permettant de savoir si un bloc a des fields et renvoie le champ du field qui est vide, sinon une chaine vide
  * @ return le champ du field non encore rempli, sinon une chaine vide
  */
  public String hasField(){
    for(Map.Entry<String, List<Object>> entry : fields.entrySet()) {
      if(entry.getValue().isEmpty()) {
        return entry.getKey();
      }
    }
    return "";
  }
}
