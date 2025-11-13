# Wreck1
Wreck1コンパイラを改造してトークン列とASTをJSONで出力するようにした

## 出力の仕様
- ASTパースの手引き
- 各オブジェクトの仕様
### ASTパースの手引き
TODO: 存在する要素だけ見られるような参照順序
☆`AST`の各要素は種類によって異なるメンバをもっている(後述)ため、すべての要素がもつ判別用メンバをもとにアクセスするメンバを決める必要があります(分かりにくいかも…すみません…)

次の手順がおすすめです
1. `Stmt or Expr`を見て、"Stmt"なら文、"Expr"なら式です
2. `Kind`を見ます
文なら
- "func"
- "funcArg"
- "var"
- "const"
- "while"
- "ifContainer"
- "ifCase"
- "return"
- "do"
- "builtinFunc"
- "builtinConst"
のどれか、式なら
- "funcCall"
- "varRef"
- "constRef"
- "funcArgRef"
- "op"
- "literal"
のどれかです
3. 下記の詳細を参考に、Kind毎に存在するメンバにだけアクセスします

## 各オブジェクトの仕様

### Token Stream の要素
全メンバが全オブジェクトで共通です
- `Name`: string
  - トークンの値。
- `Kind`: string
  - トークンの種類。次のどれかです
    - "op"
    - "ident"
    - "numLiteral"
    - "charLiteral"
    - "aggregateInitLiteral"
    - "strLiteral"
    - "aryTypeName"

### AST の要素
- funcノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "func"
  - `Name`: string
    - 関数の名前
  - `Type`: string
    - 関数の型
  - `Args`: array
    - 関数の引数たち
  - `Stmts`: array
    - 関数本体
- funcArgノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "func▽寮g"
  - `Name`: string
    - 引数の名前
  - `Type`: string
    - 引数の型
- varノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "var"
  - `Name`: string
    - 変数の名前
  - `Type`: string
    - 変数の型
  - `Expr`: object | null
    - 変数の初期値
- constノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "const"
  - `Name`: string
    - 定数の名前
  - `Type`: string
    - 定数の型
  - `Expr`: object | null
    - 定数の値
- whileノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "while"
  - `Expr`: object | null
    - 真偽値、真なら本体実行のやつ
  - `Stmts`: array
    - ループ本体
- ifContainerノードは次のメンバをもちます
> ひとつのif-elif-else分岐全体を保持するノードです
> 複数のifCaseのみをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "ifContainer"
  - `Stmts`: array
    - 分岐の各選択肢
- ifCaseノードは次のメンバをもちます
> 分岐の選択肢(ifまたはelifまたはelse)を表します
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "ifCase"
  - `Expr`: object
    - 条件
    - elseの条件にはtrueに対応するExprが入っています
  - `Stmts`: array
    - 条件に合致したら実行する部分
- returnノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "return"
  - `Expr`: object
    - 戻り値(式)
  - `Type`: string
    - 戻り値の型。所属する関数の型に一致するはず
- doノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "do"
  - `Expr`: object
    - 評価する式
- builtinFuncノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "builtinFunc"
  - `Name`: string
    - 関数の名前
  - `Type`: string
    - 関数の型
  - `Args`: array
    - 関数の引数たち
- builtinConstノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Stmt"
  - `Kind`: string = "builtinConst"
  - `Name`: string
    - 定数の名前
  - `Type`: string
    - 定数の型


- funcCallノードは次のメンバをもちます
  - `Stmt or Expr`: string = "Expr"
  - `Kind`: string = "funcCall"
  - `Type`: string
    - 呼んでいる関数の型
  - `Value`: object
