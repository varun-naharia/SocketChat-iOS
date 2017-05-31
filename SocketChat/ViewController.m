//
//  ViewController.m
//  SocketChat
//
//  Created by ImportHack on 30/06/16.
//  Copyright © 2016 TechWizard. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"

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
    
    ChatViewController *chatVc = [[self storyboard] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    [[self navigationController] pushViewController:chatVc animated:true];
    
}

@end
