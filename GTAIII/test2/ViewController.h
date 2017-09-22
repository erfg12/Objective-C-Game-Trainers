//
//  ViewController.h
//  gametrainer
//
//  Created by Jacob Fliss on 6/9/17.
//  Copyright © 2017 New Age Soldier. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../../../memory-macos-lib/memory/memory.h"

@interface ViewController : NSViewController

@property (retain, nonatomic) IBOutlet NSTextField *pointsBox;
@property (weak) IBOutlet NSTextField *ProcIDLabel;
@property (weak) IBOutlet NSButton *test;

@property (weak) IBOutlet NSButton *godmodeCheckbox;
@property (weak) IBOutlet NSButton *neverwantedCheckbox;
@property (weak) IBOutlet NSButton *refillammoCheckbox;

@property (strong, nonatomic) NSTimer *timer;

@end

