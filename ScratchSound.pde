/*
* Classe utilisée uniquement pour la génération du JSON, contient tous les champs pour le son
* @author EBRAN Kenny
*/
public class ScratchSound {
  private String assetId;
  private String name;
  private String dataFormat;
  private String format;
  private int rate;
  private int sampleCount;
  private String md5ext;
  
  public ScratchSound(String assetId,
      String name,
      String dataFormat,
      String format,
      int rate,
      int sampleCount,
      String md5ext) {
    
    super();
    this.assetId = assetId;
    this.name = name;
    this.dataFormat = dataFormat;
    this.format = format;
    this.rate = rate;
    this.sampleCount = sampleCount;
    this.md5ext = md5ext;
  }
  
  
}
