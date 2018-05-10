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
  validates :title, presence: true
  validates :topic, presence: true
  validates :size, presence: true, numericality: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
