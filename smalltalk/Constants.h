//
//  Constants.h
//  iAd
//

/*            Declare all app constants here */



/* URL Zone */
#define CBaseURL @"http://localhost/smalltalk"
#define NotesSendReqUrl @"http://127.0.0.1:8080/smalltalk/index.php/post/user/"
#define AnswersURl @"http://127.0.0.1:8080/ss.txt"
#define TestURL @"http://www.google.com"

/* String constants */
#define jsHTML @"<html><head><style>body{ margin: 0; padding: 0; }</style></head><body><script>%@</script></body></html>"
#define AdHTML @""


/* Request Tags */
#define JShttpTag 1
#define HTMLhttpTag 2

/* Ad types */
#define AdTypeNone 0
#define AdTypeBanner 1
#define AdTypePopup 2
#define AdTypeInterstitial 3

/*Timer Constants .All times in seconds*/
#define AdRefreshNone 0
#define AdRefreshTimeDefault 30
