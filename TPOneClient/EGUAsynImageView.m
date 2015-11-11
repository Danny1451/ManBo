//
//  AsynImageView.m
//  openudidtest
//
//  Created by 刘旦 on 15/8/28.
//  Copyright (c) 2015年 egame. All rights reserved.
//

#import "EGUAsynImageView.h"

#define RETRY_TIMES 5
@implementation EGUAsynImageView{
    NSInteger retryTimes;
}

@synthesize imageUrl = _imageUrl;
@synthesize placeholderImage = _placeholderImage;
@synthesize fileName = _fileName;

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        retryTimes = 0;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
    }
    
    return self;
    
}

//重写placeholerImage
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    
    if (placeholderImage != _placeholderImage) {
        
        //[_placeholderImage release];
        _placeholderImage = placeholderImage;
        self.image = _placeholderImage;
        
    }
}

- (void)setImageUrlWithOutCache:(NSString *)imageUrl{
    if (imageUrl != _imageUrl) {
        self.image = _placeholderImage;
        //        [_imageUrl release];
        //        _imageUrl = [imageUrl retain];
        _imageUrl = imageUrl;
    }
    
    if (self.imageUrl) {
        
        NSLog(@"start download");
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir = [path objectAtIndex:0];
        NSString *tmpPath = [docDir stringByAppendingPathComponent:@"AsynIamge"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:tmpPath]) {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
        
        NSArray *lineArray = [self.imageUrl componentsSeparatedByString:@"/"];
        self.fileName = [NSString stringWithFormat:@"%@/%@",tmpPath,[lineArray objectAtIndex:[lineArray count]-1]];
        NSLog(@"save dir = %@ " , tmpPath);
        NSLog(@"fileName dir = %@" , self.fileName);
        NSLog(@"readName dir = %@" , _fileName);
        if ([fm fileExistsAtPath:_fileName]) {
            //下载图片
            NSLog(@"REMOVE OLD IMAGE");
            BOOL blDele= [fm removeItemAtPath:_fileName error:nil];
            if (blDele) {
                NSLog(@"dele success");
            }else {
                NSLog(@"dele fail");
            }
        }
        [self loadImageNeedCache:NO];
       
    }

}



- (void)setImageUrl:(NSString *)imageUrl{
    if (imageUrl != _imageUrl) {
        self.image = _placeholderImage;
//        [_imageUrl release];
//        _imageUrl = [imageUrl retain];
        _imageUrl = imageUrl;
    }
    
    if (self.imageUrl) {
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir = [path objectAtIndex:0];
        NSString *tmpPath = [docDir stringByAppendingPathComponent:@"AsynIamge"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:tmpPath]) {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
        
        NSArray *lineArray = [self.imageUrl componentsSeparatedByString:@"/"];
        self.fileName = [NSString stringWithFormat:@"%@/%@",tmpPath,[lineArray objectAtIndex:[lineArray count]-1]];
        NSLog(@"save dir = %@ " , tmpPath);
        NSLog(@"fileName dir = %@" , self.fileName);
        NSLog(@"readName dir = %@" , _fileName);
        if (![fm fileExistsAtPath:_fileName]) {
            //下载图片
            NSLog(@"DOWN IMAGE");
            [self loadImageNeedCache:YES];
        }else{
            //已经缓存过了
            NSLog(@"READ IMAGE");
            NSData *data = [NSData dataWithContentsOfFile:_fileName];
        
            self.image = [UIImage imageWithData:data];
        }
    }
    
}



//请求网络图片，缓存到本地沙盒中
- (void)loadImageNeedCache:(BOOL) isCache{
    
    //对路径进行
    @try {
        //定义一个缓存并设置大小
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        
        [urlCache setMemoryCapacity:NSURL_CACHE_SIZE];
        
        //设置请求超时时间为30s
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.imageUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        
        //从请求中获取数据
        NSLog(@"从请求中获取数据");
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        if (response != nil && isCache) {
            //有缓存输出的话，从缓存中获取数据
            NSLog(@"有缓存输出的话，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        if (!connection) {
            NSLog(@"开始连接 下载");
            connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
            
            UIApplication *app = [UIApplication sharedApplication];
            app.networkActivityIndicatorVisible = YES;
            [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            
        }
    }
    @catch (NSException *exception) {
        //下载失败
        NSLog(@"下载失败，网络异常或者没有资源");
    }
    @finally {
        NSLog(@"Finall ");
    }
}
//请求成功，且接收数据(每接收一次调用一次函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(loadData==nil)
    {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
    NSLog(@"将缓存输出");
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    NSLog(@"即将发送请求");
    return request;
}
//下载完成，将文件保存到沙河里面
-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    NSLog(@"图片已经成功下载到本地缓存，指定图片  path = %@" ,_fileName);
    //图片已经成功下载到本地缓存，指定图片
    if([loadData writeToFile:_fileName atomically:YES])
    {
        //对图片进行缩放
        UIImage* before = [UIImage imageWithContentsOfFile:_fileName];
        NSLog(@" SIZE before = %f , %f" ,before.size.width , before.size.height);
        
        UIImage* after = [self scaleImage:before ToSize:self.frame.size];
        NSLog(@" SIZE after = %f , %f" ,after.size.width , after.size.height);
        
        self.image = after;
    }
    
    connection = nil;
    loadData = nil;
    retryTimes = 0;
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIImage *i;
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    [img drawInRect:imageRect];
    i=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}
//网络连接错误或者请求成功但是加载数据异常
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    NSLog(@"如果发生错误，则重新加载");
    //如果发生错误，则重新加载
    
    retryTimes++;
    connection = nil;
    loadData = nil;
    
    if (retryTimes < RETRY_TIMES) {
        
        [self loadImageNeedCache:YES];
    }else{
        
        retryTimes = 0 ;
    }
    
}

@end
