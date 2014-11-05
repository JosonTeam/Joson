#import "Factory.h"
#import "JSKit.h"

@implementation Factory

+ (NSArray *)getHeigtAndWidthOfDevice
{
    int hight = DeviceHeight;
    int width = 0;
    switch (hight)
    {
        case HeightFor3_5:
            width = WidthForElse;
            break;
        case HeightFor4_0:
            width = WidthForElse;
            break;
        case HeightFor4_7:
            width = WidthFor4_7;
            break;
        case HeightFor5_5:
            width = WidthFor5_5;
            break;
    }
    NSArray * arr =@[[NSNumber numberWithInt:width],[NSNumber numberWithInt:hight]];
    return arr;
}

#pragma mark 空间高度自适应文本长度
+ (CGFloat)contentHeight:(NSString *)content
{
    CGSize size = CGSizeMake(260, MAXFLOAT);
    NSDictionary * dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]};
    NSAttributedString  * str = [[NSAttributedString alloc] initWithString:content attributes:dic];
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return CGRectGetHeight(rect) + 20;
}

+ (NSString *)getDateWithSourceDate:(NSString *)sourceDate
                         andSysDate:(NSString *)sysDate
{
    NSString * str;
    NSArray * arr = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec"];
    
    NSArray * source = [sourceDate componentsSeparatedByString:@" "];
    NSArray * sys = [sysDate componentsSeparatedByString:@" "];
    NSArray * s_time = [source[3] componentsSeparatedByString:@":"];
    NSArray * sy_time = [sys[1] componentsSeparatedByString:@":"];
    NSArray * sy_date = [sys[0] componentsSeparatedByString:@"-"];
    
    NSMutableArray * source_Date = [[NSMutableArray alloc]initWithObjects:source[5],[NSString stringWithFormat:@"%d",[arr indexOfObject:source[1]]+1],source[2],s_time[0],s_time[1],s_time[2], nil];
    NSMutableArray * sys_Date = [[NSMutableArray alloc]initWithObjects:sy_date[0],sy_date[1],sy_date[2],sy_time[0],sy_time[1],sy_time[2], nil];
    
    if ([sys_Date[0] intValue] - [source_Date[0] intValue] != 0)
    {
        str = [NSString stringWithFormat:@"%d年前",[sys_Date[0] intValue] - [source_Date[0] intValue]];
    }
    else if([sys_Date[1] intValue] - [source_Date[1] intValue] > 0)
    {
        str = [NSString stringWithFormat:@"%d个月前",[sys_Date[1] intValue] - [source_Date[1] intValue]];
    }
    else if([sys_Date[1] intValue] - [source_Date[1] intValue] < 0)
    {
        str = [NSString stringWithFormat:@"%d个月前",[source_Date[1] intValue] - [sys_Date[1] intValue]];
    }
    else if ([sys_Date[2] intValue] - [source_Date[2] intValue] > 0)
    {
        str = [NSString stringWithFormat:@"%d天前",[sys_Date[2] intValue] - [source_Date[2] intValue]];
    }
    else if ([sys_Date[2] intValue] - [source_Date[2] intValue] < 0)
    {
        str = [NSString stringWithFormat:@"%d天前",[source_Date[2] intValue] - [sys_Date[2] intValue]];
    }
    else if ([sys_Date[3] intValue] - [source_Date[3] intValue] > 0)
    {
        str = [NSString stringWithFormat:@"%d小时前",[sys_Date[3] intValue] - [source_Date[3] intValue]];
    }
    else if ([sys_Date[3] intValue] - [source_Date[3] intValue] < 0)
    {
        str = [NSString stringWithFormat:@"%d小时前",[source_Date[3] intValue] - [sys_Date[3] intValue]];
    }
    else if ([sys_Date[4] intValue] - [source_Date[4] intValue] > 0)
    {
        str = [NSString stringWithFormat:@"%d分钟前",[sys_Date[4] intValue] - [source_Date[4] intValue]];
    }
    else if ([sys_Date[4] intValue] - [source_Date[4] intValue] < 0)
    {
        str = [NSString stringWithFormat:@"%d分钟前",[source_Date[4] intValue] - [sys_Date[4] intValue]];
    }
    else if (0 < [source_Date[5] intValue] % 60 < 5)
    {
        str = @"刚刚";
    }
    else if([sys_Date[5] intValue] - [source_Date[5] intValue] > 0)
    {
        [NSString stringWithFormat:@"%d秒前",[sys_Date[5] intValue] - [source_Date[5] intValue]];
    }
    else if ([sys_Date[5] intValue] - [source_Date[5] intValue] < 0)
    {
        [NSString stringWithFormat:@"%d秒前",[source_Date[5] intValue] - [sys_Date[5] intValue]];
    }
    
    return str;
}

@end
