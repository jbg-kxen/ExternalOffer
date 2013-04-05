public class TestPostRules implements IPostRules {

	public void postRulesExecution(OfferResponse offerResponse, ID userId) {
		
		boolean isContact = userId.getSObjectType() == Contact.sObjectType;
		if (isCOntact) {
			Contact ctct = [Select ID, Name From Contact Where Id = :userId];
			System.debug(ctct.Name);
			if (ctct.Name == 'Tim Barr') {
				OfferResponse.Response newOnTop = new OfferResponse.Response(
					// String id, String name, String script, Double proba, String stdImgUrl, String consoleImgUrl, String exclusionReason
					'', // TODO offer must exists: put a real offer ID
					'New On Top Offer',
					'Script On Bottom',
					0,
					'https://c.na9.content.force.com/servlet/servlet.ImageServer?id=015E0000000yO0u&oid=00DE0000000Jg2S', 
					'https://c.na9.content.force.com/servlet/servlet.ImageServer?id=015E0000000yO0u&oid=00DE0000000Jg2S',
					null);
				offerResponse.putOnTop(newOnTop);
				// offerResponse.put(2, newOnTop);
			} else if (ctct.Name == 'DemoContact10') {
				for(OfferResponse.Response resp : offerResponse.offerResponses) {
					resp.exclusionReason = 'Because this is YOU From TestPostRules';
				}
			} else if (ctct.Name == 'DemoContact1') {
				offerResponse.switch(0, 1);
			} else if (ctct.Name == 'DemoContact16') {
				if (offerResponse.mode == Constants.IMPROVEMENT_MODE) {
					OfferResponse.Response savings;
					OfferResponse.Response brokage;
					for(OfferResponse.Response resp : offerResponse.offerResponses) {
						if (resp.Name == 'DemoOffer:Savings Account') {
							savings = resp;
						} else if (resp.Name == 'DemoOffer:Brokerage Account') {
							brokage = resp;
						}
					}
					if (savings != null && brokage != null) {
						offerResponse.switch(savings, brokage);
					}
				}
			}
		}
			
	}

}