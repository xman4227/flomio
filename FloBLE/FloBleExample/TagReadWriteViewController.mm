//
//  TagReadWriteViewController.m
//  FloJackExample
//
//  Created by John Bullard on 11/12/12.
//  Copyright (c) 2012 John Bullard. All rights reserved.
//

#import "TagReadWriteViewController.h"

@implementation TagReadWriteViewController

@synthesize appDelegate                     = _appDelegate;
@synthesize outputTextView                  = _outputTextView;
@synthesize pollingRateTextField            = _pollingRateTextField;
@synthesize scrollView                      = _scrollView;
@synthesize statusErrorCount                = _statusErrorCount;
@synthesize statusErrorTextView             = _statusErrorTextView;
@synthesize statusNACKCount                 = _statusNACKCount;
@synthesize statusNACKTextView              = _statusNACKTextView;
@synthesize statusPingPongCount             = _statusPingPongCount;
@synthesize statusPingPongTextView          = _statusPingPongTextView;
@synthesize statusVolumeLowErrorTextView    = _statusVolumeLowErrorTextView;
@synthesize urlInputField                   = _urlInputField;
@synthesize tweakThresholdTextField         = _tweakThresholdTextField;
@synthesize maxThresholdTextField           = _maxThresholdTextField;
@synthesize switchPolling14443A             = _switchPolling14443A;
@synthesize switchPolling15693              = _switchPolling15693;
@synthesize switchPollingFelica             = _switchPollingFelica;
@synthesize switchStandaloneMode            = _switchStandaloneMode;

#pragma mark - UI View Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    _statusPingPongCount = 0;
    _statusNACKCount = 0;
    _statusErrorCount = 0;
    _scrollView.contentSize = CGSizeMake(320, 1000);
    _appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
}

#pragma mark - UI Input

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [_appDelegate.nfcAdapter setDeviceHasVolumeCap:true];
        [self updateLogTextViewWithString:[NSString stringWithFormat:@":::Device Volume Cap = True"]];
    }
    else {
        [_appDelegate.nfcAdapter setDeviceHasVolumeCap:false];
        [self updateLogTextViewWithString:[NSString stringWithFormat:@":::Device Volume Cap = False"]];
    }
}

// TODO Need to clean up button action because the self.pollingRateTextField "Send" keyboard action
// is a duplicate of this
- (IBAction)buttonWasPressedForPollingRate:(id)sender {
    int pollValue = [self.pollingRateTextField.text intValue];
    _appDelegate.nfcAdapter.pollPeriod = pollValue;
    
    [self.view endEditing:YES];
}

- (IBAction)buttonWasPressedForReadTag:(id)sender {
    switch (((UIButton *)sender).tag) {
        case 1:
            [_appDelegate.nfcAdapter setModeReadTagUID];
            break;
        case 2:
            [_appDelegate.nfcAdapter setModeReadTagUIDAndNDEF];
            break;
        case 3:
            [_appDelegate.nfcAdapter setModeReadTagData];
            break;
    }
}

- (IBAction)buttonWasPressedForUtilities:(id)sender {
    switch (((UIButton *)sender).tag) {
        case 1:
            [_appDelegate.nfcAdapter initializeFloJackDevice];
            break;
        case 2:
            [_appDelegate.nfcAdapter getFirmwareVersion];
            break;
        case 3:
            [_appDelegate.nfcAdapter getHardwareVersion];
            break;
        case 4:
            [_appDelegate.nfcAdapter getSnifferCalib];
            break;
        case 5:
            // TODO Need to clean up button action because the self.tweakThresholdTextField "Send" keyboard action
            // is a duplicate of this
            [_appDelegate.nfcAdapter setIncrementSnifferThreshold:[self.tweakThresholdTextField.text intValue]];
            [self.view endEditing:YES];
            break;
        case 6:
            [_appDelegate.nfcAdapter setDecrementSnifferThreshold:[self.tweakThresholdTextField.text intValue]];
            [self.view endEditing:YES];
            break;
        case 7:
            // TODO Need to clean up button action because the self.maxThresholdTextField "Send" keyboard action
            // is a duplicate of this
            [_appDelegate.nfcAdapter setMaxSnifferThreshold:[self.maxThresholdTextField.text intValue]];
            [self.view endEditing:YES];
            break;
        case 8:
            [_appDelegate.nfcAdapter sendResetSnifferThreshold];
            break;
        case 9:
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"EU Mode" message:@"Warning: May damage the FloJack device. Only enable for volume limited devices. See http://flomio.com/volume-limit" delegate:self cancelButtonTitle:@"Enable" otherButtonTitles:@"Cancel", nil];
            [alert show];
            break;
    }
}

// TODO Need to clean up button action because the _urlInputField "Send" keyboard action
// is a duplicate of this
- (IBAction)buttonWasPressedForWriteTag:(id)sender {
    FJNDEFMessage *testMessage = [FJNDEFMessage createURIWithString:_urlInputField.text];
    [_appDelegate.nfcAdapter setModeWriteTagWithNdefMessage:testMessage];
    [self.view endEditing:YES];
}

- (IBAction)switchWasFlippedForConfig:(id)sender {
    UISwitch *onOffSwitch = (UISwitch *) sender;
    switch (onOffSwitch.tag) {
        case 1:
            _appDelegate.nfcAdapter.pollFor14443aTags = onOffSwitch.on;
            break;
        case 2:
            _appDelegate.nfcAdapter.pollFor15693Tags = onOffSwitch.on;
            break;
        case 3:
            _appDelegate.nfcAdapter.pollForFelicaTags = onOffSwitch.on;
            break;
        case 4:
            _appDelegate.nfcAdapter.standaloneMode = onOffSwitch.on;
            break;
    }
}

- (IBAction)buttonWasPressedForSendConfig:(id)sender {
    [_appDelegate.nfcAdapter setStandaloneMode:_switchPolling14443A.isOn];
    [_appDelegate.nfcAdapter setStandaloneMode:_switchPolling15693.isOn];
    [_appDelegate.nfcAdapter setStandaloneMode:_switchPollingFelica.isOn];
    [_appDelegate.nfcAdapter setStandaloneMode:_switchStandaloneMode.isOn];
}

#pragma mark - UI Output

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    });
}

- (void)updateLogTextViewWithString:(NSString *)updateString {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.outputTextView.text = [NSString stringWithFormat:@"%@ \n%@", updateString, self.outputTextView.text];
    });
}

- (void)updateStatusTextViewWithStatus:(NSInteger)statusCode {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (statusCode) {
            case FLOMIO_STATUS_PING_RECIEVED:
                _statusPingPongCount++;
                _statusPingPongTextView.text = [NSString stringWithFormat:@"Msgs: %d",_statusPingPongCount];
                break;
            case FLOMIO_STATUS_NACK_ERROR:
                _statusNACKCount++;
                _statusNACKTextView.text = [NSString stringWithFormat:@"Issues: %d",_statusNACKCount];
                break;
            case FLOMIO_STATUS_VOLUME_LOW_ERROR:
                _statusVolumeLowErrorTextView.text = [NSString stringWithFormat:@"**ERROR** Vol low"];
                break;
            case FLOMIO_STATUS_VOLUME_OK:
                _statusVolumeLowErrorTextView.text = [NSString stringWithFormat:@"Vol OK"];
            case FLOMIO_STATUS_MESSAGE_CORRUPT_ERROR:
                // fall through
            case FLOMIO_STATUS_GENERIC_ERROR:
                _statusErrorCount++;
                _statusErrorTextView.text = [NSString stringWithFormat:@"ERR: %d", _statusErrorCount];
                break;
            default:
                break;
        }
    });
}

#pragma mark - FJNFCAdapter Delegate

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didScanTag:(FJNFCTag *)theNfcTag {
    NSMutableString *textUpdate = [NSMutableString stringWithFormat:@":::Tag Read "];
    [textUpdate appendString:[NSString stringWithFormat:@"\n UID: %@", [theNfcTag.uid fj_asHexString]]];
    [textUpdate appendString:[NSString stringWithFormat:@"\n Type: %d", theNfcTag.nfcForumType]];
    [textUpdate appendString:[NSString stringWithFormat:@"\n Data: %@", [theNfcTag.data fj_asHexString]]];

    if (theNfcTag.ndefMessage != nil && theNfcTag.ndefMessage.ndefRecords != nil) {
        for (FJNDEFRecord *ndefRecord in theNfcTag.ndefMessage.ndefRecords) {
            [textUpdate appendString:@"\n:::NDEF Record Found"];
            [textUpdate appendString:[NSString stringWithFormat:@"\n TNF: %d",ndefRecord.tnf]];
            [textUpdate appendString:[NSString stringWithFormat:@"\n Type: %@",[ndefRecord.type fj_asHexString]]];
            [textUpdate appendString:[NSString stringWithFormat:@"\n Payload: %@ (%@)",[ndefRecord.payload fj_asHexString], [ndefRecord.payload fj_asASCIIStringEncoded]]];
            
            NSURL *url = [ndefRecord getUriFromPayload];
            if (url != nil) {
                [textUpdate appendString:[NSString stringWithFormat:@"\nURI: %@", url.description]];
            }
        }
    }
    [self updateLogTextViewWithString:textUpdate];
    [self showAlertWithTitle:@"Tag Read" andMessage:[theNfcTag.uid fj_asHexString]];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didHaveStatus:(NSInteger)statusCode {
    NSString *statusCodeString = [FJMessage formatStatusCodesToString:(flomio_nfc_adapter_status_codes_t)statusCode];
    NSString *textUpdate = [NSString stringWithFormat:@":::FloJack Status %@", statusCodeString];
    [self updateLogTextViewWithString:textUpdate];
    [self updateStatusTextViewWithStatus:statusCode];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didWriteTagAndStatusWas:(NSInteger)statusCode {
    NSString *statusCodeString = [FJMessage formatTagWriteStatusToString:(flomio_tag_write_status_opcodes_t)statusCode];
    NSString *textUpdate = [NSString stringWithFormat:@":::Tag Write Status %@", statusCodeString];
    [self updateLogTextViewWithString:textUpdate];
    [self showAlertWithTitle:@"Tag Write Status" andMessage:statusCodeString];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didReceiveFirmwareVersion:(NSString *)theVersionNumber {
    NSString *textUpdate = [NSString stringWithFormat:@":::FloJack Firmware Version %@", theVersionNumber];
    [self updateLogTextViewWithString:textUpdate];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didReceiveHardwareVersion:(NSString *)theVersionNumber; {
    NSString *textUpdate = [NSString stringWithFormat:@":::FloJack Hardware Version %@", theVersionNumber];
    [self updateLogTextViewWithString:textUpdate];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didReceiveSnifferThresh:(NSString *)theSnifferValue; {
    NSString *textUpdate = [NSString stringWithFormat:@":::FloJack Sniffer Threshold %@", theSnifferValue];
    [self updateLogTextViewWithString:textUpdate];
}

- (void)nfcAdapter:(FJNFCAdapter *)nfcAdapter didReceiveSnifferCalib:(NSString *)theCalibValues; {
    NSString *textUpdate = [NSString stringWithFormat:@":::FloJack Sniffer Calibration Stats %@", theCalibValues];
    [self updateLogTextViewWithString:textUpdate];
}

- (bool)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_urlInputField]) {
        [_appDelegate.nfcAdapter setModeWriteTagWithNdefMessage:[FJNDEFMessage createURIWithString:_urlInputField.text]];
    } else if ([textField isEqual:_pollingRateTextField]) {
            _appDelegate.nfcAdapter.pollPeriod = [self.pollingRateTextField.text intValue];
    } else if ([textField isEqual:_tweakThresholdTextField]) {
        [_appDelegate.nfcAdapter setIncrementSnifferThreshold:[self.tweakThresholdTextField.text intValue]];
    } else if ([textField isEqual:_maxThresholdTextField]) {
        [_appDelegate.nfcAdapter setMaxSnifferThreshold:[self.maxThresholdTextField.text intValue]];
    }
    [self.view endEditing:YES];
    return YES;
}

- (void)viewDidUnload {
    [self setTweakThresholdTextField:nil];
    [self setMaxThresholdTextField:nil];
    [self setSwitchPolling14443A:nil];
    [self setSwitchPolling15693:nil];
    [self setSwitchPollingFelica:nil];
    [self setSwitchStandaloneMode:nil];
    [super viewDidUnload];
}
@end
