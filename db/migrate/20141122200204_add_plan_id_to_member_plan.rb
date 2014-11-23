class AddPlanIdToMemberPlan < ActiveRecord::Migration
  def change
    add_reference :member_plans, :plan, index: true
  end
end
