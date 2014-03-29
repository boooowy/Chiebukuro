//
//  QuestionListViewConroller.m
//  Chiebukuro
//
//  Created by 萱島克英 on 2014/03/24.
//  Copyright (c) 2014年 private_company. All rights reserved.
//

#import "QuestionListViewConroller.h"
#import "WebViewController.h"

@interface QuestionListViewConroller()
@property(strong,nonatomic) NSArray *questions;
@end


@implementation QuestionListViewConroller
-(void)viewDidLoad {
    [super viewDidLoad];
   // self.questions = @[@"question1",@"question2",@"question3"];
//    [self.tableView reloadData];
    [self fetchNewQuestions];
}

-(void)fetchNewQuestions {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://chiebukuro.yahooapis.jp/Chiebukuro/V1/getNewQuestionList?appid=dj0zaiZpPXI3Y2lNQ3Fwb1FVWiZzPWNvbnN1bWVyc2VjcmV0Jng9YmI-&condition=open&results=20&output=json"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            // 通信失敗
            NSLog(@"error");
        }
        
        //通信が正常終了した時の処理
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError != nil) {
            return;
        }
        
        self.questions = jsonDictionary[@"ResultSet"][@"Result"];
        NSLog(@"queston:%@", self.questions);
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    }];
    
    // 通信開始
    [task resume];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

//- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *cellId = @"Celld";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//    cell.textLabel.text = self.questions[indexPath.row];
//    return cell;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    NSDictionary *questionDic = self.questions[indexPath.row];
    NSLog(@"result:%@",questionDic[@"Category"]);
    cell.textLabel.text = questionDic[@"Content"];
    cell.detailTextLabel.text = questionDic[@"Category"];

    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell*)sender;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *question = self.questions[indexPath.row];
    WebViewController *viewController = [segue destinationViewController];
    viewController.url = [NSURL URLWithString:question[@"QuestionUrl"]];
}




@end
