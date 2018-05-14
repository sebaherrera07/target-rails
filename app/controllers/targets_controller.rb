class TargetsController < ApplicationController
  helper_method :topics

  def index
    @targets = Target.all
  end

  def create
    @target = Target.new(target_params)
    respond_to do |format|
      if @target.save
        format.json { render json: { target: @target }, status: 200 }
      else
        format.json { render json: { errors: @target.errors }, status: 422 }
      end
    end
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def topics
    @topics = Target::TOPICS.map { |x| [x, x] }.to_h
  end
end
