//
//  WebserviceConstants.h
//  TRAKKART
//
//  Created by Mac Min on 22/11/14.
//  Copyright (c) 2014 Gaganinder Singh. All rights reserved.
//

#ifndef TRAKKART_WebserviceConstants_h
#define TRAKKART_WebserviceConstants_h

#define Server_Url @"http://gagan.byethost11.com/"

#define BASE_URL Server_Url@"trakart/webservices/index.php?service="


#define WebserviceErrorKey @"error"
#define WebserviceMessageKey @"message"
#define WebserviceResponseKey @"response"

// For SignIn
#define Webservice_SignIn BASE_URL@"login"
#define WebserviceManagerSignInSuccessNotification @"WebserviceManagerSignInSuccessNotification"
#define WebserviceManagerSignInFailureNotification @"WebserviceManagerSignInFailureNotification"

// For SignUp
#define Webservice_SignUp BASE_URL@"register"
#define WebserviceManagerSignUpSuccessNotification @"WebserviceManagerSignUpSuccessNotification"
#define WebserviceManagerSignUpFailureNotification @"WebserviceManagerSignUpFailureNotification"


#endif
