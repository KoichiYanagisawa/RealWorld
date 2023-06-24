# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  belongs_to :user

  def assign_tags(tag_names)
    tag_names.each do |tag_name|
      tags << Tag.find_or_create_by(name: tag_name)
    end
  end

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name:) }
    self.tags = new_or_found_tags
  end
end
