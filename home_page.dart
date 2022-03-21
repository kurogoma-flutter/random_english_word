import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Section3 extends StatefulWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  _Section3State createState() => _Section3State();
}

class _Section3State extends State<Section3> {
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
    // 追加（ID生成？UUID?）
    FirebaseFirestore.instance.collection('words').get();
    for (int i = 1; i <= 100; i++) {
      var wordPair = WordPair.random();
      int id = _lastId + i;
      await FirebaseFirestore.instance.collection('words').add({"word": wordPair.asPascalCase, "id": id});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Section3'),
      ),
      body: Center(
        child: GestureDetector(
          child: const GenerateButton(),
          onTap: () => _createRandomWord(),
        ),
      ),
    );
  }
}

class GenerateButton extends StatelessWidget {
  const GenerateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.indigoAccent,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1.0,
            blurRadius: 5.0,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Generate Words!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
