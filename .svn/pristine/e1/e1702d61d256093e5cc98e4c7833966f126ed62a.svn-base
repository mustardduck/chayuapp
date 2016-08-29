//
//  CYHomeInfo.h
//  茶语
//
//  Created by 李峥 on 16/3/22.
//  Copyright © 2016年 Chayu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYHomeSlideInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *resource;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *resource_id;
@property (nonatomic, strong) NSString *template_id;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic ,strong) NSString *resource_type;
@property (nonatomic, strong)NSDictionary *source;
@end

@interface CYHomeToDayNewsInfo : NSObject

/**
 *  文章Id
 */
@property (nonatomic, strong) NSString *itemid;
/**
 *  图片链接
 */
@property (nonatomic, strong) NSString *thumb;
/**
 *  文章标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  点击次数
 */
@property (nonatomic, strong) NSString *comments;
/**
 *  /点赞数
 */
@property (nonatomic, strong) NSString *suports;

///date
@property (nonatomic, strong) NSString *created;

//浏览量
@property (nonatomic,strong) NSString *clicks;

//V2版
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *resource_type;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSDictionary *source;

@property (nonatomic, strong) NSString *resource_id;


@property (nonatomic, strong) NSString *template_id;

@property (nonatomic, assign) NSInteger commend;//1 头条 2最新 3最热


@end

@interface CYShardBannerInfo : NSObject
/**
 *  图片链接
 */
@property (nonatomic, strong) NSString *thumb;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *data;

//类型(type=1 跳转市集首页 2文章详情 3商品详情 4茶评详情 5茶样详情 100返回url地址)
@property (nonatomic,strong) NSString *type;


@end

@interface CYHomeTeaInfo : NSObject

/**
 *  文章Id
 */
@property (nonatomic, strong) NSString *itemid;
/**
 *  图片链接
 */
@property (nonatomic, strong) NSString *thumb;
/**
 *  文章标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  点击次数
 */
@property (nonatomic, strong) NSString *comments;
/**
 *  /点赞数
 */
@property (nonatomic, strong) NSString *clicks;

/**
 *  库存
 */
@property (nonatomic, strong) NSString *number;
/**
 *  pirce
 */
@property (nonatomic, strong) NSString *price;

@end

@interface CYHomeMarkertInfo : NSObject


@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *comments;
@property (nonatomic, strong) NSString *enjoy_num;
//good tea
@property (nonatomic, strong) NSString *price_sell;
@property (nonatomic, strong) NSString *saleCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *gid;

//V2版本数据
@property (nonatomic, strong) NSString *resource_id;
@property (nonatomic, strong) NSString *template_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic,strong)  NSString *url;
@property (nonatomic ,strong) NSString *resource_type;
@property (nonatomic,strong) NSDictionary *source;
@end

@interface CYHomeQuanInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *gid;

//V2数据
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSDictionary  *source;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *resource_id;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *title;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *template_id;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *thumb;
/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *resource_type;

/**
 *  <#属性说明#>
 */
@property (nonatomic,strong)NSString *url;

/**
 *  <#属性说明#>
 */

@end

@interface CYHomeTopicInfo : NSObject

@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray<NSString *> *attach;
@property (nonatomic, strong) NSString *created_uid;
@property (nonatomic, strong) NSString *created_time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *replies;
@property  (nonatomic,strong) NSString *hits;


/**
 *创建者昵称-我收藏的话题（帖子）
 */
@property (nonatomic, strong) NSString *user_nickanme;
/**
 *  描述者头像-我收藏的话题（帖子）
 */
@property (nonatomic, strong) NSString *user_avatar;

/**
 *  帖子描述-我收藏的话题（帖子）
 */
@property (nonatomic, strong) NSString *desc;

/**
 *  置顶类型（非0情况下都为置顶数据）-我收藏的话题（帖子）
 */
@property (nonatomic, assign) BOOL topped;

/**
 *  精华（0非  1是）-我收藏的话题（帖子）
 */
@property (nonatomic, assign) BOOL digest;

@property (nonatomic,strong)NSString *thumb;


@end

@interface CYHomeBrandInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *rqz;
@property (nonatomic, strong) NSString *goods_id;

@end

@interface CYHomeTeaBrandInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *review_score;
@property (nonatomic, strong) NSString *itemid;
@property (nonatomic, strong) NSString *brand;

@end

@interface CYHomeAllBrandInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *itemid;
@property (nonatomic, strong) NSString *brand;

@end

@interface CYHomeInfo : NSObject

//幻灯片
@property (nonatomic, strong) NSArray<CYHomeSlideInfo *> *slide;
//今日头条
@property (nonatomic, strong) NSArray<CYHomeToDayNewsInfo *> *todayNews;
@property (nonatomic, strong) NSArray<CYHomeMarkertInfo *> *shiji;
@property (nonatomic, strong) NSArray<CYHomeMarkertInfo *> *shijiGoodTea;
@property (nonatomic, strong) NSArray<CYHomeToDayNewsInfo *> *article;
@property (nonatomic, strong) NSArray<CYHomeQuanInfo *> *group;
@property (nonatomic, strong) NSArray<CYHomeTopicInfo *> *GroupTopic;
@property (nonatomic, strong) NSArray<CYHomeBrandInfo *> *shijirenqi;
@property (nonatomic, strong) NSArray<CYHomeTeaBrandInfo *> *TeaLanguageScore;
@property (nonatomic, strong) NSArray<CYHomeAllBrandInfo *> *ComprehensiveScoreTable;
@property (nonatomic, strong) NSArray<CYHomeTeaInfo *> *chapingList;


@property (nonatomic, strong) CYShardBannerInfo *shardBanner;
@property (nonatomic, strong) CYHomeTeaInfo *chayang;
@property (nonatomic, strong) CYHomeTeaInfo *chaping;

@end
