ExternalOffer::Application.routes.draw do

  root :to => "offers#index"

  get "offers" => "offers#index"
  get "offers/:orgId/:userId" => "offers#getOffers"
  post "offers/:orgId/:userId/:offerId/accept" => "offers#accept"
  post "offers/:orgId/:userId/:offerId/reject" => "offers#reject"

end
