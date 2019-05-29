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
    @bowling = Activity.new("Bowling")
    @bowling.add_participant("Maria", 0)
    @bowling.add_participant("Luther", 0)
    @bowling.add_participant("Louis", 30)
    @jet = Activity.new("Jet Skiing")
    @jet.add_participant("Maria", 0)
    @jet.add_participant("Luther", 0)
    @jet.add_participant("Louis", 40)
    @jet.add_participant("Nemo", 40)
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

  def test_detailed_breakout
    @reunion.add_activity(@brunch)
    @reunion.add_activity(@drinks)
    @reunion.add_activity(@bowling)
    @reunion.add_activity(@jet)

    expected = {"Maria" => [
      {activity: "Brunch",
      payees: ["Luther"],
      amount: 10},
      {activity: "Drinks",
      payees: ["Louis"],
      amount: -20},
      {activity: "Bowling",
      payees: ["Louis"],
      amount: 10},
      {activity: "Jet Skiing",
      payees: ["Louis", "Nemo"],
      amount: 10}],
        "Luther" => [
      {activity: "Brunch",
      payees: ["Maria"],
      amount: -10},
      {activity: "Drinks",
      payees: ["Louis"],
      amount: -20},
      {activity: "Bowling",
      payees: ["Louis"],
      amount: 10},
      {activity: "Jet Skiing",
      payees: ["Louis", "Nemo"],
      amount: 10}],
        "Louis" => [
      {activity: "Drinks",
      payees: ["Maria", "Luther"],
      amount: 20},
      {activity: "Bowling",
      payees: ["Maria", "Luther"],
      amount: -10},
      {activity: "Jet Skiing",
      payees: ["Maria", "Luther"],
      amount: -10}],
        "Nemo" => [
      {activity: "Jet Skiing",
      payees: ["Maria", "Luther"],
      amount: -10}]}

    assert_equal expected, @reunion.detailed_breakout
  end
end
