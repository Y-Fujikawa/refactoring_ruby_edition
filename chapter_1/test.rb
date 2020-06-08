# frozen_string_literal: true

require 'test/unit'
require './movie'
require './rental'
require './customer'

# テストコード
class Test1 < Test::Unit::TestCase
  def setup
    pokemon = Movie.new('Pokemon', Movie::NEW_RELEASE)
    zelda = Movie.new('Zelda', Movie::REGULAR)
    kirby = Movie.new('Kirby', Movie::CHILDRENS)

    first_rental = Rental.new(pokemon, 3)
    second_rental = Rental.new(zelda, 5)
    third_rental = Rental.new(kirby, 2)

    @boy = Customer.new('boy')
    @boy.add_rental(first_rental)
    @boy.add_rental(second_rental)
    @boy.add_rental(third_rental)

    @result = <<~RESULT
      Rental Record for boy
      #{"\t"}Pokemon#{"\t"}9
      #{"\t"}Zelda#{"\t"}6.5
      #{"\t"}Kirby#{"\t"}1.5
      Amount owed is 17.0
      You earned 4 frequent renter points
    RESULT
  end

  def test_statement
    assert_equal(@result, @boy.statement)
  end
end
