class TargetsController < ApplicationController
  helper_method :topics
  before_action :authenticate_user!

  def index
    @targets = current_user.targets
  end

  def create
    @target = Target.new(target_params)
    @target.user = current_user
    if @target.save
      render json: { target: @target }, status: :ok
    else
      render json: { errors: @target.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    target = Target.find(params[:id])
    if target.destroy
      render json: { message: I18n.t(:alert_success_target_deleted) }, status: :ok
    else
      render json: { errors: I18n.t(:alert_error_target_cant_be_deleted) },
             status: :unprocessable_entity
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
