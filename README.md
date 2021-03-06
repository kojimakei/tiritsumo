# Tiritsumo
日々の積み重ねで立てた目標を達成！！自己管理系アプリです。


# URL
https://tiritsumo.work/
![image](https://user-images.githubusercontent.com/74762457/113528868-e323bf00-95fc-11eb-98fc-dcfeea24f980.png)


# 制作背景
私がこのアプリを作成しようとした理由は、**目標達成に向けた日々の努力の習慣化**を手助けしたいと考えたためです。
多くの人は、大きさは違えど**目標**を持っているかと思います。
しかし多くの人は、**目標に向け頑張る気持ちはあるが、ついつい怠けてしまっている**かと思います。
また日々の仕事や雑務等に追われて、**その目標を忘れてしまっている人**や、**目標のための時間をなかなか確保できない人**もいらっしゃるかもしれません。

資格勉強、ダイエット、プログラミング、筋トレ等。。いずれにおいても「習慣づけ」というのは多くの人にとって難しいことだと思っております。

なぜ習慣づけが大変なのか自分なりに考えたとき、以下のような要素が思い浮かびました。
- 努力量が可視化されないため、飽きてしまう
- モチベーションの維持が難しい
- 自分への甘えが出てしまう
- 締め切りなどの期日がないため、後回しにしてしまっている

そこで、これら課題を解決するための以下機能を持ったアプリを作ることにしました。

- カレンダー機能
  →目標に向けた日々の積み重ねをカレンダーに反映可能。自分の日々の努力が目に見えてわかる！

- 同じ目標をもった仲間を見つけられるルーム機能
  →仲間がいることで互いに刺激になりモチベーションアップ！

- 仲間の達成状況を確認できる機能
  →仲間から見られているという意識を持たせて自分への甘えを断つ!

- 残り日数表示機能
  →目標を決める際に、期日を指定。残日数をheaderに記載。逆算して日々のスケジュールをたてられる！


# 機能一覧
- ユーザ登録機能
- ユーザー探索機能
- ゲストログイン機能
- ユーザーフォロー機能
- ユーザーランキング機能
- ちりつも機能
- ルーム作成機能
- ルーム検索機能
- コミュニティ参加機能
- カレンダーによる達成状況確認機能
- いいね機能（Ajax）
- コメント機能（Ajax）
- タグ機能
- タグ検索機能
- ページネーション機能
- 単体テスト
- 結合テスト
- レスポンシブ対応



# 工夫した点
- マイページを見るだけで過去の積み上げ数、時間を確認でき、達成したことを可視化できるようにしました。
- CI/CD による開発ができるように Docker, EC2, CircleCI等 を用いて テスト→ビルド→デプロイの自動パイプラインを構築しました。
# 使用技術
- フロントエンド（HTML/CSS, Sass, bootstrap, Javascript）
- バックエンド（ruby 2.6.5, Rails 6.0.3, Nginx, Unicorn）
- データベース（MySQL 5.6.51）
- AWS（VPC, EC2, S3, Route53, ACM, ELB, EIP）
- コンテナ（Docker, Docker Compose）
- テスト（Rspec, FactoryBot, Capybara）
- CI/CDパイプライン（CircleCI, Capistrano）
- 開発環境（MacOS, Git, GitHub, VScode, bash）

# 今後の改良計画
- Vuejsによる部分SPA化、UXの向上

# インフラ構成図
![名称未設定](https://user-images.githubusercontent.com/74762457/113556254-2c910000-9637-11eb-880c-6a08f5333141.png)


# E-R図
![tiritsumo](https://user-images.githubusercontent.com/74762457/113401360-34a23300-93de-11eb-9afe-bf20d16e8bb3.png)

