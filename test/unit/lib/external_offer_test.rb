require 'test_helper'
require 'Restforce'
require 'external_lib'

class ExternalOfferTest < ActiveSupport::TestCase

#  setup do
#    ExternalOffer::Application.const_set(:OFFER_SERVICE_IMPL, 'HardOfferScorer')
#  end

  #  osrv = ExternalLib::OfferService.new
  # osrv.getOffers({:orgId => 'tintin', :userId => 'tintin'})

  test "Call stored procedure" do
    orgId = offers(:one).orgId
    userId = offers_mades(:one).userId
    scorer = ExternalLib::StoredProcedureScorer.new
    offers_for_orgId = Offer.where(:orgId => orgId).all
    s = scorer.score(offers_for_orgId, userId)
    puts "score for '#{params[:userId]}': #{s.join(',')}"
    offers_for_orgId.select{|x| x.name}.each {|offer_name|
      so = s.find {|y|y.name.eql? offer_name}
      assert_not_nil so
      puts "\t#{so.name}:\t#{so.proba}\t\t#{so.exclusionReason or '-'}"
    }
  end

  test "getOffers" do
    om = offers_mades(:one)
    assert_equal 'rejected', om.status
    offerService = ExternalLib::OfferService.new
    params = {:userId => om.userId,:orgId => om.orgId}
    offers = offerService.getOffers(params)
    offer = offers[om.offerId.to_i - 1]
    assert_equal offer.id, om.offerId.to_i
    puts "exclusion: #{offer.exclusionReason}"
    assert_true !offer.exclusionReason.empty?
    offers.each{ |x|
      puts " - id: #{x.id}, name: #{x.name } -- proba: #{x.proba}, exclusion: #{x.exclusionReason}"
    }
  end
end