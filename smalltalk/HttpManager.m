
#import "HttpManager.h"



@implementation HttpManager

@synthesize delegate;
@synthesize receivedData;
@synthesize urlConnection;

/* This method initiates the load request. The connection is asynchronous, 
 and we implement a set of delegate methods that act as callbacks during 
 the load. */
- (id)initWithURL:(NSURL *)theURL delegate:(id<HttpManagerDelegate>)theDelegate
{
	NSLog(@"HttpManager:initWithURL");
	
	if (self = [super init]) 
	{
		
		self.delegate = theDelegate;
		NSLog(@"URL Requested %@",theURL);
		
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL
																  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
															  timeoutInterval:180];
		
		/* create the NSMutableData instance that will hold the received data */
		
		receivedData = [[NSMutableData alloc]init];
		
		/* Create the connection with the request and start loading the
		 data. The connection object is owned both by the creator and the
		 loading system. */
		
		NSLog(@"Request Count before %d",[theRequest retainCount]);
		self.urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest 
																	   delegate:self 
															   startImmediately:YES];
		
		if (urlConnection == nil) 
		{
			/* inform the user that the connection failed */
			[self.delegate connectionDidFail:self];
		}
	}
	
	return self;
}


/* This method initiates the load request. The connection is asynchronous,
 and we implement a set of delegate methods that act as callbacks during
 the load. */
- (id)initWithPOSTURL:(NSURL *)theURL delegate:(id<HttpManagerDelegate>)theDelegate forPostData:(NSString *)post
{
	NSLog(@"HttpManager:initWithURL");
	
	if (self = [super init])
	{
		
		self.delegate = theDelegate;
		
		
		NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL
																  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
															  timeoutInterval:180];
		
		/* create the NSMutableData instance that will hold the received data */
		
		receivedData = [[NSMutableData alloc]init];
		
		/* Create the connection with the request and start loading the
		 data. The connection object is owned both by the creator and the
		 loading system. */
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPBody:postData];
        
		
		NSLog(@"Request Count before %d",[theRequest retainCount]);
		self.urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest
                                                             delegate:self
                                                     startImmediately:YES];
		
        
		if (urlConnection == nil)
		{
			/* inform the user that the connection failed */
			[self.delegate connectionDidFail:self];
		}
	}
	
	return self;
}

- (void)dealloc
{	
	NSLog(@" HttpManager Dealloc");
	NSLog(@" count = %d",[urlConnection retainCount]);
	[urlConnection release];
	delegate = nil;
	[receivedData release];
	[super dealloc];
}


#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"HttpManager:connection didReceiveResponse");
    /* This method is called when the server has determined that it has
	 enough information to create the NSURLResponse. It can be called
	 multiple times, for example in the case of a redirect, so each time
	 we reset the data. */
    [self.receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@"HttpManager:connection connection didReceiveData");
    /* Append the new data to the received data. */
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	NSLog(@"HttpManager:connection didReceiveAuthenticationChallenge");
	NSURLCredential *newCredential;
	newCredential=[NSURLCredential credentialWithUser: @""
											 password: @""
										  persistence:NSURLCredentialPersistenceNone];
	[[challenge sender] useCredential:newCredential
		   forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"HttpManager:connection didFailWithError");
	// Show appropriate error message
	NSLog(@"Error Code %d", [error code]);
	[self.delegate connectionDidFail:self];
	
	// inform the user
   NSLog(@"Connection failed! Error - %@",[error localizedDescription]);
	
	//clear the cache memory 
	NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
	[NSURLCache setSharedURLCache:sharedCache];
	[sharedCache release];
	
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"HttpManager:connectionDidFinishLoading");
	//clear the cache memory 
	NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
	[NSURLCache setSharedURLCache:sharedCache];
	[sharedCache release];
	[self.delegate connectionDidFinish:self];
}

@end
