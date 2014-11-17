class RoomsController < ApplicationController
  include PatientGroupsHelper
# before_filter :config_opentok,:except => [:index]
# only admin can view rooms pages
before_filter :authenticate_admin_user!, only: [:index]

  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    ##commented out to trouble shoot, could add in
    ## session = @opentok.create_session request.remote_addr
    # @new_session = @opentok.create_session 
    # params[:room][:sessionId] = @new_session.session_id
    # @tok_token = @new_session.generate_token :session_id =>@new_session.session_id  
    # @new_room = Room.new(params[:room])
    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/session/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def in_session
    @room = Room.find(params[:id])
    # @tok_token =  @opentok.generate_token @room.sessionId  
    @appointment = Appointment.find(params[:appointment])
    if current_admin_user
      @user = current_admin_user
    elsif current_dietitian
      @user = current_dietitian
    else
      @user = current_user
      @family = @user.head_of_families.last
      appointment_focus = @appointment.patient_focus
      @updated_user = appointment_focus
      @family_members = []
      @family_members << appointment_focus

      family_count = @family.users.count
      
      if family_count > 0

        if @user != appointment_focus
    
          @family_members << @user
          @family.users.each do |family_member| 
            if family_member != appointment_focus
        
              @family_members << family_member 
            end
          end
        else
          @family.users.each do |family_member|
              @family_members << family_member
          end
        end
      else
        @family_members << @user
      end
    get_patient_groups!
    @diseases = @diseases 
    @intolerances = @intolerances 
    @allergies = @allergies
    @diets = @diets 
    end
  end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new ENV["API_KEY"], ENV["API_SECRET"]
    end
  end


end
