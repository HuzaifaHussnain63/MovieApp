class AddDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reviews, :status, 'Posted'
  end
end
