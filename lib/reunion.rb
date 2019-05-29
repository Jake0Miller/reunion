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

  def detailed_breakout
    @activities.each_with_object({}) do |activity, hash|
      owers = activity.owed
      activity.participants.each do |participant|
        amount = owers[participant[0]]
        if amount > 0
          payees = activity.participants.keys.find_all do |participant|
            owers[participant] < 0
          end
        else
          payees = activity.participants.keys.find_all do |participant|
            owers[participant] > 0
          end
        end
        hash[participant[0]] ||= []
        hash[participant[0]] << {activity: activity.name,
                                 payees: payees,
                                 amount: amount/payees.length}
      end
    end
  end
end
