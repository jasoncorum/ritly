class AddCounterToLinks < ActiveRecord::Migration
  def change
    add_column :links, :counter, :integer
  end
end
