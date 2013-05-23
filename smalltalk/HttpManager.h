
#import <Foundation/Foundation.h>

@protocol HttpManagerDelegate;


@interface HttpManager : NSObject 
{
	id<HttpManagerDelegate> delegate;
	NSMutableData *receivedData;
	NSURLConnection *urlConnection;

}
@property (nonatomic, assign) id<HttpManagerDelegate> delegate;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (retain) NSURLConnection *urlConnection;

- (id) initWithURL:(NSURL *) theURL delegate:(id<HttpManagerDelegate>) theDelegate;
@end

@protocol HttpManagerDelegate<NSObject>

- (void) connectionDidFail:(HttpManager *)theConnection withError:(NSError *)error;
- (void) connectionDidFinish:(HttpManager *)theConnection;

@end