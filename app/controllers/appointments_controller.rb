class AppointmentsController < ApplicationController
    before_action :authenticate_user!

    def index
        @appointments = current_user.appointments.order('appt_time ASC')
        @appointment = current_user.appointments.new
        render json: @appointments
    end
  
    def show
        @appointment = current_user.appointments.find(params[:id])
        render json: @appointment
    end
  
    def edit
        render :index
    end
  
    def update
        @appointment = current_user.appointments.find(params[:id])
        if @appointment.update(appointment_params)
            render json: @appointment
        else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end
  
    def create
        @appointment = current_user.appointments.new(appointment_params)
        if @appointment.save
            render json: @appointment
        else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end
  
    def destroy
        @appointment = current_user.appointments.find(params[:id])
        if @appointment.destroy
            head :no_content, status: :ok
        else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end
  
    private
    def appointment_params
        params.require(:appointment).permit(:title, :appt_time)
    end
end