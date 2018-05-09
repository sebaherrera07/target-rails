=begin

class User < ActiveRecord::Base
  #name
  #username
  #email
  #password
  #confirmed?

  validates_presence_of :name
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_confirmation_of :password
  validates_length_of :password, minimum: 6

  has_many :targets
  validate_on_create :targets_count_within_bounds
  private

  def targets_count_within_bounds
    return if targets.blank?
    errors.add("Reached max targets (10)") if targets.size > 10
  end
end

=end