#import "HomeViewController.h"
#import <Masonry/Masonry.h>
#import "TableInfoViewController.h"
#import "CollectionViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"选择VC显示数据";
    
}
- (IBAction)openTable:(id)sender {
    
    TableInfoViewController *vc=[[TableInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)openCollectionView:(id)sender {
    
    CollectionViewController *vc=[[CollectionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
