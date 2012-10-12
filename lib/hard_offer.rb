module HardOffer

  class ScoredOffer
    attr_accessor :proba, :exclusionReason
    def initialize(offer)
      @id = offer.id
      @name = offer.name
      @script = offer.script
      @stdImgUrl = offer.stdImgUrl
      @consoleImgUrl = offer.consoleImgUrl
    end
  end

  class RandomOfferScorer
    def score(offers, userId)
      scoredOffers = offers.collect {|x| self.scoreOffer(x, userId)}
      ranked = scoredOffers.sort { |x,y| y.proba - x.proba }
      return ranked
    end
    def scoreOffer(offer, userId)
      resp = ScoredOffer.new(offer)
      resp.proba = Random.rand
      return resp
    end
  end

  class HardOfferScorer
    def score(offers, userId)
      score = 0.96548
      scoredOffers = offers.collect { |x|
        scoredOffer = ScoredOffer.new(x)
        scoredOffer.proba = score
        score -= 0.20724
        scoredOffer
      }
      return scoredOffers
    end
  end

  class RuleEngine
    def apply(scoredOffers)
      #TODO everything
      # - load the rules
      # - fill up the exclusionReason field with Eligibility/Inventory/Offer Management rules
      # - alter the proba with some Amplifier Rules etc.
      @rankedOffers = scoredOffers
      return @rankedOffers
    end
  end

  class OfferService
    def getOffers(params)
      @offers = Offer.find_all_by_orgId(params[:orgId])
      #@scorer = RandomOfferScorer.new()
      @scorer = HardOfferScorer.new()
      @rules = RuleEngine.new()
      @scoredOffers = @scorer.score(@offers, params[:userId])
      @rankedOffers = @rules.apply(@scoredOffers)
      # @resp_excluded = @@rankedOffers.collect {|x| x.exclusionReason.empty?}
      # if not @resp_excluded.include?(true)
      #  # all offers have been excluded for some reason => default to
      #  @rankedOffers = @scoredOffers
      # end
      return @rankedOffers
    end
  end

end