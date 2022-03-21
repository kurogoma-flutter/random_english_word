# random_english_word
english_wordsというパッケージを用いて英単語をランダム生成する
ランダム英単語100件を毎回生成してFirestoreに格納していく処理です。
あるあるのランダム単語生成（Seed）みたいな処理を実装したかったのと、
ループで保存するってのをやってみたくて実装しました。

## 出力結果

### 画面
<img width="200" src="https://user-images.githubusercontent.com/67848399/159212983-97aba048-1537-4f18-97f6-ff8720c6d683.png">

### Firestore側
<img width="600" alt="section3" src="https://user-images.githubusercontent.com/67848399/159213079-5a0edd57-4a0a-4e4e-84b3-bcadf054830f.png">

## パッケージ
https://pub.dev/packages/english_words
## 参考サイト
https://blog.nainaism.com/flutter-first-app/

## コード部分
IDの自動生成がもしかしたらあるかもしれないが、パッと調べてわからなかったので自作で生成しています。

```dart
  _createRandomWord() async {
    // コレクションIDとドキュメントIDを指定して取得
    int _lastId;
    List<DocumentSnapshot> wordList = [];
    var snapshot = await FirebaseFirestore.instance.collection('words').orderBy('id', descending: true).limit(1).get();
    // 取得したドキュメントの情報をUIに反映
    setState(() {
      wordList = snapshot.docs;
    });

    _lastId = wordList[0]['id'];
    // ループ
    // ランダム単語生成
    FirebaseFirestore.instance.collection('words').get();
    for (int i = 1; i <= 100; i++) {
      var wordPair = WordPair.random();
      int id = _lastId + i;
      await FirebaseFirestore.instance.collection('words').add({"word": wordPair.asPascalCase, "id": id});
    }
  }
```
