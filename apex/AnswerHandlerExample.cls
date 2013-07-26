public with sharing class AnswerHandlerExample implements IAnswerHandler{

	//For standard page.
	public String getYesUrl(String offerId, String userId) {
		return '/' + offerId;
	}

	public String getNoUrl(String offerId, String userId) {
		return '/' + offerId;
	}

	//For VisualForce page.
	/*public String getYesUrl(String offerId, String userId) {
		return '/apex/VPage?offerId=' + offerId + '&userId=' + userId;
	}

	public String getNoUrl(String offerId, String userId) {
		return '/apex/VPage?offerId=' + offerId + '&userId=' + userId;
	}*/

	//For Flow.
	/*public String getYesUrl(String offerId, String userId) {
		return '/flow/Flow_Test?offerId='+offerId;
	}

	public String getNoUrl(String offerId, String userId) {
		return '/flow/Flow_Test?offerId='+offerId;
	}*/

}