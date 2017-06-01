//
//  WebSocket.m
//  SocketChat
//
//  Created by Varun Naharia on 01/06/17.
//  Copyright © 2017 TechWizard. All rights reserved.
//

#import "WebSocket.h"

@implementation WebSocket
@synthesize inputStream, outputStream;
- (void) initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)[NSString stringWithFormat:@"%@",_domain], [_port intValue], &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSLog(@"stream event %lu", (unsigned long)streamEvent);
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = (int)[inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        NSString *firstWord = [[output componentsSeparatedByString:@" "] objectAtIndex:0];

                        if(![firstWord isEqualToString:@"HTTP/1.1"])
                        {
                            output = [output substringFromIndex:2];
                        }
                        else
                        {
                            return;
                        }
//                        NSData *data = [[NSData alloc] initWithData:[output dataUsingEncoding:NSASCIIStringEncoding]];
//                        NSError *error;
//                        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                        NSData *data = [output dataUsingEncoding:NSUTF8StringEncoding];
                        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        if([[json valueForKey:@"type"] isEqualToString:@"usermsg"])
                        {
                            if (nil != json) {
                                
                                NSLog(@"%@", [json valueForKey:@"message"]);
                                [self messageReceived:[json valueForKey:@"message"] andSenderID:[json valueForKey:@"name"]];
                                
                            }
                        }
                    }
                }
            }
            break;
            
            
        case NSStreamEventErrorOccurred:
        {
            NSError *error = [theStream streamError];
            NSString* errorMessage = [NSString stringWithFormat:@"%@ (Code = %ld)",[error localizedDescription],(long)[error code]];
            NSLog(@"%@",errorMessage);
            NSLog(@"Can not connect to the host!");
            break;
        }
            
        case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            
            break;
        default:
            NSLog(@"Unknown event");
    }
    
}

- (void) messageReceived:(NSString *)message andSenderID:(NSString *)senderId {
    if([[self delegate] respondsToSelector:@selector(messageDidReceived:andSenderId:)])
    {
        [[self delegate] messageDidReceived:message andSenderId:senderId];
    }
//    
}
@end
