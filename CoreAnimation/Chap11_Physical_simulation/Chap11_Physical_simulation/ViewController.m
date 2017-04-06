//
//  ViewController.m
//  Chap11_Physical_simulation
//
//  Created by Joonwon Lee on 3/27/17.
//  Copyright © 2017 joonwon. All rights reserved.
//

#import "ViewController.h"
#import "chipmunk.h"

@interface Crate : UIImageView

@property (nonatomic, assign) cpBody *body;
@property (nonatomic, assign) cpShape *shape;

@end

@implementation Crate

#define  MASS 100

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"Crate.png"];
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        self.body = cpBodyNew(MASS, cpMomentForBox(MASS, frame.size.width, frame.size.height));
        
        cpVect corners[] = {
            cpv(0, 0),
            cpv(0, frame.size.height),
            cpv(frame.size.width, frame.size.height),
            cpv(frame.size.width, 0)
        };
        self.shape = cpPolyShapeNew(self.body, 4, corners, cpv(-frame.size.width/2, -frame.size.height/2));
        cpShapeSetFriction(self.shape, 0.5);
        cpShapeSetElasticity(self.shape, 0.8);
        
        self.shape->data = (__bridge void *)self;
        cpBodySetPos(self.body, cpv(frame.origin.x + frame.size.width/2, 300 - frame.origin.y - frame.size.height/2));
    }
    return self;
}

- (void)dealloc {
    cpShapeFree(_shape);
    cpBodyFree(_body);
}

@end



@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, assign) cpSpace *space;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CFTimeInterval lastStep;

@end

@implementation ViewController

#define GRAVITY 1000

- (void)addCrateWithFrame:(CGRect)frame
{
    Crate *crate = [[Crate alloc] initWithFrame:frame]; [self.containerView addSubview:crate]; cpSpaceAddBody(self.space, crate.body); cpSpaceAddShape(self.space, crate.shape);
}

- (void)addWallShapeWithStart:(cpVect)start end:(cpVect)end
{
    cpShape *wall = cpSegmentShapeNew(self.space->staticBody, start, end, 1); cpShapeSetCollisionType(wall, 2);
    cpShapeSetFriction(wall, 0.5);
    cpShapeSetElasticity(wall, 0.8);
    cpSpaceAddStaticShape(self.space, wall);
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    //update gravity
    cpSpaceSetGravity(self.space, cpv(acceleration.y * GRAVITY,
                                      -acceleration.x * GRAVITY));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //invert view coordinate system to match physics
    self.containerView.layer.geometryFlipped = YES;
    //set up physics space
    self.space = cpSpaceNew(); cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
    //add wall around edge of view
    [self addWallShapeWithStart:cpv(0, 0) end:cpv(300, 0)]; [self addWallShapeWithStart:cpv(300, 0) end:cpv(300, 300)]; [self addWallShapeWithStart:cpv(300, 300) end:cpv(0, 300)]; [self addWallShapeWithStart:cpv(0, 300) end:cpv(0, 0)];
    //add a crates
    [self addCrateWithFrame:CGRectMake(0, 0, 32, 32)]; [self addCrateWithFrame:CGRectMake(32, 0, 32, 32)]; [self addCrateWithFrame:CGRectMake(64, 0, 64, 64)]; [self addCrateWithFrame:CGRectMake(128, 0, 32, 32)]; [self addCrateWithFrame:CGRectMake(0, 32, 64, 64)];
    //start the timer
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)]; [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    //update gravity using accelerometer
    [UIAccelerometer sharedAccelerometer].delegate = self;
    [UIAccelerometer sharedAccelerometer].updateInterval = 1/60.0;
    
    
//    //invert view coordinate system to match physics
//    self.containerView.layer.geometryFlipped = YES;
//    //set up physics space
//    self.space = cpSpaceNew(); cpSpaceSetGravity(self.space, cpv(0, -GRAVITY));
//    //add a crate
//    Crate *crate = [[Crate alloc] initWithFrame:CGRectMake(100, 0, 100, 100)]; [self.containerView addSubview:crate];
//    cpSpaceAddBody(self.space, crate.body);
//    cpSpaceAddShape(self.space, crate.shape);
//    
//    //start the timer
//    self.lastStep = CACurrentMediaTime();
//    self.timer = [CADisplayLink displayLinkWithTarget:self
//                                             selector:@selector(step:)];
//    
//    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

#define SIMULATION_STEP (1/120.0)

- (void)step:(CADisplayLink *)timer {
    //calculate frame step duration
    CFTimeInterval frameTime = CACurrentMediaTime();
    //update simulation
    while (self.lastStep < frameTime) {
        cpSpaceStep(self.space, SIMULATION_STEP);
        self.lastStep += SIMULATION_STEP; }
    //update all the shapes
    cpSpaceEachShape(self.space, &updateShape, NULL);
}

void updateShape(cpShape *shape, void *unused)
{
    //get the crate object associated with the shape
    Crate *crate = (__bridge Crate *)shape->data;
    //update crate view position and angle to match physics shape
    cpBody *body = shape->body;
    crate.center = cpBodyGetPos(body);
    crate.transform = CGAffineTransformMakeRotation(cpBodyGetAngle(body));
}

//- (void)step:(CADisplayLink *)timer
//{
//    //calculate step duration
//    CFTimeInterval thisStep = CACurrentMediaTime(); CFTimeInterval stepDuration = thisStep - self.lastStep; self.lastStep = thisStep;
//    //update physics
//    cpSpaceStep(self.space, stepDuration);
//    //update all the shapes
//    cpSpaceEachShape(self.space, &updateShape, NULL);
//}

@end
