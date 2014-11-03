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

@end
