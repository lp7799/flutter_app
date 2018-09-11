import 'dart:convert';

class Article{
final String title;
final String envelopePic;
final String niceDate;
final String link;
final String chapterName;
final String superChapterName;


Article(this.title, this.envelopePic, this.niceDate, this.link,
    this.chapterName, this.superChapterName);

static List<Article> getArticle(String jsonData){
      List<Article> list = new List<Article>();
      var data = json.decode(jsonData);
      var resules = data['data']['datas'];
      for(int i=0;i<resules.length;i++){
        list.add(froMap(resules[i]));
      }
      return list;
    }
  static Article froMap(Map map) {
      var t = map['title'];
      var e = map['envelopePic'];
      var n = map['niceDate'];
      var l = map['link'];
      var c = map['chapterName'];
      var s = map['superChapterName'];
      return new Article(t, e, n, l,c,s);
  }
}