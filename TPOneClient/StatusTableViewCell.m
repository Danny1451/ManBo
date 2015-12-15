//
//  StatusTableViewCell.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/2.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "CommonUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoBroswerVC.h"

@implementation StatusTableViewCell

- (void)showDate:(Status *)model{
    
    self.modelStatus = model;
    
    self.userNameLab.text = model.user.name;
    self.timeCreatedLab.text = [CommonUtils sinaDateToTargetDate:model.timeCreated target:@"yyyy-MM-dd HH:mm:ss"];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.user.profileUrl] placeholderImage:[UIImage imageNamed:@"ico_avatar_normal.png"]];
    
    self.textLab.text = model.text;
    [self.textLab sizeToFit];
    
    
    [self.repostLab setText:[NSString stringWithFormat:@"转发:%d", (int)model.repostCount]];
    [self.repostLab sizeToFit];
    
    [self.commentLab setText:[NSString stringWithFormat:@"评论:%d", (int)model.commentsCount]];
    [self.commentLab sizeToFit];
    
    
    
    [self.attitudeLab setText:[NSString stringWithFormat:@"点赞:%d", (int)model.attitudeCount]];
    [self.attitudeLab sizeToFit];
    
    
    self.picBroswer.images = self.images;
    
    
    
    self.picBroswer.ClickImageBlock =  ^(NSUInteger index){
        
        //本地图片展示
        [self networkImageShow:index];
        
        
    };

    
    
    
}

- (void)addImageView:(NSArray*) images{
    
    if (images.count > 0) {
        
    }
    
    //UIImageView*
    
}


/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index{
    
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self.parentView type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
      
//        NSArray *networkImages=@[
//                                 @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
//                                 @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
//                                 @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
//                                 @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
//                                 @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
//                                 
//                                 @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
//                                 
//                                 @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
//                                 
//                                 @"http://www.netbian.com/d/file/20140724/fefe4f48b5563da35ff3e5b6aa091af4.jpg",
//                                 
//                                 @"http://www.netbian.com/d/file/20140529/95e170155a843061397b4bbcb1cefc50.jpg"
//                                 ];
        NSMutableArray *networkImages = [[NSMutableArray alloc] init];
        
        for (id temp in _modelStatus.picurl) {
            NSString* newurl = [CommonUtils picUrl:temp Format:PicBmiddle];
            [networkImages addObject:newurl];

        }
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.title = [NSString stringWithFormat:@"%@/%d",@(i+1),networkImages.count];
            pbModel.desc = _modelStatus.text;
            pbModel.image_HD_U = networkImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.picBroswer.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}



- (CGFloat)getCellHeight{
    
    
    CGFloat labHeight = self.textLab.frame.size.height;
    
    
    NSUInteger maxRow = 3;
    
    
    if (self.images.count > 6) {
        maxRow = 3;
    }else if (self.images.count > 3){
        maxRow = 3;
    }else if (self.images.count > 0){
        maxRow = self.images.count;
    }
    
    int picHigh = ((self.picBroswer.frame.size.width - 20) - PIC_GAP * (maxRow - 1)) / maxRow;
    TRACE(@" picHigh = %d" , picHigh);
    if (self.modelStatus.picurl.count == 0) {
        return labHeight + 130;
    }else if (self.modelStatus.picurl.count > 6){
        return labHeight + 130 + picHigh * 3 + PIC_GAP * 2;
    }else if (self.modelStatus.picurl.count > 3){
        return labHeight + 130 + picHigh * 2 + PIC_GAP ;
    }else{
        return labHeight + 130 + picHigh;
    }
    
    
}


//---------------------Lazy init ----------------
- (NSArray*)images{
    
    if (_images == nil) {
        NSMutableArray *arrayM = [NSMutableArray array];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        for (id temp  in self.modelStatus.picurl) {
            
            [manager downloadImageWithURL:temp
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            }
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                                    if (image)
                                    {
                                        // do something with image
                                        
                                        [arrayM addObject:image];
                                    }
            }];
            
        }
        
        
        
        
        _images = arrayM;
    }
    return _images;
}

@end
