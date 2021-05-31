import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
* Classe utilisée uniquement pour la génération du JSON, contient tous les champs pour le Stage
* @author EBRAN Kenny
*/
public class ScratchStage extends ScratchObject{
  private boolean isStage = true;
  private String name = "Stage";
  private Map<String,List<Object>> variables = new HashMap();
  private Map<Object,Object> lists = new HashMap();
  private Map<Object,Object> broadcasts = new HashMap();
  private Map<Object,Blocks> blocks = new HashMap();
  private Map<Object,Object> comments = new HashMap();
  private int currentCostume = 0;
  private List<ScratchCostume> costumes = new ArrayList();
  private List<ScratchSound> sounds = new ArrayList();
  private int volume = 100;
  private int layerOrder = 0;
  private int tempo = 60;
  private int videoTransparency = 50;
  private String videoState = "on";
  private Object textToSpeechLanguage = null;
  
  public ScratchStage() {
    this.getCostumes().add(new ScratchCostume("cd21514d0531fdffb22204e0ec5ed84a",
        "backdrop1",
        "cd21514d0531fdffb22204e0ec5ed84a.svg",
        "svg",
        240,
        180));
    this.getSounds().add(new ScratchSound("83a9787d4cb6f3b7632b4ddfebf74367",
        "pop",
        "wav",
        "",
        48000,
        1123,
        "83a9787d4cb6f3b7632b4ddfebf74367.wav"));
    List<Object> list = new ArrayList();
    list.add("var1");
    list.add(0);
    variables.put("var1",list);
    list = new ArrayList();
    list.add("var2");
    list.add(0);
    variables.put("var2",list);
  }
  
  public List<ScratchCostume> getCostumes(){
    return this.costumes;
  }
  
  public List<ScratchSound> getSounds(){
    return this.sounds;
  }
}
