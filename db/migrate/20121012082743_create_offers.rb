class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :orgId
      t.string :name
      t.string :script
      t.string :stdImgUrl
      t.string :consoleImgUrl

      t.timestamps
    end
  end
end
