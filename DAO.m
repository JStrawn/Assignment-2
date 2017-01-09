//
//  DAO.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/12/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "Product.h"
#import "Company.h"

@implementation DAO
//se;lf.dao.company is eventually how i'm going to get company list
//


//ensures ONLY ONE DAO INSTANCE IS CREATED EVER;
+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}




-(id)init {
// Initialize Products
    Product *iPad = [[Product alloc]initWithName:@"iPad" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/ipad/"];
    Product *iPodTouch = [[Product alloc]initWithName:@"iPod Touch" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/ipod-touch/"];
    Product *iPhone = [[Product alloc]initWithName:@"iPhone" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/iphone-7/"];
    
    Product *galaxyS4 = [[Product alloc]initWithName:@"Galaxy S4" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/"];
    Product *galaxyNote = [[Product alloc]initWithName:@"Galaxy Note" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/samsung-galaxy-note5-32gb-at-t-black-sapphire-sm-n920azkaatt/"];
    Product *galaxyTab = [[Product alloc]initWithName:@"Galaxy Tab" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/tablets/galaxy-tab-s2/sm-t713-sm-t713nzkexar/"];
    
    Product *googlePixel = [[Product alloc]initWithName:@"Google Pixel" andImage:@"google.png" andURL:@"https://madeby.google.com/phone/"];
    Product *nexus6P = [[Product alloc]initWithName:@"Nexus 6P" andImage:@"google.png" andURL:@"https://www.google.com/nexus/6p/"];
    Product *nexus5X = [[Product alloc]initWithName:@"Nexus 5X" andImage:@"google.png" andURL:@"https://www.google.com/nexus/5x/"];
    
    Product *amazonFire = [[Product alloc]initWithName:@"Amazon Fire Phone" andImage:@"amazon.png" andURL:@"https://www.amazon.com/Amazon-Fire-Phone-32GB-Unlocked/dp/B00OC0USA6"];
    Product *kindleFire = [[Product alloc]initWithName:@"Kindle Fire" andImage:@"amazon.png" andURL: @"https://www.amazon.com/Amazon-Fire-7-Inch-Tablet-8GB/dp/B00TSUGXKE"];
    Product *kindlePaperWhite = [[Product alloc]initWithName:@"Kindle PaperWhite" andImage:@"amazon.png" andURL:  @"https://www.amazon.com/Amazon-Kindle-Paperwhite-6-Inch-4GB-eReader/dp/B00OQVZDJM"];
    
    // Initialize Companies with Products
    Company *apple = [[Company alloc]initWithName:@"Apple" andTicker:@"AAPL" andProducts:[[NSMutableArray alloc]initWithObjects:iPad, iPodTouch, iPhone, nil] andImage:@"apple-xxl.png"];
    
    Company *samsung = [[Company alloc]initWithName:@"Samsung" andTicker:@"SMSD.L" andProducts:[[NSMutableArray alloc]initWithObjects:galaxyS4, galaxyNote, galaxyTab, nil] andImage:@"samsung.jpg"];
    
    Company *google = [[Company alloc]initWithName:@"Google" andTicker:@"GOOG" andProducts:[[NSMutableArray alloc]initWithObjects:googlePixel, nexus6P, nexus5X, nil] andImage:@"google.png"];
    
    Company *amazon = [[Company alloc]initWithName:@"Amazon" andTicker:@"AMZN" andProducts:[[NSMutableArray alloc]initWithObjects:amazonFire, kindleFire, kindlePaperWhite, nil] andImage:@"amazon.png"];
    
    self.companyList = [[NSMutableArray alloc]initWithObjects:apple, samsung, google, amazon, nil];
    [self loadStockPrices];
//    [self.reloadDelegate reloadStockData];
    return self;
}

- (void)loadStockPrices {
    
    //using NSURLSession, get csv string with URL
    //parse the csv and assign the right stock pric to every company;
    //url is based on all companies in the company list, make sure it deletes from url when you delete a company
    //loop through companies and add + sign and add all that to url string
    //when you add a company, append its ticker to the url
    
    
    NSMutableString *companyTickerList = [[NSMutableString alloc]init];
    NSMutableString *url = [[NSMutableString alloc]init];

    //use fast enum, it's preferred over a i=0; i++ type of loop because it knows where to end
    for (Company *currentCompany in   self.companyList) {
        [companyTickerList appendString: currentCompany.ticker];
        [companyTickerList appendString:@"+"];
    }
    
    //create the url string
    [url appendString:@"http://finance.yahoo.com/d/quotes.csv?s="];
    [url appendString:companyTickerList];
    [url appendString:@"+&f=a"];
    
    //if your app is going to get any info from the internet, you HAVE to change the plist file to configure App Transport Security Sessions
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    
    
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        
                                        //separate by new line, and get those numbers assigned to each company.stockPrice
                                        
                                        NSLog(@"%@", data);
                                        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                        NSLog(@"%@", dataString);
                                        
                                        NSString *dataStringTrimmed = [dataString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

                                        NSArray *stockPrices = [dataStringTrimmed componentsSeparatedByString:@"\n"];
                                        NSLog(@"%@", stockPrices);
                                        
                                        int i = 0;
                                        for (Company *currentCompany in self.companyList) {
                                                currentCompany.stockPrice = stockPrices[i];
                                            i++;
                                        }
                                        [self.reloadDelegate reloadStockData];
                                    }];
    [task resume];
    
}


@end
