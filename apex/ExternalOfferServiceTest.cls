@isTest
private class ExternalOfferServiceTest {
	
	@isTest
	static void testGetOffers() {
		ID id = UserInfo.getUserId();
		OfferResponse.Response[] offers = new ExternalOfferService('http://tests-have-no-connectity.com').getOffers(id, id).offerResponses;
		System.assertEquals('Brokerage Account', offers[0].name);
	}
	
	@isTest
	static void testAccept() {
		ID id = UserInfo.getUserId();
		ExternalOfferService offerService = new ExternalOfferService('http://tests-have-no-connectity.com');
		offerService.accept(id, id, 'xa5546');
		OfferResponse.Response[] offers = offerService.getOffers(id, id).offerResponses;
		System.assertEquals('Brokerage Account', offers[0].name);
	}
	
	@isTest
	static void testReject() {
		ID id = UserInfo.getUserId();
		ExternalOfferService offerService = new ExternalOfferService('http://tests-have-no-connectity.com');
		offerService.reject(id, id, 'xa5546');
		OfferResponse.Response[] offers = offerService.getOffers(id, id).offerResponses;
		System.assertEquals('Brokerage Account', offers[0].name);
	}
}