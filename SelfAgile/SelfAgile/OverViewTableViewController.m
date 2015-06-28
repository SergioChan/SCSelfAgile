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
#import "StringConstant.h"

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
        return 300.0f;
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
    sprintTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *ToDoLabel = [[UIView alloc]initWithFrame:CGRectMake(15.0f, sprintTitleLabel.bottom + 10.0f, (ScreenWidth - 50.0f)/3.0f, 120.0f)];
    UIView *DoingLabel = [[UIView alloc]initWithFrame:CGRectMake(ToDoLabel.right + 10.0f, sprintTitleLabel.bottom + 10.0f, (ScreenWidth - 50.0f)/3.0f, 120.0f)];
    UIView *DoneLabel = [[UIView alloc]initWithFrame:CGRectMake(DoingLabel.right + 10.0f, sprintTitleLabel.bottom + 10.0f, (ScreenWidth - 50.0f)/3.0f, 120.0f)];
    ToDoLabel.backgroundColor = [UIColor clearColor];
    DoingLabel.backgroundColor = [UIColor clearColor];
    DoneLabel.backgroundColor = [UIColor clearColor];
    
    UIView *seperatorView_1 = [[UIView alloc]initWithFrame:CGRectMake(ToDoLabel.width + 5.0f, 0.0f, 0.5f, ToDoLabel.height)];
    seperatorView_1.backgroundColor = [UIColor whiteColor];
    [ToDoLabel addSubview:seperatorView_1];
    
    UIView *seperatorView_2 = [[UIView alloc]initWithFrame:CGRectMake(-5.0f, 0.0f, 0.5f, DoneLabel.height)];
    seperatorView_2.backgroundColor = [UIColor whiteColor];
    [DoneLabel addSubview:seperatorView_2];
    
    //title label for todo
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(((ScreenWidth - 50.0f)/3.0f - 50.0f)/2.0f, 5.0f, 50.0f, 15.0f)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLabel.text = @"未完成";
    [ToDoLabel addSubview:titleLabel];
    
    //card number label for todo
    UILabel *todoCardNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, titleLabel.bottom + 10.0f, ToDoLabel.width, 50.0f)];
    todoCardNumberLabel.textColor = [UIColor whiteColor];
    todoCardNumberLabel.textAlignment = NSTextAlignmentCenter;
    todoCardNumberLabel.font = [UIFont fontWithName:DefaultNumberFont size:50.0f];
    NSString *numberToShow = @"0";
    NSInteger tmp_numberToShow = [SAEvent getCurrentSprintTodoCardCount:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow >= 100)
    {
        numberToShow = @"99+";
    }
    else
    {
        numberToShow = [NSString stringWithFormat:@"%ld",tmp_numberToShow];
    }
    
    todoCardNumberLabel.text = numberToShow;
    [ToDoLabel addSubview:todoCardNumberLabel];
    
    UILabel *todoCardPointLabel = [[UILabel alloc]initWithFrame:CGRectMake((ToDoLabel.width - 70.0f)/2.0f, todoCardNumberLabel.bottom + 10.0f, 70.0f, 30.0f)];
    todoCardPointLabel.textAlignment = NSTextAlignmentCenter;
    todoCardPointLabel.font = [UIFont fontWithName:DefaultNumberFont size:25.0f];
    todoCardPointLabel.textColor = [UIColor whiteColor];
    todoCardPointLabel.backgroundColor = [UIColor customColorGreen];
    todoCardPointLabel.clipsToBounds = YES;
    todoCardPointLabel.layer.cornerRadius = 6.0f;
    
    //todo point -----------------------------------
    NSString *numberToShow_todoPoint = @"0";
    NSInteger tmp_numberToShow_todoPoint = [SAEvent getCurrentSprintTodoPointTotal:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow_todoPoint >= 1000)
    {
        numberToShow_todoPoint = @"999+";
    }
    else
    {
        numberToShow_todoPoint = [NSString stringWithFormat:@"%ld",tmp_numberToShow_todoPoint];
    }
    todoCardPointLabel.text = numberToShow_todoPoint;
    //-----------------------------------
    
    [ToDoLabel addSubview:todoCardPointLabel];
    
    //title label for doing
    UILabel *titleLabel_2 = [[UILabel alloc]initWithFrame:CGRectMake(((ScreenWidth - 50.0f)/3.0f - 50.0f)/2.0f, 5.0f, 50.0f, 15.0f)];
    titleLabel_2.textAlignment = NSTextAlignmentCenter;
    titleLabel_2.textColor = [UIColor whiteColor];
    titleLabel_2.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLabel_2.text = @"进行中";
    [DoingLabel addSubview:titleLabel_2];
    
    //card number label for doing
    UILabel *doingCardNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, titleLabel_2.bottom + 10.0f, DoingLabel.width, 50.0f)];
    doingCardNumberLabel.textColor = [UIColor whiteColor];
    doingCardNumberLabel.textAlignment = NSTextAlignmentCenter;
    doingCardNumberLabel.font = [UIFont fontWithName:DefaultNumberFont size:50.0f];
    NSString *numberToShow_2 = @"0";
    NSInteger tmp_numberToShow_2 = [SAEvent getCurrentSprintDoingCardCount:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow_2 >= 100)
    {
        numberToShow_2 = @"99+";
    }
    else
    {
        numberToShow_2 = [NSString stringWithFormat:@"%ld",tmp_numberToShow_2];
    }
    
    doingCardNumberLabel.text = numberToShow_2;
    [DoingLabel addSubview:doingCardNumberLabel];
    
    UILabel *doingCardPointLabel = [[UILabel alloc]initWithFrame:CGRectMake((ToDoLabel.width - 70.0f)/2.0f, todoCardNumberLabel.bottom + 10.0f, 70.0f, 30.0f)];
    doingCardPointLabel.textAlignment = NSTextAlignmentCenter;
    doingCardPointLabel.font = [UIFont fontWithName:DefaultNumberFont size:25.0f];
    doingCardPointLabel.textColor = [UIColor whiteColor];
    doingCardPointLabel.backgroundColor = [UIColor customColorGreen];
    doingCardPointLabel.clipsToBounds = YES;
    doingCardPointLabel.layer.cornerRadius = 6.0f;
    
    //doing point -----------------------------------
    NSString *numberToShow_doingPoint = @"0";
    NSInteger tmp_numberToShow_doingPoint = [SAEvent getCurrentSprintDoingPointTotal:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow_doingPoint >= 1000)
    {
        numberToShow_doingPoint = @"999+";
    }
    else
    {
        numberToShow_doingPoint = [NSString stringWithFormat:@"%ld",tmp_numberToShow_doingPoint];
    }
    doingCardPointLabel.text = numberToShow_doingPoint;
    //-----------------------------------
    
    [DoingLabel addSubview:doingCardPointLabel];
    
    //title label for done
    UILabel *titleLabel_3 = [[UILabel alloc]initWithFrame:CGRectMake(((ScreenWidth - 50.0f)/3.0f - 50.0f)/2.0f, 5.0f, 50.0f, 15.0f)];
    titleLabel_3.textAlignment = NSTextAlignmentCenter;
    titleLabel_3.textColor = [UIColor whiteColor];
    titleLabel_3.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLabel_3.text = @"已完成";
    [DoneLabel addSubview:titleLabel_3];
    
    //card number label for done
    UILabel *doneCardNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, titleLabel_3.bottom + 10.0f, DoneLabel.width, 50.0f)];
    doneCardNumberLabel.textColor = [UIColor whiteColor];
    doneCardNumberLabel.textAlignment = NSTextAlignmentCenter;
    doneCardNumberLabel.font = [UIFont fontWithName:DefaultNumberFont size:50.0f];
    NSString *numberToShow_3 = @"0";
    NSInteger tmp_numberToShow_3 = [SAEvent getCurrentSprintDoneCardCount:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow_3 >= 100)
    {
        numberToShow_3 = @"99+";
    }
    else
    {
        numberToShow_3 = [NSString stringWithFormat:@"%ld",tmp_numberToShow_3];
    }
    
    doneCardNumberLabel.text = numberToShow_3;
    [DoneLabel addSubview:doneCardNumberLabel];
    
    UILabel *doneCardPointLabel = [[UILabel alloc]initWithFrame:CGRectMake((ToDoLabel.width - 70.0f)/2.0f, todoCardNumberLabel.bottom + 10.0f, 70.0f, 30.0f)];
    doneCardPointLabel.textAlignment = NSTextAlignmentCenter;
    doneCardPointLabel.font = [UIFont fontWithName:DefaultNumberFont size:25.0f];
    doneCardPointLabel.textColor = [UIColor whiteColor];
    doneCardPointLabel.backgroundColor = [UIColor customColorGreen];
    doneCardPointLabel.clipsToBounds = YES;
    doneCardPointLabel.layer.cornerRadius = 6.0f;
    
    //done point -----------------------------------
    NSString *numberToShow_donePoint = @"0";
    NSInteger tmp_numberToShow_donePoint = [SAEvent getCurrentSprintDonePointTotal:[[[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"] integerValue]];
    
    if(tmp_numberToShow_donePoint >= 1000)
    {
        numberToShow_donePoint = @"999+";
    }
    else
    {
        numberToShow_donePoint = [NSString stringWithFormat:@"%ld",tmp_numberToShow_donePoint];
    }
    doneCardPointLabel.text = numberToShow_donePoint;
    //-----------------------------------
    
    [DoneLabel addSubview:doneCardPointLabel];
    
    [scoreHeaderView addSubview:sprintTitleLabel];
    [scoreHeaderView addSubview:ToDoLabel];
    [scoreHeaderView addSubview:DoingLabel];
    [scoreHeaderView addSubview:DoneLabel];
    
    UILabel *titleLabel_total = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, ToDoLabel.bottom + 10.0f, ScreenWidth, 15.0f)];
    titleLabel_total.textAlignment = NSTextAlignmentCenter;
    titleLabel_total.textColor = [UIColor whiteColor];
    titleLabel_total.font = [UIFont boldSystemFontOfSize:14.0f];
    titleLabel_total.text = @"总共";
    [scoreHeaderView addSubview:titleLabel_total];
    
    return scoreHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0f;
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
        cell.backgroundColor = [UIColor whiteColor];
        UIView *seperatorView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, 5.0f)];
        seperatorView.backgroundColor = [UIColor customColorDefault];
        UIView *seperatorView_1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 145.0f, ScreenWidth, 5.0f)];
        seperatorView_1.backgroundColor = [UIColor customColorDefault];
        [cell.contentView addSubview:seperatorView];
        [cell.contentView addSubview:seperatorView_1];
    }
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
