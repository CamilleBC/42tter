class RenameTextToBody < ActiveRecord::Migration[5.2]
  def change
	rename_column :messages, :text, :body 
  end
end
