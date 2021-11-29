module Sizeable
  extend ActiveSupport::Concern

  def epic?
    size >= 5
  end

  def small?
    size <= 1
  end
end
