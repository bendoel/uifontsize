//
//  FirstViewController.m
//  UIFontsize
//
//  Created by albertus dio padmadharma on 8/6/17.
//  Copyright © 2017 debouraq. All rights reserved.
//

#import "FirstViewController.h"
#import "UFDynamicTableViewCell.h"

@interface FirstViewController ()
{
    NSArray *arrayFontSize;
    IBOutlet UITableView *tableFontSize;
    
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrayFontSize = @[@9, @10, @12, @14, @16, @18, @20, @24, @26, @32, @44];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(arrayFontSize.count > 0)
        return arrayFontSize.count;
    else
        return 1; 
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UFDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FontCellIdentifier" forIndexPath:indexPath];
    
    NSNumber *fontSize = arrayFontSize[indexPath.row];
    [self setupCell:cell atIndexPath:indexPath withFontSize:[fontSize floatValue]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static UFDynamicTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"FontCellIdentifier"];
    });
    
    NSNumber *fontSize = arrayFontSize[indexPath.row];
    [self setupCell:cell atIndexPath:indexPath withFontSize:[fontSize floatValue]];
    
    return [self calculateHeightForConfiguredSizingCell:cell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void) setupCell: (UFDynamicTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withFontSize:(CGFloat )fontSize
{
    cell.TextLabel.text = [NSString stringWithFormat:@"%d", [arrayFontSize[indexPath.row] intValue]];
    [cell.TextLabel setFont:[UIFont systemFontOfSize:fontSize]];
}

@end
