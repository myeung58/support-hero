class CreateSupportDuties < ActiveRecord::Migration
  def change
    create_table :support_duties do |t|
      t.datetime :assigned_at
      t.string :state
      t.references :user, index: true

      t.timestamps
    end
  end
end
