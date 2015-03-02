# module for functions not belonging logically to other classes
module Helpers
  def validate(answer)
    return answer if %w('y', 'n').include?(answer)

    print "Answer only with 'y' or 'n'. -> "
    validate(gets.chomp.downcase)
  end
end
