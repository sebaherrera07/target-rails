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

  def topic_icon
    target = Target::TOPICS.detect { |tar| tar[:title] == params[:topic] }
    render json: { icon: target[:icon] }, status: 200
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def topics
    @topics = Target::TOPICS.map { |topic| [topic[:title], topic[:title]] }.to_h
  end
end
