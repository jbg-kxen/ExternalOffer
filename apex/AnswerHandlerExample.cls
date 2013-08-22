public with sharing class AnswerHandlerExample implements IAnswerHandler2{
	public static String pageType;

	//For standard page.
	public String getYesUrl(String offerId, String userId) {
		pageType = 'YesPage';
		return '/' + offerId;
	}

	public String getNoUrl(String offerId, String userId) {
		pageType = 'NoPage';
		return '/' + offerId;
	}

	//For VisualForce page.
	/*public String getYesUrl(String offerId, String userId) {
		pageType = 'YesPage';
		return '/apex/VPage?offerId=' + offerId + '&userId=' + userId;
	}

	public String getNoUrl(String offerId, String userId) {
		pageType = 'NoPage';
		return '/apex/VPage?offerId=' + offerId + '&userId=' + userId;
	}*/

	//For Flow.
	/*public String getYesUrl(String offerId, String userId) {
		pageType = 'YesPage';
		return '/flow/Flow_Test?offerId='+offerId;
	}

	public String getNoUrl(String offerId, String userId) {
		pageType = 'NoPage';
		return '/flow/Flow_Test?offerId='+offerId;
	}*/

	//tab label for yes and no page.
	public String getTabLabel(){
		String pageTitle = '';
		if (pageType == 'YesPage'){
			pageTitle = 'yes page!!';
		}else if (pageType == 'NoPage'){
			pageTitle = 'no page!!';
		}
		return pageTitle;
	}

}