# Class to register users targets in map
class Target < ActiveRecord::Base
  # title
  # topic
  # size
  # latitude
  # longitude

  validates_presence_of :title
  validates_presence_of :topic
  validates_presence_of :size
  validates_numericality_of :size
  validates_presence_of :latitude
  validates_presence_of :longitude

  # belongs_to :user
end
