class CreateModerationActions < ActiveRecord::Migration[7.1]
  def change
    create_table :moderation_actions do |t|
      t.string :action, null: false
      t.text :note
      t.references :moderator, null: false, foreign_key: { to_table: :users }, index: true
      t.string :moderatable_type, null: false
      t.bigint :moderatable_id, null: false

      t.timestamps
    end

    add_index :moderation_actions, [:moderatable_type, :moderatable_id]
    add_index :moderation_actions, [:moderator_id, :created_at]
  end
end
