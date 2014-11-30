//
//  MovingImages.m
//  TRAKART
//
//  Created by Mac Min on 21/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#import "MovingImages.h"
#import "Constants.h"
#import "MovingImageCollectionViewCell.h"
@implementation MovingImages

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    NSArray *arrNib = [[NSBundle mainBundle]loadNibNamed:@"MovingImages" owner:self options:nil];
    UIView *vwMyDetail = [arrNib lastObject];
    [self addSubview:vwMyDetail];
    
    [self initlization];
}


//+ (id)sharedManager {
//    static MovingImages *sharedMyManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedMyManager = [[self alloc] init];
//    });
//    return sharedMyManager;
//}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


-(void)initlization
{
    
    UINib *cellNib = [UINib nibWithNibName:KMovingImageCollectionViewNib bundle:nil];
    [vwCollectionView registerNib:cellNib forCellWithReuseIdentifier:KMoviewImageCollectionViewCellIdentifer];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
     CGRect screenRect = [[UIScreen mainScreen] bounds];
    [flowLayout setItemSize:screenRect.size];
    
    AppDelegate *delegate=(AppDelegate *)KAppDelegate;
    
    //NSLog(@"Size %@", NSStringFromCGSize(delegate.window.bounds.size));
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [vwCollectionView setCollectionViewLayout:flowLayout];
    
   arrAminationImages=[[NSMutableArray alloc]init];
    for (int i=1; i<=10; i++) {
        [arrAminationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Background.png"]]];
        
    }
    
    scrollIndex=0;
    
}


#pragma mark - UICollectionView Delegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrAminationImages.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;//arrAminationImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIImage *image = [arrAminationImages objectAtIndex:indexPath.row];
    MovingImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMoviewImageCollectionViewCellIdentifer forIndexPath:indexPath];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
  
    cell.frame=CGRectMake(cell.frame.origin.x-10, cell.frame.origin.y-10,screenRect.size.width+10,screenRect.size
                          .height+10);
    
    [cell setImage:image];

    return cell;

}

-(void)startAnimation
{
  
   self.scrollingTimer =[NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(moveImage)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)moveImage
{

    [vwCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollIndex inSection:0]
                      atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                              animated:YES];
    
    scrollIndex=(scrollIndex<arrAminationImages.count-1)?(scrollIndex+1):0;
    if(scrollIndex==0)
    {
         [self.scrollingTimer invalidate];
        [vwCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:scrollIndex inSection:0]
                                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                         animated:NO];
        
        [self startAnimation];
       
    }
    
}

-(void)invalidateTimer
{
    [self.scrollingTimer invalidate];
}



@end
