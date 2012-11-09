class CreateConfessions < ActiveRecord::Migration
  def change
    create_table :confessions do |t|
      t.string :user
      t.text :text

      t.timestamps
    end
  end
end
