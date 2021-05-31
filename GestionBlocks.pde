import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/*
* Classe permettant de gérer la gestion des blocs et notamment de l'ajout d'un TopCode ou d'un cubarithmes
* @author EBRAN Kenny
*/
public class GestionBlocks {
  private Map<String,Blocks> listBlocks = new LinkedHashMap<String,Blocks>();
  private tabgo_be tb = new tabgo_be();
  
  /*
  * Constructeur permettant d'initialiser la map listBlocks en créant tous les blocs de l'INJA
  * à partir d'un fichier "blocs.csv" dans le dossier "data"
  */
  public GestionBlocks() {
    String csvFile = dataPath("") + "/blocs.csv";
    BufferedReader br = null;
    String line = "";
    String csvSplitBy = ",";
    
    
    try {
      br = new BufferedReader(new FileReader(csvFile));
      while((line = br.readLine()) != null) {
        
        //Suppression des espaces de fins
        line.trim();
        
        //On saute les lignes vides
        if(line.length() == 0) {
          continue;
        }
        
        //On saute les lignes de commentaires
        if(line.startsWith("#")) {
          continue;
        }
        
        //use comma as separator
        String[] blocks = line.split(csvSplitBy);
        
        Blocks b = tb.new Blocks(blocks[2]);
        boolean field = false;
        int i = 3;
        while(i < blocks.length && ! field) {
          if(blocks[i].equals("F")) {
            field = true;
          } else {
            b.getInputs().put(blocks[i], new ArrayList<Object>());
          }
          i++;
        }
        if(field) {
          List<Object> tmp = new ArrayList<Object>();
          tmp.add(blocks[i+1]);
          tmp.add(null);
          b.getFields().put(blocks[i],tmp);
        }
        
        listBlocks.put(blocks[1], b);
       }
    } catch(IOException e) {
      e.printStackTrace();
    } finally {
      if(br != null) {
        try {
          br.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }  
    }
  }
  
  public Map<String,Blocks>getListBlocks() {
    return listBlocks;
  }
  
  /*
  * Méthode permettant de savoir quels sont les blocs qui ont des inputs
  * @return true si le blocs à des inputs, sinon false
  */
  public boolean hasInput(String code) {
    switch(code) {
    case "55":
    case "59":
    case "61":
    case "79":
    case "87":
    case "91":
    case "115":
    case "117":
    case "155":
    case "157":
    case "167":
    case "171":
    case "173":
    case "179":
    case "181":
    case "185":
    case "199":
    case "283":
    case "285":
    case "295":
    case "299":
    case "301":
    case "307":
    case "309":
    case "313":
    case "327":
    case "331":
    case "333":
    case "339":
    case "341":
    case "345":
    case "355":
    case "369":
    case "391":
    case "395":
    case "397":
      return true;
    default:
      return false;
    }
  }
  
  /*
  * Méthode permettant d'ajouter à la liste des blocs donné en paramètre le bloc correspondant au TopCode donné (Version sans parent)
  * @param list : Liste des blocs
  * @param code : le TopCode lu par le programme
  * @param topLevel : booléen permettant de savoir si le code donné correspond au premier bloc du programme
  * @param current : numéro du bloc courant, correspond à l'ordre de traitement
  * @param prev : numéro du bloc précédant, correspond à l'ordre de traitement
  */
  public void ajoutTopCode(List<Blocks> list, TopCode code, boolean topLevel,int current, int prev) {
    Blocks blockToAdd = tb.new Blocks(listBlocks.get(String.valueOf(code.getCode())));
    blockToAdd.setTopLevel(topLevel);
    if( ! topLevel) {
      list.get(prev).setNext("bloc" + current);
    }
    list.add(blockToAdd);
  }
  
  /*
  * Méthode permettant d'ajouter à la liste des blocs donné en paramètre le bloc correspondant au TopCode donné (Version avec parent)
  * @param list : Liste des blocs
  * @param code : le TopCode lu par le programme
  * @param topLevel : booléen permettant de savoir si le code donné correspond au premier bloc du programme
  * @param current : numéro du bloc courant, correspond à l'ordre de traitement
  * @param prev : numéro du bloc précédant, correspond à l'ordre de traitement
  * @param parent : numéro du bloc parent, correspond à l'ordre de traitement
  */
  public void ajoutTopCode(List<Blocks> list, TopCode code,boolean topLevel, int current, int prev, int parent) {
    String champ;
      List<Object> listToAdd;
      List<Object> tmp;
      if(isVariable(code.getCode())) {
        addVariable(list, code, parent); 
      } else {
        addBlock(list, code, topLevel, current, prev, parent);
      }
  }
  
  /*
  * Méthode privée qui permet d'ajouter un bloc.
  * @see ajoutTopCode()
  * @param list : Liste des blocs
  * @param code : le TopCode lu par le programme
  * @param topLevel : booléen permettant de savoir si le code donné correspond au premier bloc du programme
  * @param current : numéro du bloc courant, correspond à l'ordre de traitement
  * @param prev : numéro du bloc précédant, correspond à l'ordre de traitement
  * @param parent : numéro du bloc parent, correspond à l'ordre de traitement
  */
  private void addBlock(List<Blocks> list, TopCode code, boolean topLevel, int current, int prev, int parent) {
    String champ;
    List<Object> listToAdd;
    List<Object> tmp;
    Blocks blockToAdd = tb.new Blocks(listBlocks.get(String.valueOf(code.getCode())));
    blockToAdd.setTopLevel(topLevel);
    if( ! topLevel) {
      champ = list.get(parent).hasInput();
      if(! champ.equals("")) {
        listToAdd = new ArrayList<Object>();
        if(hasShadow(champ)) {
          listToAdd.add(3);
          listToAdd.add("bloc"+current);
          tmp = new ArrayList<Object>();
          tmp.add(10);
          tmp.add("");
          listToAdd.add(tmp);
         } else {
          listToAdd.add(2);
          listToAdd.add("bloc"+current);
         }
        list.get(parent).getInputs().put(champ, listToAdd);
        
      } else {
        list.get(prev).setNext("bloc"+current);
      }
      blockToAdd.setParent("bloc"+parent);
    }
    list.add(blockToAdd);
  }
  
  /*
  * Méthode privée qui permet d'ajouter un bloc variable à un bloc parent.
  * @see ajoutTopCode()
  * @param list : Liste des blocs
  * @param code : le TopCode lu par le programme
  * @param parent : numéro du bloc parent, correspond à l'ordre de traitement
  */
  private void addVariable(List<Blocks> list, TopCode code, int parent) {
    String champ;
    List<Object> listToAdd;
    List<Object> tmp;
      listToAdd = new ArrayList();
      champ = list.get(parent).hasInput();
      String var = code.getCode() == 357 ? "var1" : "var2";
      if(champ.equals("") && isDataVariable(list.get(parent).getOpcode())) {
        listToAdd.add(var);
        listToAdd.add(var);
        list.get(parent).getFields().put("VARIABLE", listToAdd);
      } else {
        listToAdd.add(3);
        tmp = new ArrayList();
        tmp.add(12);
        tmp.add(var);
        tmp.add(var);
        listToAdd.add(tmp);
        List<Object> tmp2 = new ArrayList();
        tmp2.add(10);
        tmp2.add("");
        listToAdd.add(tmp2);
        list.get(parent).getInputs().replace(champ, listToAdd);
      }
  }
  
  /*
  * Méthode permettant d'ajouter un cubarithme à un input d'un bloc
  * @param list : liste des blocs
  * @param chaine : caractere correspond au braille du cubarithme
  * @param prev : numéro du bloc précédant, ordre de traitement
  */
  public void ajoutCubarithme(List<Blocks> list, String chaine,int prev) {
    if(! list.isEmpty()){
      String champ = list.get(prev).hasInput();
      List<Object> listToAdd = new ArrayList<Object>();
      listToAdd.add(1);
      List<Object> tmp = new ArrayList<Object>();
      tmp.add(10);
      tmp.add(chaine);
      listToAdd.add(tmp);
      list.get(prev).getInputs().put(champ, listToAdd);
    }
  }
  
  /*
  * Méthode qui détermine si le code donné en paramètre correspond au bloc qui signifie l'arrêt d'un bloc de contrôle
  * @param code : TopCode
  * @return true si le TopCode correspond au bloc qui signifie l'arrêt d'un bloc de contrôle, sinon false
  */
  public boolean isStopBlock(int code) {
    return code == 93;
  }
  
  /*
  * Méthode qui détermine si le code donné en paramètre correspond au bloc qui signifie que l'on rentre dans un else
  * @param code : TopCode
  * @return true si le TopCode correspond au bloc qui signifie que l'on rentre dans le else, sinon false
  */
  public boolean isElseBlock(int code){
    return code == 91;
  }
  
  /*
  * Méthode qui détermine si le code donné en paramètre correspond à un bloc de contrôle
  * @param code : TopCode
  * @return true si le TopCode correspond à un bloc de contrôle, sinon false
  */
  public boolean isControlBlock(int code) {
    switch(code){
      case 55:
      case 59:
      case 61:
      case 79:
      case 91:
        return true;
       default:
         return false;
    }
  }
  
  /*
  * Méthode qui détermine si le champ donné en paramètre peut être un champ "Shadow"
  * @param champ : Champ d'input
  * @return true si le champ peut être shadow, sinon false
  */
  public boolean hasShadow(String champ) {
    switch(champ){
      case "TIMES":
      case "DURATION":
      case "MESSAGES":
      case "SECS":
      case "STEPS":
      case "DEGREES":
      case "DIRECTION":
      case "X":
      case "Y":
      case "DX":
      case "DY":
      case "QUESTION":
      case "NUM1":
      case "NUM2":
      case "NUM":
      case "OPERAND1":
      case "OPERAND2":
      case "FROM":
      case "TO":
      case "STRING1":
      case "STRING2":
      case "VALUE":
        return true;
      default:
        return false;
    }
  }
  
  /*
  * Méthode qui permet de savoir si le TopCode donné en paramètre correspond à un bloc variable
  * @param code : TopCode
  * @return true si le TopCode correspond à une variable, sinon false
  */
  public boolean isVariable(int code) {
    switch(code) {
    case 357:
    case 361:
      return true;
    default:
      return false;
    }
  }
  
  /*
  * Méthode qui permet de savoir si le opcode donné en paramètre correspond à un bloc data_variable
  * @param opcode : Opcode
  * @return true si le opCode correspond à un bloc data_variable, sinon false
  */
  public boolean isDataVariable(String opcode) {
    switch(opcode) {
    case "data_setvariableto":
    case "data_changevariableby":
    case "data_showvariable":
    case "data_hidevariable":
      return true;
    default:
      return false;
    }
  }
  public int getTopcode(String opcode) {
    for(Map.Entry<String,Blocks> entry : listBlocks.entrySet()) {
      if(entry.getValue().getOpcode().equals(opcode)) {
        return Integer.parseInt(entry.getKey());
      }
    }
    return -1;
  }
}
