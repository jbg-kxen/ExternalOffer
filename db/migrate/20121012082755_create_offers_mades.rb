class CreateOffersMades < ActiveRecord::Migration
  def change
    create_table :offers_mades do |t|
      t.string :orgId
      t.string :userId
      t.string :offerId
      t.string :status

      t.timestamps
    end
  end
end
