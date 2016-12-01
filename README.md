

# 开始之前
所用到的类:
CAGradientLayer;
*  可以生成两个或者更多颜色平滑渐变.
*  colors : 存放渐变颜色的数组
*  locations: 渐变颜色的区间分布
*  startPoint: 映射locations中的第一个位置,用单位向量表示.
*  endpoint: 映射locations中的最后一个位置,用单位向量表示.
*  type: 默认值是kCAGradientLayerAxial，表示按像素均匀变化。除了默认值也无其它选项。

CAShapeLayer;
*  CALayer 的子类,但比CALayer更灵活,可以画出各种图形.

CAKeyframeAnimation;
*  关键帧动画,前边博文有详细讲到,在这就不细说了.

# 开始画画

DrawHelper此类存放画好的path:
	![images](https://raw.githubusercontent.com/Josin22/JSCatSwitch/master/Source/switch44.png)

JSCatSwitch此类存放layer属性:
	![images](https://raw.githubusercontent.com/Josin22/JSCatSwitch/master/Source/switch33.png)

在点击事件里触发动画:

	![images](https://raw.githubusercontent.com/Josin22/JSCatSwitch/master/Source/switch22.png)


在controller里调动:
	![images](https://raw.githubusercontent.com/Josin22/JSCatSwitch/master/Source/switch11.png)
	

# 主要画画方法讲解
UIBezierPath 里主要方法讲解:


//画二元曲线，一般和moveToPoint配合使用
*  addQuadCurveToPoint:controlPoint;  
//以某个中心点画弧线
*  addArcWithCenter:radius:startAngle:endAngle:clockwise;
//以三个点画一段曲线，一般和moveToPoint配合使用
*  addCurveToPoint:controlPoint1:controlPoint2;
//根据矩形框的内切圆画曲线
*  bezierPathWithOvalInRect:


# 最终显示效果
![images](https://raw.githubusercontent.com/Josin22/JSCatSwitch/master/Source/CatSwitch.gif)






