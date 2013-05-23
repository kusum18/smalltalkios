//
//  Constants.h
//  iAd
//

/*            Declare all app constants here */



/* URL Zone */
#define CBaseURL @"http://137.132.179.37/openx/www/delivery/"
#define CUrlZone1     @"http://137.132.179.37/openx/www/delivery/ajs.php?zoneid=1&amp;cb=%d&amp;charset=UTF-8"
#define CUrlZone2     @"http://137.132.179.37/openx/www/delivery/ajs.php?zoneid=2&amp;cb=%d&amp;charset=UTF-8"
#define CUrlZone3     @"http://www.google.com"

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
