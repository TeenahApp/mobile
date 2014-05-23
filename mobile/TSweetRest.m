//
//  TSweetRest.m
//  TSweet
//
//  Created by Hussam Al-Zughaibi on 3/30/14.
//  Copyright (c) 2014 Hussam Al-Zughaibi. All rights reserved.
//

#import "TSweetRest.h"

@implementation NSString (NSString_Extended)

- (NSString *)urlencode
{
    
    NSMutableString *output = [NSMutableString string];
    
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    
    for (int i = 0; i < sourceLen; ++i)
    {
        const unsigned char thisChar = source[i];
        
        if (thisChar == ' ')
        {
            [output appendString:@"+"];
        }
        else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        }
        else
        {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end

@implementation TSweetRest

+(id) shared
{
    static TSweetRest * shared = nil;
    @synchronized(self) {
        if (shared == nil)
            shared = [[self alloc] init];
    }
    return shared;
}

-(id)init
{

    if (self = [super init])
    {
        /*
        self.apiUrl = @"http://api.teenah-app.com/v1";
        self.appKey = @"MNwPLdo7hVdj5Mj0Jz7diq804sd5Sf";
        self.appSecret = @"$2y$10$9XuWj51VVDY8tuhYghGcIuN2oEL35RnA17GeesMxIm2cKYvDpGBEW";
         */

        self.apiUrl = @"http://localhost/~hossamzee/web.api/public/index.php/v1";
        self.appKey = @"SSxZcuQc2oiCbZ4cQSSZnRp1NdbbzZ";
        self.appSecret = @"$2y$10$wkmiYLbNwjJ2S3Yo/Vqsj.q4hegPvDxamDaruUrN2Nhs20Nd10ivq";
        
    }

    return self;
}

-(TSweetResponse *) request:(enum method) method
                      route:(NSString *)route
                 parameters:(NSDictionary *)parameters
{

    NSString * url = [[NSString alloc] initWithFormat:@"%@%@", self.apiUrl, route];
    
    // Request.
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    
    // Set some variables.
    [request setURL:[[NSURL alloc] initWithString: url]];
    
    // Add API key and secret.
    [request setValue:self.appKey forHTTPHeaderField:@"X-App-Key"];
    [request setValue:self.appSecret forHTTPHeaderField:@"X-App-Secret"];
    
    // Add user token if exists.
    [request setValue:self.userToken forHTTPHeaderField:@"X-User-Token"];
    
    // TODO: Consider cookies.

    switch (method)
    {
            
        case get:
            [request setHTTPMethod:@"GET"];
            break;
            
        case post:
        {
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        break;
            
        case put:
            [request setHTTPMethod:@"PUT"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            break;
            
        case delete:
            [request setHTTPMethod:@"DELETE"];
            break;
    }
    
    NSLog(@"url = %@", url);
    
    // TODO:    Probably it is better to use: The block approach.
    //          To avoid running the lookup algorithm for every key.
    // http://stackoverflow.com/questions/1284429/is-there-a-way-to-iterate-over-a-dictionary
    
    NSMutableArray * pairs = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSDateFormatter * longDateFormatter = [[NSDateFormatter alloc] init];
    [longDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter * shortDateFormatter = [[NSDateFormatter alloc] init];
    [shortDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (id key in parameters)
    {
        // Get the value of the key (also the type of the object).
        id value = parameters[key];
        NSString * stringValue = @"";
        
        NSLog(@"%@\n", key);
        
        // Check the type of the object and make a related decision.
        if ([value isKindOfClass:[NSNull class]]);
        
        else if ([value isKindOfClass:[NSNumber class]])
        {
            if (strcmp([value objCType], @encode(BOOL)))
            {
                stringValue = ([value boolValue] == YES) ? @"1" : @"0";
            }
            else
            {
                stringValue = [value stringValue];
            }
        }
        
        else if ([value isKindOfClass:[NSDate class]])
        {
            // Check if the key is either dob, dod.
            if (key == (id)@"dob" || key == (id)@"dod")
            {
                stringValue = [shortDateFormatter stringFromDate:value];
            }
            else
            {
                stringValue = [longDateFormatter stringFromDate:value];
            }
        }
        
        // NSArray.
        else if ([value isKindOfClass:[NSArray class]])
        {
            stringValue = [NSString stringWithFormat:@"[%@]", [value componentsJoinedByString:@","]];
        }
        
        // NSData.
        else if ([value isKindOfClass:[NSData class]])
        {
            stringValue = [value base64EncodedStringWithOptions:0];
        }
        
        else
        {
            stringValue = value;
        }

        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [stringValue urlencode]]];
    }

    NSString * requestParameters = [pairs componentsJoinedByString:@"&"];
    NSLog(@"parameters = %@", requestParameters);
    
    // Set the body
    [request setHTTPBody:[requestParameters dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Response.
    NSHTTPURLResponse * response;
    
    //return nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // TODO: Check if nil.
    
    NSInteger responseCode = [response statusCode];
    NSString * responseBody = [[NSString alloc] initWithBytes:[responseData bytes]
                                                       length:[responseData length]
                                                     encoding: NSUTF8StringEncoding];
    
    if ([response respondsToSelector:@selector(allHeaderFields)])
    {
        NSDictionary *reqh = [request allHTTPHeaderFields];
        
        NSLog(@"Request Headers:\n%@", [reqh description]);
        NSLog(@"\n\nRequest Body:\n%@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
        
        NSDictionary *resh = [response allHeaderFields];
        
        NSLog(@"Response Headers:\n%@", [resh description]);
        NSLog(@"\n\nResponse Body:\n%@", responseBody);
    }
    
    return [[TSweetResponse alloc] initWithParameters:responseCode body:responseData];
}

// http://stackoverflow.com/questions/7673127/xcode-ios-how-do-i-send-a-json-to-a-url-post-and-get-request-resolved

-(TSweetResponse *) get:(NSString *)route
{
    return [self request:get route:route parameters:nil];
}

-(TSweetResponse *) post:(NSString *)route parameters:(NSDictionary *)parameters
{
    return [self request:post route:route parameters:parameters];
}

-(TSweetResponse *)put:(NSString *)route parameters:(NSDictionary *)parameters
{
    return [self request:put route:route parameters:parameters];
}

-(TSweetResponse *)delete:(NSString *)route parameters:(NSDictionary *)parameters
{
    return [self request:delete route:route parameters:parameters];
}

@end
