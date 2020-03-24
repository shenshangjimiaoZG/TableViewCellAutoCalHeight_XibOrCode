#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "InfoTableViewCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *infoTable;
@property (nonatomic,copy)NSString *desc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.infoTable=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.infoTable.dataSource=self;
    self.infoTable.delegate=self;
    [self.infoTable registerNib:[UINib nibWithNibName:kInfoTableViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kInfoTableViewCell];
    
    [self.view addSubview:self.infoTable];
    
    [self.infoTable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.desc=@"I'm hurting, baby, I'm broken down I need your loving, loving, I need it now When I'm without you I'm something weak You got me beggingBegging, I'm on my kneesI don't wanna be needing your love I just wanna be deep in your love And it's killing me when you're away Ooh, baby,'Cause I really don't care where you are I just wanna be there where you are And I gotta get one little taste Your sugar Yes, please======end";
    
    if(@available(iOS 11,*))
    {
        self.infoTable.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}
#pragma mark table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf=self;
    
    return [InfoTableViewCell hyb_heightForTableView:tableView cellType:Cell_XIB config:^(UITableViewCell *sourceCell) {
        InfoTableViewCell *cell=(InfoTableViewCell*)sourceCell;
        [cell setDesc:weakSelf.desc];
    } cache:^NSDictionary *{
        
        return @{kHYBCacheUniqueKey:@"sugur",kHYBCacheStateKey:@"see you again",kHYBRecalculateForStateKey:@(YES)};
    }];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kInfoTableViewCell];
    if(cell==nil)
    {
        cell=[[NSBundle mainBundle]loadNibNamed:kInfoTableViewCell owner:self options:nil].lastObject;
    }
    [cell setDesc:self.desc];
    
    return cell;
}
@end
