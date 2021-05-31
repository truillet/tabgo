import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/*
* Classe utilisée uniquement pour la création du JSON, contient les champ targets (avec le Stage et le Sprite) ainsi que les champs de fin de fichier
* @author EBRAN Kenny
*/
public class MainScratch {
  private List<ScratchObject> targets;
  private Object[] monitors = {};
  private Object[] extensions = {};
  private Map<String,String> meta = new LinkedHashMap<String,String>();
  
  public MainScratch(List<Blocks> listBlocks) {
    targets = new ArrayList<ScratchObject>();
    ScratchStage stage = new ScratchStage();
    ScratchSprite sprite = new ScratchSprite();
    int i = 0;
    for(Blocks blocks : listBlocks) {
      sprite.addBlocks("bloc"+i, blocks);
      i++;
    }
    targets.add(stage);
    targets.add(sprite);
    meta.put("semver", "3.0.0");
    meta.put("vm", "0.2.0-prerelease.20210324111836");
    meta.put("agent", "Mozilla/5.0");
  }
}
