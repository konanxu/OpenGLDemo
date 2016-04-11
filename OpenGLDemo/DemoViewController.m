//
//  DemoViewController.m
//  OpenGLDemo
//
//  Created by Konan on 16/4/11.
//  Copyright © 2016年 Konan. All rights reserved.
//

#pragma mark - 查阅文章
//http://blog.csdn.net/xiajun07061225/article/details/7455283
//http://blog.sina.com.cn/s/blog_3e50cef401019cxq.html
#pragma mark -

#import "DemoViewController.h"

typedef struct {
    GLKVector3 positionCoords;
} T_Vertex;

static const T_Vertex vertices [] = {
//    {{-1,0}},{{0,0.5}},{{1,0}},{{0,-0.5}}
    
    { -0.90, -0.90 },  // Triangle 1
    {  0.85, -0.90 },
    { -0.90,  0.85 },
    {  0.90, -0.85 },  // Triangle 2
    {  0.90,  0.90 },
    { -0.85,  0.90 }
};

static GLfloat colors[] = {
    1,0,0,1,
    0,0,1,1,
    0,1,0,1,
    1,0,0,1,
    0,1,0,1,
    0,0,1,1
};
static float  transY ;



typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    {{1, -1, 0}, {1, 0, 0, 1}},
    {{1, 1, 0}, {0, 1, 0, 1}},
    {{-1, 1, 0}, {0, 0, 1, 1}},
    {{-1, -1, 0}, {0, 0, 0, 1}}
};



@interface DemoViewController ()<GLKViewDelegate>
{
    GLuint vertexBufferID;
    GLuint vertexBufferID2;
}

@property (nonatomic,strong)GLKBaseEffect *baseEffect;
@end

@implementation DemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //获取上下文
    GLKView *view = (GLKView *)self.view;
        view.backgroundColor = [UIColor whiteColor];
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 0.0f, 0.0f, 1.0f);
    
//    self.baseEffect.colorMaterialEnabled = GL_TRUE;
    glClearColor(1.f, 1.f, 1.f, 1.f);
    
    
    
    
    
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_DYNAMIC_DRAW);
//    
//    glGenBuffers(1, &vertexBufferID);
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_DYNAMIC_DRAW);
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    
    
    //创建一个2维的投影矩阵
    //1:左边坐标2:右边坐标
    //3:下面坐标4:上面坐标
    //5:近处坐标6:远处坐标
    //其实就是定义一个视野区域，就是确定镜头看到的东西(设置镜头的大小)
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(-2, 2, -3.51, 3.51, -1, 1);
    //使用创建的矩阵作为投影矩阵
    self.baseEffect.transform.projectionMatrix = projectionMatrix;
    
    self.baseEffect.transform.modelviewMatrix = GLKMatrix4MakeTranslation(0, (GLfloat)sinf(transY/2.0f), 0);
    transY += 0.1f;
    
    glClear(GL_COLOR_BUFFER_BIT);
    
//    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    
    
    //传递数据
    //1:传递是什么数据？这里是顶点位置数据GLKVertexAttribPosition
    //2:数据的大小(每个点的数据个数，我们每个点只有xy2个值所以是2，如果做三维的话还有z坐标，那么就是3)
    //3:顶点的数据类型，我们定义的是GLfloat数组所以是GL_FLOAT，如果用int定义顶点那么就是GL_INT.。。
    //4:这个。。一般都是GL_FALSE
    //5:跨度值，简单来讲，就是隔多少个值取一个点。假如设为1(这个1不是真正的1,因为跨度是按内存空间来算的)，
    //就是1个单位，那么我们就只能取到1,3,5.。。24被跨过去了。这个在使用顶点结构体的时候会有用，现在设为0
    //6:数据的地址，就是数组的名字
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(T_Vertex), vertices);
    
    
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 0, colors);
    
//    GL_TRIANGLES GL_TRIANGLE_STRIP GL_TRIANGLE_FAN 不同解释
    /*
    GL_TRIANGLES是以每三个顶点绘制一个三角形。第一个三角形使用顶点v0,v1,v2,第二个使用v3,v4,v5,以此类推。如果顶点的个数n不是3的倍数，那么最后的1个或者2个顶点会被忽略。
    
    GL_TRIANGLE_STRIP则稍微有点复杂。
    其规律是：
    构建当前三角形的顶点的连接顺序依赖于要和前面已经出现过的2个顶点组成三角形的当前顶点的序号的奇偶性（如果从0开始）：
    如果当前顶点是奇数：
    组成三角形的顶点排列顺序：T = [n-1 n-2 n].
    如果当前顶点是偶数：
    组成三角形的顶点排列顺序：T = [n-2 n-21 n].
    以上图为例，第一个三角形，顶点v2序号是2，是偶数，则顶点排列顺序是v0,v1,v2。第二个三角形，顶点v3序号是3，是奇数，则顶点排列顺序是v2,v1,v3,第三个三角形，顶点v4序号是4，是偶数，则顶点排列顺序是v2,v3,v4,以此类推。
    这个顺序是为了保证所有的三角形都是按照相同的方向绘制的，使这个三角形串能够正确形成表面的一部分。对于某些操作，维持方向是很重要的，比如剔除。
    注意：顶点个数n至少要大于3，否则不能绘制任何三角形。
    
    GL_TRIANGLE_FAN与GL_TRIANGLE_STRIP类似，不过它的三角形的顶点排列顺序是T = [n-1 n-2 n].各三角形形成一个扇形序列。
    */
    
    glDrawArrays(GL_TRIANGLES, 0, 6);
    
    
    
    glDisableVertexAttribArray(GLKVertexAttribPosition);
    glDisableVertexAttribArray(GLKVertexAttribColor);

    
}


@end
