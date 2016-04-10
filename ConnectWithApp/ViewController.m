//
//  ViewController.m
//  ConnectWithApp
//
//  Created by tops on 4/11/16.
//  Copyright (c) 2016 tops. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url=[NSURL URLWithString:@"http://localhost/logintest/insertdata.php"];//place your url link
    
    NSString *st_body=[NSString stringWithFormat:@"e_nm=%@&e_ct=%@&e_unm=%@&e_upass=%@",@"chirag",@"baroda",@"chirag",@"chirag"];
    
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc]initWithURL:url];
    [req setHTTPBody:[st_body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPMethod:@"POST"];
    
    NSURLConnection *con=[[NSURLConnection alloc]initWithRequest:req delegate:self];
    if (con)
    {
        datamute=[[NSMutableData alloc]init];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    datamute.length=0;
    NSLog(@"didReceiveResponse");
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error description]);
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datamute appendData:data];
    NSLog(@"didReceiveData");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSString *str=[[NSString alloc]initWithData:datamute encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:datamute options:kNilOptions error:nil];
    NSLog(@"%@",[dict objectForKey:@"msg"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
