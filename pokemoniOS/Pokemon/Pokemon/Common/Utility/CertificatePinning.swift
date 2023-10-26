//
// AuthenticationChallengeResponder.swift
//  Pokemon
//
//

import Foundation
import Kingfisher

class AuthenticationChallengeResponder: NSObject, AuthenticationChallengeResponsible, URLSessionTaskDelegate {

    /*func downloader(_ downloader: ImageDownloader, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)

                if errSecSuccess == status {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData)
                        let size = CFDataGetLength(serverCertificateData)
                        let cert1 = NSData(bytes: data, length: size)
                        let fileDer = Bundle.main.path(forResource: "raw.githubusercontent.com", ofType: "cer")
                        if let file = fileDer {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) { completionHandler(URLSession
                                    .AuthChallengeDisposition.useCredential,
                                    URLCredential(trust: serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
    }*/
    
    func downloader(_ downloader: ImageDownloader, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
               // let isServerTrusted = SecTrustEvaluateWithError(serverTrust, nil)
                
                    if let serverCertificate = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate] {
                        let cert1 = SecCertificateCopyData(serverCertificate.first!) as NSData
                        
                        if let file = Bundle.main.path(forResource: "raw.githubusercontent.com", ofType: "cer") {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert2 == cert1 {
                                    print("SSL Pinning Complete! :::::::::")
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    return
                                } else {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    print("SSL Pinning Not Matching ::::::::")
                                }
                            }
                        }
                    }
                }
        }
    }
    
    /*func downloader(_ downloader: ImageDownloader, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let status = SecTrustEvaluateWithError(serverTrust, nil)
                if status {
                        let fileDer = Bundle.main.path(forResource: "raw.githubusercontent.com", ofType: "cer")
                        if let file = fileDer {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if  let serverCertificate = SecTrustCopyCertificateChain(serverTrust),
                                      let serverCertificateData = SecCertificateCopyData(serverCertificate as! SecCertificate) as Data?,
                                      serverCertificateData == cert2 as Data  {
                                    completionHandler(URLSession
                                        .AuthChallengeDisposition.useCredential,
                                        URLCredential(trust: serverTrust))
                                        return
                                }
                        }
                    }
                }
            }
        }
    }*/

}
