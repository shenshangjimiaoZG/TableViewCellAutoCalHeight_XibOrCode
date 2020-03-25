#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
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

@interface UICollectionView (HPCacheHeight)
/*
 *  用于缓存cell的行高
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *hp_cacheCellHeightDict;

/*
 *
 *用于获取或者添加计算行高的cell，因为理论上只有一个cell用来计算行高，以降低消耗
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *hp_reuseCells;

@end

NS_ASSUME_NONNULL_END
