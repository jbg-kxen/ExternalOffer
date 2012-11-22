class OffersController < ApplicationController
  def index
  end

  def getOffers
    scoredOffers = ExternalLib::OfferService.new.getOffers(params)
    respond_to do |format|
      format.html  { render :json => scoredOffers, :content_type => 'application/json' }
      format.json  { render :json => scoredOffers }
    end
  end

  def accept
    ExternalLib::OfferService.new.accept(params)
    getOffers
  end

  def reject
    ExternalLib::OfferService.new.reject(params)
    getOffers
  end

end