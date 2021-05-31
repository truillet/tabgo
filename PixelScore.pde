/**
 * Classe PixelScore modélisant un pixel avec ses coordonnees ainsi que son score.
 * Cette classe servira à stoquer les différent pixel ainsi que leur score.
 * @author Felix DUPEYSSET
 *
 */


class PixelScore {
  int x;
  int y;
  float score;

  PixelScore(int rx, int ry, float rscore) {
    x= rx;
    y= ry;
    score = rscore;
  }
}
