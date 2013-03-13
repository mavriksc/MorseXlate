//
//  ViewController.h
//  MorseXlate
//
//  Created by sean carlisle on 8/27/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVBufferPlayer;

@interface ViewController : UIViewController{
IBOutlet UITextField *inputTextField;
IBOutlet UITextView *translated;
    IBOutlet UIButton *play;
    AVBufferPlayer *player;
}
@property (nonatomic,strong) IBOutlet UITextField *inputTextField;
@property (nonatomic,strong) IBOutlet UITextView *translated;
@property (nonatomic,strong) IBOutlet UIButton *play;

-(AVBufferPlayer *)bufferGivenSwitchSeq:(NSString *)switchSeq;
-(IBAction)translate;
- (IBAction)playSound;
-(NSString *)gateOpperationForCode:(NSString *)code;
@end
