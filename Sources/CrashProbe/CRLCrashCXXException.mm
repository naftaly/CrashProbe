/*
 * Copyright (c) 2014 HockeyApp, Bit Stadium GmbH.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#import "CRLCrashCXXException.h"
#import <exception>
#import <string>

class kaboom_exception : public std::exception
{
	virtual const char* what() const throw();
};

const char* kaboom_exception::what() const throw()
{
	return "If this had been a real exception, you would be cursing now.";
}

@implementation CRLCrashCXXException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw C++ exception"; }
- (NSString *)desc { return @""
  "Throw an uncaught C++ exception. "
  "This is a difficult case for crash reporters to handle, "
  "as it involves the destruction of the data necessary to generate a correct backtrace.";
}

- (void)crash __attribute__((noreturn))
{
	throw new kaboom_exception;
}

@end

@interface CRLCrashBadAllocException : CRLCrash
@end

@implementation CRLCrashBadAllocException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw std::bad_alloc"; }
- (NSString *)desc { return @"Throw an uncaught C++ exception. ";
}

- (void)crash __attribute__((noreturn))
{
    throw new std::bad_alloc();
}

@end

@interface CRLCrashStdStringException : CRLCrash
@end

@implementation CRLCrashStdStringException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw std::string"; }
- (NSString *)desc { return @"Throw an uncaught C++ exception. ";
}

- (void)crash __attribute__((noreturn))
{
    throw new std::string("std::string exception content");
}

@end

@interface CRLCrashStd2StringException : CRLCrash
@end

@implementation CRLCrashStd2StringException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw std::string stack"; }
- (NSString *)desc { return @"Throw an uncaught C++ exception. ";
}

- (void)crash __attribute__((noreturn))
{
    throw std::string("std::string exception content");
}

@end

@interface CRLCrashCharException : CRLCrash
@end

@implementation CRLCrashCharException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw const char *"; }
- (NSString *)desc { return @"Throw an uncaught C++ exception. ";
}

- (void)crash __attribute__((noreturn))
{
    throw "char * exception content";
}

@end

@interface CRLCrashChar2Exception : CRLCrash
@end

@implementation CRLCrashChar2Exception
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw char *"; }
- (NSString *)desc { return @"Throw an uncaught C++ exception. ";
}

- (void)crash __attribute__((noreturn))
{
    static char *c = "char * exception content";
    throw c;
}

@end

@interface CRLCrashObjCPPThrowCException: CRLCrash
@end

@implementation CRLCrashObjCPPThrowCException
CRL_LOAD
- (NSString *)category { return @"Exceptions"; }
- (NSString *)title { return @"Throw Objective-C exception"; }
- (NSString *)desc { return @"Raise an uncaught Objective-C exception."; }

- (void)crash __attribute__((noreturn))
{
    throw [NSException exceptionWithName:NSGenericException reason:@"An uncaught exception! SCREAM."
                                 userInfo:@{ NSLocalizedDescriptionKey: @"I'm in your program, catching your exceptions!" }];
}

@end
