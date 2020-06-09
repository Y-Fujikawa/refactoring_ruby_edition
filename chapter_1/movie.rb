# frozen_string_literal: true

# ムービークラス
class Movie
  attr_reader :title
  attr_accessor :price_code
  attr_accessor :price

  def initialize(title, price)
    @title = title
    @price = price
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  # レンタルポイントの加算
  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end

# デフォルトプライス
module DefaultPrice
  # レンタルポイントの加算
  def frequent_renter_points(_days_rented)
    1
  end
end

# レギュラープライス
class RegularPrice
  include DefaultPrice

  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

# ニューリリースプライス
class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end
end

# チルドレンプライス
class ChildrensPrice
  include DefaultPrice

  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end
