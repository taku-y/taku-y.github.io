Git入門
===============================================================================
最終更新: 20161008 吉岡琢

.. contents::
    :depth: 3

ここではGitの使い方を一通り説明します. 特に, Gitを理解するために重要な概念をできるだけ具体的に説明します. 一方, Gitの意義やインストールに関する説明はしません. Gitのディレクトリにパスが通っており, Gitのコマンドが利用可能であると仮定します. 例では一貫して :code:`~/Download/repo[n]` ディレクトリを使用します. 断りが無い限り, 例のコマンドは全てこのディレクトリで実行します. 例は最初から順に実行すると仮定します. 例2を確認する場合, 例1が終了していることを前提とします. 

0. 初期設定
-------------------------------------------------------------------------------
コンソール上で以下のコマンドを入力し, ユーザ名とメールアドレスを入力します. 

.. code:: console

    $ git config --global user.name "<ユーザ名>"
    $ git config --global user.email "<メールアドレス>"

ユーザ名とメールアドレスはコミット(後述)を実行したユーザの識別に使用されます. 上記コマンドを実行すると, ユーザのホームディレクトリに :code:`.gitconfig` というファイルが作成されます. このファイルの中身を見ると設定内容が分かります. 上記の設定は :code:`git config` を実行したユーザが扱う全てのリポジトリ（後述）で有効です. 

（オプション）:code:`.gitconfig` ファイルに以下の行を追加することで, Gitコマンドのエイリアスを設定します. 

.. code:: console

    [alias]
        lg = log --graph --date=short --format=\"%C(yellow)%h%C(reset) %C(magenta)[%ad]%C(reset)%C(auto)%d%C(reset) %s %C(cyan)@%an%C(reset)\"

上記の設定後, リポジトリ内で :code:`git lg` と入力すると, ログが分かりやすく表示されます. 

1. リポジトリ
-------------------------------------------------------------------------------
リポジトリとはファイルとその変更履歴をまとめたものです. Gitにおけるリポジトリの実体は, リポジトリのルートディレクトリに存在する :code:`.git` ディレクトリです. 実際, :code:`.git` ディレクトリを削除するとリポジトリの情報は全て消えます. リポジトリのルートディレクトリ以下でGitコマンド（例えば :code:`git add` や :code:`git status` など）を実行すると, そのリポジトリに対して操作が実行されます. 

例1: リポジトリの作成
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
リポジトリを作成するためにコマンド :code:`git init` を使用します. リポジトリの作成とは, プロジェクトの構成要素（主にテキストファイル）を含むディレクトリをGitのバージョン管理下に置くことです. ディレクトリ名は何でも良いのですが, ここの説明では :code:`~/Download/repo1` という名前にします. ディレクトリをGitのバージョン管理下に置くにはコマンド :code:`git init` を使用します. 

.. code:: console

    $ mkdir -p ~/Download/repo1
    $ cd ~/Download/repo1
    $ git init

これでこのディレクトリがリポジトリになりました. 

2. ステージングとコミット
-------------------------------------------------------------------------------
コミットとはリポジトリのある時点でのスナップショットです. コミットはその直近の祖先へのポインタを持ちます. これにより, コミットはリポジトリに対する追加・変更の履歴を表現するグラフとして表現されます. これをコミットグラフと呼びます（`参考リンク <https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E6%A9%9F%E8%83%BD-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%A8%E3%81%AF>`_）. 

コミットという単語はスナップショットをコミットグラフに追加する操作を指すこともあります. この場合, 「ファイルをコミットする」「変更をコミットする」というように使われます. 

.. note:: ネット上で, Gitはコミットをスナップショットとして格納するという説明を見かけることがあります. 実際は, コミットを構成するオブジェクトに対して差分管理が適用されます. スナップショットの系列の差分を抽出してファイルを圧縮するプロセスをGitではパッキングと呼びます. これは新しく追加された機能ということです（`参考リンク <https://git-scm.com/book/ja/v1/Git%E3%81%AE%E5%86%85%E5%81%B4-%E3%83%91%E3%83%83%E3%82%AF%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB>`_）. 

ステージング
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ステージングとはコミットする変更内容をリポジトリに通知する事です. ステージングを何度も行う事で, 複数の変更を同時にコミットできます. さらに, 変更されたファイルの一部をステージングすることもできます. 例えば, 一つのファイルに二つの機能を追加した場合, それらを別々のコミットとして扱う事が出来ます. そのためには, コマンド :code:`git add` のオプション :code:`-p` を指定します. ステージングされた変更は, コミットする前であれば取り消すことができます. 

例2: ステージングとコミット
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
この例ではコマンド :code:`git status`, :code:`git add`, :code:`git commit`, :code:`git lg`（エイリアスとして追加したもので, 標準のコマンドではありません）を使用します. 適当なファイルを作成し, リポジトリにコミットしてみましょう. 以下のコマンドを入力して空のファイルを作成します. 

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

まず, 現在"master"という名前のブランチ(後述)にいることが分かります. そして, 作成した :code:`source.txt` が追跡（バージョン管理）の対象になっていないことが分かります. このファイルを追跡対象とするためにはコマンド :code:`git add` を使用します. 

.. code:: console

    $ git add source.txt
    $ git status
    On branch master

    Initial commit

    Changes to be committed:
      (use "git rm --cached <file>..." to unstage)

            new file:   source.txt

ファイルが追跡対象として追加され（:code:`new file`）, かつステージングされました（:code:`Changes to be committed`）. これでファイルをコミットする準備ができました. コマンド :code:`git commit` でコミットします. 

.. code:: console

    $  git commit -m "First commit"
    [master (root-commit) 8c86d01] First commit
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 source.txt

ここでオプション :code:`-m "<文字列>"` はコミットのメッセージを設定します. 

現在のリポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    nothing to commit, working directory clean

このメッセージは, このリポジトリの全てのファイル（今は :code:`source.txt` だけです）に直前のコミット以降変更が無いことを意味します. エイリアスとして登録した :code:`git lg` を用いてコミットグラフを確認します. 

.. code:: console

    $ git lg
    * 8c86d01 [2016-10-05] (HEAD -> master) First commit @taku-y

これで最初のコミットを確認できました. 先頭の :code:`c8e4a5c` はコミットを識別するハッシュ値を表します. 

ファイルに変更を加えてその内容を確認します. 変更箇所の確認のためには :code:`git diff` を使用します. 

.. code:: console

    $ echo "string" > source.txt
    $ git diff
    diff --git a/source.txt b/source.txt
    index e69de29..ee8a39c 100644
    --- a/source.txt
    +++ b/source.txt
    @@ -0,0 +1 @@
    +string

ファイルに対する変更が確認できました. コミットします. 

.. code:: console

    $ git add . # "." は変更があった全てのファイルをステージングすることを意味します. 
    $ git commit -m "Modify a file."
    [master ef783b7] Modify a file
     1 file changed, 1 insertion(+)

コミットグラフを確認します. 

.. code:: console

    $ git lg
    * ef783b7 [2016-10-05] (HEAD -> master) Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

新たなコミットが追加されたことが分かります. 

3. バージョン管理対象の制御
-------------------------------------------------------------------------------
:code:`.gitignore` ファイルはGitバージョン管理の対象としないファイル（例えばコンパイラが出力する中間ファイル）を指定するものです. VC++やPythonなど各種プロジェクトに適した :code:`.gitignore` ファイルのテンプレートがネット上にあります. 必要に応じて検索しましょう. 

例3: :code:`.gitignore` の設定
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
中間ファイルとして :code:`tmp` というファイルが生成されたとします. 

.. code:: console

    $ touch tmp

コマンド :code:`git status` でリポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            tmp

    nothing added to commit but untracked files present (use "git add" to track)

中間ファイルは追跡対象としたくないので, :code:`.gitignore` ファイルを作成し, 中間ファイル名を追加します. 

.. code:: console

    $ echo tmp > .gitignore

リポジトリの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            .gitignore

    nothing added to commit but untracked files present (use "git add" to track)

先ほどの状態と比べると, :code:`tmp` ファイルが無視されていることが分かります. ただし, 新たに作成した :code:`.gitignore` ファイルが検出されます. :code:`.gitignore` ファイル内ではワイルドカードを使用できます. ネット上の例を参照してください. 

:code:`.gitignore` ファイルをコミットします. 

.. code:: console

    $ git add .
    $ git commit -m "Add .gitignore."
    [master 350b614] Add .gitignore
     1 file changed, 1 insertion(+)
     create mode 100644 .gitignore

4. ブランチ
-------------------------------------------------------------------------------
ブランチとはリポジトリに含まれる異なるバージョンのスナップショットです. ブランチの実体はコミットへのポインタです. リポジトリは必ず「現在のブランチ」を状態として持ちます. これまでの例では「現在のブランチ」は :code:`master` という名前でした. これはリポジトリを作成する時のデフォルトのブランチ名です. リポジトリを切り替えると, ブランチが移動し, ディレクトリの内容はブランチが指すコミットに含まれるものに置き換えられます. もちろん, 元のブランチに戻ればディレクトリの内容もまた元に戻ります. Gitではブランチの切り替えをチェックアウトと呼びます. 

例4: ブランチの確認と切り替え
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
例3まで完了し, 現在のリポジトリの状態が次のようになっているとします. 

.. code:: console

    $ cd ~/Download/repo1
    $ git status
    On branch master
    nothing to commit, working directory clean
    $ git lg
    * 350b614 [2016-10-05] (HEAD -> master) Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

コマンド :code:`git branch` を使用してリポジトリが持つブランチを表示します. 

.. code:: console

    $ git branch
    * master

:code:`master` ブランチしか存在しないことが確認できます. 先頭のアスタリスクは現在のブランチが :code:`master` であることを表します. 

次に :code:`develop` という名前のブランチを新規に作成し, 同時にそのブランチをチェックアウトします. コマンド :code:`git checkout` を使用します. 

.. code:: console

    $ git checkout -b develop
    Switched to a new branch 'develop'

オプション :code:`-b` は存在しないブランチを新たに作成してからチェックアウトすることを指示します. 

もう一度ブランチを確認します. 

.. code:: console

    $ git branch
    * develop
      master

新たに :code:`develop` ブランチが作成されると同時に, ブランチが移動したことが分かります. 

コミットグラフを確認します. 

.. code:: console

    $ git lg
    * 350b614 [2016-10-05] (HEAD -> develop, master) Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

最新のコミットを見ると, :code:`develop` ブランチ作成前には :code:`HEAD -> master` となっていた部分が :code:`HEAD -> develop, master` となっているのが分かります. この :code:`HEAD` は現在のブランチを表すコミットへのポインタです. 

この状態で適当な修正をリポジトリに加え, コミットします. 

.. code:: console

    $ echo string2 >> source.txt
    $ git add .
    $ git commit -m "Modify a file"
    [develop 88afd83] Modify a file
     1 file changed, 1 insertion(+)

- コミットグラフを確認します. 

.. code:: console

    $ git lg
    * 32fc7a4 [2016-10-06] (HEAD -> develop) Modify a file @taku-y
    * 350b614 [2016-10-05] (master) Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

先ほどの修正に対応するコミットが追加され, :code:`develop` ブランチがそのコミットを指していることが分かります. 一方, :code:`master` ブランチが指すコミットは元のままです. :code:`master` ブランチに移動し, :code:`source.txt` ファイルの中身を確認します. 

.. code:: console

    $ git checkout master
    Switched to branch 'master'
    $ cat source.txt
    string

:code:`develop` ブランチでの修正が反映されていないことが確認できました. 

最後に, ブランチの分岐の例を示すため, :code:`master` ブランチに修正を加えます. 

.. code:: console

    $ touch source2.txt
    $ git add .
    $ git commit -m "Add a new file."
    [master 6f1d258] Add a new file
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 source2.txt
    $ git lg
    * 6f1d258 [2016-10-06] (HEAD -> master) Add a new file @taku-y
    * 350b614 [2016-10-05] Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

コミットグラフには :code:`master` ブランチしか表示されていませんが, これで正常です. :code:`develop` ブランチは3番目のコミット以降分岐しているためです. 二つのブランチがマージ(後述)されると, :code:`develop` ブランチの履歴が :code:`master` ブランチから参照可能となります. :code:`master` ブランチに追加した :code:`source2.txt` は当然 :code:`develop` ブランチには含まれません. 

5. マージ
-------------------------------------------------------------------------------
マージはあるブランチの修正を別のブランチに取り込むことです. 具体的には, 二つのブランチの先頭のコミットがマージされた新たなコミットが作成されます. マージで問題となるのは変更が衝突する場合ですが, まずは衝突がない場合の例を見てみます. 

例5: 衝突が無い場合のマージ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- :code:`develop` ブランチの内容を :code:`master` ブランチに取り込みます. そのために, まず :code:`master` ブランチに移動します. 

.. code:: console

    $ cd ~/Download/repo1
    $ git checkout master
    Switched to branch 'master'

.. note:: :code:`develop` ブランチに他のブランチの変更を取り込む場合は :code:`develop` ブランチに移動します. 

コマンド :code:`git merge` を用いて :code:`develop` ブランチとマージします. 

.. code:: console

    $ git merge develop

するとコミットメッセージの入力を促されます. 

.. code:: console

    Merge branch 'develop'

    # Please enter a commit message to explain why this merge is necessary,
    # especially if it merges an updated upstream into a topic branch.
    #
    # Lines starting with '#' will be ignored, and an empty message aborts
    # the commit.

エディタのコマンドでメッセージをこのまま保存します. 次のようなメッセージが表示され, マージが完了します. 

.. code:: console

    Merge made by the 'recursive' strategy.
     source.txt | 1 +
     1 file changed, 1 insertion(+)

コミットグラフを確認します. 

.. code:: console

    $ git lg
    *   ff5e941 [2016-10-06] (HEAD -> master) Merge branch 'develop' @taku-y
    |\
    | * 32fc7a4 [2016-10-06] (develop) Modify a file @taku-y
    * | 6f1d258 [2016-10-06] Add a new file @taku-y
    |/
    * 350b614 [2016-10-05] Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

二つのブランチが分岐し, 最後のコミットで両者がマージされていることが分かります. 今回のマージでは, 分岐した後で変更の衝突がなかったため問題は起こりませんでした. 

例6: マージにおける衝突の解消
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ここではマージの際に衝突が起こる場合を見てみます. :code:`master` ブランチに移動し, 新たに :code:`develop2` ブランチを作成します. そして, :code:`source.txt` に変更を追加します. 

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
    * 20ee04d [2016-10-06] (HEAD -> develop2) Add string3 @taku-y
    *   ff5e941 [2016-10-06] (master) Merge branch 'develop' @taku-y
    |\
    | * 32fc7a4 [2016-10-06] (develop) Modify a file @taku-y
    * | 6f1d258 [2016-10-06] Add a new file @taku-y
    |/
    * 350b614 [2016-10-05] Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

次に :code:`master` ブランチに戻り同じファイルに別の変更を追加します. 

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
    * a210d0e [2016-10-06] (HEAD -> master) Add string4 @taku-y
    *   ff5e941 [2016-10-06] Merge branch 'develop' @taku-y
    |\
    | * 32fc7a4 [2016-10-06] (develop) Modify a file @taku-y
    * | 6f1d258 [2016-10-06] Add a new file @taku-y
    |/
    * 350b614 [2016-10-05] Add .gitignore @taku-y
    * ef783b7 [2016-10-05] Modify a file @taku-y
    * 8c86d01 [2016-10-05] First commit @taku-y

この状態で :code:`develop2` ブランチを :code:`master` ブランチにマージします. 

.. code:: console

    $ git merge develop2
    Auto-merging source.txt
    CONFLICT (content): Merge conflict in source.txt
    Automatic merge failed; fix conflicts and then commit the result.

すると, このように衝突を解消してからコミットを行うよう指示されます. 衝突が起こっている :code:`source.txt` の中身を確認します.

.. code:: console

    $ cat source.txt
    string
    string2
    <<<<<<< HEAD
    string4
    =======
    string3
    >>>>>>> develop2

:code:`master` ブランチと :code:`develop2` ブランチへの変更内容が衝突している様子が分かります. :code:`master` ブランチは現在のブランチなので :code:`HEAD` と示されています. 今回は二つの変更内容を次のように統合することとします. 

.. code:: console

    $ # ファイルを編集します. 編集した結果を確認します. 
    $ cat source.txt
    string
    string2
    string34

:code:`master` ブランチの状態を確認します. 

.. code:: console

    $ git status
    On branch master
    You have unmerged paths.
      (fix conflicts and run "git commit")

    Unmerged paths:
      (use "git add <file>..." to mark resolution)

        both modified:   source.txt

    no changes added to commit (use "git add" and/or "git commit -a")

先ほどの修正内容をコミットします. 

.. code:: console

    $ git add .
    $ git commit -m "Resolve conflict"
    [master 5e9b133] Resolve conflict
    $ git lg -3 # 直近の3コミットのみ表示します. 
    *   5a871fb [2016-10-06] (HEAD -> master) Resolve conflict @taku-y
    |\
    | * 20ee04d [2016-10-06] (develop2) Add string3 @taku-y
    * | a210d0e [2016-10-06] Add string4 @taku-y
    |/

これで衝突を解消してマージすることができました. 

Fast-forwardマージ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
あるブランチAから分岐したブランチBにコミットを追加し, かつブランチAに何もコミットを追加しない場合を考えます. このときにブランチAにブランチBをマージするためには, ブランチAにブランチBのコミットを追加すれば十分です. したがって, ブランチAが指すコミットへのポインタをブランチBが指すコミットに移動すればよいことになります. このようなマージをfast-forwardマージと呼びます（`参考リンク <https://git-scm.com/book/ja/v1/Git-のブランチ機能-ブランチとマージの基本>`_, 図13, 14. :code:`master` ブランチに :code:`hotfix` ブランチをマージするときにfast-forwardマージが適用されます）. 

例7: Fast-forwardマージ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fast-forwardマージを試してみます. そのために, :code:`master` ブランチから分岐する :code:`develop3` ブランチを作成し, ファイルに修正を追加します. 

.. code:: console

    $ cd ~/Download/repo1
    $ git checkout master
    Already on 'master'
    $ git checkout -b develop3
    Switched to a new branch 'develop3'
    $ echo string5 >> source.txt
    $ git add .
    $ git commit -m "Add string5"
    [develop3 1c45527] Add string5
     1 file changed, 1 insertion(+)

コミットグラフを確認します. 

.. code:: console

    $ git lg -4
    * 1c45527 [2016-10-06] (HEAD -> develop3) Add string5 @taku-y
    *   5a871fb [2016-10-06] (master) Resolve conflict @taku-y
    |\
    | * 20ee04d [2016-10-06] (develop2) Add string3 @taku-y
    * | a210d0e [2016-10-06] Add string4 @taku-y
    |/

この状態で :code:`master` ブランチに :code:`develop3` ブランチをマージします. 

.. code:: console

    $ git checkout master
    Switched to branch 'master'
    $ git merge develop3
    Updating 5a871fb..1c45527
    Fast-forward
     source.txt | 1 +
     1 file changed, 1 insertion(+)

Fast-forwardマージが適用されたことが分かります. コミットグラフを確認します. 

.. code:: console

    $ git lg -4
    * 1c45527 [2016-10-06] (HEAD -> master, develop3) Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\
    | * 20ee04d [2016-10-06] (develop2) Add string3 @taku-y
    * | a210d0e [2016-10-06] Add string4 @taku-y
    |/

:code:`master` ブランチのポインタが1つ先に進んだだけであることが分かります. 

例8: Fast-forwardマージの明示的な回避
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
例7のような状況でブランチが分岐したことを履歴に残したい場合があるとします. その場合, :code:`git merge` のオプション :code:`--no-ff` を指定します. 先ほどと同様に, :code:`master` ブランチから新たなブランチを分岐し, 適当な修正を追加します. 

.. code:: console

    $ cd ~/Download/repo1
    $ git checkout master
    Already on 'master'
    $ git checkout -b develop4
    Switched to a new branch 'develop4'
    $ echo string6 >> source.txt
    $ git add .
    $ git commit -m "Add string6"
    [develop4 3a56f79] Add string6
     1 file changed, 1 insertion(+)

:code:`--no-ff` オプションを指定してマージします. 

.. code:: console

    $ git checkout master
    Switched to branch 'master'
    $ git merge --no-ff develop4
    Merge made by the 'recursive' strategy.
     source.txt | 1 +
     1 file changed, 1 insertion(+)

コミットグラフを確認します. 

.. code:: console

    $ git lg -4
    *   9b566b7 [2016-10-06] (HEAD -> master) Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] (develop3) Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

分岐したブランチのマージが履歴に残っていることが分かります. 

6. リモートリポジトリ
-------------------------------------------------------------------------------
リモートリポジトリとは手元のリポジトリと別の場所に存在するリポジトリのことです. それが同一マシン上（の別ディレクトリ）
に存在したとしてもリモートリポジトリとみなします. 区別のため, 今後は手元のリポジトリをローカルリポジトリと呼ぶこととします. 

通常の運用では, リモートリポジトリはローカルリポジトリと共通のコミットを持ちます. 典型的には,  リモートリポジトリの内容をコピーしてローカルリポジトリを作成し, 独自に修正を適用するような場合です. 

ローカルリポジトリをリモートリポジトリと同期させるためには, ローカルリポジトリにリモートリポジトリを登録する必要があります. 一度登録すれば, 登録を解除するまでリモートリポジトリの情報が現在のリポジトリに記憶されます. リモートリポジトリの情報はローカルリポジトリのリモートトラッキングブランチとして参照できます. リモートトラッキングブランチについては後述します. 先へ進む前に, ここでベアリポジトリについて触れます. 

ベアリポジトリ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
これまでの例で使用したリポジトリは作業用ファイルとコミットグラフ（:code:`.git` ディレクトリの中身）の情報を持っていました. 例えば, ブランチをチェックアウトすると対応するコミットに含まれる履歴が作業用のファイルに反映されました. これに対して, 作業用ファイルを持たず :code:`.git` コミットグラフの情報だけから構成されるリポジトリはベアリポジトリと呼ばれます. これはGitサーバの構成に用いられます. 

例9: ベアリポジトリの作成と作業履歴の書き込み
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ここでは, ベアリポジトリを作成し, これまでの例での作業履歴を書き込んでみます. このベアリポジトリをリモートリポジトリとみなします. まず, ベアリポジトリを :code:`~Download/outside` に作成します. そのためにはコマンド :code:`git init` にオプション :code:`--bare` を指定して実行します. ローカルリポジトリと区別するため, リポジトリのディレクトリ名を :code:`repo` とします. 

.. code:: console

    $ mkdir -p ~/Download/outside/repo
    $ cd ~/Download/outside/repo
    $ git init --bare
    Initialized empty Git repository in /Users/taku-y/Downloads/tmp/outside/repo/

ローカルリポジトリの作業履歴をこのベアリポジトリに追加するため, ローカルリポジトリのディレクトリに移動します. 

.. code:: console

    $ cd ~/Download/repo1

ローカルリポジトリに登録されているリモートリポジトリを確認するため, コマンド :code:`git remote` を使用します. 

.. code:: console

    $ git remote -v

コマンドを実行しても何も表示されません. ローカルリポジトリにリモートリポジトリが登録されていないためです. 上の手順で作成したベアリポジトリをリモートリポジトリとして登録するため, コマンド :code:`git remote add` を実行します. 

.. code:: console

    $ git remote add origin ../outside/repo

これで :code:`~/Download/outside/repo` に存在するベアリポジトリがリモートリポジトリとして登録されました. :code:`origin` というのは現在のローカルリポジトリにおける登録したリモートリポジトリの名前です. リモートリポジトリの名前は任意に設定できます. ここではベアリポジトリをリモートリポジトリとして登録しましたが, ベアリポジトリでない通常のリポジトリも同様にリモートリポジトリとして登録できます. 

ベアリポジトリがリモートリポジトリとして登録されているかどうか確認します. 

.. code:: console

    $ git remote -v
    origin  ../outside/repo (fetch)
    origin  ../outside/repo (push)

上記のメッセージで, :code:`fetch` はリモートリポジトリから情報を取得する操作, :code:`push` はローカルリポジトリの修正内容をリモートリポジトリに適用する操作を表します. :code:`fetch` については後述します. 

コマンド :code:`git push` を使用して, リモートリポジトリ（ :code:`~/Download/outside/repo` ）にローカルリポジトリ（ :code:`~/Download/repo1` ）の作業履歴を書き込みます. 

.. code:: console

    $ git push origin master
    Counting objects: 32, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (21/21), done.
    Writing objects: 100% (32/32), 2.81 KiB | 0 bytes/s, done.
    Total 32 (delta 5), reused 0 (delta 0)
    To ../outside/repo
     * [new branch]      master -> master

1行目のコマンドはリモートリポジトリ :code:`origin` に対してローカルリポジトリの :code:`master` ブランチの履歴を送信することを意味します. 

他のブランチの履歴を送信する例は以下の通りです. 

.. code:: console

    git push origin develop4
    Total 0 (delta 0), reused 0 (delta 0)
    To ../outside/repo
     * [new branch]      develop4 -> develop4

例10: クローン
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
この例では, 例9のベアリポジトリをローカルリポジトリとして手元にコピーし, ローカルリポジトリで適用した修正をベアリポジトリに適用します. このベアリポジトリはローカルリポジトリのリモートリポジトリとなります. 

この例のために仮想的な別のユーザを考え, そのユーザのためのディレクトリ（これまでと同じユーザアカウントで作業します）を作成し, 移動します. 

.. code:: console

    $ mkdir -p ~/Download/user2
    $ cd ~/Download/user2

リモートリポジトリの情報を手元にコピーします. Gitではリポジトリをクローンすると言います. コマンド :code:`git clone` を使用します. 

.. code:: console

    $ git clone ~/Download/outside/repo
    Cloning into 'repo'...
    done.

これでリモートリポジトリのクローンが完了しました. ローカルリポジトリの中身を確認します. 例8の最後と同じ状態になっていることが分かります. 

.. code:: console

    $ ls
    repo
    $ cd repo
    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    nothing to commit, working directory clean
    $ git lg -4
    *   9b566b7 [2016-10-06] (HEAD -> master, origin/master, origin/HEAD) Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

.. note:: 例10のローカルリポジトリは例9までのローカルリポジトリと異なることに注意します. 

このローカルリポジトリのリモートリポジトリを確認します. 

.. code:: console

    $ git remote -v
    origin  /Users/taku-y/Downloads/outside/repo (fetch)
    origin  /Users/taku-y/Downloads/outside/repo (push)

このローカルリポジトリではリモートリポジトリを登録していません. しかし, リポジトリをクローンすると, そのリポジトリが自動的に :code:`origin` という名前でリモートリポジトリとして登録されます.

では, これまでと同様にファイルに変更を加えてコミットします. 

.. code:: console

    $ echo string7 >> source2.txt
    $ git add .
    $ git commit -m "Add string7"
    [master 0b6b375] Add string7
     1 file changed, 1 insertion(+)

コミットグラフを確認します. 

.. code:: console

    $ git lg -4
    * 0b6b375 [2016-10-07] (HEAD -> master) Add string7 @taku-y
    *   9b566b7 [2016-10-06] (origin/master, origin/HEAD) Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y

ローカルリポジトリの :code:`master` ブランチが最新のコミットを指していることが分かります. また, 新たに追加されたコミットがリモートリポジトリの :code:`master` ブランチが指すものより新しいことも分かります. このことは :code:`git status` によって確認することもできます. 

.. code:: console

    $ git status
    On branch master
    Your branch is ahead of 'origin/master' by 1 commit.
      (use "git push" to publish your local commits)
    nothing to commit, working directory clean 

例9と同様にコマンド :code:`git push` を使用してローカルリポジトリの変更をリモートリポジトリに反映させます.

.. code:: console

    $ git push origin master
    Counting objects: 3, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 263 bytes | 0 bytes/s, done.
    Total 3 (delta 1), reused 0 (delta 0)
    To /Users/taku-y/Downloads/outside/repo/
       9b566b7..0b6b375  master -> master

これで修正内容が送信されました. リモートリポジトリのディレクトリ :code:`~Downloads/outside/repo` に移動し, コミットログを確認します. 

.. code:: console

    $ cd ~/Downloads/outside/repo/
    $ git lg -4
    * 0b6b375 [2016-10-07] (HEAD -> master) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y

:code:`"Add string7"` の変更が反映されていることを確認できました. 

7. リモートトラッキングブランチとフェッチ
-------------------------------------------------------------------------------
複数人で作業を行うと, 自分が作業中に別の人によってリモートリポジトリの状態が変わり, 競合が起こる場合があります. 具体的には, リモートリポジトリの状態とはリモートリポジトリのブランチの状態です. リポジトリの同期とは, ローカルリポジトリとリモートリポジトリのブランチの同期を意味します. 

ローカルリポジトリはリモートブランチのコピーを持ちます. このコピーはリモートトラッキングブランチと呼ばれます. リモートトラッキングブランチは元のリモートリポジトリのブランチと常に同期しているとは限りません. リモートリポジトリのブランチの最新状態を対応するリモートトラッキングブランチに反映する操作がフェッチです. そして, フェッチして最新状態に更新されたリモートトラッキングブランチを対応するローカルリポジトリのブランチにマージすることでローカルリポジトリとリモートリポジトリのブランチが同期されます. 

リモートトラッキングブランチはリモートリポジトリの名前とブランチの名前で表されます. 例えば, :code:`origin/master` はリモートリポジトリ :code:`origin` の :code:`master` ブランチのリモートトラッキングブランチです. 

.. note:: 上の説明からわかるように, リモートリポジトリとの同期はブランチ単位で行われます. 

例11: フェッチ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
例10を終了した時点で次の三つのリポジトリが存在します. 便宜的にリポジトリA, B, Cと呼ぶこととします. 

- リポジトリA: :code:`~/Downloads/repo1`
- リポジトリB: :code:`~/Downloads/user2/repo`
- リポジトリC: :code:`~/Downloads/outside/repo`

リポジトリCはAとBのリモートリポジトリでした. これら三つのリポジトリの :code:`master` ブランチの状態を確認します. 

- リポジトリA: 

.. code:: console

    $ cd ~/Downloads/repo1; git lg -4
    *   9b566b7 [2016-10-06] (HEAD -> master, origin/master) Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4, develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] (develop3) Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

- リポジトリB: 

.. code:: console

    $ cd ~/Downloads/user2/repo; git lg -5
    * 0b6b375 [2016-10-07] (HEAD -> master, origin/master, origin/HEAD) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

- リポジトリC: 

.. code:: console

    $ cd ~/Downloads/outside/repo; git lg -5
    * 0b6b375 [2016-10-07] (HEAD -> master) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

リポジトリAの状態が古いことが分かります. ここではリポジトリAをリモートリポジトリCに同期します. リポジトリAのディレクトリに移動した後（ :code:`cd ~/Downloads/repo1` ）, リモートリポジトリをフェッチします. 

.. code:: console

    $ git fetch origin
    remote: Counting objects: 3, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From ../outside/repo
       9b566b7..0b6b375  master     -> origin/master

これでリモートトラッキングブランチ :code:`origin/master` が最新の状態になりました. このリモートトラッキングブランチをローカルリポジトリの :code:`master` ブランチにマージすることで同期されます. 

.. code:: console

    $ git merge origin/master
    Updating 9b566b7..0b6b375
    Fast-forward
     source2.txt | 1 +
     1 file changed, 1 insertion(+)
    $ git lg -5
    * 0b6b375 [2016-10-07] (HEAD -> master, origin/master) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4, develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] (develop3) Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\

8. 競合の解消
-------------------------------------------------------------------------------
二人のユーザがリポジトリAとBで :code:`master` ブランチを起点として別のブランチを作成し, それぞれの作業が完了後に :code:`master` ブランチにマージすることを考えます. リポジトリAの作業が完了後にリポジトリBの作業を開始する場合は, 作業の前にリポジトリBで :code:`master` ブランチをリモートリポジトリと同期すれば問題は起こりません. しかし, リポジトリAの作業完了前, すなわち :code:`master` ブランチへのマージが完了する前にリポジトリBの作業を開始すると, :code:`master` ブランチをプッシュするときに競合が発生します. 

例12: 競合の発生
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
リポジトリAでブランチ :code:`develop5` を作成し, :code:`source.txt` に修正を加えた後, :code:`master` にマージします. ただしリモートリポジトリへのプッシュはまだ行わないとします. 

.. code:: console

    $ cd ~/Downloads/repo1
    $ git checkout -b develop5
    Switched to a new branch 'develop5'
    $ echo string8 >> source.txt
    $ git status
    On branch develop5
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   source.txt

    no changes added to commit (use "git add" and/or "git commit -a")
    $ git add .
    $ git commit -m "Add string8"
    [develop5 72c756d] Add string8
     1 file changed, 1 insertion(+)
    $ git checkout master
    Switched to branch 'master'
    $ git merge --no-ff develop5
    Merge made by the 'recursive' strategy.
     source.txt | 1 +
     1 file changed, 1 insertion(+)
    $ git lg -5
    *   1641c26 [2016-10-08] (HEAD -> master) Merge branch 'develop5' @taku-y
    |\
    | * 72c756d [2016-10-08] (develop5) Add string8 @taku-y
    |/
    * 0b6b375 [2016-10-07] (origin/master) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4, develop4) Add string6 @taku-y
    |/

次に, リポジトリBでブランチ :code:`develop6` を作成し, 同様に修正を加えて :code:`master` にマージします. 

.. code:: console

    $ cd ~/Downloads/user2/repo/
    $ git checkout -b develop6
    Switched to a new branch 'develop6'
    $ echo string9 >> source.txt
    $ git add .
    $ git commit -m "Add string9"
    [develop6 2bcb366] Add string9
     1 file changed, 1 insertion(+)
    Taku-no-MacBook-Pro:repo taku-y$ git checkout master
    Switched to branch 'master'
    Your branch is up-to-date with 'origin/master'.
    $ git merge --no-ff develop6
    Merge made by the 'recursive' strategy.
     source.txt | 1 +
     1 file changed, 1 insertion(+)
    $ git lg -5
    *   2bc058f [2016-10-08] (HEAD -> master) Merge branch 'develop6' @taku-y
    |\
    | * 2bcb366 [2016-10-08] (develop6) Add string9 @taku-y
    |/
    * 0b6b375 [2016-10-07] (origin/master, origin/HEAD) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    
この時点でリポジトリAとBの :code:`master` ブランチが競合します. 先にリポジトリAがリモートリポジトリにプッシュされるとします. この時点では問題は起こりません. 

.. code:: console

    $ cd ~/Downloads/repo1/
    $ git push origin master
    Counting objects: 4, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (4/4), 424 bytes | 0 bytes/s, done.
    Total 4 (delta 1), reused 0 (delta 0)
    To ../outside/repo
       0b6b375..1641c26  master -> master

この状態でリポジトリBの :code:`master` ブランチをプッシュしようとすると, 競合のためにエラーが発生します. 

.. code:: console

    $ cd ~/Downloads/user2/repo/
    $ git branch
      develop6
    * master
    $ git push origin master
    To /Users/taku-y/Downloads/outside/repo/
     ! [rejected]        master -> master (fetch first)
    error: failed to push some refs to '/Users/taku-y/Downloads/outside/repo/'
    hint: Updates were rejected because the remote contains work that you do
    hint: not have locally. This is usually caused by another repository pushing
    hint: to the same ref. You may want to first integrate the remote changes
    hint: (e.g., 'git pull ...') before pushing again.
    hint: See the 'Note about fast-forwards' in 'git push --help' for details.

例13: 競合の解消
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
競合を解消するため, リポジトリBの :code:`master` ブランチの状態をマージ前の状態に戻します. 

.. code:: console

    $ cd ~/Downloads/user2/repo
    $ git lg -5
    *   2bc058f [2016-10-08] (HEAD -> master) Merge branch 'develop6' @taku-y
    |\
    | * 2bcb366 [2016-10-08] (develop6) Add string9 @taku-y
    |/
    * 0b6b375 [2016-10-07] (origin/master, origin/HEAD) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    $ git reset 0b6b375
    Unstaged changes after reset:
    M   source.txt
    $ git lg -5
    * 0b6b375 [2016-10-07] (HEAD -> master, origin/master, origin/HEAD) Add string7 @taku-y
    *   9b566b7 [2016-10-06] Merge branch 'develop4' @taku-y
    |\
    | * 3a56f79 [2016-10-06] (origin/develop4) Add string6 @taku-y
    |/
    * 1c45527 [2016-10-06] Add string5 @taku-y
    *   5a871fb [2016-10-06] Resolve conflict @taku-y
    |\
    Taku-no-MacBook-Pro:repo taku-y$ git checkout .
    Taku-no-MacBook-Pro:repo taku-y$ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    nothing to commit, working directory clean

次に :code:`master` ブランチをリポートリポジトリと同期します. 

.. code:: console

    $ git fetch origin
    remote: Counting objects: 4, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (4/4), done.
    From /Users/taku-y/Downloads/outside/repo
       0b6b375..1641c26  master     -> origin/master
    $ git merge origin/master
    Updating 0b6b375..1641c26
    Fast-forward
     source.txt | 1 +
     1 file changed, 1 insertion(+)
    Taku-no-MacBook-Pro:repo taku-y$ cat source.txt
    string
    string2
    string34
    string5
    string6
    string8

この状態で :code:`develop6` ブランチをマージしようとすると競合が発生します. 

.. code:: console

    $ git merge develop6
    Auto-merging source.txt
    CONFLICT (content): Merge conflict in source.txt
    Automatic merge failed; fix conflicts and then commit the result.

競合を解消するため :code:`source.txt` ファイルを修正します. 

.. code:: console

    $ cat source.txt
    string
    string2
    string34
    string5
    string6
    string8
    string9

リポジトリの状態は以下の通りです. 

.. code:: console

    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    You have unmerged paths.
      (fix conflicts and run "git commit")

    Unmerged paths:
      (use "git add <file>..." to mark resolution)

        both modified:   source.txt

    no changes added to commit (use "git add" and/or "git commit -a")

修正後のファイルをコミットします. 

.. code:: console

    $ git add source.txt
    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    All conflicts fixed but you are still merging.
      (use "git commit" to conclude merge)

    Changes to be committed:

        modified:   source.txt

    $ git commit -m "Resolve conflict"
    [master c0c294f] Resolve conflict

最後に変更をリモートリポジトリにプッシュします. 

.. code:: console

    $ git push origin master
    Counting objects: 6, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (5/5), done.
    Writing objects: 100% (6/6), 670 bytes | 0 bytes/s, done.
    Total 6 (delta 0), reused 0 (delta 0)
    To /Users/taku-y/Downloads/outside/repo/
       1641c26..c0c294f  master -> master

ローカルリポジトリで競合を解消されたので, 今度は正常にプッシュが完了しました. 

更新履歴
-------------------------------------------------------------------------------
- 2016????: 初版を公開しました. 
- 20161008: 体裁を修正し, 項目を追加しました. 

免責事項
-------------------------------------------------------------------------------
本文書の情報については充分な注意を払っておりますが, その内容の正確性等に対して一切保障するものではありません. 本文書の利用で起きたいかなる結果について, 一切責任を負わないものとします. 
