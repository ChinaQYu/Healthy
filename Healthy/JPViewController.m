//
//  JPViewController.m
//  Healthy
//
//  Created by YinXun-Yu on 16/6/22.
//  Copyright © 2016年 YinXun-Yu. All rights reserved.
//

#import "JPViewController.h"
#import "UIView+Toast.h"
#import <HealthKit/HealthKit.h>
#import "ErWeiMaViewController.h"

@interface JPViewController ()
{
         SDCycleScrollView *_sdc; // 轮播图
}

@property (nonatomic, strong)HKHealthStore *healthStore;
@property (nonatomic, strong)NSTimer *time;
@end

@implementation JPViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"healthy";

    [self creatimage];
    self.imageView.image = [UIImage imageNamed:@"AP-千禧18K玫瑰金表--G25773"];
    [self creatscrollview];
    
}

- (void)creatscrollview
{
    NSArray *images = @[[UIImage imageNamed:@"bannner1"],[UIImage imageNamed:@"bannner2"],[UIImage imageNamed:@"banner3"]];
    // 网络加载图片的轮播器
    _sdc = [SDCycleScrollView cycleScrollViewWithFrame:self.scrollview.frame  imageNamesGroup:images];
    _sdc.pageDotColor = [UIColor whiteColor];
    _sdc.currentPageDotColor = [UIColor whiteColor];
    _sdc.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _sdc.pageControlDotSize = CGSizeMake(8, 8);
    _sdc.delegate = self;
    [self.view addSubview:_sdc];
}



- (void)creatimage
{
    
    //2.保存到对应的沙盒目录中，具体代码如下：
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"qwe"]];   // 保存文件的名称
    //    [UIImagePNGRepresentation(myImage)writeToFile: filePath    atomically:YES];
    UIImage *image = [[UIImage alloc]init];
    image = [UIImage imageNamed:@"qwe"];
    [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    
    NSArray *pathsa = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *filePatha = [[pathsa objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"qwe"]];   // 保存文件的名称
    
    [info setObject:filePatha forKey:@"img"];
    
    NSArray *pathss = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePaths = [[pathss objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"qwe"]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePaths];
    NSLog(@"%@",img);
//    self.imageView.image = img;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)start:(UIButton *)sender {
    //第三种 每一秒执行一次 （重复性）
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];
}

- (IBAction)stop:(UIButton *)sender {
    [self.time invalidate];
    self.time = nil;
      [self.view makeToast:@"暂停加步" duration:2.0f position:CSToastPositionCenter];
    
}

- (void)testTimer
{
    self.healthStore = [[HKHealthStore alloc] init];
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *writeDataTypes = [NSSet setWithObjects:stepCountType,  nil];
    
    NSSet *readDataT =nil;
    [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataT completion:^(BOOL success, NSError *error) {
        
        if (!success) {
            //失败了
            NSLog(@"shibaile");
            return;
        }
        
    }];
    
    //数据看类型为步数.
    HKQuantityType *quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //表示步数的数据单位的数量
    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:self.getbut.text.doubleValue];
    
    
    //数量样本.
    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
    
    //保存
    [self.healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError *error) {
        if (success) {
            //保存成功
            NSLog(@"加3步");
//            [self.view makeToast:@"正在加步" duration:2.0f position:CSToastPositionCenter];
            
        }else {
            //保存失败
            NSLog(@"wozuile");
        }
    }];
}
- (IBAction)getbushu:(UIButton *)sender {
//        [self getdevice];
    [self.view makeToast:@"暂不可用" duration:2.0f position:CSToastPositionCenter];
    
}
- (void)getdevice
{
    //查看healthKit在设备上是否可用，ipad不支持HealthKit
    if(![HKHealthStore isHealthDataAvailable])
    {
        NSLog(@"设备不支持healthKit");
    }
    
    //创建healthStore实例对象
    self.healthStore = [[HKHealthStore alloc] init];
    
    //设置需要获取的权限这里仅设置了步数
    HKObjectType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSSet *healthSet = [NSSet setWithObjects:stepCount, nil];
    
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        if (success)
        {
            NSLog(@"获取步数权限成功");
            //获取步数后我们调用获取步数的方法
            [self readStepCount];
        }
        else
        {
            NSLog(@"获取步数权限失败");
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//查询数据
- (void)readStepCount
{
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个
     HKSample类所以对应的查询类就是HKSampleQuery。
     下面的limit参数传1表示查询最近一条数据,查询多条数据只要设置limit的参数值就可以了
     */
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:nil limit:1 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //打印查询结果
        NSLog(@"resultCount = %ld result = %@",results.count,results);
        //把结果装换成字符串类型
        HKQuantitySample *result = results[0];
        HKQuantity *quantity = result.quantity;
        NSString *stepStr = (NSString *)quantity;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //查询是在多线程中进行的，如果要对UI进行刷新，要回到主线程中
            NSLog(@"最新步数：%@",stepStr);
            self.bushu.text = [NSString stringWithFormat:@"%@步",stepStr];
        }];
        
    }];
    //执行查询
    [self.healthStore executeQuery:sampleQuery];
}

- (IBAction)erweima:(UIButton *)sender {
    ErWeiMaViewController *erweima = [[ErWeiMaViewController alloc] init];
    
    [self.navigationController pushViewController:erweima animated:YES];
    
}
@end
