//
//  ViewController.m
//  ReactiveObjcTest
//
//  Created by yangjingwei on 2017/9/27.
//  Copyright © 2017年 yangjingwei. All rights reserved.
//
//基于函数响应式编程，链式编程思想
#import "ViewController.h"

#import <ReactiveObjC.h>
#import <objc/runtime.h>

#import "Person.h"
#import "Person1.h"

#import "Student.h"

@interface ViewController ()<UIAlertViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) Student *stu;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //0.简单链式编程举例
//    [self test0];
    
    //1.创建signal
//    [self createSignal];
    
    //2.简单的如何使用RAC来实现KVO
//    [self useRACSignal];
    
    //3.我们再看看RAC如何帮我们实现target-action
//    [self btnClick];
    
    //4.点击手势
//    [self tapGesture];
    
    //5.通知的使用
//    [self notification];
    
    //6.代理的应用
//    [self delegate];
    
    //7.我们先从UITextView+RACSignalSupport.h开始看
//    [self textViewTest];
    
    //8.UITextField+RACSignalSupport.h的用法
//    [self textFieldTest];
    
    //9.UIActionSheet+RACSignalSupport.h
//    [self actionSheetTest];
    
    //10.UIAlertView+RACSignalSupport.h
//    [self alertViewTest];
    
    //11.UIControl+RACSignalSupport.h的用法
//    [self controlTest];
    
    //12.UIDatePicker+RACSignalSupport.h的用法
//    [self datePickerTest];
    
    //13.UIImagePickerController+RACSignalSupport.h
//    [self imagePickerTest];
    
    //14.UISegmentedControl+RACSignalSupport.h
//    [self segmentTest];
    
    //15.UISlider+RACSignalSupport.h
//    [self sliderTest];
    
    //16.UIStepper+RACSignalSupport.h
//    [self stepperTest];
    
    //17.UISwitch+RACSignalSupport.h
    [self switchTest];
    
    //18.UITableViewCell+RACSignalSupport.h
    [self tableViewCellTest];
    
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.stu.age = @"1000";
    
#warning --- 发送通知,第5个点是通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil userInfo:nil];
}

//18.UITableViewCell+RACSignalSupport.h
//有一个rac_prepareForReuseSignal属性, 看字面意思就很清除准备复用时调用
- (void) tableViewCellTest{
    /*
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
     if (!cell) {
     
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
     }
     
     cell.textLabel.text = @"cell";
     
     [[cell
     rac_prepareForReuseSignal]
     subscribeNext:^(RACUnit * _Nullable x) {
     
     NSLog(@"开始复用");
     }];
     
     
     return cell;
     }
     */
}


//17.UISwitch+RACSignalSupport.h
- (void)switchTest{
    // 创建一个UISwitch
    UISwitch *aswitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    aswitch.center = self.view.center;
    
    [self.view addSubview:aswitch];
    
    // 创建一个UITextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    
    [self.view addSubview:textField];
    
    // 获取aswitch的channelTerminal
    RACChannelTerminal *aswitchTerminal = [aswitch rac_newOnChannel];
    
    // 获取textField的channelTerminal
    RACChannelTerminal *textFieldTerminal = [textField rac_newTextChannel];
    
    [[aswitchTerminal
      map:^id _Nullable(id  _Nullable value) {
          
          if ([value boolValue]) {
              
              return @"1";
          }
          
          return @"0";
      }]
     subscribe:textFieldTerminal];
}


//16.UIStepper+RACSignalSupport.h
- (void) stepperTest{
    // 创建一个UIStepper
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    stepper.center = self.view.center;
    
    [self.view addSubview:stepper];
    
    // 创建一个UITextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    
    [self.view addSubview:textField];
    
    // 获取stepper的channelTerminal
    RACChannelTerminal *stepperTerminal = [stepper rac_newValueChannelWithNilValue:0];
    
    // 获取textField的channelTerminal
    RACChannelTerminal *textFieldTerminal = [textField rac_newTextChannel];
    
    
    [[stepperTerminal
      map:^id _Nullable(id  _Nullable value) {
          
          return [NSString stringWithFormat:@"%@", value];
      }]
     subscribe:textFieldTerminal];
}


//15.UISlider+RACSignalSupport.h
- (void) sliderTest{
    // 创建一个UISlider
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    slider.center = self.view.center;
    
    [self.view addSubview:slider];
    
    // 创建一个UITextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    
    [self.view addSubview:textField];
    
    // 获取slider的channelTerminal
    RACChannelTerminal *sliderTerminal = [slider rac_newValueChannelWithNilValue:0];
    
    // 获取textField的channelTerminal
    RACChannelTerminal *textFieldTerminal = [textField rac_newTextChannel];
    
    
    
    [[sliderTerminal
      map:^id _Nullable(id  _Nullable value) {
          
          return [NSString stringWithFormat:@"%@", value];
      }]
     subscribe:textFieldTerminal];
}

//14.UISegmentedControl+RACSignalSupport.h
//可以把分段选择器的选择结果直接绑定给其他控件, 或者拿去做别的
- (void) segmentTest{
    // 创建一个UISegementController
    UISegmentedControl *segmentController = [[UISegmentedControl alloc] initWithItems:@[@"One", @"Two"]];
    segmentController.frame = CGRectMake(0, 0, 160, 40);
    segmentController.center = self.view.center;
    [self.view addSubview:segmentController];
    
    // 创建一个UITextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:textField];
    
    // 获取segement的channelTerminal
    RACChannelTerminal *segmentTerminal = [segmentController rac_newSelectedSegmentIndexChannelWithNilValue:0];
    
    // 获取textField的channelTerminal
    RACChannelTerminal *textFieldTerminal = [textField rac_newTextChannel];
    
    // 把segementdeterminal结果处理后绑定给textfieldTerminal
    [[segmentTerminal
      map:^id _Nullable(id  _Nullable value) {
          
          if ([value  isEqual: @(1)]) {
              
              return @"选择了: Two";
          } else {
              
              return @"选择了: One";
          }
      }]
     subscribe:textFieldTerminal];
}


//13.UIImagePickerController+RACSignalSupport.h
//一个取消按钮的代理, 一个选择完毕的代理,
- (void) imagePickerTest{
    // 创建一个RACDelegateProxy
    RACDelegateProxy *imgPickerDelegateProxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UIImagePickerControllerDelegate)];
    
    // 绑定取消代理事件
    [[imgPickerDelegateProxy
      rac_signalForSelector:@selector(imagePickerControllerDidCancel:)]
     subscribeNext:^(RACTuple * _Nullable x) {
         //点击取消返回的x是imgPickerController本身, 转义后直接拿来dismiss即可
         NSLog(@"取消代理: %@", x);
         UIImagePickerController *imgPicker = x[0];
         [imgPicker dismissViewControllerAnimated:YES completion:nil];
     }];
    
    // 绑定选择完毕事件
    [[imgPickerDelegateProxy
      rac_signalForSelector:@selector(imagePickerController:didFinishPickingImage:editingInfo:)]
     subscribeNext:^(RACTuple * _Nullable x) {
         //选择图片后x是一个数组, 第一个是imgPickerComtroller, 第二个是选择的image
         NSLog(@"选择完成: %@", x);
         self.view.backgroundColor = [UIColor colorWithPatternImage:x[1]];
         
         UIImagePickerController *imgPicker = x[0];
         [imgPicker dismissViewControllerAnimated:YES completion:nil];
     }];
    
    // 创建UIImagePickerController
    UIImagePickerController *imgPickerController = [[UIImagePickerController alloc] init];
    imgPickerController.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPickerController.allowsEditing = YES;
    
    // 设置代理为我们创建的delegateProxy
    // 这里注意一般UIImagePickerController需要实现UIImagePickerDelegate & UINavigationControllerDelegate, 但这里用RAC自带的方法只能设置一个代理
    // 不过其实RAC其实也只为UIImagePickerController处理了UIImagePickerControllerDelegate而已, 所以这里会有警告先不管它
    // 后面我们再想想其他方式,  是重新写一个UIImagePickerController分类还是重写方法什么的
    
    imgPickerController.delegate      = (id<UIImagePickerControllerDelegate,UINavigationControllerDelegate>)imgPickerDelegateProxy;
    
    
    // retain delegateProxy
    objc_setAssociatedObject(imgPickerController, _cmd, imgPickerDelegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self presentViewController:imgPickerController animated:YES completion:nil];
}


//12.UIDatePicker+RACSignalSupport.h的用法
//将UIDatePicker绑定给UITextField, 当我们滚动datePicker的时候 textField的值会跟着改变
- (void) datePickerTest{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    datePicker.center = self.view.center;
    datePicker.backgroundColor = [UIColor redColor];
    [self.view addSubview:datePicker];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 180, 35)];
    textField.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    textField.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textField];
    
    RACChannelTerminal *datePickerTerminal = [datePicker rac_newDateChannelWithNilValue:[NSDate date]];
    RACChannelTerminal *textFieldTerminal  = [textField rac_newTextChannel];
    
    [[datePickerTerminal
      map:^id _Nullable(id  _Nullable value) {
          
          NSLog(@"%@", value);
          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
          return [dateFormatter stringFromDate:value];
      }]
     subscribe:textFieldTerminal];
}


//11.UIControl+RACSignalSupport.h的用法
- (void)controlTest{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake(10, 150, 100, 35)];
    [button setBackgroundColor:[UIColor yellowColor]];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    
    [[button
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         
         NSLog(@"点击了按钮");
         x.backgroundColor = [UIColor redColor];
     }];
    
    [self.view addSubview:button];
}



//10.UIAlertView+RACSignalSupport.h
- (void) alertViewTest{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC Alert" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [[alert
      rac_buttonClickedSignal]
     subscribeNext:^(NSNumber * _Nullable x) {
         
         NSLog(@"click: x");
     }];
    
    [[alert
      rac_willDismissSignal]
     subscribeNext:^(NSNumber * _Nullable x) {
         
         NSLog(@"dismiss: %@", x);
     }];
    
    [alert show];
}

//9.UIActionSheet+RACSignalSupport.h
//1个属性和1个方法
- (void) actionSheetTest{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"RAC ActionSheet" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"OK" otherButtonTitles:@"Other", nil];
    
    [[actionSheet
      rac_buttonClickedSignal]
     subscribeNext:^(NSNumber * _Nullable x) {
         
         NSLog(@"%@", x);
     }];
    
    [actionSheet showInView:self.view];
}

//8.UITextField+RACSignalSupport.h的用法:
//有2个方法
- (void) textFieldTest{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 100, 30)];
    
    textField.backgroundColor = [UIColor yellowColor];
    //8.1 普通的用法
    [[textField
      rac_textSignal]
     subscribeNext:^(NSString * _Nullable x) {
         
         NSLog(@"%@", x);
     }];
    //8.2 可以当普通的用法，也可以做双向绑定
    [[textField
      rac_newTextChannel]
     subscribeNext:^(NSString * _Nullable x) {
         
         NSLog(@"%@", x);
     }];
    [self.view addSubview:textField];
    
    //下面是8.2双向绑定的用法
    UITextField *textFieldA = [[UITextField alloc] initWithFrame:CGRectMake(10, 190, 100, 30)];
    textFieldA.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textFieldA];
    
    UITextField *textFieldB = [[UITextField alloc] initWithFrame:CGRectMake(10, 230, 100, 30)];
    textFieldB.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:textFieldB];
    
    //实现双向绑定的简单方法,和夏面的方法实现的效果是一样的
    RACChannelTerminal *terminalA = [textFieldA rac_newTextChannel];
    RACChannelTerminal *terminalB = [textFieldB rac_newTextChannel];
    [terminalA subscribe:terminalB];
    [terminalB subscribe:terminalA];
    
    //实现双向绑定的简单方法,和上面的方法实现的效果是一样的
//    RACChannelTo(textFieldA, text) = RACChannelTo(textFieldB, text);
}



//7.我们先从UITextView+RACSignalSupport.h开始看,RACDelegateProxy:关于RACDelegateProxy这个类的用途大概是把初始化传入的代理绑定或者添加给当前正在处理的信号
- (void)textViewTest{
    // 以UITextViewDelegate来初始化一个RACDelegateProxy
    RACDelegateProxy *delegateProxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UITextViewDelegate)];
    
    // 注册要实现的方法
    [[delegateProxy
      rac_signalForSelector:@selector(textViewDidBeginEditing:)]
     subscribeNext:^(RACTuple * _Nullable x) {
         
         NSLog(@"开始编辑");
     }];
    [[delegateProxy
      rac_signalForSelector:@selector(textViewDidChange:)]
     subscribeNext:^(RACTuple * _Nullable x) {
         
         NSLog(@"正在编辑");
     }];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 150, 100, 100)];
    
    textView.backgroundColor = [UIColor greenColor];
    
    // 设置代理为我们创建的RACDelegateProxy, 注意要转义不然会有警告
    textView.delegate        = (id<UITextViewDelegate>)delegateProxy;
    
    [self.view addSubview:textView];
    
    [[textView
      rac_textSignal]
     subscribeNext:^(NSString * _Nullable x) {
         
         NSLog(@"%@", x);
     }];
    
    // retain我们创建的delegateProxy, 避免被释放
    objc_setAssociatedObject(textView, _cmd, delegateProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//6.代理的应用
/*
 另外要注意的是用RAC写代理是有局限的，它只能实现返回值为void的代理方法
 */
- (void) delegate{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC Delegate Test" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    //在这里遵守协议就行UIAlertViewDelegate，不需要在头文件里遵守了
    [[self
      rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)]
     subscribeNext:^(RACTuple * _Nullable x) {
         //RACTuple,这里的x是RACTuple，是一个元祖，可以点击去看这个元祖
         NSLog(@"%@", x);
         NSLog(@"%@",x[1]);//这个是索引
     }];
    
    [alertView show];
    
}

//5.通知的使用
#warning --- 接受通知
- (void) notification{
    [[[NSNotificationCenter defaultCenter]
      rac_addObserverForName:@"noti" object:nil]
     subscribeNext:^(NSNotification * _Nullable x) {
         
         NSLog(@"接到了通知");
     }];
}
//4.点击手势
- (void) tapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap
      rac_gestureSignal]
     subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
         
         NSLog(@"点击了view");
         NSLog(@"x: %@", x);
         x.view.backgroundColor = [UIColor blueColor];
     }];
    [self.tapView addGestureRecognizer:tap];
    
}

//3.我们再看看RAC如何帮我们实现target-action
- (void) btnClick{
    [[self.myButton
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         x.backgroundColor = [UIColor greenColor];
         NSLog(@"%@", x);
     }];
}

//2.简单的如何使用RAC来实现KVO
/*
 很方便对吧, 不用我们去add observe, 不用出来观察事件, 也不用我们去移除关注
 不过大家注意到了没, 这里添加关注后block立即执行了一次, 大家可以依据实际项目情况加个条件判断做处理.
 */
-(void) useRACSignal{
    Student *stu = [[Student alloc] init];
    
    // RAC KVO
    [RACObserve(stu, age) subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"stu的age改变为: %@", x);
    }];
    
    stu.age = @"10";
    self.stu = stu;
}


//1.创建signal
- (void) createSignal{
    // 创建一个信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"创建一个信号");
        
        // 发送信号
        [subscriber sendNext:@"发送一个信号"];
        
        return nil;
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅一个信号");
        NSLog(@"订阅到的: %@", x);
    }];
}

//0.简单链式编程举例
- (void)test0{
    [self test1];
    [self test2];
}
//普通的调用
- (void) test1{
    Person *person = [[Person alloc] init];
    [[person run] walk];
}
//链式编程
- (void) test2{
    // 调用block
    Person1 *person = [[Person1 alloc] init];
    person.runBlock().walkBlock();
}

@end
