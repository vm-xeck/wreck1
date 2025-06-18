# Wreck1
プログラミング言語のLLVMフロントエンド、Kuin製
構造体と配列に対応したい気持ちもある

## EBNF
```ebnf
code = { func | var | const | struct | comment }; //TODO: asm, import
stmt = var | const | while | if | return | do; //TODO: asm
func = "func", func-name, "(", [ arg, { ",", arg } ], ")", ":", type-name,
    "{", { stmt }, return, "}";
var = "var", var-name, ":", type-name, [ "::", expr ];
cosnt = "const", const-name, ":", type-name, [ "::", expr ];
while = "while", "(", expr, ")", "{", { stmt }, "}";
if = "if", "(", expr, ")", "{", { stmt }, "}",
    { "elif", "(", expr, ")", "{", { stmt }, "}" },
    [ "else", "{", { stmt }, "}" ];
return = "return", expr;
do = "do", expr;

comment = "#", { * }, "#";

expr = assignment;
assignment = { var-name, "<-" }, or;
or = and, { "|", and };
and = relational, { "&", relational };
relational = add, { ( "=" | "<>" | "<" | "<=" | ">" | ">=" ), add };
add = mul, { ( "+" | "-" ), mul };
mul = unary, { ( "*" | "/" | "%" ), unary };
unary = [ "+" | "-" | "!" ], primary;
primary = literal | var-ref | func-call | "(", expr, ")";

type-name =
    "int", ("8" | "16" | "32" | "64")
    | "uint", ("8" | "16" | "32" | "64")
    | "float", ("32" | "64")
    | "bool";

separator-sign = " " | "\t" | "\n" | comment;
```

## 注意？
* 関数はトップレベルにしか置けないです
  * LLVMの制約によります。内部の関数をトップレベルに移動させる処理を書いていないのが悪いです
* 代入、関数呼び出しなどの式の結果を捨てる場合は`do`文の中に書いてください
  * 生の式はstmtとして認められません
* 定義(`::`)と代入(`<-`)の演算子が違います
  * `const`は後者ができないイメージ
* 識別子の先頭はalphaでお願いします
TODO: 思い出したら追記
