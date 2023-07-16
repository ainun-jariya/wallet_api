# frozen_string_literal: true

# add soft delete & some log
class AddColumnsToSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :sessions, :deleted_at, :datetime
    add_column :sessions, :logged_in_at, :datetime
    add_column :sessions, :logged_out_at, :datetime
  end
end
