class RecipePolicy < ApplicationPolicy

  def

  class Scope < Struct.new(:dietitian, :scope)
    def resolve
      scope
    end
  end

end
