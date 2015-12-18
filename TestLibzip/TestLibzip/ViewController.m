//
//  ViewController.m
//  TestLibzip
//
//  Created by kingly on 15/12/18.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import "ViewController.h"
#import "LBZipArchive.h"

@interface ViewController ()<LBZipArchiveDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testUnzippingWithUnicodeFilenameInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)testUnzippingWithUnicodeFilenameInside {
    
    NSString* zipPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Unicode" ofType:@"zip"];
    NSString* outputPath = [LBZipArchive cachesPath:@"Unicode"];
    
    [LBZipArchive unzipFileAtPath:zipPath toDestination:outputPath delegate:self];
    
    bool unicodeFilenameWasExtracted = [[NSFileManager defaultManager] fileExistsAtPath:[outputPath stringByAppendingPathComponent:@"Accént.txt"]];
    
    if (unicodeFilenameWasExtracted) {
        
        NSLog(@" ok");
        
        
        
        NSString *textFileContent=[NSString stringWithContentsOfFile:[outputPath stringByAppendingPathComponent:@"Accént.txt"] encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"textFileContent::%@",textFileContent);
        
    }else{
        NSLog(@" no ok");
    }
    
    bool unicodeFolderWasExtracted = [[NSFileManager defaultManager] fileExistsAtPath:[outputPath stringByAppendingPathComponent:@"Fólder/Nothing.txt"]];
    
    if (unicodeFolderWasExtracted) {
        
        NSLog(@" ok");
        NSString *textFileContent=[NSString stringWithContentsOfFile:[outputPath stringByAppendingPathComponent:@"Fólder/Nothing.txt"] encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"textFileContent::%@",textFileContent);
        
        
    }else{
        NSLog(@" no ok");
    }
    
    
}


#pragma mark - LBZipArchiveDelegate

- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {
    NSLog(@"*** zipArchiveWillUnzipArchiveAtPath: `%@` zipInfo:", path);
}


- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath {
    NSLog(@"*** zipArchiveDidUnzipArchiveAtPath: `%@` zipInfo: unzippedPath: `%@`", path, unzippedPath);
}

- (BOOL)zipArchiveShouldUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(unz_file_info)fileInfo
{
    NSLog(@"*** zipArchiveShouldUnzipFileAtIndex: `%d` totalFiles: `%d` archivePath: `%@` fileInfo:", (int)fileIndex, (int)totalFiles, archivePath);
    return YES;
}

- (void)zipArchiveWillUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(unz_file_info)fileInfo {
    NSLog(@"*** zipArchiveWillUnzipFileAtIndex: `%d` totalFiles: `%d` archivePath: `%@` fileInfo:", (int)fileIndex, (int)totalFiles, archivePath);
}


- (void)zipArchiveDidUnzipFileAtIndex:(NSInteger)fileIndex totalFiles:(NSInteger)totalFiles archivePath:(NSString *)archivePath fileInfo:(unz_file_info)fileInfo {
    NSLog(@"*** zipArchiveDidUnzipFileAtIndex: `%d` totalFiles: `%d` archivePath: `%@` fileInfo:", (int)fileIndex, (int)totalFiles, archivePath);
}

- (void)zipArchiveProgressEvent:(NSInteger)loaded total:(NSInteger)total {
    NSLog(@"*** zipArchiveProgressEvent: loaded: `%d` total: `%d`", (int)loaded, (int)total);
    
}
@end