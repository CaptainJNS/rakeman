# frozen_string_literal: true

class CreateRakemanTaskParameters < ActiveRecord::Migration[6.0]
  def change
    create_table :rakeman_task_parameters do |t|
      t.string :name, null: false
      t.references :rakeman_rake_task

      t.timestamps
    end
  end
end
