//
//  ViewController.m
//  coreplotsample
//
//  Created by Mayur Joshi on 20/01/13.
//  Copyright (c) 2013 Mayur Joshi. All rights reserved.
//

#import "ViewController.h"

#define X_VAL @"x"
#define Y_VAL @"y"


@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getGraphValues];
    [self buildGraph];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) buildGraph
{
    double xAxisLength = [self.sampleArray count];
    
    self.barChart = [[CPTXYGraph alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
    
    self.barChart.plotAreaFrame.borderLineStyle = nil;
    self.barChart.plotAreaFrame.cornerRadius = 0.0f;
    
    self.barChart.paddingLeft = 0.0f;
    self.barChart.paddingRight = 0.0f;
    self.barChart.paddingTop = 0.0f;
    self.barChart.paddingBottom = 0.0f;
    
    self.barChart.plotAreaFrame.paddingLeft = 60.0;
    self.barChart.plotAreaFrame.paddingTop = 40.0;
    self.barChart.plotAreaFrame.paddingRight = 10.0;
    self.barChart.plotAreaFrame.paddingBottom = 40.0;
    
    self.barChart.title = @"Sample Innovations";
    
    CPTMutableTextStyle *textStyle = [CPTTextStyle textStyle];
    textStyle.color = [CPTColor grayColor];
    textStyle.fontSize = 16.0f;
    textStyle.textAlignment = CPTTextAlignmentCenter;
    self.barChart.titleTextStyle = textStyle;  // Error found here
    self.barChart.titleDisplacement = CGPointMake(0.0f, -10.0f);
    self.barChart.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.barChart.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    x.axisLineStyle = nil;
    x.majorTickLineStyle = nil;
    x.minorTickLineStyle = nil;
    x.majorIntervalLength = CPTDecimalFromString(@"10");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    x.title = @"Names";
    x.titleLocation = CPTDecimalFromFloat(7.5f);
    x.titleOffset = 25.0f;
    
    // Define some custom labels for the data elements
    x.labelRotation = M_PI/5;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    
    NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:0], [NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:2], [NSDecimalNumber numberWithInt:3], [NSDecimalNumber numberWithInt:4], nil];
    
    
    NSArray *xAxisLabels = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil];
    NSUInteger labelLocation = 0;
    
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
    for (NSNumber *tickLocation in customTickLocations)
    {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI/xAxisLength;
        [customLabels addObject:newLabel];
    }
    
    x.axisLabels =  [NSSet setWithArray:customLabels];
    
    CPTXYAxis *y = axisSet.yAxis;
    y.axisLineStyle = nil;
    y.majorTickLineStyle = nil;
    y.minorTickLineStyle = nil;
    y.majorIntervalLength = CPTDecimalFromString(@"50");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    y.title = @"Work Status";
    y.titleOffset = 40.0f;
    y.titleLocation = CPTDecimalFromFloat(150.0f);
    
    CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
    hostingView.hostedGraph = self.barChart;
    [self.view addSubview:hostingView];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) self.barChart.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0f) length:CPTDecimalFromDouble(16.0f)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0f) length:CPTDecimalFromDouble(500.0f)];
    
//    CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
//    barPlot.plotRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(10)];//xAxisLength
//    barPlot.barOffset = CPTDecimalFromFloat(0.25f);
//    barPlot.baseValue = CPTDecimalFromString(@"0");
//    barPlot.barWidth = CPTDecimalFromFloat(10.0f);
//    barPlot.cornerRadius = 2.0f;
//    barPlot.dataSource = self;
//
//    [self.barChart addPlot:barPlot];
    
    [self animateNow];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animation stopped");
    
}

- (void) animateNow
{
    CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    barPlot.plotRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromDouble(10)];//xAxisLength
    barPlot.barOffset = CPTDecimalFromFloat(0.25f);
    barPlot.baseValue = CPTDecimalFromString(@"0");
    barPlot.barWidth = CPTDecimalFromFloat(10.0f);
    barPlot.cornerRadius = 2.0f;
    barPlot.dataSource = self;

    //adding animation here
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    [anim setDuration:2.0f];
    anim.toValue = [NSNumber numberWithFloat:1];
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    
    
    barPlot.anchorPoint = CGPointMake(0.0, 0.0);
    [barPlot addAnimation:anim forKey:@"grow"];
    [self.barChart addPlot:barPlot ];// IMPORTANT here I added the plot data to the graph :) .
}


-(void) getGraphValues
{
    int barValues [] = {10,50,100,200};//,150,200,10,20,30,40,50,100,400,450,350
        
    self.sampleArray = [[NSMutableArray alloc] initWithObjects:nil];
    
    for (int i = 0; i < 4; i++)
    {
        double y = barValues[i];
        NSLog(@"XVal : %@", X_VAL);
        NSDictionary *sample = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithDouble:30],X_VAL,[NSNumber numberWithDouble:y],Y_VAL,nil];
        [self.sampleArray addObject:sample];
    }
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.sampleArray count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDictionary *sample = [self.sampleArray objectAtIndex:index];
    
    
    if (fieldEnum == CPTScatterPlotFieldX)
        return [sample valueForKey:X_VAL];
    else
        return [sample valueForKey:Y_VAL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
