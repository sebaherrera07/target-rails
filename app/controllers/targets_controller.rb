class TargetsController < ApplicationController
  helper_method :topics
  before_action :authenticate_user!

  def index
    @targets = Target.all
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      render json: { target: @target }, status: :ok
    else
      render json: { errors: @target.errors }, status: :unprocessable_entity
    end
  end

  def topic_icon
    target = Target::TOPICS.detect { |tar| tar[:title] == params[:topic] }
    render json: { icon: target[:icon] }, status: :ok
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def topics
    @topics = Target::TOPICS.map { |topic| [topic[:title], topic[:title]] }.to_h
  end
end
