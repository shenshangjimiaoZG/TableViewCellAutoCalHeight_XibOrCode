#import <UIKit/UIKit.h>
#import "UICollectionViewCell+HPMasonryAutoCellHeight.h"

NS_ASSUME_NONNULL_BEGIN
static NSString *const kInfoCollectionViewCell=@"InfoCollectionViewCell";

@interface InfoCollectionViewCell : UICollectionViewCell

-(void)setDesc:(NSString*)desc;

@end

NS_ASSUME_NONNULL_END
