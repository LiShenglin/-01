//
//  HomeController.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "HomeController.h"
#import "HomeFlowLayout.h"
#import "LSLHttpTool.h"
#import "homeModel.h"
#import "HomeCollectionCell.h"
#import "PhotoBrowserController.h"
#import "PhotoBrowserAnimator.h"

static NSString * const homeCell = @"shuai";
@interface HomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/**  <#名称#> */
@property (nonatomic,strong)UICollectionView * collectionView;

/**   */
@property (nonatomic,strong)NSMutableArray * homeArrayMMM;

/**  <#名称#> */
@property (nonatomic,strong)PhotoBrowserAnimator * Animator;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 网络请求
    // 注册
    [self.collectionView registerClass:[HomeCollectionCell class] forCellWithReuseIdentifier:homeCell];
    [self setJSONClickIndex:0];
}

#pragma mark - 网络请求
- (void)setJSONClickIndex: (NSInteger)index
{
   
    
        [LSLHttpTool get:index params:nil success:^(id responseObj) {
          
            NSArray * homeArray = responseObj[@"data"];

            
            for (NSDictionary * homeDict in homeArray) {
                
             homeModel * model = [[homeModel alloc] initWithHomeModel:homeDict];
                [self.homeArrayMMM addObject:model];
            }
            
            
            [self.collectionView reloadData];
            
            
            
        } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeArrayMMM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    HomeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCell forIndexPath:indexPath];
    
    cell.model = self.homeArrayMMM[indexPath.row];

    
    // 判断是否是刷新后最后的第二个
    if (indexPath.item == self.homeArrayMMM.count - 1) {
        
        // 重新调用
        [self setJSONClickIndex:self.homeArrayMMM.count];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    PhotoBrowserController * photo = [[PhotoBrowserController alloc] init];
    
    // 监听点击的路径的是哪个位置
    photo.indexPath = indexPath;
    // 创建一个数据来保存当前的数据的模型
    photo.shops = self.homeArrayMMM;
    
    // 添加动画
    photo.modalPresentationStyle = UIModalPresentationCustom;
    // 设置专场动画的代理对象
    photo.transitioningDelegate = self.Animator;
    
    
    [self presentModalViewController:photo animated:YES];
    
    
}













#pragma mark - 将尾部空白的格子给补全

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        HomeFlowLayout * homeFlowLayout = [[HomeFlowLayout alloc] init];
        
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:homeFlowLayout];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
    }
    return _collectionView;
}

- (NSMutableArray *)homeArrayMMM
{
    if (!_homeArrayMMM) {
        _homeArrayMMM = [NSMutableArray array];
    }
    return _homeArrayMMM;
}

- (PhotoBrowserAnimator *)Animator
{
    if (!_Animator) {
       PhotoBrowserAnimator * p = [[PhotoBrowserAnimator alloc] init];
        self.Animator = p;
    }
    return _Animator;
}


@end
