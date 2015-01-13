//
//  FloJackTests.m
//  FloJackTests
//
//  Created by John Bullard on 9/21/12.
//  Copyright (c) 2012 Flomio Inc. All rights reserved.
//

#import "FloJackTests.h"

@implementation FloJackTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


#pragma mark Test: NDEF Encoding / Decoding Tests


// Touch-a-tag read only NFC tag
// 1 NDEF Record (URI): http://www.ttag.be/m/04FAC9193E2580
// TNF_WELL_KNOWN = 0x01;
// RTD_URI = {0x55};   // "U"
- (void)testNDEFMessageEncodeDecode
{    
    UInt8 bytes[] = {0xd1, 0x01, 0x19, 0x55,
                        0x01, 0x74, 0x74, 0x61,
                        0x67, 0x2e, 0x62, 0x65,
                        0x2f, 0x6d, 0x2f, 0x30,
                        0x34, 0x46, 0x41, 0x43,
                        0x39, 0x31, 0x39, 0x33,
                        0x45, 0x32, 0x35, 0x38,
                        0x30};
    int bytesLength = 29;
    
    NSData *ndefMessageData = [[NSData alloc] initWithBytes:bytes length:bytesLength];
    FJNDEFMessage *ndefMessage = [[FJNDEFMessage alloc] initWithByteBuffer:ndefMessageData];
    NSData *ndefMessageDataDecoded = [ndefMessage asByteBuffer];
    
    XCTAssertTrue(([ndefMessageData isEqualToData:ndefMessageDataDecoded])
                 , @"Data does not match!");
}

// Touch-a-tag read only NFC tag
// 1 NDEF Record (URI): http://www.ttag.be/m/04FAC9193E2580
// TNF_WELL_KNOWN = 0x01;
// RTD_URI = {0x55};   // "U"
- (void)testUriNdefMessage
{
    UInt8 bytes[] = {0xd1, 0x01, 0x19, 0x55,
                        0x01, 0x74, 0x74, 0x61,
                        0x67, 0x2e, 0x62, 0x65,
                        0x2f, 0x6d, 0x2f, 0x30,
                        0x34, 0x46, 0x41, 0x43,
                        0x39, 0x31, 0x39, 0x33,
                        0x45, 0x32, 0x35, 0x38,
                        0x30};
    int bytesLength = 29;
    
    NSData *data = [[NSData alloc] initWithBytes:bytes length:bytesLength];                  
    NSArray *ndefRecords = [FJNDEFRecord parseData:data andIgnoreMbMe:FALSE];
    
    XCTAssertTrue(([ndefRecords count] == 1)
                 , @"Incorrect number of NDEF Records");
}



// NFC Task Launcher (two tasks, call + text 5613099334
// 2 NDEF Short Records: Well Known (URI), MIME (NTL)

/*
// Record 0
[0] Flag Byte
1001 0001 (0x91)
|||| ||
|||| ||---> TNF = 001 	// TNF_WELL_KNOWN = 0x01;
|||| |----> IL = 0
||||
||||------>	SR = 1 		// short record
|||------->	CF = 0 		
||-------->	ME = 0
|--------->	MB = 1 		// message begin

[1] Type Length
0000 0001  (1)

[2] Payload Length
0000 1100 (12) 	// "(http://)tags.to/ntl", note this only applies to chunk 0

[3] Type
0101 0101 (85) 	// RTD_URI = {0x55};   // "U"s

[4..15] Payload
0000 0011 (3)	// "http://" 0x03
116, 97, 103, 115, 46, 116, 111, 47, 110, 116, 108

// Record 1
[16] Flag Byte
0101 0010 (82) (0x52)
|||| ||
|||| ||---> TNF = 010 	// TNF_MIME_MEDIA = 0x02;
|||| |----> IL = 0
||||
||||------>	SR = 1 		// short record
|||------->	CF = 0 		
||-------->	ME = 1 		// message end
|--------->	MB = 0

[17] Type Length
0000 0011 (3) (0x03)

[18] Payload Length
0010 1011 (43) (0x2b)

[19..21] Type
0110 1110 (110) (0x6e)	// ntl
0111 1000 (116) (0x74)
0110 1100 (118) (0x6c)

[22..64] Payload
2, 101, 110, 90, 58, 56, 58, 84, 97, 115, 107, 32, 56, 59, 112, 58, 53, 54, 49, 51, 48, 57, 57, 51, 51, 52, 59, 111, 58, 53, 54, 49, 51, 48, 57, 57, 51, 51, 52, 58, 121, 101, 115
 */
- (void)testTwoNdefShortRecords
{
    UInt8 bytes[] = {-111, 1, 12, 85, 3, 116, 97, 103, 115, 46, 116, 111, 47, 110, 116, 108, 82, 3, 43, 110, 116, 108, 2, 101, 110, 90, 58, 56, 58, 84, 97, 115, 107, 32, 56, 59, 112, 58, 53, 54, 49, 51, 48, 57, 57, 51, 51, 52, 59, 111, 58, 53, 54, 49, 51, 48, 57, 57, 51, 51, 52, 58, 121, 101, 115};
    int bytesLength = 65;
    
    NSData *data = [[NSData alloc] initWithBytes:bytes length:bytesLength];
    NSArray *ndefRecords = [FJNDEFRecord parseData:data andIgnoreMbMe:FALSE];
    
    XCTAssertTrue(([ndefRecords count] == 2)
                 , @"Incorrect number of NDEF Records");
}

@end
