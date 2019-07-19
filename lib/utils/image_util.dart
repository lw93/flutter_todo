class ImageUtil {
  static String getImgByName(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }
}
