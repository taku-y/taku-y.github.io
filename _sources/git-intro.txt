Git入門
===============================================================================
最終更新: 20160617 (c) 吉岡琢

.. contents::
    :depth: 2

- ここではGitの意義やインストールに関する説明はしません. 
- Gitのディレクトリにパスが通っており, Gitのコマンドが利用可能であると仮定します. 
- 例では一貫して :code:`~/Download/repo[n]` ディレクトリを使用します. 断りが無い限り, 例のコマンドは全てこのディレクトリで実行します. 
- 例は最初から順に実行すると仮定します. 例2を確認する場合, 例1が終了していることを前提とします. 

初期設定
-------------------------------------------------------------------------------
- コンソール上で以下のコマンドを入力し, ユーザ名とメールアドレスを入力します. 

.. code:: console

    $ git config --global user.name "<ユーザ名>"
    $ git config --global user.email "<メールアドレス>"

- ユーザ名とメールアドレスはコミット(後述)を実行したユーザの識別に使用されます. 
- 上記コマンドを実行すると, ユーザのホームディレクトリに :code:`.gitconfig` というファイルが作成されます. このファイルの中身を見ると設定内容が分かります. 
- 上記の設定は :code:`git config` を実行したユーザが扱う全てのリポジトリ(後述)で有効です. 
- (オプション) :code:`.gitconfig` ファイルに以下の行を追加することで, Gitコマンドのエイリアスを設定します. 

.. code:: console

    [alias]
        lg = log --graph --date=short --format=\"%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)\"

- 上記の設定後, リポジトリ内で :code:`git lg` と入力すると, ログが分かりやすく表示されます. 

リポジトリ
-------------------------------------------------------------------------------
- リポジトリとはファイルとその変更履歴をまとめたものです. 
- Gitにおけるリポジトリの実体は, リポジトリのルートディレクトリに存在する :code:`.git` ディレクトリです. 実際, :code:`.git` ディレクトリを削除するとリポジトリの情報は全て消えます. 
- リポジトリのルートディレクトリ以下でGitコマンド(例えば :code:`git add` や :code:`git status` など)を実行すると, そのリポジトリに対して操作が実行されます. 

例1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- この例では以下のコマンドを使用します. 

    - :code:`git init`

- 適当なディレクトリをGitのバージョン管理下に置きます. 
- ディレクトリは何でも良いのですが, ここの説明では :code:`~/Download/repo1` ディレクトリを用いることとします. 
- ディレクトリをバージョン管理下に置くにはコマンド :code:`git init` を使用します. 

.. code:: console

    $ mkdir -p ~/Download/repo1
    $ cd ~/Download/repo1
    $ git init

- これでディレクトリがGitのバージョン管理下に置かれました. 

コミットとステージング
-------------------------------------------------------------------------------
- コミットとはレポジトリのある時点でのスナップショットです. 
- コミットはその直近の祖先へのポインタを持ちます. これにより, コミットはリポジトリに対する追加・変更の履歴を表現するグラフとして表現されます. これをコミットグラフと呼びます（`参考リンク <https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E6%A9%9F%E8%83%BD-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%A8%E3%81%AF>`_）. 
- コミットという単語はスナップショットをコミットグラフに追加する操作を指すこともあります. この場合, 「ファイルをコミットする」「変更をコミットする」というように使われます. 

.. note:: ネット上で, Gitはコミットをスナップショットとして格納するという説明を見かけることがあります. 実際は, コミットを構成するオブジェクトに対して差分管理が適用されます. スナップショットの系列の差分を抽出してファイルを圧縮するプロセスをGitではパッキングと呼びます. これは新しく追加された機能ということです(`参考リンク <https://git-scm.com/book/ja/v1/Git%E3%81%AE%E5%86%85%E5%81%B4-%E3%83%91%E3%83%83%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB>`_). 

ステージング
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- ステージングとはコミットする変更内容をリポジトリに通知する事です. 
- ステージングを何度も行う事で複数の変更を同時にコミットできます. 
- さらに, 変更されたファイルの一部をステージングすることもできます. 例えば, 一つのファイルに二つの機能を追加した場合, それらを別々のコミットとして扱う事が出来ます. コマンド :code:`git add` のオプション :code:`-p` を指定します. 
- ステージングされた変更は, コミットする前であれば取り消すことができます. 

例2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- この例では以下のコマンドを使用します. 

    - :code:`git status`
    - :code:`git add`
    - :code:`git commit`
    - :code:`git lg` (エイリアスとして追加したもので, 標準のコマンドではありません)

- 適当なファイルを作成し, リポジトリにコミットしてみましょう. 
- 以下のコマンドを入力して空のファイルを作成します. 

.. code:: console

    $ cd ~/Download/repo1
    $ touch source.txt # ファイル名は適当です

- コマンド :code:`git status` を用いてリポジトリの状態を見てみましょう. 

.. code:: console

    $ git status
    On branch master

    Initial commit

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            source.txt

    nothing added to commit but untracked files present (use "git add" to track)

- まず, 現在"master"という名前のブランチ(後述)にいることが分かります. 
- そして, 作成した :code:`source.txt` が追跡(バージョン管理)の対象になっていないことが分かります. 
- このファイルを追跡対象とするためにはコマンド :code:`git add` を使用します. 

.. code:: console

    $ git add source.txt
    On branch master

    Initial commit

    Changes to be committed:
      (use "git rm --cached <file>..." to unstage)

            new file:   source.txt

- ファイルが追跡対象として追加され(:code:`new file`), かつステージングされました(:code:`Changes to be committed`). これでファイルをコミットする準備ができました. 
- コマンド :code:`git commit` でコミットします. 

.. code:: console

    $ git commit -m "First commit."
    [master (root-commit) c8e4a5c] First commit.
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 source.txt

- オプション :code:`-m "<文字列>"` はコミットのメッセージを設定します. 
- 現在のリポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    nothing to commit, working directory clean

- このメッセージは, このリポジトリの全てのファイル(今は :code:`source.txt` だけです)に直前のコミット以降変更が無いことを意味します. 
- エイリアスとして登録した :code:`git lg` を用いてコミットグラフを確認します. 

.. code:: console

    $ git lg
    * c8e4a5c [2016-06-19] (HEAD -> master) First commit. @username

- 最初のコミットを確認できました. 
- 先頭の :code:`c8e4a5c` はコミットを識別するハッシュ値を表します. 
- ファイルに変更を加えてその内容を確認します. 

.. code:: console

    $ echo "string" > source.txt
    $ git diff
    diff --git a/source.txt b/source.txt
    index e69de29..ee8a39c 100644
    --- a/source.txt
    +++ b/source.txt
    @@ -0,0 +1 @@
    +string

- ファイルに対する変更が確認できました. コミットします. 

.. code:: console

    $ git add . # "." は変更があった全てのファイルをステージングすることを意味します. 
    $ git commit -m "Modify a file."
    [master 1633e39] Modify a file.
     1 file changed, 1 insertion(+)

- コミットグラフを確認します. 

.. code:: console

    $ git lg
    * 1633e39 [2016-06-19] (HEAD -> master) Modify a file. @username
    * c8e4a5c [2016-06-19] First commit. @username

- 新たなコミットが追加されたことが分かります. 

バージョン管理対象の制御
-------------------------------------------------------------------------------
- :code:`.gitignore` ファイルはGitバージョン管理の対象としないファイル(例えばコンパイラが出力する中間ファイル)を指定するものです. 
- VC++やPythonなど各種プロジェクトに適した :code:`.gitignore` ファイルのテンプレートがネット上にあります. 必要に応じて検索しましょう. 

例3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- 中間ファイルとして :code:`tmp` というファイルが生成されたとします. 

.. code:: console

    $ touch tmp

- コマンド :code:`git status` でリポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            tmp

    nothing added to commit but untracked files present (use "git add" to track)

- 中間ファイルは追跡対象としたくないので, :code:`.gitignore` ファイルを作成し, 中間ファイル名を追加します. 

.. code:: console

    $ echo tmp > .gitignore

- リポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            .gitignore

    nothing added to commit but untracked files present (use "git add" to track)

- 先ほどの状態と比べると, :code:`tmp` ファイルが無視されていることが分かります. ただし, 新たに作成した :code:`.gitignore` ファイルが検出されます. 
- :code:`.gitignore` ファイル内ではワイルドカードを使用できます. ネット上の例を参照してください. 
- :code:`.gitignore` ファイルをコミットします. 

.. code:: console

    $ git add .
    $ git commit -m "Add .gitignore."
    [master 50178a5] Add .gitignore.
     1 file changed, 1 insertion(+)
     create mode 100644 .gitignore

ブランチ
-------------------------------------------------------------------------------
- ブランチとはリポジトリに含まれる異なるバージョンのスナップショットです. 
- ブランチの実体はコミットへのポインタです. 
- リポジトリは必ず「現在のブランチ」を状態として持ちます. これまでの例では「現在のブランチ」は :code:`master` という名前でした. これはリポジトリを作成する時のデフォルトのブランチ名です. 
- リポジトリを切り替えると, ブランチが移動し, ディレクトリの内容はブランチが指すコミットに含まれるものに置き換えられます. もちろん, 元のブランチに戻ればディレクトリの内容もまた元に戻ります. Gitでは, ブランチの切り替えをチェックアウトと呼びます. 

例4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- 例3まで完了し, 現在のリポジトリの状態が次のようになっているとします. 

.. code:: console

    $ cd ~/Download/repo1
    $ git status
    On branch master
    nothing to commit, working directory clean
    $ git lg
    * 3d9f3bb [2016-06-19] (HEAD -> master) Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- コマンド :code:`git branch` を使用してリポジトリが持つブランチを表示します. 

.. code:: console

    $ git branch
    * master

- :code:`master` ブランチしか存在しないことが確認できます. 
- 次に, :code:`develop` という名前のブランチを新規に作成し, 同時にそのブランチをチェックアウトします. コマンド :code:`git checkout` を使用します. 

.. code:: console

    $ git checkout -b develop
    Switched to a new branch 'develop'

- もう一度ブランチを確認します. 

.. code:: console

    $ git branch
    * develop
      master

- 新たに :code:`develop` ブランチが作成されています. 先頭の :code:`*` は現在のブランチを表します. 
- コミットグラフを確認します. 

.. code:: console

    $ git lg
    * 3d9f3bb [2016-06-19] (HEAD -> develop, master) Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- 最新のコミットを見ると, :code:`develop` ブランチ作成前には :code:`HEAD -> master` となっていた部分が :code:`HEAD -> develop, master` となっているのが分かります. 
- この :code:`HEAD` は現在のブランチを表すコミットへのポインタです. 
- この状態で適当な修正をリポジトリに加え, コミットします. 

.. code:: console

    $ echo string2 >> source.txt
    $ git add .
    $ git commit -m "Modify a file."
    [develop 88afd83] Modify a file.
     1 file changed, 1 insertion(+)

- コミットグラフを確認します. 

.. code:: console

    $ git lg
    * 88afd83 [2016-06-19] (HEAD -> develop) Modify a file. @username
    * 3d9f3bb [2016-06-19] (master) Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- 先ほどの修正に対応するコミットが追加され, :code:`develop` ブランチがそのコミットを指していることが分かります. 
- 一方, :code:`master` ブランチが指すコミットは元のままです. 
- :code:`master` ブランチに移動し, :code:`source.txt` ファイルの中身を確認します. 

.. code:: console

    $ git checkout master
    $ cat source.txt
    string

- :code:`develop` ブランチでの修正が反映されていないことが確認できました. 
- この例の最後に, :code:`master` ブランチに修正を加えます. 

.. code:: console

    $ touch source2.txt
    $ git add .
    $ git commit -m "Add a new file."
    [master 6462d05] Add a new file.
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 source2.txt
    $ git lg
    * 6462d05 [2016-06-19] (HEAD -> master) Add a new file. @username
    * 3d9f3bb [2016-06-19] Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- コミットグラフには :code:`master` ブランチしか表示されていませんが, これで正常です. :code:`develop` ブランチは3番目のコミット以降分岐しているためです. 
- 二つのブランチがマージ(後述)されると, :code:`develop` ブランチの履歴が :code:`master` ブランチから参照可能となります. 
- :code:`master` ブランチに追加した :code:`source2.txt` は当然 :code:`develop` ブランチには含まれません. 

マージ
-------------------------------------------------------------------------------
- マージはあるブランチの修正を別のブランチに取り込むことです. 
- 具体的には, 二つのコミットがマージされた新たなコミットが作成されます. 
- マージで問題となるのは変更が衝突する場合ですが, まずは衝突がない場合の例を見てみます. 

例5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- :code:`develop` ブランチの内容を :code:`master` ブランチに取り込みます. そのために, 他のブランチを取り込むブランチ, すなわち :code:`master` ブランチに移動します. 

.. code:: console

    $ cd ~/Download/repo1
    $ git checkout master
    Switched to branch 'master'

.. note:: :code:`develop` ブランチに他のブランチの変更を取り込む場合は :code:`develop` ブランチに移動します. 

- コマンド :code:`git merge` を用いて :code:`develop` ブランチとマージします. 

.. code:: console

    $ git merge

- するとコミットメッセージの入力を促されます. 

.. code:: console

    Merge branch 'develop'

    # Please enter a commit message to explain why this merge is necessary,
    # especially if it merges an updated upstream into a topic branch.
    #
    # Lines starting with '#' will be ignored, and an empty message aborts
    # the commit.

- エディタのコマンドでメッセージをこのまま保存します. 次のようなメッセージが表示され, マージが完了します. 

.. code:: console

    Merge made by the 'recursive' strategy.
     source.txt | 1 +
     1 file changed, 1 insertion(+)

- コミットグラフを確認します. 

.. code:: console

    $ git lg
    *   834468a [2016-06-19] (HEAD -> master) Merge branch 'develop' @username
    |\
    | * 88afd83 [2016-06-19] (develop) Modify a file. @username
    * | 6462d05 [2016-06-19] Add a new file. @username
    |/
    * 3d9f3bb [2016-06-19] Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- 二つのブランチが分岐し, 最後のコミットで両者がマージされていることが分かります. 
- 今回のマージでは, 分岐した後で変更の衝突がなかったため問題は起こりませんでした. 

例6: マージにおける衝突の解消
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- ここではマージの際に衝突が起こる場合を見てみます. 
- :code:`master` ブランチに移動し, 新たに :code:`develop2` ブランチを作成します. そして, :code:`source.txt` に変更を追加します. 

.. code:: console

    $ cd ~/Download/repo1
    $ git checkout master
    Already on 'master'
    $ git checkout -b develop2
    Switched to a new branch 'develop2'
    $ echo string3 >> source.txt
    $ git add .
    $ git commit -m "Add string3."
    [develop2 88287ed] Add string3.
     1 file changed, 1 insertion(+)
    $ git lg
    * 88287ed [2016-06-19] (HEAD -> develop2) Add string3. @username
    *   834468a [2016-06-19] (master) Merge branch 'develop' @username
    |\
    | * 88afd83 [2016-06-19] (develop) Modify a file. @username
    * | 6462d05 [2016-06-19] Add a new file. @username
    |/
    * 3d9f3bb [2016-06-19] Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- 次に :code:`master` ブランチに戻り同じファイルに別の変更を追加します. 

.. code:: console

    $ git checkout master
    Switched to branch 'master'
    $ cat source.txt
    string
    string2
    $ echo string4 >> source.txt
    $ git add .
    $ git commit -m "Add string4."
    [master 515ba7a] Add string4.
     1 file changed, 1 insertion(+)
    $ git lg
    * 515ba7a [2016-06-19] (HEAD -> master) Add string4. @username
    *   834468a [2016-06-19] Merge branch 'develop' @username
    |\
    | * 88afd83 [2016-06-19] (develop) Modify a file. @username
    * | 6462d05 [2016-06-19] Add a new file. @username
    |/
    * 3d9f3bb [2016-06-19] Add .gitignore. @username
    * 0ce339c [2016-06-19] Modify a file. @username
    * 10f33be [2016-06-19] First commit. @username

- この状態で :code:`develop2` ブランチを :code:`master` ブランチにマージします. 

.. code:: console

    $ git merge develop2
    Auto-merging source.txt
    CONFLICT (content): Merge conflict in source.txt
    Automatic merge failed; fix conflicts and then commit the result.

- すると, このように衝突を解消してからコミットを行うよう指示されます. 
- 衝突が起こっている :code:`source.txt` の中身を確認します.

.. code:: console

    $ cat source.txt
    string
    string2
    <<<<<<< HEAD
    string4
    =======
    string3
    >>>>>>> develop2

- :code:`master` ブランチと :code:`develop2` ブランチへの変更内容が衝突している様子が分かります. :code:`master` ブランチは現在のブランチなので :code:`HEAD` と示されています. 
- 今回は二つの変更内容を次のように統合することとします. 

.. code:: console

    $ # ファイルを編集します. 編集した結果を確認します. 
    $ cat source.txt
    string
    string2
    string34

- :code:`master` ブランチの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    You have unmerged paths.
      (fix conflicts and run "git commit")

    Unmerged paths:
      (use "git add <file>..." to mark resolution)

        both modified:   source.txt

    no changes added to commit (use "git add" and/or "git commit -a")

- 先ほどの修正内容をコミットします. 

.. code:: console

    $ git add .
    $ git commit -m "Fix conflict."
    [master 5e9b133] Fix conflict.
    $ git lg -3 # 直近の3コミットのみ表示します. 
    *   5e9b133 [2016-06-22] (HEAD -> master) Fix conflict. @username
    |\
    | * 88287ed [2016-06-22] (develop2) Add string3. @username
    * | 515ba7a [2016-06-22] Add string4. @username
    |/

- これで衝突を解消してマージすることができました. 

Fast-forwardマージ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`参考リンク <https://git-scm.com/book/ja/v1/Git-のブランチ機能-ブランチとマージの基本>`_, 図13, 14. :code:`master` ブランチに :code:`hotfix` ブランチをマージするときにfast-forwardマージが適用されます. 

例7: Fast-forwardマージ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

例8: Fast-forwardマージの明示的な回避
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

リモートリポジトリ
-------------------------------------------------------------------------------
- リモートリポジトリとは現在のリポジトリ(カレントディレクトリと考えてよいでしょう)と別の場所に存在するリポジトリのことです. それが同一マシン上(の別ディレクトリ)に存在したとしても, リモートリポジトリとして扱われます. 
- 通常, リモートリポジトリは現在のリポジトリと共通のコミットを持ちます. 典型的には,  リモートリポジトリの内容をコピーして現在のリポジトリを作成し, 独自に修正を適用するような場合です. 
- リモートリポジトリと同期を取るためには, リモートリポジトリを現在のリポジトリに登録する必要があります. 一度登録すれば, 登録を解除するまでリモートリポジトリの情報が現在のリポジトリに記憶されます. 
- 元のリモートリポジトリに対する変更は, 現在のリポジトリが持つリモートリポジトリには自動的には反映されません. そのため, リモートリポジトリの最新の状態を明示的に取得する必要があります. 
- リモートリポジトリのブランチを現在のブランチにマージすることで, リモートリポジトリへの変更が現在のリポジトリに取り込まれます. 

例9: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- 以下のコマンドを使用します. 

    - ```git clone```
    - ```git remote```
    - ```git fetch```
    - ```git push```

更新履歴
-------------------------------------------------------------------------------

免責事項
-------------------------------------------------------------------------------
