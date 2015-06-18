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
#import "SAEvent.h"
#import "TWMessageBarManager.h"

#define duedateTag 10001
#define titleTag 10002
#define contentTag 10003
#define levelTag 10004
#define pointTag 10005

#define ScreenBottomPadding 150.0f
@interface CreateTableViewController () <UITextFieldDelegate,UITextViewDelegate,ResizeFrameDelegate,PickerViewReloadCellDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITextField *dueDateInputView;
@property (nonatomic,strong) UITextField *titleInputView;
@property (nonatomic,strong) UITextView *contentInputView;
@property (nonatomic,strong) UITextField *levelInputView;
@property (nonatomic,strong) UITextField *pointInputView;

@property(nonatomic, strong) CusPickerView *cus;
@property(nonatomic, strong) CusPickerView *cusLevel;
@property(nonatomic, strong) CusPickerView *cusPoints;

@end

@implementation CreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView hideExtraCellLine];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor customColorDefault];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UITextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
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
        return (ScreenHeight - 200.0f - ScreenBottomPadding);
    else if(indexPath.row == 3)
        return 60.0f;
    else if(indexPath.row == 4)
        return 60.0f;
    else if(indexPath.row == 5)
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
    return 6;
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
                _dueDateInputView.placeholder = @"选择最后期限日期";
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
                _titleInputView.placeholder = @"取个雄心壮志的标题";
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
                
                self.contentInputView = [[UITextView alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, ScreenHeight - 200.0f - ScreenBottomPadding -2.0f - 20.0f)];
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
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pointTableViewCell"];
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pointTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentView.backgroundColor = [UIColor whiteColor];
                UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,ScreenWidth , 2.0f)];
                topLine.backgroundColor = [UIColor customColorDefault];
                
                UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 12.0f, 80.0f, 38.0f)];
                titleLabel.text = @"Points";
                titleLabel.textAlignment = NSTextAlignmentRight;
                titleLabel.textColor = [UIColor customColorDefault];
                titleLabel.font = [UIFont systemFontOfSize:15.0f];
                
                self.pointInputView = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right + 10.0f, titleLabel.top, ScreenWidth - titleLabel.right - 25.0f, 38.0f)];
                _pointInputView.tag = pointTag;
                _pointInputView.delegate = self;
                _pointInputView.borderStyle = UITextBorderStyleNone;
                _pointInputView.placeholder = @"为您的任务估计一个点数";
                _pointInputView.textColor = [UIColor lightGrayColor];
                _pointInputView.font = [UIFont systemFontOfSize:15.0f];
                
                [cell.contentView addSubview:_pointInputView];
                [cell.contentView addSubview:titleLabel];
                [cell.contentView addSubview:topLine];
            }
            return cell;
        }
            break;
        case 5:
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
    
    if(_cusPoints)
    {
        [_cusPoints hiddenView];
    }
}

#pragma mark - UI Action
- (IBAction)cancelCreate:(id)sender
{
    if(![self.dueDateInputView.text isEqualToString:@""] ||![self.titleInputView.text isEqualToString:@""]||![self.contentInputView.text isEqualToString:@""]||![self.levelInputView.text isEqualToString:@""])
    {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"您有尚未保存的卡片，是否要丢弃您所做的编辑？" delegate:self cancelButtonTitle:@"返回" destructiveButtonTitle:@"不保存返回" otherButtonTitles:nil];
        sheet.tintColor = [UIColor customColorDefault];
        [sheet showInView:self.view];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // is this necessary?
        self.cus = nil;
        self.cusLevel = nil;
        self.dueDateInputView = nil;
        self.titleInputView = nil;
        self.contentInputView = nil;
        self.pointInputView = nil;
        self.levelInputView = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        return;
    }
}

- (IBAction)finishEditing:(id)sender
{
    if(![self.dueDateInputView.text isEqualToString:@""] && ![self.titleInputView.text isEqualToString:@""] && ![self.contentInputView.text isEqualToString:@""] && ![self.levelInputView.text isEqualToString:@""])
    {
        NSNumber *sprintNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"sprintNum"];
        
        NSNumber *levelValue = nil;
        if([self.levelInputView.text isEqualToString:@"Urgent"])
        {
            levelValue = [NSNumber numberWithInt:2];
        }
        else if([self.levelInputView.text isEqualToString:@"Normal"])
        {
            levelValue = [NSNumber numberWithInt:1];
        }
        else
        {
            levelValue = [NSNumber numberWithInt:0];
        }
        
        NSDictionary *eventData = [NSDictionary dictionaryWithObjects:@[self.titleInputView.text,self.contentInputView.text,levelValue,self.dueDateInputView.text,sprintNum] forKeys:@[@"title",@"content",@"level",@"endDate",@"sprintNum"]];
        
        // this method will return a boolean value, decide whether to save draft or not
        [SAEvent createEvents:eventData];
        
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Congratulations!"
                                                       description:@"成功创建卡片"
                                                              type:TWMessageBarMessageTypeSuccess];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Notice"
                                                       description:@"您还有未填写的内容，请填写完再提交"
                                                              type:TWMessageBarMessageTypeInfo];
    }
}

#pragma mark - UITextView delegate
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

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == duedateTag) {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        if (_cus == nil) {
            _cus = [[CusPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) andOptions:nil andType:1 andToolBarTitle:@""];
            _cus.delegate = self;
            _cus.resizeFrameDelegate = self;
            [_cus setTag:102];
        }
        NSDate *date = [DateHelper getFormatterDateFromString:textField.text andFormatter:@"yyyy-MM-dd"];
        if (date) {
            [(UIDatePicker *)[_cus viewWithTag:CusPickerDateTag] setDate:date animated:YES];
        } else {
            [(UIDatePicker *)[_cus viewWithTag:CusPickerDateTag] setDate:[NSDate date] animated:YES];
        }
        
        if(_cusLevel)
        {
            [_cusLevel hiddenView];
        }
        
        if(_cusPoints)
        {
            [_cusPoints hiddenView];
        }
        
        [_cus showViewInSuperView:self.view];
        return NO;
    }
    else if(textField.tag == levelTag)
    {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        NSMutableArray *options = [NSMutableArray arrayWithObjects:@"Urgent",@"Normal",@"Take it easy",nil];
        if(_cusLevel == nil)
        {
            _cusLevel = [[CusPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) andOptions:options andType:PickerTypeStandard andToolBarTitle:@""];
            _cusLevel.delegate = self;
            _cusLevel.resizeFrameDelegate = self;
            [_cusLevel setTag:103];
        }
        NSUInteger index = [options indexOfObject:textField.text] == NSNotFound ? 0 : [options indexOfObject:textField.text];
        
        [(UIPickerView *)[_cusLevel viewWithTag:PickerViewTag] selectRow:index inComponent:0 animated:YES];
        
        if(_cus)
        {
            [_cus hiddenView];
        }
        
        if(_cusPoints)
        {
            [_cusPoints hiddenView];
        }
        
        [_cusLevel showViewInSuperView:self.view];
        return NO;
    }
    else if(textField.tag == pointTag)
    {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        NSMutableArray *options = [NSMutableArray arrayWithObjects:@"2",@"3",@"5",@"8",@"12",nil];
        if(_cusPoints == nil)
        {
            _cusPoints = [[CusPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) andOptions:options andType:PickerTypeStandard andToolBarTitle:@""];
            _cusPoints.delegate = self;
            _cusPoints.resizeFrameDelegate = self;
            [_cusPoints setTag:104];
        }
        NSUInteger index = [options indexOfObject:textField.text] == NSNotFound ? 0 : [options indexOfObject:textField.text];
        
        [(UIPickerView *)[_cusPoints viewWithTag:PickerViewTag] selectRow:index inComponent:0 animated:YES];
        
        if(_cus)
        {
            [_cus hiddenView];
        }
        
        if(_cusLevel)
        {
            [_cusLevel hiddenView];
        }
        
        [_cusPoints showViewInSuperView:self.view];
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
            textField.text = [newText substringWithRange:NSMakeRange(0, 15)];
            return NO;
        }else
        {
            return YES;
        }
    }
    return YES;
}

#pragma mark - CusPickerView delegate
- (void) pickerView:(CusPickerView *)pickerView returnDataAndRefeshCellWithSelectValue:(NSString *)selectValue
{
    if(pickerView.tag == 102)
    {
        if(selectValue == nil)
        {
            self.dueDateInputView.text = [DateHelper getFormatterDateStringFromDate:[NSDate date] andFormatter:@"yyyy-MM-dd"];
            return;
        }
        
        self.dueDateInputView.text = selectValue;
    }
    else if(pickerView.tag == 103)
    {
        self.levelInputView.text = selectValue;
    }
    else if(pickerView.tag == 104)
    {
        self.pointInputView.text = selectValue;
    }
    else
    {
        return;
    }
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
