class CreateSneakerComments < ActiveRecord::Migration[6.1]
  def change
    create_table :sneaker_comments do |t|
      t.comment :text
      t.user_id :integer
      t.sneaker_id :integer

      t.timestamps
    end
  end
end
