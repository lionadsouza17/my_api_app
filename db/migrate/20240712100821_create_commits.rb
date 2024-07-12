class CreateCommits < ActiveRecord::Migration[7.0]
  def change
    create_table :commits do |t|
      t.references :repository, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
