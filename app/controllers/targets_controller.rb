class TargetsController < ApplicationController
  helper_method :topics

  def index
    @targets = Target.all
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      flash.now[:success] = t(:alert_success_target_created)
    else
      if @target.errors[:latitude].any?
        flash.now[:error] = t(:alert_error_target_not_set)
      else
        flash.now[:error] = t(:alert_error_target_data_incomplete)
      end
    end
    render action: 'index'
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def topics
    topics_array = [t(:topics_sports), t(:topics_travel), t(:topics_politics), t(:topics_arts), t(:topics_dating),
                    t(:topics_music), t(:topics_movies), t(:topics_series), t(:topics_food)]
    @topics = topics_array.map { |x| [x, x] }.to_h
  end
end
