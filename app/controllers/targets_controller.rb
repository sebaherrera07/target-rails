# TargetsController
class TargetsController < ApplicationController
  def index
    load_dropdown_topics
  end

  def create
    @target = Target.new(target_params)
    if @target.save
      flash[:success] = 'Target created!'
    else
      if @target.errors[:latitude].any?
        flash[:error] = 'Target not set on the map.'
      else
        flash[:error] = 'Target data incomplete.'
      end
    end
    load_dropdown_topics
    render action: 'index'
  end

  private

  def target_params
    params.require(:target).permit(:title, :topic, :size, :latitude, :longitude)
  end

  def load_dropdown_topics
    ts = %w[Sports Travel Politics Arts Dating Music Movies Series Food]
    @topics = ts.map { |x| [x, x] }.to_h
  end
end
