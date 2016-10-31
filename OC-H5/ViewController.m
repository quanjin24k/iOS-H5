//
//  ViewController.m
//  OC-H5
//
//  Created by hubery on 2016/10/14.
//  Copyright © 2016年 hubery. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate, UINavigationControllerDelegate, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webview.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

#pragma mark 操作网页
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //～～～～～～～～～～～～～～～～～～～～OC-加载H5～～～～～～～～～～～～～～～～～～～～～～～～～
    //删除
//    NSString *str1 = @"var word = document.getElementById('word');";
//    NSString *str2 = @"word.remove();";
//    
//    [webView stringByEvaluatingJavaScriptFromString:str1];
//    [webView stringByEvaluatingJavaScriptFromString:str2];
//    
//    //更改
//    NSString *str3 = @"var change = document.getElementsByClassName('change')[0];change.innerHTML = '好你的猫哦！';";
//    [webView stringByEvaluatingJavaScriptFromString:str3];
//    
//    //插入 pic
//    NSString *str4 = @"var img = document.createElement('img'); img.src='mode_show0.png';img.width='60';img.height='40';document.body.appendChild(img);";
//    [webView stringByEvaluatingJavaScriptFromString:str4];
    //～～～～～～～～～～～～～～～～～～～～OC-加载H5～～～～～～～～～～～～～～～～～～～～～～～～～
}

//在此自定义下协议头：xmg://  H5调用OC
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str = request.URL.absoluteString;
    NSLog(@"%@", str);
    NSRange range = [str rangeOfString:@"xmg://"];
    if (range.location != NSNotFound) {
        NSString *method = [str substringFromIndex:range.location + range.length];
        NSLog(@"%@", method);//截取到H5中的函数
        //包装所截函数， sel=getImage
        SEL sel = NSSelectorFromString(method);
        [self performSelector:sel];//执行下方的访问相册函数getImage
    }
    
    return YES;
}

//访问相册
-(void)getImage
{
    NSLog(@"选择图片OC函数");
    UIImagePickerController *pickerImg = [[UIImagePickerController alloc] init];
    pickerImg.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerImg animated:YES completion:nil];
}

@end
