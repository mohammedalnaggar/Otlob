class ChangeArticle < ActiveRecord::Migration[5.2]
  def change
    change_table :articles do |t|

      t.references :user, foreign_key: true

    end
  end
end
