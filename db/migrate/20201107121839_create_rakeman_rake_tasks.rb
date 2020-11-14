# frozen_string_literal: true

class CreateRakemanRakeTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :rakeman_rake_tasks do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
