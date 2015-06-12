//
//  CreateTableViewController.m
//  SelfAgile
//
//  Created by chen Yuheng on 15/6/12.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "CreateTableViewController.h"
#import "UIColor+Custom.h"
#import "UIViewExt.h"
#import "UITableView+Helper.h"

@interface CreateTableViewController ()
@property (nonatomic,strong) UITextView *dueDateInputView;
@property (nonatomic,strong) UITextView *titleInputView;
@property (nonatomic,strong) UITextView *contentInputView;
@property (nonatomic,strong) UITextView *levelInputView;
@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView hideExtraCellLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor customColorDefault];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setTintColor:[UIColor customColorDefault]];
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

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <=1)
        return 60.0f;
    else if(indexPath.row == 2)
        return 300.0f;
    else if(indexPath.row == 3)
        return 60.0f;
    else if(indexPath.row == 4)
        return 20.0f;
    else
        return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch(indexPath.row)
    {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dueDateTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dueDateTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
            topLine.backgroundColor = [UIColor customColorDefault];
            [cell.contentView addSubview:topLine];
            
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
            topLine.backgroundColor = [UIColor customColorDefault];
            [cell.contentView addSubview:topLine];
            
            return cell;
        }
            break;
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
            topLine.backgroundColor = [UIColor customColorDefault];
            [cell.contentView addSubview:topLine];
            return cell;
        }
            break;
        case 3:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"levelTableViewCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
            topLine.backgroundColor = [UIColor customColorDefault];
            [cell.contentView addSubview:topLine];
            return cell;
        }
            break;
        case 4:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DoneTableViewCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 3.0f, ScreenWidth, 14.0f)];
            guideLabel.font = [UIFont systemFontOfSize:12.0f];
            guideLabel.textColor = [UIColor whiteColor];
            guideLabel.textAlignment = NSTextAlignmentCenter;
            guideLabel.text = @"完成请点击右上角钩号提交，放弃从左上角回到之前的页面";
            
            [cell.contentView addSubview:guideLabel];
            return cell;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

- (IBAction)cancelCreate:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishEditing:(id)sender
{
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
