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
    result = 0
    case movie.price_code
    when Movie::REGULAR
      result += 2
      result += (days_rented - 2) * 1.5 if days_rented > 2
    when Movie::NEW_RELEASE
      result += days_rented * 3
    when Movie::CHILDRENS
      result += 1.5
      result += (days_rented - 3) * 1.5 if days_rented > 3
    end
    result
  end
end
