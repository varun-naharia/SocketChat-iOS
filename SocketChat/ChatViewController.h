//
//  ChatViewController.h
//  SocketChat
//
//  Created by Varun Naharia on 31/05/17.
//  Copyright © 2017 TechWizard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSQMessagesViewController/JSQMessages.h>
#import "WebSocket.h"
@interface ChatViewController : JSQMessagesViewController<WebSocketDelegate>


@property(nonatomic, strong) NSString *domain;
@property(nonatomic, strong) NSString *port;

@property(nonatomic, strong)WebSocket *socket;


@end
