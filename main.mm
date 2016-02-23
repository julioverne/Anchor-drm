OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (sha1)
+ (NSString*)sha1:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
+(NSString *)udid {
    CFStringRef UDID = MGCopyAnswer(CFSTR("UniqueDeviceID"));
    return (NSString *)UDID;
}
@end

int main()
{
	NSFileManager *manager = [[[NSFileManager alloc] init] autorelease];
	NSString *pref_lice = @"//var/mobile/Library/Preferences/anchor.license";	
	NSString* key = [NSString stringWithFormat:@"%@%@", @"julio", [NSString sha1:[NSString stringWithFormat:@"%@%@", @"julio", [NSString udid]]]];
	
	NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	[data writeToFile:pref_lice options:NSDataWritingAtomic error:&error];
	if(error != nil) {
		printf("\n*** Error writing license to file! ***\n");
	} else {
		[manager setAttributes:@{
			NSFileOwnerAccountName:@"mobile",
			NSFileGroupOwnerAccountName:@"mobile",
			NSFilePosixPermissions:@0644,
		} ofItemAtPath:pref_lice error:nil];
		printf("\n*** License has been generated! ***\n");
	}
	
	printf("\n");
	printf("Respring!!!\n");
	printf("Respring!!!\n");
	printf("Respring!!!\n");
	printf("\n");
	printf("*** Keygen Anchor by julioverne ***\n");
	printf("\n");
}