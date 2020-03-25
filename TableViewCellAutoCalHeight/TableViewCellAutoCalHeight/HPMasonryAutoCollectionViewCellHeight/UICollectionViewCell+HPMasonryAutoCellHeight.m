#import "UICollectionViewCell+HPMasonryAutoCellHeight.h"
#import <objc/runtime.h>
#import "UICollectionView+HPCacheHeight.h"

NSString *const kHPCacheUniqueKey = @"kHPCacheUniqueKey";
NSString *const kHPCacheStateKey = @"kHPCacheStateKey";
NSString *const kHPRecalculateForStateKey = @"kHPRecalculateForStateKey";
NSString *const kHPCacheForCollectionViewKey = @"kHPCacheForCollectionViewKey";

const void *s_hp_lastViewInCellKey = "hp_lastViewInCellKey";
const void *s_hp_bottomOffsetToCellKey = "hp_bottomOffsetToCellKey";


@implementation UICollectionViewCell (HPMasonryAutoCellHeight)

#pragma mark - Public
+ (CGFloat)hp_heightForCollectionView:(UICollectionView *)collectionView cellType:(CellType)type config:(HPCellBlock)config {
    UICollectionViewCell *cell = [collectionView.hp_reuseCells objectForKey:[[self class] description]];
    
    if (cell == nil) {
        
        if(type==Cell_Code)
        {
             
            cell=[[UICollectionViewCell alloc]init];
        }
        else if (type==Cell_XIB)
        {
            cell=[[NSBundle mainBundle]loadNibNamed:[[self class]description] owner:self options:nil].lastObject;
        }
     
        
        
        [collectionView.hp_reuseCells setObject:cell forKey:[[self class] description]];
    }
    
    if (config) {
        config(cell);
    }
    
    return [cell private_hp_heightForCollectionView:collectionView];
}

+ (CGFloat)hp_heightForCollectionView:(UICollectionView *)collectionView
  cellType:(CellType)type
                           config:(HPCellBlock)config
                            cache:(HPCacheHeight)cache {
    
    NSAssert(collectionView, @"collectionView is necessary param");
    
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *key = cacheKeys[kHPCacheUniqueKey];
        NSString *stateKey = cacheKeys[kHPCacheStateKey];
        NSString *shouldUpdate = cacheKeys[kHPRecalculateForStateKey];
        
        NSMutableDictionary *stateDict = collectionView.hp_cacheCellHeightDict[key];
        NSString *cacheHeight = stateDict[stateKey];
        
        if (collectionView.hp_cacheCellHeightDict.count == 0
            || shouldUpdate.boolValue
            || cacheHeight == nil) {
            CGFloat height = [self hp_heightForCollectionView:collectionView cellType:type config:config];
            
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                collectionView.hp_cacheCellHeightDict[key] = stateDict;
            }
            
            [stateDict setObject:[NSString stringWithFormat:@"%lf", height] forKey:stateKey];
            
            return height;
        } else if (collectionView.hp_cacheCellHeightDict.count != 0
                   && cacheHeight != nil
                   && cacheHeight.integerValue != 0) {
            return cacheHeight.floatValue;
        }
    }
    
    return [self hp_heightForCollectionView:collectionView cellType:type config:config];
}

- (void)setHp_lastViewInCell:(UIView *)hp_lastViewInCell {
    objc_setAssociatedObject(self,
                             s_hp_lastViewInCellKey,
                             hp_lastViewInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)hp_lastViewInCell {
    return objc_getAssociatedObject(self, s_hp_lastViewInCellKey);
}

- (void)setHp_lastViewsInCell:(NSArray *)hp_lastViewsInCell {
    objc_setAssociatedObject(self,
                             @selector(hp_lastViewsInCell),
                             hp_lastViewsInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)hp_lastViewsInCell {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHp_bottomOffsetToCell:(CGFloat)hp_bottomOffsetToCell {
    objc_setAssociatedObject(self,
                             s_hp_bottomOffsetToCellKey,
                             @(hp_bottomOffsetToCell),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hp_bottomOffsetToCell {
    NSNumber *valueObject = objc_getAssociatedObject(self, s_hp_bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    
    return 0.0;
}

#pragma mark - Private
- (CGFloat)private_hp_heightForCollectionView:(UICollectionView *)collectionView
{
//    NSAssert(self.hp_lastViewInCell != nil
//             || self.hp_lastViewsInCell.count != 0,
//             @"您未指定cell排列中最后的视图对象，无法计算cell的高度");
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    CGFloat rowHeight = 0.0;
    
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    
//    if (self.hp_lastViewInCell) {
//        rowHeight = self.hp_lastViewInCell.frame.size.height + self.hp_lastViewInCell.frame.origin.y;
//    } else {
//        for (UIView *view in self.hp_lastViewsInCell) {
//            if (rowHeight < CGRectGetMaxY(view.frame)) {
//                rowHeight = CGRectGetMaxY(view.frame);
//            }
//        }
//    }
    
    rowHeight += self.hp_bottomOffsetToCell;
    
    return rowHeight;
}

@end
