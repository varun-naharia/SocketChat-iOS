//
//  ViewController.m
//  SocketChat
//
//  Created by ImportHack on 30/06/16.
//  Copyright © 2016 TechWizard. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import "WebSocket.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)connectAction:(id)sender {
    
    WebSocket *socket = [[WebSocket alloc] init];
    socket.domain = _txtDomain.text;
    socket.port = _txtPort.text;
    [socket initNetworkCommunication];
    ChatViewController *chatVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    chatVc.socket = socket;
    chatVc.senderDisplayName = _txtUsername.text;
    chatVc.senderId = _txtUsername.text;
    chatVc.domain = _txtDomain.text;
    chatVc.port = _txtPort.text;
    [[self navigationController] pushViewController:chatVc animated:true];
    
}

@end
