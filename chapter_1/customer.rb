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
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      # レンタルポイントの加算
      frequent_renter_points += element.frequent_renter_points

      # このレンタルの料金を表示
      # chargeメソッドを1度ではなく、2度呼び出している。
      # それだけの理由でこの変更を避けようという人がいる。
      # 本当に高いパフォーマンスを得たいのなら、パフォーマンスについてこのような考え方をするべきではない
      # (2.11説「リファクタリングとパフォーマンス」を参照)
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
      total_amount += element.charge
    end
    # フッター行を追加
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points\n"
    result
  end
end
