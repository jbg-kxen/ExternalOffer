ExternalOffer::Application.routes.draw do

  root :to => "offers#index"

  get "offers" => "offers#index"
  get "offers/:orgId/:userId" => "offers#getOffers"
  get "offers/:orgId/:userId/accept/:offerId" => "offers#accept"
  get "offers/:orgId/:userId/reject/:offerId" => "offers#reject"

end
