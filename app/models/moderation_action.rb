class ModerationAction < ApplicationRecord
  ACTIONS = %w[approved rejected].freeze

  belongs_to :moderator, class_name: 'User'

  validates :action, inclusion: { in: ACTIONS }
  validates :moderatable_type, :moderatable_id, :moderator_id, presence: true

  def moderatable
    moderatable_type.constantize.find(moderatable_id)
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :for_moderatable, ->(record) { where(moderatable_type: record.class.name, moderatable_id: record.id) }
end
