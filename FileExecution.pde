import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;
import guru.ttslib.*;


/**
 * Cette classe comprend l'ensemble des fonctions utiles permettant la création du fichier 
 * C'est cette classe qui réalise l'intégration entre la méthode de reconnaissance
 * d'un algorithme Scratch et la méthode de transcription d'un programme en projet JSON.
 * 
 * (05/21) Modifiée par EBRAN Kenny pour générer le JSON avec la librairie GSON
 * Ajout du feedback sonore grâce à la librairie ttslib de processing pour avertir d'un "succès" ou "échecs" lors de la conversion Zip -> sb3
 */
public class FileExecution{
  public void fileE(String json, TTS tts){
    try{
      File output = new File(dataPath("")+"/project.json");
      if( ! output.createNewFile()) {
        output.delete();
        output.createNewFile();
      }
      FileWriter writer = new FileWriter(output);
      writer.write(json);
      writer.close();
      
      /* On écrit le projet généré dans le fichier de sortie */            
      // Je Copie le fichier original et l'enregistre dans un fichier zip qui sera modifié
      File originalfile =new File(dataPath("")+"/ScratchOriginal.zip");
      File newfile =new File(dataPath("")+"/sb3/Programme_scratch.sb3");
      File oldfile =new File(dataPath("")+"/sb3/ProgrammeTest.zip");
      
      if(oldfile.exists()) {
        oldfile.delete();
      }
      System.out.println(".: Création du Zip :."); 
      ZipFile zipSrc = new ZipFile(originalfile);
      ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(oldfile));

      // Parcours du zip original et ajout dans le zip qui sera convertit en sb3
      Enumeration srcEntries = zipSrc.entries();
      while (srcEntries.hasMoreElements()) {
          zos.setLevel(ZipOutputStream.DEFLATED);
          ZipEntry entry = (ZipEntry) srcEntries.nextElement();
          ZipEntry newEntry = new ZipEntry(entry.getName());
          zos.putNextEntry(newEntry);

          BufferedInputStream bis = new BufferedInputStream(zipSrc.getInputStream(entry));
          while (bis.available() > 0) {
            zos.write(bis.read());
          }
          zos.closeEntry();
          bis.close();
        }
      
        println("Ajout du json");
        // Ajout du json correspondant aux blocs reconnus
        FileInputStream fis = new FileInputStream(output);
        ZipEntry newEntry = new ZipEntry("project.json");
        zos.putNextEntry(newEntry);
        byte[] bytes = new byte[1024];
        int length;
        while((length = fis.read(bytes)) >= 0) {
          zos.write(bytes,0,length);
        }
        zos.closeEntry();
        fis.close();
        zos.finish();
        zos.close();
        zipSrc.close();
       
        /* CONVERSION DU FICHIER ZIP EN SB3 */        
        System.out.println(".: Conversion du fichier ZIP en SB3 :."); 
        if (newfile.exists()) {
          System.out.println("\t Création du nouveau Projet Scratch !!!");
          newfile.delete();          
        }        
        if(oldfile.renameTo(newfile)){
          System.out.println("Rename succesful");
          tts.speak("Success");
        }
        else {
          System.out.println("Rename failed");
          tts.speak("Failed");
        }        
      }
      catch(Exception e){
        System.out.println("Exception levée : " + e); 
    }    
  }   
} 
