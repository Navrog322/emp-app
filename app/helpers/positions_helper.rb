module PositionsHelper
  def deletable? pos
    pos.employees.empty?
  end
end
