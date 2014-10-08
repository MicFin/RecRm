class QualityReviewPolicy < ApplicationPolicy

  def
  end

  class Scope < Struct.new(:dietitian, :scope)
    def resolve
      scope
    end
  end

end
