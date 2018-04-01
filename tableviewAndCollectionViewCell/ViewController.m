//
//  ViewController.m
//  tableviewAndCollectionViewCell
//
//  Created by 曹轩 on 2018/4/1.
//  Copyright © 2018年 曹轩. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *myTextView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell0;
@property (strong, nonatomic) IBOutlet UITableViewCell *cell2;

// 存储图片地址
@property(nonatomic,strong)  NSMutableArray *souceArr;
// 存储图片 2机制流
@property(nonatomic,strong) NSMutableArray *souceImageArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.myTableView.estimatedRowHeight=44;
    self.myTableView.rowHeight=UITableViewAutomaticDimension;
    [self CXTableViewInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-
#pragma uitabelViewDelegate and uitableDateSouce-

-(void)CXTableViewInit{
    
    self.myTableView.backgroundColor=[UIColor whiteColor];
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
          return   _cell0;
            break;
        case 1:
        {
            // cell类名
            static NSString *inentifier=@"TableViewCell";
            
            TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:inentifier];
            if (!cell) {
                
                cell=[[[NSBundle mainBundle]loadNibNamed:inentifier owner:nil options:nil]firstObject];
            }
            // cell 的blcok 回掉
            __weak typeof(self) weakself=self;
            cell.otherMand = ^(NSMutableArray *souceImageUrlArr, NSMutableArray *souceImageArr) {
                // 获取图片资源
                weakself.souceArr=souceImageUrlArr;
                weakself.souceImageArr=souceImageArr;
                [weakself.myTableView reloadData];
            };
            // 将图片资源传给cell
            if (self.souceImageArr) {
                cell.souceImageArr=self.souceImageArr;
            
            }
            //  图片数组地址
            if (self.souceArr) {
                cell.souceArr=self.souceArr;
            }

            return cell;
        }
            break;
        case 2:
            return   _cell2;
            break;

        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma   tableViewdelegate tableViewDateSouce end



@end
