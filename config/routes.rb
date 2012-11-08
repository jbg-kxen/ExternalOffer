ExternalOffer::Application.routes.draw do

  root :to => "offers#index"

  get "offers" => "offers#index"
  get "offers/:orgId/:userId" => "offers#getOffers"
  get "offers/:orgId/:userId/:offerId/accept" => "offers#accept"
  get "offers/:orgId/:userId/:offerId/reject" => "offers#reject"

end
