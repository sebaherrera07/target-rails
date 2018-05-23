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
#

# Class to register users targets in map
class Target < ActiveRecord::Base
  validates :title, :topic, :latitude, :longitude, presence: true
  validates :size, presence: true,
                   numericality: { greater_than_or_equal_to: 50, less_than_or_equal_to: 500 }

  TOPICS = [
    {
      title: I18n.t(:topics_sports),
      icon: 'sports-icon.png'
    },
    {
      title: I18n.t(:topics_travel),
      icon: 'travel-icon.png'
    },
    {
      title: I18n.t(:topics_politics),
      icon: 'politics-icon.png'
    },
    {
      title: I18n.t(:topics_arts),
      icon: 'art-icon.png'
    },
    {
      title: I18n.t(:topics_dating),
      icon: 'dating-icon.png'
    },
    {
      title: I18n.t(:topics_music),
      icon: 'music-icon.png'
    },
    {
      title: I18n.t(:topics_movies),
      icon: 'movies-icon.png'
    },
    {
      title: I18n.t(:topics_series),
      icon: 'series-icon.png'
    },
    {
      title: I18n.t(:topics_food),
      icon: 'food-icon.png'
    }
  ].freeze
end
