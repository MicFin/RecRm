namespace :updaterecipestep do
    desc "Updates ingredients and steps with no position to 1"
 task update_position: :environment do
    puts "Updating steps with no position to 1"
    RecipeStep.all.each do |step|
      if step.position == nil
        step.position = 1
      end
      step.save
    end
  end
end