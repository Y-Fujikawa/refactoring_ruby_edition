# frozen_string_literal: true

require 'test/unit'
require './movie'
require './rental'
require './customer'

# テストコード
class Test1 < Test::Unit::TestCase
  def setup
    pokemon = Movie.new('Pokemon', NewReleasePrice.new)
    zelda = Movie.new('Zelda', RegularPrice.new)
    kirby = Movie.new('Kirby', ChildrensPrice.new)

    first_rental = Rental.new(pokemon, 3)
    second_rental = Rental.new(zelda, 5)
    third_rental = Rental.new(kirby, 2)

    @boy = Customer.new('boy')
    @boy.add_rental(first_rental)
    @boy.add_rental(second_rental)
    @boy.add_rental(third_rental)

    @result = <<~RESULT
      Rental Record for boy
      \tPokemon\t9
      \tZelda\t6.5
      \tKirby\t1.5
      Amount owed is 17.0
      You earned 4 frequent renter points
    RESULT

    @html_result = <<~RESULT
      <h1>Rentals for <em>boy</em></h1><p>
      \tPokemon: 9<br>
      \tZelda: 6.5<br>
      \tKirby: 1.5<br>
      <p>You owe <em>17.0</em></p>
      On this rental you earned <em>4</em> frequent renter points<p>
    RESULT
  end

  def test_statement
    assert_equal(@result, @boy.statement)
  end

  def test_html_statement
    assert_equal(@html_result, @boy.html_statement)
  end
end
