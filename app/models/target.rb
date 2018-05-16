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
  validates :size, presence: true, numericality: true

  TOPICS = [I18n.t(:topics_sports), I18n.t(:topics_travel), I18n.t(:topics_politics),
            I18n.t(:topics_arts), I18n.t(:topics_dating), I18n.t(:topics_music),
            I18n.t(:topics_movies), I18n.t(:topics_series), I18n.t(:topics_food)].freeze
end
