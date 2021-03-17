class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items, options: 'COLLATE utf8mb4_bin' do |t|
      t.string :name
      t.references :list
      t.timestamps
    end
  end
end
