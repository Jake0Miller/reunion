require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/activity'
require './lib/reunion'

class ReunionTest <Minitest::Test
  def setup
    @brunch = Activity.new("Brunch")
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)
    @reunion = Reunion.new("1406 BE")
    @drinks = Activity.new("Drinks")
    @drinks.add_participant("Maria", 60)
    @drinks.add_participant("Luther", 60)
    @drinks.add_participant("Louis", 0)
  end

  def test_it_exists
    assert_instance_of Reunion, @reunion
  end

  def test_attributes
    assert_equal "1406 BE", @reunion.name
    assert_equal [], @reunion.activities
  end

  def test_it_holds_activities
    @reunion.add_activity(@brunch)

    assert_equal [@brunch], @reunion.activities
  end

  def test_total_cost
    assert_equal 0, @reunion.total_cost

    @reunion.add_activity(@brunch)

    assert_equal 60, @reunion.total_cost

    @reunion.add_activity(@drinks)

    assert_equal 180, @reunion.total_cost
  end

  def test_breakout
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)

    expected = {"Maria" => -10, "Luther" => -30, "Louis" => 40}
    assert_equal expected, @reunion.breakout
  end

  def test_summary
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)

    expected = "Maria: -10\nLuther: -30\nLouis: 40"
    assert_equal expected, @reunion.summary
  end
end
