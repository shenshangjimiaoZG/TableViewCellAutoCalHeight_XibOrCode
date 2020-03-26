#import "CollectionReusableHeadView.h"
#import <Masonry/Masonry.h>

@interface CollectionReusableHeadView ()
@property (nonatomic,strong)UILabel *subView;
@end

@implementation CollectionReusableHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.subView=[UILabel new];
        self.subView.text=@"CollectionReusableHeadView";
        self.subView.textAlignment=NSTextAlignmentCenter;
           self.subView.backgroundColor=[UIColor darkGrayColor];
           [self addSubview:self.subView];
    }
   
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}
@end
