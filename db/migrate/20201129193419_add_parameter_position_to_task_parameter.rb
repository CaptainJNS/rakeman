# frozen_string_literal: true

class AddParameterPositionToTaskParameter < ActiveRecord::Migration[6.0]
  def change
    add_column :rakeman_task_parameters, :parameter_position, :integer, default: 0
  end
end
