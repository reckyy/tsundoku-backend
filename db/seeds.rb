# frozen_string_literal: true

user = User.create!(
  name: 'tsundoku',
  email: 'tsundoku53@gmail.com',
  avatar_url: 'https://lh3.googleusercontent.com/a/ACg8ocLQxl632IEr8xbH4aSNrIIsu0FeDjSyCmjhBIbnke4vy7R5oA=s96-c'
)

books = Book.create!(
  [
    {
      title: '実践Next.js -- App Routerで進化するWebアプリ開発',
      author: '吉井 健文',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0618/9784297140618_1_2.jpg?_ex=200x200'
    },
    {
      title: 'プロを目指す人のためのRuby入門［改訂2版］　言語仕様からテスト駆動開発・デバッグ技法まで',
      author: '伊藤 淳一',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/4373/9784297124373_1_5.jpg?_ex=200x200'
    },
    {
      title: 'プロを目指す人のためのTypeScript入門　安全なコードの書き方から高度な型の使い方まで',
      author: '鈴木 僚太',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7473/9784297127473_1_3.jpg?_ex=200x200'
    },
    {
      title: 'SCRUM BOOT CAMP THE BOOK【増補改訂版】 スクラムチームではじめるアジャイル開発',
      author: '西村 直人/永瀬 美穂/吉羽 龍太郎',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3680/9784798163680.jpg?_ex=200x200'
    },
    {
      title: '賢さをつくる',
      author: '谷川祐基',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/2338/9784484192338.jpg?_ex=200x200'
    },
    {
      title: 'プログラマー脳 〜優れたプログラマーになるための認知科学に基づくアプローチ',
      author: 'Felienne Hermans/水野貴明/水野いずみ',
      cover_image_url: 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8534/9784798068534_1_5.jpg?_ex=200x200'
    }
  ]
)

books.each do |book|
  book.save_with_user_book(user, 8)
end

now = Time.zone.today
(1..15).each do |i|
  ReadingLog.create!(
    read_date: now.ago(i.days).to_date,
    memo_id: i
  )
end
(16..25).each do |i|
  ReadingLog.create!(
    read_date: now.ago(i.days).to_date,
    memo_id: i
  )
end
(26..30).each do |i|
  ReadingLog.create!(
    read_date: now.ago(i.days).to_date,
    memo_id: i
  )
end
(31..35).each do |i|
  ReadingLog.create!(
    read_date: now.ago(i.days).to_date,
    memo_id: i
  )
end
