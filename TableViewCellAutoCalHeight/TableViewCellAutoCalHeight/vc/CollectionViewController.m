#import "CollectionViewController.h"
#import "UICollectionViewCell+HPMasonryAutoCellHeight.h"
#import "InfoCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "CollectionReusableHeadView.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)NSString *desc;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"collectionviewcell自动计算高度缓存";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.collectionViewLayout=layout;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:kInfoCollectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kInfoCollectionViewCell];
    
    [self.collectionView registerClass:[CollectionReusableHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableHeadView"];
    
    [self.view addSubview:self.collectionView];
    
    
    
    if(@available(iOS 11,*))
    {
        self.collectionView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.desc=@"It's been a long day without you my friend And I'll tell you all about it when I see you again We've come a long way from where we began Oh I'll tell you all about it when I see you again When I see you again Damn, who knew all the planes we flew Good things we've been through That I'll be standing right here Talking to you about another path I know we loved to hit the road and laugh But something told me that it wouldn't last Had to switch up look at things different see the bigger picture Those were the days hard work forever pays Now I see you win the better place How could we not talk about family when family's all that we got? Everything I went through you were standing there by my side And now you gonna be with me for the last ride======end";
    
}
#pragma mark collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf=self;
    
    CGFloat h=[InfoCollectionViewCell hp_heightForCollectionView:collectionView cellType:Cell_XIB config:^(UICollectionViewCell *sourceCell) {
        InfoCollectionViewCell *cell=(InfoCollectionViewCell*)sourceCell;
        [cell setDesc:weakSelf.desc];
        
    } cache:^NSDictionary *{
        return @{kHPCacheUniqueKey:@"see you agin",kHPCacheStateKey:@"old friend",kHPRecalculateForStateKey:@(NO)};
    }];
    
    return CGSizeMake(self.view.bounds.size.width, h);
}
//动态设置每个分区的EdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}
//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//动态设置某组头视图大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 60);
    
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        CollectionReusableHeadView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableHeadView" forIndexPath:indexPath];
       
        if(view==nil)
        {
            view=[[CollectionReusableHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
            
        }
        
        //view.backgroundColor=[UIColor darkGrayColor];
        return view;
    }
    return nil;
}

//动态设置某组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kInfoCollectionViewCell forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[NSBundle mainBundle]loadNibNamed:kInfoCollectionViewCell owner:self options:nil].lastObject;
    }
    [cell setDesc:self.desc];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
