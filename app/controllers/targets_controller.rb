class TargetsController < ApplicationController
  helper_method :topics

  def index
    @targets = Target.all
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      render json: { target: @target }, status: 200
    else
      render json: { errors: @target.errors }, status: 422
    end
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def topics
    @topics = Target::TOPICS.map { |name| [name, name] }.to_h
  end
end
