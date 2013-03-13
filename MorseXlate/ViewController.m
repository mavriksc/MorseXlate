//
//  ViewController.m
//  MorseXlate
//
//  Created by sean carlisle on 8/27/12.
//  Copyright (c) 2012 sean carlisle. All rights reserved.
//

#import "ViewController.h"

#import "AVBufferPlayer.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize inputTextField,translated,play;

-(AVBufferPlayer *)bufferGivenSwitchSeq:(NSString *)switchSeq
{
    //play.enabled=NO;
    player=nil;
    const int seconds = [switchSeq length]/10;
    const int sampleRate = 44100;
    const float gain = 0.9f;
    
    int frames = seconds * sampleRate;
    float* buffer = (float*)malloc(frames*sizeof(float));
    
    for (int i = 0; i < frames; i++)
    {
        
        // Simple 440Hz sine wave *switch sequence;
        buffer[i] = (gain * sinf(i*2*M_PI*440/sampleRate))*[[switchSeq substringWithRange:NSMakeRange(i/4410, 1)] integerValue];
    }
    
    player = [[AVBufferPlayer alloc] initWithBuffer:buffer frames:frames];
    free(buffer);
    //play.enabled=YES;
    return player;

}
-(IBAction)translate
{
        NSDictionary *codes=[NSDictionary dictionaryWithObjectsAndKeys:@".- ",@"a",@"-... ",@"b",@"-.-. ",@"c",@"-.. ",@"d",@". ",@"e",@"..-. ",@"f",@"--. ",@"g",@".... ",@"h",@".. ",@"i",@".--- ",@"j",@"-.-  ",@"k",@".-.. ",@"l",@"-- ",@"m",@"-. ",@"n",@"--- ",@"o",@".--. ",@"p",@"--.- ",@"q",@".-. ",@"r",@"... ",@"s",@"- ",@"t",@"..- ",@"u",@"...- ",@"v",@".-- ",@"w",@"-..- ",@"x",@"-.-- ",@"y",@"--.. ",@"z",@".---- ",@"1",@"..---- ",@"2",@"...-- ",@"3",@"....- ",@"4",@"..... ",@"5",@"-.... ",@"6",@"--... ",@"7",@"---.. ",@"8",@"----. ",@"9",@"-----",@"0", nil];
    NSString *input,*encoded,*key;
    input=[[self inputTextField] text];
    encoded=[input lowercaseString];
    for(key in codes)
    {
        encoded=[encoded stringByReplacingOccurrencesOfString:key withString:[codes objectForKey:key]];
    }
    [[self translated] setText:encoded];
    
    [self bufferGivenSwitchSeq:[self gateOpperationForCode:[input lowercaseString]]];

}
-(NSString *)stringForGateGiven:(NSString *)code{
    NSDictionary *codes=[NSDictionary dictionaryWithObjectsAndKeys:@".- ",@"a",@"-... ",@"b",@"-.-. ",@"c",@"-.. ",@"d",@". ",@"e",@"..-. ",@"f",@"--. ",@"g",@".... ",@"h",@".. ",@"i",@".--- ",@"j",@"-.-  ",@"k",@".-.. ",@"l",@"-- ",@"m",@"-. ",@"n",@"--- ",@"o",@".--. ",@"p",@"--.- ",@"q",@".-. ",@"r",@"... ",@"s",@"- ",@"t",@"..- ",@"u",@"...- ",@"v",@".-- ",@"w",@"-..- ",@"x",@"-.-- ",@"y",@"--.. ",@"z",@".---- ",@"1",@"..---- ",@"2",@"...-- ",@"3",@"....- ",@"4",@"..... ",@"5",@"-.... ",@"6",@"--... ",@"7",@"---.. ",@"8",@"----. ",@"9",@"-----",@"0", nil];
    NSString *input,*encoded,*key;
    input=[[self inputTextField] text];
    encoded=[[input lowercaseString] stringByAppendingString:@" "];
    encoded=[encoded stringByReplacingOccurrencesOfString:@" " withString:@"/"];
    for(key in codes)
    {
        encoded=[encoded stringByReplacingOccurrencesOfString:key withString:[codes objectForKey:key]];
    }
    return encoded;

}
-(NSString *)gateOpperationForCode:(NSString *)code{
    
    NSString  *switchSequence=@"";
    code=[self stringForGateGiven:code];
    for (int i=0; i<code.length; i++) {
        switch ([code characterAtIndex:i]) {
            case '.':
                switchSequence=[switchSequence stringByAppendingString:@"10"];
                break;
            case '-':
                switchSequence=[switchSequence stringByAppendingString:@"1110"];
                break;
            case ' ':
                switchSequence=[switchSequence stringByAppendingString:@"00"];
                break;
            case '/':
                switchSequence=[switchSequence stringByAppendingString:@"0000"];
                break;
                
            default:
                break;
        }
    }
    return switchSequence;
}
- (IBAction)playSound
{
 [player play];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[self inputTextField] setText:@"Type in here and then hit encode"];
    [self translate]; 

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
