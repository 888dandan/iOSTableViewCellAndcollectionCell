//
//  TableViewCell.h
//  tableviewAndCollectionViewCell
//
//  Created by 曹轩 on 2018/4/1.
//  Copyright © 2018年 曹轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
// 存储图片地址
@property(nonatomic,strong)  NSMutableArray *souceArr;
// 存储图片 2机制流
@property(nonatomic,strong) NSMutableArray *souceImageArr;
// 回掉
@property(nonatomic,copy) void (^otherMand)(NSMutableArray *souceImageUrlArr,NSMutableArray *souceImageArr);

@end
