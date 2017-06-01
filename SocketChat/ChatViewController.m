//
//  ChatViewController.m
//  SocketChat
//
//  Created by Varun Naharia on 31/05/17.
//  Copyright © 2017 TechWizard. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@property(nonatomic, strong) NSMutableArray *message;

@end

@implementation ChatViewController
@synthesize socket,domain,port;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _message = [[NSMutableArray alloc] init];
    socket.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *response  = [NSString stringWithFormat:@"{\"type\": \"system\",\"name\": \"%@\", \"message\": \"%@\", \"color\": \"red\"}",self.senderDisplayName, @"connection"];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    [socket.outputStream write:[data bytes] maxLength:[data length]];
}

-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date
{
    NSLog(@"%@: %@",senderDisplayName, text);
    NSString *response  = [NSString stringWithFormat:@"{\"type\": \"usermsg\",\"name\": \"%@\", \"message\": \"%@\", \"color\": \"red\"}",self.senderDisplayName,text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    [socket.outputStream write:[data bytes] maxLength:[data length]];
    
//    [_message addObject:[JSQMessage messageWithSenderId:senderId displayName:senderDisplayName text:text]];
//    [[super collectionView] reloadData];
}

-(id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesBubbleImageFactory *bubble = [[JSQMessagesBubbleImageFactory alloc] init];
    if([[_message objectAtIndex:indexPath.item] senderId] != self.senderId)
    {
        return [bubble incomingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    }
    else
    {
        return [bubble outgoingMessagesBubbleImageWithColor:[UIColor blackColor]];
    }
    
}

-(id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_message objectAtIndex:indexPath.item];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_message count];
}

-(void)didPressAccessoryButton:(UIButton *)sender
{
    NSLog(@"camera");
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
    return cell;
}

-(void)messageDidReceived:(NSString *)message andSenderId:(NSString *)senderId
{
    [self.message addObject:[JSQMessage messageWithSenderId:senderId displayName:senderId text:message]];
    [[super collectionView] reloadData];
}




@end
