require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest <Minitest::Test
  def setup
    @brunch = Activity.new("Brunch")
  end

  def test_it_exists
    assert_instance_of Activity, @brunch
  end

  def test_attributes
    assert_equal "Brunch", @brunch.name
    expected = {}
    assert_equal expected, @brunch.participants
  end

  def test_participants
    @brunch.add_participant("Maria", 20)

    expected = {"Maria" => 20}
    assert_equal expected, @brunch.participants

    @brunch.add_participant("Luther", 40)

    expected = {"Maria" => 20, "Luther" => 40}
    assert_equal expected, @brunch.participants
  end

  def test_total_cost
    assert_equal 0, @brunch.total_cost

    @brunch.add_participant("Maria", 20)

    assert_equal 20, @brunch.total_cost

    @brunch.add_participant("Luther", 40)

    assert_equal 60, @brunch.total_cost
  end

  def test_split
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    assert_equal 30, @brunch.split
  end

  def test_owed
    @brunch.add_participant("Maria", 20)
    @brunch.add_participant("Luther", 40)

    expected = {"Maria" => 10, "Luther" => -10}
    assert_equal expected, @brunch.owed
  end
end
