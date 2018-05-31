module TargetMatcherService
  extend self

  def matches_for_all_targets(targets)
    targets.flat_map { |target| matches_for(target) }
  end

  def matches_for(target)
    origin = [target.latitude, target.longitude]
    targets_in_max_range = Target.within(target.size + Target::MAX_SIZE, origin: origin)
                                 .where(topic: target.topic)
                                 .where.not(user_id: target.user_id)
    compatible_targets_range_validation(target, targets_in_max_range)
  end

  private

  def compatible_targets_range_validation(target, targets_in_max_range)
    compatible_targets = []
    targets_in_max_range.each do |other_target|
      origin = [other_target.latitude, other_target.longitude]
      in_range = Target.within(other_target.size + target.size, origin: origin).include?(target)
      compatible_targets.push(other_target) if in_range
    end
    compatible_targets
  end
end
