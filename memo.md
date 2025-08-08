## メモ

### 全体的な方向性
* 型推論をやめる
* コンパイラの表現力と拡張性のために、型(等)の記述にクラスを使う

### 現状
かなりぐちゃっている、動かない

* LLVMの出力内容はast->LLVM textual IRの写像を使って移したものとする
☆LLVM textual IRの仕様も変更されないとは限らない

* ところでNamespaceってStmtNode.parent: StmtNode、ExprNode.parent: StmtNodeがあればいらないかも
  * NamespaceがなければStmtNodeがpathをもつ必要もない、というかpathの概念が必要ない<-完
    * Wreck1には存在せず、LLVM上で構築すればよくなるの意

☆ExprNode.valueには演算子の記号を入れてもいいし、何も入れなくてもいい気もする

☆本当のリファクタリングはこれからだ!
