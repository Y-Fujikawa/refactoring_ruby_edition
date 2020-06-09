# frozen_string_literal: true

# レンタルクラス
class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  # 各行の金額を計算
  # chargeメソッドを冪等性（何度実行しても同じ結果になる性質）にできているか確認する
  # SOLID原則でも同じような原則があるのでそっちで覚えたほうが良い
  def charge
    movie.charge(days_rented)
  end

  # レンタルポイントの加算
  def frequent_renter_points
    # 新作2日間レンタルでボーナス点をプラスする
    movie.frequent_renter_points(days_rented)
  end
end
