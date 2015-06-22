//
//  OverViewTableViewController.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/21.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "OverViewTableViewController.h"
#import "UITableView+Helper.h"
#import "UIColor+Custom.h"
#import "SAEvent.h"
#import "UIViewExt.h"

@interface OverViewTableViewController ()

@end

@implementation OverViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView hideExtraCellLine];
    self.title = @"迭代概览";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor customColorDefault];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor customColorDefault];
    
    // Hide the shadow of navBar
    for (UIView *view in [[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 200.0f;
    }
    else
    {
        return 0.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *scoreHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth ,200.0f)];
    scoreHeaderView.backgroundColor = [UIColor customColorDefault];
    
    UILabel *sprintTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, ScreenWidth - 20.0f, 11.0f)];
    sprintTitleLabel.text = [NSString stringWithFormat:@"您当前处于第%ld个迭代",[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    sprintTitleLabel.font = [UIFont systemFontOfSize:11.0f];
    sprintTitleLabel.textColor = [UIColor whiteColor];
    sprintTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [scoreHeaderView addSubview:sprintTitleLabel];
    return scoreHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OverViewTableCell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OverViewTableCell"];
    }
    cell.backgroundColor = [UIColor customColorDefault];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
