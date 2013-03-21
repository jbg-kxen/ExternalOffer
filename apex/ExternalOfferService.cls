public class ExternalOfferService implements IOfferService {

	private enum ExternalURL {Offers, Accept, Reject}

	private String base_url;

	public ExternalOfferService() {
		base_url = 'http://yourserver.herokuapp.com';
	}

	public OfferResponse getOffers(ID orgId, ID userId) {
		HttpRequest req = new HttpRequest();
		req.setMethod('GET');
		req.setEndpoint(getExternalURL(ExternalURL.Offers, orgId, userId, ''));
		return sendRequest(req);
	}

	public void accept(ID orgId, ID userId, String productId) {
		HttpRequest req = new HttpRequest();
		req.setMethod('POST');
		req.setHeader('Content-Length', '0');
		req.setEndpoint(getExternalURL(ExternalURL.Accept, orgId, userId, productId));
		sendRequest(req);
	}

	public void reject(ID orgId, ID userId, String productId) {
		HttpRequest req = new HttpRequest();
		req.setMethod('POST');
		req.setHeader('Content-Length', '0');
		req.setEndpoint(getExternalURL(ExternalURL.Reject, orgId, userId, productId));
		sendRequest(req);
	}

	private OfferResponse sendRequest(HttpRequest req) {
		OfferResponse offerResponse = new OfferResponse();
		String jsonResp;
		System.debug('calling-url: ' + req);
		if (Test.isRunningTest()) {
			// no external calls allowed during tests
			jsonResp = '[{"id":"xa5546","name":"Brokerage Account","script":"Brokerage account script","probability":0.5,"stdImgUrl":"http://my.company.com/images/offers/xa5546.png","consoleImgUrl":"http://my.company.com/images/offers/xa5546_banner.png","exclusionReason":""},{"id":"rq9875","name":"Checking Account","script":"Checking account script","probability":0.3,"stdImgUrl":"http://my.company.com/images/offers/rq9875.png","consoleImgUrl":"http://my.company.com/images/offers/rq9875_banner.png","exclusionReason":"Out of stock"}]';
		} else {
			HttpResponse res = new Http().send(req);
			if (res.getStatusCode() != 200) {
				throw new OfferServiceException(res + '<p>' + res.getBody() + '</p>');
			}
			jsonResp = res.getBody();
		}
		offerResponse.offerResponses = (OfferResponse.Response[]) Json.deserialize(jsonResp, OfferResponse.Response[].class);
		for (OfferResponse.Response res : offerResponse.offerResponses) {
			res.probability = (Decimal.valueOf(res.probability*100)).setScale(3).doubleValue();
		}
		return offerResponse;
	}

	private String getExternalURL(ExternalURL actionURL, ID orgId, ID userId, String offerId) {
		String url = base_url += '/offers/' + String.valueOf(orgId) + '/' + String.valueOf(userId);
		if (ExternalURL.Accept == actionURL) {
			url += '/' + offerId + '/accept';
		} else if (ExternalURL.Reject == actionUrl) {
			url += '/' + offerId + '/reject';
		}
		return url;
	}

}