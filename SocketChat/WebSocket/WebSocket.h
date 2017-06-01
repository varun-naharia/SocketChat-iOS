//
//  WebSocket.h
//  SocketChat
//
//  Created by Varun Naharia on 01/06/17.
//  Copyright © 2017 TechWizard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebSocketDelegate <NSObject>   //define delegate protocol
- (void) messageDidReceived:(NSString *)message andSenderId:(NSString *)senderId;  //define delegate method to be implemented within another class
@end //end protocol

@interface WebSocket : NSObject<NSStreamDelegate>
//{
//    
//    NSInputStream	*inputStream;
//    NSOutputStream	*outputStream;
//}
@property (nonatomic, weak) id <WebSocketDelegate> delegate;
@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;
@property(nonatomic, strong) NSString *domain;
@property(nonatomic, strong) NSString *port;
- (void) initNetworkCommunication;
- (void) messageReceived:(NSString *)message;

@end
