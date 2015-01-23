//
//  NetInterface.h
//  OnlineDragstroe
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 Lison. All rights reserved.
//

#ifndef OnlineDragstroe_NetInterface_h
#define OnlineDragstroe_NetInterface_h

//客服电话
#define kTelphoneNumber @"400-080-3609"
//首页分类的图片
#define kListImageUrl @"http://www.16120.cn/skin/default/icon/fenlei/%@.jpg"

//首页分类
#define kHomeListUrl @"http://www.16120.cn/soap/cat/"

//服务区域的信息
#define kServiceAreaUrl @"http://www.16120.cn/soap/area/"

//品质保障网页
#define kQualityAssureUrl @"http://www.16120.cn/announce/"

//请求一级分类详情数据(需传入cid)
#define kDetailDataUrl @"http://www.16120.cn/soap/opencat/index.php?cid=%@"

//请求二级分类详情数据(需传入cid)
#define kSecDetailDataUrl @"http://www.16120.cn/soap/ceshi/index.php?cid=%@"

//产品简介(需获取itemid)
#define kBriefIntroductionUrl @"http://www.16120.cn/soap/goodcontent/index.php?cid=%@"

//搜索
#define kSearchProductUrl @"http://www.16120.cn/soap/search/index.php?cid=%@"

//分类界面所有分类
#define kAllCategorysUrl @"http://www.16120.cn/soap/cats/"

//优惠药 特价药
#define kSpecialPriceUrl @"http://www.16120.cn/soap/tejia/"

//登录接口
#define kLoginUrl @"http://www.16120.cn/member/login_wap.php"

#endif
