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
    redirect_to "/offers/#{params[:orgId]}/#{params[:userId]}"
  end

  def reject
    ExternalLib::OfferService.new.reject(params)
    redirect_to "/offers/#{params[:orgId]}/#{params[:userId]}"
  end

end