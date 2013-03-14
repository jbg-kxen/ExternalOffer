module ExternalLib

  class ScoredOffer
    attr_accessor :probability, :exclusionReason
    attr_accessor :id,:name,:script,:stdImgUrl,:consoleImgUrl
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
      ranked = scoredOffers.sort { |x,y| y.probability - x.probability }
      return ranked
    end
    def scoreOffer(offer, userId)
      resp = ScoredOffer.new(offer)
      resp.probability = Random.rand
      return resp
    end
  end

  class HardOfferScorer
    def score(offers, userId)
      score = 0.96548
      scoredOffers = offers.collect { |x|
        scoredOffer = ScoredOffer.new(x)
        scoredOffer.probability = score
        score -= 0.20724
        scoredOffer
      }
      return scoredOffers
    end
  end

  class StoredProcedureScorer
    attr_accessor :model_procedure, :model_arg, :field_types
    def initialize
      @model_procedure = {'Brokerage Account'=>'urbano',
                          'Checking Account'=>'dueudf',
                          'Retirement Account'=>'proudf',
                          'Savings Account'=>'massimo',
                          'Visa Account'=>'miniudf'}

      @model_arg = {'Brokerage Account'=>%w(MailingState Gender__c Income_Range__c Age__c Marital_Status__c),
                    'Checking Account'=>%w(MailingState Income_Range__c Age__c Homeowner__c Marital_Status__c),
                    'Retirement Account'=>%w(MailingState Gender__c Income_Range__c Age__c Homeowner__c),
                    'Savings Account'=>%w(MailingState Gender__c Income_Range__c Age__c Homeowner__c Marital_Status__c),
                    'Visa Account'=>%w(MailingState Gender__c Income_Range__c Age__c Homeowner__c Occupation__c Marital_Status__c)}

      @field_types = {}
    end
    
    def score(offers,  userId)
      input = buildADS(userId)
      puts "StoredProcedureScorer ... input: #{input.to_s}"
      scoredOffers = offers.collect { |x|
        # first initialize the response object
        scoredOffer = ScoredOffer.new x
        # then calculate the score
        procedure_name = model_procedure[x.name]
        procedure_args = model_arg[x.name].collect {|y| get_input(input,y) }.join(',')
        score = execProc("#{procedure_name}(#{procedure_args})")
        # and finally calculate the proba
        scoredOffer.probability = execProc("#{procedure_name}_proba(#{score})").to_f
        scoredOffer
      }
      return scoredOffers
    end

    def buildADS(user_id)
      # TODO programatically determine the type of the user ('Lead' or 'Contact')
      # -- type:Lead id:00QE000000DrYcp Name:Akin, Kristen
      # -- type:Contact id:003E000000K2nDM Name:Tim Barr
      #user_id = '003E000000K2nDM'
      filter = ' where ID=\'' + user_id + '\''
      object_type = 'Contact'
      # connect to Salesforce to retrieve input data
      client = Restforce.new :username => SF_USERNAME,
                             :password => SF_PASSWORD,
                             :security_token => SF_SECURITY_TOKEN,
                             :client_id => SF_CLIENT_ID,
                             :client_secret => SF_CLIENT_SECRET
      #fields = client.describe(object_type)['fields'].collect {|f| f.name}
      fields = client.describe(object_type)['fields'].collect {|f|
        @field_types[f.name]=f.type
        f.name
      }
      res = client.query('select ' + fields.join(',') + ' from ' + object_type + filter).first
    end

    def get_input(input, var)
      v = input[var]
      if v == nil
        # Should return NULL all the time?
        # Keep as is for demo purposes
        should_quote(var) ? 'NULL' : 0
      elsif @field_types[var]=='boolean'
        v ? 1 : 0
      else
        should_quote(var) ? "'#{v}'" : v
      end
    end

    def should_quote(var)
      return !(%w(double int).include? @field_types[var])
    end

    def execProc(proc_name)
      # the return value is an instance of PG::Result
      res = ActiveRecord::Base.connection.execute('select '+proc_name)
      return res.getvalue(0,0)
    end

  end

  class OfferService

    def initialize(service_name=OFFER_SERVICE_IMPL)
      mod = self.class.name.split('::').first
      @impl = Object.const_get(mod).const_get(service_name).new
    end

    def getOffers(params)
      offers = Offer.find_all_by_orgId(params[:orgId])
      scoredOffers = @impl.score(offers, params[:userId])
      rankedOffers = apply_rules(scoredOffers, params[:userId])
      return rankedOffers.sort { |x,y| y.probability - x.probability }
    end

    def accept(params)
      om = OffersMade.new
      om.orgId = params[:orgId]
      om.userId = params[:userId]
      om.offerId = params[:offerId]
      om.status = 'accepted'
      om.save
      puts "OfferService.accept: #{params}"
      puts om.to_json
    end

    def reject(params)
      om = OffersMade.new
      om.orgId = params[:orgId]
      om.userId = params[:userId]
      om.offerId = params[:offerId]
      om.status = 'rejected'
      om.save
      puts "OfferService.reject: #{params}"
      puts om.to_json
    end

    private
    def apply_rules(scoredOffers, userId)
      history = {}
      offer_mades = OffersMade.where(:userId => userId)
      offer_mades.each {|offer_made|
        offer_id = offer_made.offerId
        if history[offer_id].nil?
          history[offer_id] = [offer_made]
        else
          history[offer_id].push offer_made
        end
      }

      return scoredOffers.each { |scored_offer|
        offers_mades = history[scored_offer.id.to_s]
        next if offers_mades.nil?
        exclusion_reasons = []
        if !offers_mades.find{|x| x.status.eql? 'accepted'}.nil?
          exclusion_reasons.push 'ALREADY HAS'
        end
        if !offers_mades.find{|x| x.status.eql? 'rejected'}.nil?
          exclusion_reasons.push 'PRIOR OFFER REJECTED'
        end
        scored_offer.exclusionReason = exclusion_reasons.join(',')
      }
    end

  end

end
