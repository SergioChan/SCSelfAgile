//
//  MainViewController.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/9.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "MainViewController.h"
#import "PullToReact.h"
#import "MentionPullToReactView.h"
#import "UITableView+Helper.h"
#import "UIImage+Helper.h"
#import "SAEvent.h"
#import "UIColor+Custom.h"
#import "UIViewExt.h"

#import "SADoingTableViewCell.h"
#import "SADoneTableViewCell.h"
#import "SAToDoTableViewCell.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) MNTPullToReactControl *reactControl;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic) NSInteger selectedIndex;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"S#1:My First Sprint";
    _data = [NSMutableArray arrayWithArray:@[@"To do", @"Doing", @"Done"]];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor customColorDefault];
    [self.tableView hideExtraCellLine];
    self.tableView.backgroundColor = [UIColor customColorDefault];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.reactControl = [[MNTPullToReactControl alloc] initWithNumberOfActions:MentionPullToReactViewNumberOfAction];
    self.reactControl.threshold = 90;
    self.reactControl.contentView = [[MentionPullToReactView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [self.reactControl addTarget:self action:@selector(reaction:) forControlEvents:UIControlEventValueChanged];
    self.tableView.reactControl = self.reactControl;
    self.selectedIndex = 0;
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewEvent)];
    add.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = add;
    //[SAEvent createEvents:[NSDictionary dictionaryWithObjects:@[@"Hello world!",@"This is my first event",[NSNumber numberWithInt:1],[NSNumber numberWithInt:0]] forKeys:@[@"title",@"content",@"level",@"sprintNum"]]];
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor customColorDefault]];
    
    // Hide the shadow of navBar
    for (UIView *view in [[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(self.selectedIndex)
    {
        case -1:
        case 0:
        {
            SAToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoTableViewCell"];
            if(!cell)
            {
                cell = [[SAToDoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"todoTableViewCell"];
            }
            
            return cell;
        }
            break;
        case 1:
        {
            SADoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoingTableViewCell"];
            if(!cell)
            {
                cell = [[SADoingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DoingTableViewCell"];
            }
            
            return cell;
        }
            break;
        case 2:
        {
            SADoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneTableViewCell"];
            if(!cell)
            {
                cell = [[SADoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DoneTableViewCell"];
            }
            
            return cell;
        }
            break;
        default:
        {
            SAToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todoTableViewCell"];
            if(!cell)
            {
                cell = [[SAToDoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"todoTableViewCell"];
            }
            
            cell.textLabel.text = @"test1";
            return cell;
        }
            break;
    }
}

#pragma mark - Pull to react target-action method
- (void)reaction:(id)sender
{
    MNTPullToReactControl *reactControl = (MNTPullToReactControl *)sender;
    if(reactControl.action < 1 || reactControl.action > 3)
    {
        return;
    }
    
    NSLog(@"Doing action %ld", (long)reactControl.action);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectedIndex = reactControl.action - 1;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
//            usleep(1100 * 1000);
            [reactControl endAction:reactControl.action];
        });
    });
}

#pragma mark - Private
- (void)doAction:(NSInteger)action
{
    [self.reactControl beginAction:action];
    NSLog(@"Do action %ld", (long)action);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        usleep(10 * 1000);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.reactControl endAction:action];
        });
    });
}

#pragma mark - Create new event
- (void)addNewEvent
{
    NSLog(@"hey");
    [self performSegueWithIdentifier:@"CreateNewEvent" sender:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
