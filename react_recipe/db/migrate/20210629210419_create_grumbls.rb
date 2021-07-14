class CreateGrumbls < ActiveRecord::Migration[6.1]
  def change
    create_table :grumbls do |t|
      t.string :name, null: false
      t.text :ingredients, null: false
      t.text :instruction, null: false
      t.string :image, default: 'https://cdn.mos.cms.futurecdn.net/hQdwFN8qZkxzZy846M5kTg.jpg'

      t.timestamps
    end
  end
end
