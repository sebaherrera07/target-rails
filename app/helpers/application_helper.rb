module ApplicationHelper
  def get_topic_icon(topic)
    topic_item = Target::TOPICS.detect { |top| top[:title] == topic }
    topic_item[:icon]
  end
end
