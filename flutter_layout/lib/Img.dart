
import 'dart:convert';

class Img {
  final String url;
  final String createdAt;

  Img(this.url, this.createdAt);

  static List<Img> decodeData(String jsonData){
    List<Img> imgs = new List<Img>();
    var data = json.decode(jsonData);
    var results = data['data'];
    for (int i=0; i<results.length;i++){
      imgs.add(froMap(results[i]));
    }
    return imgs;
  }
  static Img froMap(Map map){
    var img = map['url'];
   var time = map['createdAt'];
    return new Img(img,time);
  }
}