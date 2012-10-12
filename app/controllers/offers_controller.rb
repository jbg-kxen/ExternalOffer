class OffersController < ApplicationController
  def index
  end

  def getOffers
    @scoredOffers = HardOffer::OfferService.new.getOffers(params)
    respond_to do |format|
      format.json  { render :json => @scoredOffers }
    end
  end

end