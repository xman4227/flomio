//
//  FJNDEFTests.m
//  FJNDEFTests
//
//  Created by John Bullard on 9/21/12.
//  Copyright (c) 2012 Flomio Inc. All rights reserved.
//

#import "FJNDEFURITests.h"
#import "NSData+FJStringDisplay.h"

@implementation FJNDEFURITests

@synthesize ndefTestData = _ndefTestData;

- (void)setUp
{
    [super setUp];
    self.ndefTestData = [[NSMutableArray alloc] initWithCapacity:7];
    
    /**
     Test Dataset 1:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "http://www.ttag.be/m/04FAC9193E2580"
     */
    int bytesLengthT1 = 29;
    UInt8 bytesT1[] = {0xd1, 0x01, 0x19, 0x55,
        0x01, 0x74, 0x74, 0x61,
        0x67, 0x2e, 0x62, 0x65,
        0x2f, 0x6d, 0x2f, 0x30,
        0x34, 0x46, 0x41, 0x43,
        0x39, 0x31, 0x39, 0x33,
        0x45, 0x32, 0x35, 0x38,
        0x30};
    NSURL *urlT1 = [[NSURL alloc] initWithString:@"http://www.ttag.be/m/04FAC9193E2580"];
    NSNumber *ndefRecordCountT1 = [NSNumber numberWithInt:1];
    
    
    NSData *ndefMessageDataT1 = [[NSData alloc] initWithBytes:bytesT1 length:bytesLengthT1];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                ndefMessageDataT1,      @"ndefData",
                                ndefMessageDataT1,      @"ndefDataDecoded",
                                ndefRecordCountT1,      @"ndefRecordCount",
                                urlT1,                  @"url"
                                , nil];
    [self.ndefTestData addObject:dict];
    
    /**
     Test Dataset 2:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "http://www.flomio.com"
     */
    int bytesLengthT2 = 15;
    UInt8 bytesT2[] = {
        0xd1, 0x01, 0x0b, 0x55,
        0x01, 0x66, 0x6c, 0x6f,
        0x6d, 0x69, 0x6f, 0x2e,
        0x63, 0x6f, 0x6d
    };
    
    NSURL *urlT2 = [[NSURL alloc] initWithString:@"http://www.flomio.com"];
    NSNumber *ndefRecordCountT2 = [NSNumber numberWithInt:1];
    
    NSData *ndefMessageDataT2 = [[NSData alloc] initWithBytes:bytesT2 length:bytesLengthT2];
    NSDictionary *dictT2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          ndefMessageDataT2,        @"ndefData",
                          ndefMessageDataT2,        @"ndefDataDecoded",
                          ndefRecordCountT2,        @"ndefRecordCount",
                          urlT2,                    @"url"
                          , nil];
    [self.ndefTestData addObject:dictT2];
    
    /**
     Test Dataset 3:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "mailto:info@flomio.com?subject=Flo&amp;body=jack"
     */
    int bytesLengthT3 = 42;
    UInt8 bytesT3[] = {
        0xd1, 0x01, 0x26, 0x55,
        0x06, 0x69, 0x6e, 0x66,
        0x6f, 0x40, 0x66, 0x6c,
        0x6f, 0x6d, 0x69, 0x6f,
        0x2e, 0x63, 0x6f, 0x6d,
        0x3f, 0x73, 0x75, 0x62,
        0x6a, 0x65, 0x63, 0x74,
        0x3d, 0x46, 0x6c, 0x6f,
        0x26, 0x62, 0x6f, 0x64,
        0x79, 0x3d, 0x6a, 0x61,
        0x63, 0x6b 
    };
    
    NSURL *urlT3 = [[NSURL alloc] initWithString:@"mailto:info@flomio.com?subject=Flo&body=jack"];
    NSNumber *ndefRecordCountT3 = [NSNumber numberWithInt:1];
    
    NSData *ndefMessageDataT3 = [[NSData alloc] initWithBytes:bytesT3 length:bytesLengthT3];
    NSDictionary *dictT3 = [NSDictionary dictionaryWithObjectsAndKeys:
                            ndefMessageDataT3,        @"ndefData",
                            ndefMessageDataT3,        @"ndefDataDecoded",
                            ndefRecordCountT3,        @"ndefRecordCount",
                            urlT3,                    @"url"
                            , nil];
    [self.ndefTestData addObject:dictT3];
    
    /*
     Test Dataset 4:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "tel:3055559334"
     */
    int bytesLengthT4 = 15;
    UInt8 bytesT4[] = {
        0xd1, 0x01, 0x0b, 0x55,
        0x05, 0x33, 0x30, 0x35,
        0x35, 0x35, 0x35, 0x39,
        0x33, 0x33, 0x34
    };
    NSURL *urlT4 = [[NSURL alloc] initWithString:@"tel:3055559334"];
    NSNumber *ndefRecordCountT4 = [NSNumber numberWithInt:1];
    
    NSData *ndefMessageDataT4 = [[NSData alloc] initWithBytes:bytesT4 length:bytesLengthT4];
    NSDictionary *dictT4 = [NSDictionary dictionaryWithObjectsAndKeys:
                            ndefMessageDataT4,        @"ndefData",
                            ndefMessageDataT4,        @"ndefDataDecoded",
                            ndefRecordCountT4,        @"ndefRecordCount",
                            urlT4,                    @"url"
                            , nil];
    [self.ndefTestData addObject:dictT4];
    
    /*
     Test Dataset 5:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "sms:3055559334?body=NFC rocks my socks "    
     */
    int bytesLengthT5 = 52; //44;
    UInt8 bytesT5[] = {
        0xd1, 0x01, 0x30, 0x55,
        0x00, 0x73, 0x6d, 0x73,
        0x3a, 0x33, 0x30, 0x35,
        0x35, 0x35, 0x35, 0x39,
        0x33, 0x33, 0x34, 0x3f,
        0x62, 0x6f, 0x64, 0x79,
        0x3d, 0x4e, 0x46, 0x43,
        0x25, 0x32, 0x30, 0x72,
        0x6f, 0x63, 0x6b, 0x73,
        0x25, 0x32, 0x30, 0x6d,
        0x79, 0x25, 0x32, 0x30,
        0x73, 0x6f, 0x63, 0x6b,
        0x73, 0x25, 0x32, 0x30
    };
    NSURL *urlT5 = [[NSURL alloc] initWithString:@"sms:3055559334?body=NFC%20rocks%20my%20socks%20"];
    NSNumber *ndefRecordCountT5 = [NSNumber numberWithInt:1];
    
    NSData *ndefMessageDataT5 = [[NSData alloc] initWithBytes:bytesT5 length:bytesLengthT5];
    NSDictionary *dictT5 = [NSDictionary dictionaryWithObjectsAndKeys:
                            ndefMessageDataT5,        @"ndefData",
                            ndefMessageDataT5,        @"ndefDataDecoded",
                            ndefRecordCountT5,        @"ndefRecordCount",
                            urlT5,                    @"url"
                            , nil];
    [self.ndefTestData addObject:dictT5];
    
    /**
     Test Dataset 6:
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "http://flomio.com/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio"
     */
    int bytesLengthT6 = 162;
    UInt8 bytesT6[] = {
        0xD1, 0x01,
        0x9E, 0x55, 0x03, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2E, 0x63, 0x6F,
        0x6D, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F
    };
    NSURL *urlT6 = [[NSURL alloc] initWithString:@"http://flomio.com/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio"];
    NSNumber *ndefRecordCountT6 = [NSNumber numberWithInt:1];
    
    
    NSData *ndefMessageDataT6 = [[NSData alloc] initWithBytes:bytesT6 length:bytesLengthT6];
    NSDictionary *dictT6 = [NSDictionary dictionaryWithObjectsAndKeys:
                            ndefMessageDataT6,      @"ndefData",
                            ndefMessageDataT6,        @"ndefDataDecoded",
                            ndefRecordCountT6,      @"ndefRecordCount",
                            urlT6,                  @"url"
                            , nil];
    [self.ndefTestData addObject:dictT6];
    
    /**
     Test Dataset 7:
     Incomplete NDEF Message (8 bytes truncated)
     TNF = TNF_WELL_KNOWN (0x01), RTD = RTD_URI (0x55)
     Payload = "http://flomio.com/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio/flomio"
     */
    int bytesLengthT7 = 154;
    UInt8 bytesT7[] = {
        0xD1, 0x01,
        0x9E, 0x55, 0x03, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2E, 0x63, 0x6F,
        0x6D, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
        0x6F, 0x2F, 0x66, 0x6C,
        0x6F, 0x6D, 0x69, 0x6F,
        0x2F, 0x66, 0x6C, 0x6F,
        0x6D, 0x69, 0x6F, 0x2F,
        0x66, 0x6C, 0x6F, 0x6D,
        0x69, 0x6F, 0x2F, 0x66,
        0x6C, 0x6F, 0x6D, 0x69,
    };
    NSNumber *ndefRecordCountT7 = [NSNumber numberWithInt:0];
    
    NSData *ndefMessageDataT7 = [[NSData alloc] initWithBytes:bytesT7 length:bytesLengthT7];
    NSDictionary *dictT7 = [NSDictionary dictionaryWithObjectsAndKeys:
                            ndefMessageDataT7,      @"ndefData",
                            nil,                    @"ndefDataDecoded",
                            ndefRecordCountT7,      @"ndefRecordCount",
                            nil,                    @"url"
                            , nil];
    [self.ndefTestData addObject:dictT7];
}

- (void)testFJNDEFMessageDataDecoding
{
    for(id item in self.ndefTestData) {
        NSData *ndefData = [item objectForKey:@"ndefData"];
        NSData *ndefDataDecoded = [item objectForKey:@"ndefDataDecoded"];
        NSNumber *ndefRecordCount = [item objectForKey:@"ndefRecordCount"];
        
        FJNDEFMessage *ndefMessage = [[FJNDEFMessage alloc] initWithByteBuffer:ndefData];
        NSData *ndefMessageDataDecoded = [ndefMessage asByteBuffer];
        
        XCTAssertTrue(([ndefDataDecoded isEqualToData:ndefMessageDataDecoded] ||
                      (ndefDataDecoded == nil && ndefMessageDataDecoded == nil))
                        , @"FJNDEFMessage decoded data is incorrect.");
        XCTAssertTrue((ndefMessage.ndefRecords.count == ndefRecordCount.intValue)
                        , @"FJNDEFMessage has incorrect number of NDEF records.");
    }
}

- (void)testFJNDEFRecordDataDecoding
{
    for(id item in self.ndefTestData) {
        NSData *ndefData = [item objectForKey:@"ndefData"];
        NSData *ndefDataDecoded = [item objectForKey:@"ndefDataDecoded"];
        NSNumber *ndefRecordCount = [item objectForKey:@"ndefRecordCount"];
        NSURL *url = [item objectForKey:@"url"];
        
        NSArray *ndefRecords = [FJNDEFRecord parseData:ndefData andIgnoreMbMe:FALSE];
        FJNDEFRecord *ndefRecord = [ndefRecords objectAtIndexedSubscript:0];
        
        XCTAssertTrue(([ndefRecords count] == ndefRecordCount.intValue)
                     , @"FJNDEFRecord has incorrect number of NDEF Records.");
        XCTAssertTrue(([ndefRecord.asByteBuffer isEqualToData:ndefDataDecoded] ||
                      (ndefRecord.asByteBuffer == nil && ndefDataDecoded == nil))
                     , @"FJNDEFRecord decoded byte stream incorrect.");
        XCTAssertTrue(([ndefRecord.getUriFromPayload isEqual:url] ||
                      (ndefRecord == nil && url == nil))
                     , @"FJNDEFRecord decoded URI is incorrect.");
    }
}

- (void)testFJNDEFMessageDataEncoding
{    
    for(id item in self.ndefTestData) {
        NSData *ndefDataDecoded = [item objectForKey:@"ndefDataDecoded"];
        NSNumber *ndefRecordCount = [item objectForKey:@"ndefRecordCount"];
        NSURL *url = [item objectForKey:@"url"];
        
        FJNDEFMessage *ndefMessage = [FJNDEFMessage createURIWithString:url.absoluteString];
                
        XCTAssertTrue((ndefMessage.ndefRecords.count == ndefRecordCount.intValue)
                     , @"FJNDEFMessage encoded incorrect number of NDEF Records.");
        XCTAssertTrue(([ndefMessage.asByteBuffer isEqualToData:ndefDataDecoded] ||
                      (ndefMessage.asByteBuffer == nil && ndefDataDecoded == nil))
                     , @"FJNDEFMessage encoded byte stream incorrect.");
        
    }
}

- (void)testFJNDEFRecordDataEncoding
{
    for(id item in self.ndefTestData) {
        NSData *ndefDataDecoded = [item objectForKey:@"ndefDataDecoded"];
        NSURL *url = [item objectForKey:@"url"];
        
        FJNDEFRecord *ndefRecord = [FJNDEFRecord createURIWithString:url.absoluteString];
        
        XCTAssertTrue(([ndefRecord.asByteBuffer isEqualToData:ndefDataDecoded] ||
                      (ndefRecord.asByteBuffer == nil && ndefDataDecoded == nil))
                     , @"FJNDEFRecord decoded byte stream incorrect.");
        XCTAssertTrue(([ndefRecord.getUriFromPayload isEqual:url] ||
                      (ndefRecord == nil && url == nil))
                     , @"FJNDEFRecord decoded URI is incorrect.");
        
        ndefRecord = [FJNDEFRecord createURIWithURL:url];
        
        XCTAssertTrue(([ndefRecord.asByteBuffer isEqualToData:ndefDataDecoded] ||
                      (ndefRecord.asByteBuffer == nil && ndefDataDecoded == nil))
                     , @"FJNDEFRecord decoded byte stream incorrect.");
        XCTAssertTrue(([ndefRecord.getUriFromPayload isEqual:url] ||
                      (ndefRecord == nil && url == nil))
                     , @"FJNDEFRecord decoded URI is incorrect.");
    }
}

- (void)tearDown
{
    [super tearDown];
}

@end
