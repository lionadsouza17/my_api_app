class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.string :owner_name
      t.string :repository_name

      t.timestamps
    end
  end
end
