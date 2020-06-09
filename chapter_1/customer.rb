# frozen_string_literal: true

# カスタマークラス
class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(args)
    @rentals << args
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # このレンタルの料金を表示
      # chargeメソッドを1度ではなく、2度呼び出している。
      # それだけの理由でこの変更を避けようという人がいる。
      # 本当に高いパフォーマンスを得たいのなら、パフォーマンスについてこのような考え方をするべきではない
      # (2.11説「リファクタリングとパフォーマンス」を参照)
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end
    # フッター行を追加
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{total_frequent_renter_points} frequent renter points\n"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1><p>\n"
    @rentals.each do |element|
      result += "\t" + element.movie.title + ': ' + element.charge.to_s + "<br>\n"
    end
    # フッター行を追加
    result += "<p>You owe <em>#{total_charge}</em></p>\n"
    result += 'On this rental you earned ' + "<em>#{total_frequent_renter_points}</em> " + "frequent renter points<p>\n"
    result
  end

  private

  # レンタルの料金の合算
  # 金額計算ルーチンの移動と同じで「total_XXX」メソッドでも
  # パフォーマンスが心配になってしまうが、まずはコードをわかりやすくしてから
  # プロファイルを使ってパフォーマンス問題に取り組むということである。
  def total_charge
    # 最初、ループで合算していたが
    # 「ループからコレクションクロージャメソッドへ」を使い
    # さらにリファクタリングする
    # result = 0
    # @rentals.each do |element|
    #   result += element.charge
    # end
    # result
    @rentals.inject(0) { |sum, rental| sum + rental.charge }
  end

  # レンタルポイントの合算
  def total_frequent_renter_points
    @rentals.inject(0) { |sum, rental| sum + rental.frequent_renter_points }
  end
end
