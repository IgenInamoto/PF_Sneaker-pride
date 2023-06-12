class CreateSneakerComments < ActiveRecord::Migration[6.1]
  def change
    create_table :sneaker_comments do |t|
      t.text :comment
      t.integer:user_id 
      t.integer :sneaker_id 

      t.timestamps
    end
  end
end
