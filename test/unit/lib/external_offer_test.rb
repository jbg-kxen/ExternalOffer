require 'test_helper'
require 'external_lib'

class ExternalOfferTest < ActiveSupport::TestCase

  test "Call stored procedure" do
    orgId = offers(:one).orgId
    userId = offers_mades(:one).userId
    scorer = ExternalLib::StoredProcedureScorer.new
    offers_for_orgId = Offer.where(:orgId => orgId).all
    scored_offers = scorer.score(offers_for_orgId, userId)
    offers_for_orgId.map{|x| x.name}.each {|offer_name|
      scored_offer = scored_offers.find {|y|y.name.eql? offer_name}
      assert_not_nil scored_offer
      puts " - name: #{scored_offer.name} -- proba: #{scored_offer.probability}, exclusion: #{scored_offer.exclusionReason or '-'}"
      assert_not_nil scored_offer.probability
    }
  end

  test "HardOfferScorer getOffers" do
    testGetOffers ExternalLib::HardOfferScorer
  end

  test "RandomOfferScorer getOffers" do
    testGetOffers ExternalLib::RandomOfferScorer
  end

  test "StoredProcedureScorer getOffers" do
    testGetOffers ExternalLib::StoredProcedureScorer
  end

  def testGetOffers(service_impl)
    om = offers_mades(:one)
    assert_equal 'rejected', om.status
    impl_name = service_impl.name.split('::').last
    puts "Testing scorer: #{impl_name}"
    offerService = ExternalLib::OfferService.new(impl_name)
    params = {:userId => om.userId,:orgId => om.orgId}
    offers = offerService.getOffers(params)
    offer = offers.find{|offer| offer.id == om.offerId.to_i}
    assert_equal offer.id, om.offerId.to_i
    puts "exclusion: #{offer.exclusionReason}"
    assert_true !offer.exclusionReason.empty?
    offers.each{ |x|
      puts " - id: #{x.id}, name: #{x.name } -- proba: #{x.probability}, exclusion: #{x.exclusionReason}"
    }
  end
end
