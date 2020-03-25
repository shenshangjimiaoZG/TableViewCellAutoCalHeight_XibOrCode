#import <UIKit/UIKit.h>

/**
*  基于Masonry自动布局实现的自动计算cell的行高扩展
*
*  @author huangyibiao
*  @email  huangyibiao520@163.com
*  @github https://github.com/CoderJackyHuang
*  @blog   http://www.henishuo.com/masonry-cell-height-auto-calculate/
*
*  @note Make friends with me：
*        QQ:(632840804)
*        Please tell me your real name when you send message to me.3Q.
*/



typedef NS_ENUM(NSInteger,CellType)
{
    Cell_Code,
    Cell_XIB,
};
/**
 * 获取高度前会回调，需要在此BLOCK中配置数据，才能正确地获取高度
 */
typedef void(^HPCellBlock)(UICollectionViewCell *sourceCell);

typedef NSDictionary *(^HPCacheHeight)();

/**
 *    @author 黄仪标, 16-01-22 21:01:09
 *
 *    唯一键，通常是数据模型的id，保证唯一
 */
FOUNDATION_EXTERN NSString *const kHPCacheUniqueKey;

/**
 *    @author 黄仪标, 16-01-22 21:01:57
 *
 *    对于同一个model，如果有不同状态，而且不同状态下高度不一样，那么也需要指定
 */
FOUNDATION_EXTERN NSString *const kHPCacheStateKey;

/**
 *    @author 黄仪标, 16-01-22 21:01:47
 *
 *    用于指定更新某种状态的缓存，比如当评论时，增加了一条评论，此时该状态的高度若已经缓存过，则需要指定来更新缓存
 */
FOUNDATION_EXTERN NSString *const kHPRecalculateForStateKey;
NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (HPMasonryAutoCellHeight)
/************************************************************************
 *
 * @note UI布局必须放在UICollectionViewCell的初始化方法中：
 *
 * - initWithStyle:reuseIdentifier:
 *
 * 且必须指定hp_lastViewInCell才能生效
 ************************************************************************/

/**
 * 必传设置的属性，也就是在cell中的contentView内最后一个视图，用于计算行高
 * 例如，创建了一个按钮button作为在cell中放到最后一个位置，则设置为：self.hp_lastVieInCell = button;
 * 即可。
 * 默认为nil，如果在计算时，值为nil，会crash (弃用)
 */
@property (nonatomic, strong) UIView *hp_lastViewInCell;

/**
 *  当距离分割线的视图不确定时，可以将可能的所有视图放在这个数组里面，优先级低于上面的属性，也就是当`hp_lastViewInCell`有值时，`hp_lastViewsInCell`不起作用。(弃用)
 */
@property (nonatomic, strong) NSArray *hp_lastViewsInCell;

/**
 * 可选设置的属性，默认为0，表示指定的hp_lastViewInCell到cell的bottom的距离
 * 默认为0.0
 */
@property (nonatomic, assign) CGFloat hp_bottomOffsetToCell;

/**
 * 通过此方法来计算行高，需要在config中调用配置数据的API
 *
 * @param collectionView 必传，为哪个collectionView缓存行高
 * @param config     必须要实现，且需要调用配置数据的API
 *
 * @return 计算的行高
 */
+ (CGFloat)hp_heightForCollectionView:(UICollectionView *)collectionView cellType:(CellType)type config:(HPCellBlock)config;

/**
 *    @author 黄仪标, 16-01-22 23:01:56
 *
 *    此API会缓存行高
 *
 *    @param collectionView 必传，为哪个tableView缓存行高
 *    @param config 必须要实现，且需要调用配置数据的API
 *    @param cache  返回相关key
 *
 *    @return 行高
 */
+ (CGFloat)hp_heightForCollectionView:(UICollectionView *)collectionView
                          cellType:(CellType)type
                           config:(HPCellBlock)config
                            cache:(HPCacheHeight)cache;
@end

NS_ASSUME_NONNULL_END
