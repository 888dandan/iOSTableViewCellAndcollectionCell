//
//  TableViewCell.m
//  tableviewAndCollectionViewCell
//
//  Created by 曹轩 on 2018/4/1.
//  Copyright © 2018年 曹轩. All rights reserved.
//

#import "TableViewCell.h"
#import "JHUploadImage.h"
#import "Masonry.h"
#import "CXCollectionViewCell.h"
#import "UIView+MyView.h"



@interface TableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,JHUploadImageDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mycollectionView;

@end

@implementation TableViewCell

// 已经添加过图片
-(void)setSouceArr:(NSMutableArray *)souceArr{
    _souceArr=souceArr;
 
#pragma  mark 当我们打断点会发现 从控制器进入cell 的时候首先调用 的是 awakeFromNib 的方法 然后调用 setSouceArr 的方法 这样就导致 cell 的高度始终 是最开始的高度 无法根据collectionviewcell 的数量将cell 撑起来 我理解是因为 先加载了 awakeFromNib 里面 mas_updateConstraints 方法 后添加的数据源 autolayout相当于没起作用
    [self.mycollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.mycollectionView.collectionViewLayout.collectionViewContentSize.height));
    }];
    
    
}
-(void)setSouceImageArr:(NSMutableArray *)souceImageArr{
    
    _souceImageArr=souceImageArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   //    // 没有添加图片
    if (_souceArr==nil) {
        _souceArr=[[NSMutableArray alloc]init];
    }
    if (_souceImageArr==nil) {
        _souceImageArr=[[NSMutableArray alloc]init];
        
    }

    //1.创建流式布局
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;//横着排列；
    
    layOut.itemSize= CGSizeMake(76+4, 76+4);
    layOut.minimumInteritemSpacing =0;
    layOut.minimumLineSpacing = 0;
    
    self.mycollectionView.collectionViewLayout = layOut;
    self.mycollectionView.delegate=self;
    self.mycollectionView.dataSource=self;
    
#pragma  mark  次代码保证 给 mycollectionview 一个启示高度
    [self.mycollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.mycollectionView.collectionViewLayout.collectionViewContentSize.height));
    }];
    [self.mycollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _souceArr.count+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UINib *nib = [UINib nibWithNibName:@"CXCollectionViewCell"
                                bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"CXCollectionViewCell"];
    
    CXCollectionViewCell *cell = [[CXCollectionViewCell alloc] init];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXCollectionViewCell"
                                                     forIndexPath:indexPath];
// 添加删除按钮
    [cell.deleteBtn addTarget:self action:@selector(deleteClcik:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag=10000+indexPath.row;
    
    if (_souceArr.count>0) {
        
        // 显示默认图片
        if (indexPath.row==_souceArr.count) {
            
            cell.myImageView.image=[UIImage imageNamed:@"abd_chengyun.png"];
            
            //隐藏删除按钮
            cell.deleteBtn.hidden=YES;
        }
        else{
            // 显示自己添加的图片
            UIImage *image=self.souceImageArr[indexPath.row];
            cell.myImageView.image=image;
           
        }
        
    }
    else{
        // 隐藏删除按钮
        cell.deleteBtn.hidden=YES;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 添加图片
    // 规定只能从最后一张添加
    if (indexPath.row==self.souceArr.count) {
        [JHUPLOAD_IMAGE showActionSheetInFatherViewController:self.parentController delegate:self];
    }
}

#pragma mark - JHUploadImageDelegate

-(void)uploadImageToServerWithImage:(UIImage *)image OriginImage:(UIImage *)originImage
{
//    NSData *data=UIImageJPEGRepresentation(originImage, 0.1);
//    [self makeToastActivity:@"center"];
//    [NetworkWorker networkPost:[NetworkUrlGetter setjsonuserimageUpdate] formPostData:data andFileName:@{@"name":@"2"} success:^(NSDictionary *dictionary) {
//
//        [self hideToastActivity];
//        [self makeToast:dictionary[@"message"] duration:1 position:@"bottom"];
//

//        [self.mycollectionView reloadData];
//
//
//    } failure:^(NSString *error, NSDictionary *dictionary) {
//        [self hideToastActivity];
//
//        [self makeToast:dictionary[@"message"] duration:1 position:@"bottom"];
//    }];
#warning  souarr 本应该存储的是图片地址 但demo 省去了网络请求
             [self.souceArr addObject:originImage];
             [self.souceImageArr addObject:originImage];
              self.otherMand(self.souceArr, self.souceImageArr);
}

// 删除图片
// 其实和添加图片的操作相同
-(void)deleteClcik:(UIButton*)btn{
    
    NSInteger index=btn.tag-10000;
    [self.souceArr removeObjectAtIndex:index];
    [self.souceImageArr removeObjectAtIndex:index];
    self.otherMand(self.souceArr, self.souceImageArr);


}

@end
