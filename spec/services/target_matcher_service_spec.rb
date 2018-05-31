require 'rails_helper'

RSpec.describe TargetMatcherService do
  let(:user_1)          { create(:user) }
  let(:user_2)          { create(:user) }
  let(:topic_A)         { Target::TOPICS[1][:title] }
  let(:topic_B)         { Target::TOPICS[2][:title] }
  let(:pos_A)           { { lat: -34.8956766, long: -56.1665157 } }
  let(:pos_B)           { { lat: -34.895281, long: -56.171875 } }

  context 'when targets have same position and topic' do
    let!(:target_1) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_A)
    end
    let!(:target_2) do
      create(:target, user: user_2, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_A)
    end

    it 'returns the match' do
      compatibles_user_1 = TargetMatcherService.matches_for_all_targets(user_1.targets)
      expect(compatibles_user_1).to include(target_2)
      expect(target_1.compatible_targets).to include(target_2)
    end
  end

  context 'when targets have same position and different topic' do
    let!(:target_1) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_A)
    end
    let!(:target_2) do
      create(:target, user: user_2, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_B)
    end

    it 'does not return the match' do
      compatibles_user_1 = TargetMatcherService.matches_for_all_targets(user_1.targets)
      expect(compatibles_user_1).not_to include(target_2)
      expect(target_1.compatible_targets).not_to include(target_2)
    end
  end

  context 'when targets have same position, topic and user' do
    let!(:target_1) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_A)
    end
    let!(:target_2) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long], topic: topic_A)
    end

    it 'does not return the match' do
      compatibles_user_1 = TargetMatcherService.matches_for_all_targets(user_1.targets)
      expect(compatibles_user_1).not_to include(target_2)
      expect(target_1.compatible_targets).not_to include(target_2)
    end
  end

  context 'when targets are in their range' do
    let!(:target_1) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long],
                      topic: topic_A, size: 500)
    end
    let!(:target_2) do
      create(:target, user: user_2, latitude: pos_B[:lat], longitude: pos_B[:long],
                      topic: topic_A, size: 400)
    end

    it 'returns the match' do
      compatibles_user_1 = TargetMatcherService.matches_for_all_targets(user_1.targets)
      expect(compatibles_user_1).to include(target_2)
      expect(target_1.compatible_targets).to include(target_2)
      compatibles_user_2 = TargetMatcherService.matches_for_all_targets(user_2.targets)
      expect(compatibles_user_2).to include(target_1)
      expect(target_2.compatible_targets).to include(target_1)
    end
  end

  context 'when targets are not in their range' do
    let!(:target_1) do
      create(:target, user: user_1, latitude: pos_A[:lat], longitude: pos_A[:long],
                      topic: topic_A, size: 200)
    end
    let!(:target_2) do
      create(:target, user: user_2, latitude: pos_B[:lat], longitude: pos_B[:long],
                      topic: topic_A, size: 100)
    end

    it 'does not return the match' do
      compatibles_user_1 = TargetMatcherService.matches_for_all_targets(user_1.targets)
      expect(compatibles_user_1).not_to include(target_2)
      expect(target_1.compatible_targets).not_to include(target_2)
      compatibles_user_2 = TargetMatcherService.matches_for_all_targets(user_2.targets)
      expect(compatibles_user_2).not_to include(target_1)
      expect(target_2.compatible_targets).not_to include(target_1)
    end
  end
end
