import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
/*
* Classe utilisée uniquement pour la génération du JSON, contient tous les champs pour le Sprite, et notamment
* l'ajout des blocs reconnu par le programme
* @author EBRAN Kenny
*/
public class ScratchSprite extends ScratchObject{
  private boolean isStage = false;
  private String name = "Sprite1";
  private Map<Object,Object> variables = new HashMap();
  private Map<Object,Object> lists = new HashMap();
  private Map<Object,Object> broadcasts = new HashMap();
  private Map<String,Blocks> blocks = new LinkedHashMap();
  private Map<Object,Object> comments = new HashMap();
  private int currentCostume = 0;
  private List<ScratchCostume> costumes = new ArrayList();
  private List<ScratchSound> sounds = new ArrayList();
  private int volume = 100;
  private int layerOrder = 1;
  private boolean visible = true;
  private int x = 0;
  private int y = 0;
  private int size = 100;
  private int direction = 90;
  private boolean draggable = false;
  private String rotationStyle = "all around";
  
  public ScratchSprite() {
    this.getCostumes().add(new ScratchCostume("bcf454acf82e4504149f7ffe07081dbc",
        "costume1",
        "bcf454acf82e4504149f7ffe07081dbc.svg",
        "svg",
        48,
        50));
    this.getSounds().add(new ScratchSound("83c36d806dc92327b9e7049a565c6bff",
        "Meow",
        "wav",
        "",
        48000,
        40681,
        "83c36d806dc92327b9e7049a565c6bff.wav"));
  }
  
  public void addBlocks(String id,Blocks blocks) {
    this.getBlocks().put(id, blocks);
  }
  public List<ScratchCostume> getCostumes(){
    return this.costumes;
  }
  
  public List<ScratchSound> getSounds(){
    return this.sounds;
  }
  
  public Map<String,Blocks> getBlocks(){
    return this.blocks;
  }
}
