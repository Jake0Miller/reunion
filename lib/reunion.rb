class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum {|activity| activity.total_cost}
  end

  def breakout
    @activities.each_with_object(Hash.new(0)) do |activity, hash|
      activity.owed.each do |participant|
        hash[participant[0]] += participant[1]
      end
    end
  end

  def summary
    breakout.each_with_object("") do |ower, str|
      str << "#{ower[0]}: #{ower[1]}\n"
    end.chop
  end
end
