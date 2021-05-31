/*
* Classe utilisée uniquement pour la génération du JSON, comprend tous les champs pour le costume
* @author EBRAN Kenny
*/
public class ScratchCostume {
  private String assetId;
  private String name;
  private String md5ext;
  private String dataFormat;
  private int rotationCenterX;
  private int rotationCenterY;
  
  public ScratchCostume(String assetId,
      String name,
      String md5ext,
      String dataFormat,
      int rotationCenterX,
      int rotationCenterY) {
    
    super();
    this.assetId = assetId;
    this.name = name;
    this.md5ext = md5ext;
    this.dataFormat = dataFormat;
    this.rotationCenterX = rotationCenterX;
    this.rotationCenterY = rotationCenterY;
  }
  
  
}
