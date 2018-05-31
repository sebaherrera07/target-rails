# == Schema Information
#
# Table name: targets
#
#  id        :bigint(8)        not null, primary key
#  title     :string           not null
#  topic     :string           not null
#  size      :integer          not null
#  latitude  :decimal(, )      not null
#  longitude :decimal(, )      not null
#  user_id   :bigint(8)
#

# Class to register users targets in map
class Target < ActiveRecord::Base
  MIN_SIZE = 50
  MAX_SIZE = 500
  LIMIT = 5
  TOPICS = [
    { title: I18n.t(:topics_sports),    icon: 'sports-icon.png' },
    { title: I18n.t(:topics_travel),    icon: 'travel-icon.png' },
    { title: I18n.t(:topics_politics),  icon: 'politics-icon.png' },
    { title: I18n.t(:topics_arts),      icon: 'art-icon.png' },
    { title: I18n.t(:topics_dating),    icon: 'dating-icon.png' },
    { title: I18n.t(:topics_music),     icon: 'music-icon.png' },
    { title: I18n.t(:topics_movies),    icon: 'movies-icon.png' },
    { title: I18n.t(:topics_series),    icon: 'series-icon.png' },
    { title: I18n.t(:topics_food),      icon: 'food-icon.png' }
  ].freeze

  belongs_to :user
  delegate :name, to: :user, prefix: true

  validates :title, :topic, :latitude, :longitude, presence: true
  validates :size,
            presence: true,
            numericality: { greater_than_or_equal_to: MIN_SIZE, less_than_or_equal_to: MAX_SIZE }
  validate :validate_targets_limit

  acts_as_mappable default_units:       :meters,
                   default_formula:     :flat,
                   distance_field_name: :distance,
                   lat_column_name:     :latitude,
                   lng_column_name:     :longitude

  def compatible_targets
    TargetMatcherService.matches_for(self)
  end

  private

  def validate_targets_limit
    errors.add(:user_limit, 'reached user limit') if user.targets.count >= LIMIT
  end
end
