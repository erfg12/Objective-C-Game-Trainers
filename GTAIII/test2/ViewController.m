//
//  ViewController.m
//  gametrainer
//
//  Created by Jacob Fliss on 6/9/17.
//  Copyright © 2017 New Age Soldier. All rights reserved.
//
//  GAME USED: Grand Theft Auto III from Steam
//  Example code: https://github.com/iosre/HippocampHairSalon/blob/master/main.m
//

#import "ViewController.h"

@implementation ViewController

//addesses
NSString *cashAddress = @"0x9526D4";
NSString *healthAddress = @"0x37308D8";
NSString *wantedAddress = @"0x8E95B40";
NSString *pistammoAddress = @"0x37309AC";
NSString *automaticammoAddress = @"0x37309C4";
NSString *shotgumammoAddress = @"0x37309e0";
NSString *ak47ammoAddress = @"0x37309F4";
NSString *assaultrifleammoAddress = @"0x3730A0C";
NSString *sniperrifleAddress = @"0x3730A28";
NSString *rocketlauncherAddress = @"0x3730A40";
NSString *maltovsAddress = @"0x3730A70";
NSString *grenadesAddress = @"0x3730A88";

//shared process task
mach_port_t _processTask = 0;

void messageBox (NSString* msgTitle, NSString* msg) {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:msgTitle];
    [alert setInformativeText:msg];
    [alert addButtonWithTitle:@"Ok"];
    [alert runModal];
    return;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startTimedTask]; //start the worker
}


- (void)startTimedTask //run every 1 seconds
{
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
}


- (void)performBackgroundTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Do background work
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_processTask > 0) { //game is running. Let's check if we can modify constant values.
                if (_godmodeCheckbox.state == 1)
                    writeMemory(healthAddress, @"float", @"100");
                if (_neverwantedCheckbox.state == 1)
                    writeMemory(wantedAddress, @"int", @"0");
                if (_refillammoCheckbox.state == 1){
                    writeMemory(pistammoAddress, @"int", @"12");
                    writeMemory(automaticammoAddress, @"int", @"12");
                    writeMemory(shotgumammoAddress, @"int", @"10");
                    writeMemory(ak47ammoAddress, @"int", @"60");
                    writeMemory(assaultrifleammoAddress, @"int", @"50");
                    writeMemory(sniperrifleAddress, @"int", @"10");
                    writeMemory(rocketlauncherAddress, @"int", @"10");
                    writeMemory(maltovsAddress, @"int", @"10");
                    writeMemory(grenadesAddress, @"int", @"10");
                }
            } else { //game isn't running. Keep checking...
                int pid = getPIDFromName(@"Grand Theft Auto 3");
                _ProcIDLabel.stringValue = [NSString stringWithFormat:@"%d", pid];
                if (pid != 0){
                    _processTask = openProcess(pid);
                    if (_processTask != 0){
                        NSString *string = [NSString stringWithFormat:@"%d", readInt32(cashAddress)];
                        _pointsBox.stringValue = string;
                    }
                }
            }
        });
    });
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)buttonClick:(id)sender {
    //change cash button
    writeMemory(cashAddress, @"int", @"99999999");
}

@end
