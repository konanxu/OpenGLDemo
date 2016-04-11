//
//  Demo2ViewController.m
//  OpenGLDemo
//
//  Created by Konan on 16/4/11.
//  Copyright © 2016年 Konan. All rights reserved.
//

#import "Demo2ViewController.h"

@interface Demo2ViewController ()<GLKViewDelegate, GLKViewControllerDelegate>
@property(nonatomic, strong) GLKBaseEffect * bEffect;
@property(nonatomic, strong) EAGLContext * ctx;
@property(nonatomic, strong) GLKView * graphicViewer;
@end

@implementation Demo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    _graphicViewer = (GLKView *) self.view;
    _graphicViewer.context = _ctx;
    _graphicViewer.delegate = self;
    
    _graphicViewer.drawableColorFormat = GLKViewDrawableColorFormatRGB565;
    _graphicViewer.drawableStencilFormat = GLKViewDrawableStencilFormat8;
    _graphicViewer.drawableDepthFormat = GLKViewDrawableDepthFormat16;
    
    self.preferredFramesPerSecond = 60;
    self.delegate=self;
    _bEffect = [[GLKBaseEffect alloc] init];
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [_bEffect prepareToDraw];
    static const GLfloat Vertices[] = {
        -1.5f, -1.5f, 1,
        0.5f, -0.5f, 1,
        -0.5f,  0.5f, 1,
        0.5f,  0.5f, 1
    };
    
    
    //This the RGB colors to draw
    static const GLubyte Colors[] = {
        255, 255,   0, 125,
        0,   255, 255, 255,
        0,   255,   0,   255,
        255,   0, 255, 255,
    };
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    glClear(GL_DEPTH_BUFFER_BIT);
    glClear(GL_STENCIL_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, Vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, 0, Colors);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 10);
    
    
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);
}

- (void)glkViewControllerUpdate:(GLKViewController *)controller{
    static float posY = 0.0f;
    float y = sinf(posY)/2.0f;
    posY += 0.355f;
    
    GLKMatrix4 modelviewmatrix  = GLKMatrix4MakeTranslation(0, y, -5.0f);
    _bEffect.transform.modelviewMatrix = modelviewmatrix;
    
    GLfloat ratio = self.view.bounds.size.width/self.view.bounds.size.height;
    GLKMatrix4 projectionmatrix = GLKMatrix4MakePerspective(45.0f, ratio, 0.1f, 20.0f);
    _bEffect.transform.projectionMatrix = projectionmatrix;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
