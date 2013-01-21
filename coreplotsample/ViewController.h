//
//  ViewController.h
//  coreplotsample
//
//  Created by Mayur Joshi on 20/01/13.
//  Copyright (c) 2013 Mayur Joshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface ViewController : UIViewController <CPTBarPlotDataSource,CPTBarPlotDelegate>

@property (nonatomic, retain) CPTXYGraph *barChart;
@property (nonatomic, retain) NSMutableArray *sampleArray;

@property (nonatomic, retain) NSTimer* timer;
@property (nonatomic, readwrite)   CGPoint moved;

-(void) getGraphValues;


@end
