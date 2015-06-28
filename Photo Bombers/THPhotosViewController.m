//
//  THPhotosViewController.m
//  Photo Bombers
//
//  Created by Sam Soffes on 1/28/14.
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "THPhotosViewController.h"
#import "THPhotoCell.h"
#import "THDetailViewController.h"

#import <SimpleAuth/SimpleAuth.h>

@interface THPhotosViewController ()

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;

@end

@implementation THPhotosViewController

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Photo Bombers";
    
    [self.collectionView registerClass:[THPhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //connect to instagram with access token and get list of photos from api
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    
    if (self.accessToken == nil) { //not logged in
        //launch authorization
        //sets up instagram authorization
        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"]} completion:^(NSDictionary *responseObject, NSError *error) {
            
            self.accessToken = responseObject[@"credentials"][@"token"];
            //save access token to access it later
            
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            
            //cause view to reload after sign in
            [self refresh];
        }];
    } else {
        [self refresh];
    }
    
}

- (void)refresh {
    //obtains all the information about photos that used "breaking bad" tag
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/breakingbad/media/recent?access_token=%@", self.accessToken];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        //transfer JSON into objective-c objects (returns dictionary with arrays, strings, etc.)
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //obtain all photos
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.collectionView reloadData];
        });
        
    }];
    [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *photo = self.photos[indexPath.row];
    THDetailViewController *viewController = [[THDetailViewController alloc] init];
    viewController.photo = photo;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end









