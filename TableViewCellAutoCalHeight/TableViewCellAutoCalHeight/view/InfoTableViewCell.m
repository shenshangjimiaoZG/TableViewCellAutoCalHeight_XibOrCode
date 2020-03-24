#import "InfoTableViewCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry/Masonry.h>

@interface InfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;

@end

@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"from nib");
    
    self.lblDesc.numberOfLines=0;
    
    self.hyb_bottomOffsetToCell=10;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@300);
        make.centerX.equalTo(self.contentView);
        
    }];
}
-(void)setDesc:(NSString *)desc
{
    // 段落设置与实际显示的 Label 属性一致 采用 NSMutableParagraphStyle 设置Nib 中 Label 的相关属性传入到 NSAttributeString 中计算；
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentLeft;
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:desc attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSParagraphStyleAttributeName:style}];
    
    CGSize size =  [string boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    
    // 并不是高度计算不对，我估计是计算出来的数据是 小数，在应用到布局的时候稍微差一点点就不能保证按照计算时那样排列，所以为了确保布局按照我们计算的数据来，就在原来计算的基础上 取ceil值，再加1；
    CGFloat height = ceil(size.height) + 1;
    
    _lblDesc.attributedText=string;
    
    [_lblDesc mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(height));
    }];
}

@end
