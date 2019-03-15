class ApplicationController < ActionController::API

    def index
        @appointments = Appointments.order('appt_time ASC')
        @appointment = Appointments.new

        render json: @appointments
    end

    def show
        @appointment = Appointments.find(params[:id])
        render json: @appointment
    end

    def edit
        render :index
    end

    def update
        @appointment = Appointments.find(params[:id])
        if @appointment.update(appointment_params)
            render json: @appointment
        else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end

    def create
        @appointment = Appointments.create(appointment_params)
        if @appointment.save
            render json: @appointment
        else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @appointment = Appointments.find(params[:id])
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
