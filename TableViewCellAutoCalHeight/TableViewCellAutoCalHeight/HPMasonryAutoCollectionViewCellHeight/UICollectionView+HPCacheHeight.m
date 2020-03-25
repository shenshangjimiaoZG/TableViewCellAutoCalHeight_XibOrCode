#import "UICollectionView+HPCacheHeight.h"
#import <objc/runtime.h>

static const void *__hp_collectionview_cacheCellHeightKey = "__hp_collectionview_cacheCellHeightKey";
static const void *__hp_collectionview_reuse_cells_key = "__hp_collectionview_reuse_cells_key";

@implementation UICollectionView (HPCacheHeight)

- (NSMutableDictionary *)hp_cacheCellHeightDict {
 NSMutableDictionary *dict = objc_getAssociatedObject(self, __hp_collectionview_cacheCellHeightKey);
  
  if (dict == nil) {
    dict = [[NSMutableDictionary alloc] init];
    
    objc_setAssociatedObject(self,
                             __hp_collectionview_cacheCellHeightKey,
                             dict,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  
  return dict;
}

- (NSMutableDictionary *)hp_reuseCells {
  NSMutableDictionary *cells = objc_getAssociatedObject(self, __hp_collectionview_reuse_cells_key);
  
  if (cells == nil) {
    cells = [[NSMutableDictionary alloc] init];
    
    objc_setAssociatedObject(self,
                             __hp_collectionview_reuse_cells_key,
                             cells,
                             OBJC_ASSOCIATION_RETAIN);
  }
  
  return cells;
}

@end
