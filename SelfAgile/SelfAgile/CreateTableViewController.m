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
#import "CusPickerView.h"
#import "NSDate+Helper.h"

#define duedateTag 10001
#define titleTag 10002
#define contentTag 10003
#define levelTag 10004

@interface CreateTableViewController () <UITextFieldDelegate,UITextViewDelegate,ResizeFrameDelegate>
@property (nonatomic,strong) UITextField *dueDateInputView;
@property (nonatomic,strong) UITextField *titleInputView;
@property (nonatomic,strong) UITextView *contentInputView;
@property (nonatomic,strong) UITextField *levelInputView;

@property(nonatomic, strong) CusPickerView *cus;
@property(nonatomic, strong) CusPickerView *cusLevel;
@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView hideExtraCellLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor customColorDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UITextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
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
    [self.navigationController.navigationBar setTranslucent:YES];
    
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
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth,2.0f)];
                topLine.backgroundColor = [UIColor customColorDefault];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 80.0f, 38.0f)];
                titleLabel.text = @"DueDate";
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.textColor = [UIColor customColorDefault];
                titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                self.dueDateInputView = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, 38.0f)];
                _dueDateInputView.tag = duedateTag;
                _dueDateInputView.delegate = self;
                _dueDateInputView.borderStyle = UITextBorderStyleNone;
                _dueDateInputView.placeholder = @"先选择您这项任务的最后期限日期";
                _dueDateInputView.textColor = [UIColor lightGrayColor];
                _dueDateInputView.font = [UIFont systemFontOfSize:15.0f];
                
                [cell.contentView addSubview:self.dueDateInputView];
                [cell.contentView addSubview:titleLabel];
                [cell.contentView addSubview:topLine];
            }
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
                topLine.backgroundColor = [UIColor customColorDefault];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 80.0f, 38.0f)];
                titleLabel.text = @"Title";
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.textColor = [UIColor customColorDefault];
                titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                self.titleInputView = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, 38.0f)];
                _titleInputView.tag = titleTag;
                _titleInputView.delegate = self;
                _titleInputView.borderStyle = UITextBorderStyleNone;
                _titleInputView.placeholder = @"取个雄心壮志的标题,别超过15个字哦";
                _titleInputView.textColor = [UIColor lightGrayColor];
                _titleInputView.font = [UIFont systemFontOfSize:15.0f];
                
                [cell.contentView addSubview:_titleInputView];
                [cell.contentView addSubview:titleLabel];
                [cell.contentView addSubview:topLine];
            }
            return cell;
        }
            break;
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
                topLine.backgroundColor = [UIColor customColorDefault];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 80.0f, 38.0f)];
                titleLabel.text = @"Content";
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.textColor = [UIColor customColorDefault];
                titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                self.contentInputView = [[UITextView alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, 278.0f)];
                _contentInputView.tag = contentTag;
                _contentInputView.delegate = self;
                _contentInputView.textColor = [UIColor lightGrayColor];//colorWithRed:0.0f green:0.0f blue:0.098f alpha:0.22f];
                _contentInputView.font = [UIFont systemFontOfSize:15.0f];
                _contentInputView.contentInset = UIEdgeInsetsMake(0.0, -3.0, 0.0, 0.0);
                
                [cell.contentView addSubview:_contentInputView];
                [cell.contentView addSubview:titleLabel];
                [cell.contentView addSubview:topLine];
            }
            return cell;
        }
            break;
        case 3:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"levelTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
                topLine.backgroundColor = [UIColor customColorDefault];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 80.0f, 38.0f)];
                titleLabel.text = @"Level";
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.textColor = [UIColor customColorDefault];
                titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                self.levelInputView = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, 38.0f)];
                _levelInputView.tag = levelTag;
                _levelInputView.delegate = self;
                _levelInputView.borderStyle = UITextBorderStyleNone;
                _levelInputView.placeholder = @"为您的任务挑选一个优先级吧";
                _levelInputView.textColor = [UIColor lightGrayColor];
                _levelInputView.font = [UIFont systemFontOfSize:15.0f];
                
                [cell.contentView addSubview:_levelInputView];
                [cell.contentView addSubview:titleLabel];
                [cell.contentView addSubview:topLine];
            }
            return cell;
        }
            break;
        case 4:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoneTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DoneTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 3.0f, ScreenWidth, 14.0f)];
                guideLabel.font = [UIFont systemFontOfSize:12.0f];
                guideLabel.textColor = [UIColor whiteColor];
                guideLabel.textAlignment = NSTextAlignmentCenter;
                guideLabel.text = @"完成请点击右上角钩号提交，放弃从左上角回到之前的页面";
                
                [cell.contentView addSubview:guideLabel];
                }
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    if(_cus)
    {
        [_cus hiddenView];
    }
    
    if(_cusLevel)
    {
        [_cusLevel hiddenView];
    }
}

- (IBAction)cancelCreate:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishEditing:(id)sender
{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView.tag != contentTag)
    {
        return;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView.tag != contentTag)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.markedTextRange==nil)
    {
        return;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if(textView.markedTextRange==nil)
    {
        return YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == duedateTag) {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        if (_cus == nil) {
            _cus = [[CusPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) andOptions:nil andType:1 andToolBarTitle:@""];
            
            _cus.resizeFrameDelegate = self;
            [_cus setTag:102];
        }
        NSDate *date = [DateHelper getFormatterDateFromString:textField.text andFormatter:@"yyyy-MM-dd"];
        if (date) {
            [(UIDatePicker *)[_cus viewWithTag:CusPickerDateTag] setDate:date animated:YES];
        } else {
            [(UIDatePicker *)[_cus viewWithTag:CusPickerDateTag] setDate:[NSDate dateFromString:@"2015-06-12" withFormat:[NSDate dateFormatString]] animated:YES];
        }
        
        if(_cusLevel)
        {
            [_cusLevel hiddenView];
        }
        
        [_cus showViewInSuperView:self.view];
        return NO;
    }
    else if(textField.tag == levelTag)
    {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        if(_cusLevel == nil)
        {
            NSMutableArray *options = [NSMutableArray arrayWithObjects:@"Urgent",@"Normal",@"Take it easy",nil];
            _cusLevel = [[CusPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) andOptions:options andType:PickerTypeStandard andToolBarTitle:@""];
            
            _cusLevel.resizeFrameDelegate = self;
            [_cusLevel setTag:103];
        }
        
        [(UIPickerView *)[_cusLevel viewWithTag:PickerViewTag] selectRow:0 inComponent:0 animated:YES];
        
        if(_cus)
        {
            [_cus hiddenView];
        }
        
        [_cusLevel showViewInSuperView:self.view];
        return NO;
    }
    else
    {
        if(_titleInputView.markedTextRange == nil)
        {
            if([_titleInputView.text length] > 15)
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
        return YES;
    }
}

- (void)UITextFieldDidChange:(NSNotification *)notification
{
    if(_titleInputView.markedTextRange == nil)
    {
        NSMutableString *newText = [_titleInputView.text mutableCopy];
        if([_titleInputView.text length] > 15)
        {
            _titleInputView.text = [newText substringWithRange:NSMakeRange(0, 15)];
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag != titleTag)
    {
        return NO;
    }
    
    if(textField.markedTextRange == nil)
    {
        NSMutableString *newText = [textField.text mutableCopy];
        [newText replaceCharactersInRange:range withString:string];
        
        if ([string length] != 0 && [newText length] > 15) {
            textField.text = [newText substringWithRange:NSMakeRange(0, 30)];
            return NO;
        }else
        {
            return YES;
        }
    }
    return YES;
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
