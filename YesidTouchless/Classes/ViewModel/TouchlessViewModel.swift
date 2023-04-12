//
//  TouchlessViewModel.swift
//  yesid
//
//  Created by Emmanuel Mtera on 11/9/22.
//

import Foundation
import SwiftUI
import Combine


class TouchlessViewModel: ObservableObject {
    @Published var touchlessEnrollmentProgress = 0
    @Published var dismissModal: Bool = false
    @Published var viewController: UIViewController?
    // Touchless
    @Published var rightHandText = "Get ready to scan your right hand"
    @Published var rightThumbText = "Get ready to scan your right thumb"
    @Published var leftHandText = "Get ready to scan your left hand"
    @Published var leftThumbText = "Get ready to scan your left thumb"
    
    @Published var rightHandImage = "right_hand"
    @Published var rightThumbImage = "right_thumb"
    @Published var leftHandImage = "left_hand"
    @Published var leftThumbImage = "left_thumb"
    
    @Published var isRightFingerScan:Bool = false
    @Published var isRightThumbScan:Bool = false
    @Published var rightFingerResult:OnyxResult?
    @Published var rightThumbResult:OnyxResult?
    
    @Published var isLeftFingerScan:Bool = false
    @Published var isLeftThumbScan:Bool = false
    @Published var leftFingerResult:OnyxResult?
    @Published var leftThumbResult:OnyxResult?
    
    public func NSMutableArrayToUIImageArray(someArray: NSMutableArray?)->[UIImage]{
        // convert NSMutableArray? to [UIImage]
        var images:[UIImage] = []
        if let endResult = someArray {
            for item in endResult {
                images.append(item as! UIImage)
            }
        }
        return images
    }
    
    public func getFingerWithTheHighestScore() -> String{
        
        var fingerWithBestQuality = ""
        
        var fingerWithBestQualityRightHand = 0
        var fingerWithBestQualityLeftHand = 0
        var fingerWithBestQualityRightThumb = 0
        var fingerWithBestQualityLeftThumb = 0
        
        
        let result1 = self.rightFingerResult?.captureMetrics?.nfiqMetrics
        let result2 = self.rightThumbResult?.captureMetrics?.nfiqMetrics
        let result3 = self.leftFingerResult?.captureMetrics?.nfiqMetrics
        let result4 = self.leftThumbResult?.captureMetrics?.nfiqMetrics
        
        result1.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the highest score
                    fingerWithBestQualityRightHand = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result2.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the highest score
                    fingerWithBestQualityRightThumb = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result3.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the highest score
                    fingerWithBestQualityLeftHand = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result4.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the highest score
                    fingerWithBestQualityLeftThumb = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        if(fingerWithBestQualityRightHand > fingerWithBestQualityRightThumb && fingerWithBestQualityRightHand > fingerWithBestQualityLeftHand && fingerWithBestQualityRightHand > fingerWithBestQualityLeftThumb){
            fingerWithBestQuality = "Right Hand"
        }else if(fingerWithBestQualityRightThumb > fingerWithBestQualityRightHand && fingerWithBestQualityRightThumb > fingerWithBestQualityLeftHand && fingerWithBestQualityRightThumb > fingerWithBestQualityLeftThumb){
            fingerWithBestQuality = "Right Thumb"
        }else if(fingerWithBestQualityLeftHand > fingerWithBestQualityRightHand && fingerWithBestQualityLeftHand > fingerWithBestQualityRightThumb && fingerWithBestQualityLeftHand > fingerWithBestQualityLeftThumb){
            fingerWithBestQuality = "Left Hand"
        }else if(fingerWithBestQualityLeftThumb > fingerWithBestQualityRightHand && fingerWithBestQualityLeftThumb > fingerWithBestQualityRightThumb && fingerWithBestQualityLeftThumb > fingerWithBestQualityLeftHand){
            fingerWithBestQuality = "Left Thumb"
        }
        
        return fingerWithBestQuality
        
    }
    
    func getFingerWithTheLowestScore()-> String {
        var fingerWithLowestQuality = ""
        
        var fingerWithLowestQualityRightHand = 0
        var fingerWithLowestQualityLeftHand = 0
        var fingerWithLowestQualityRightThumb = 0
        var fingerWithLowestQualityLeftThumb = 0
        
        let result1 = self.rightFingerResult?.captureMetrics?.nfiqMetrics
        let result2 = self.rightThumbResult?.captureMetrics?.nfiqMetrics
        let result3 = self.leftFingerResult?.captureMetrics?.nfiqMetrics
        let result4 = self.leftThumbResult?.captureMetrics?.nfiqMetrics
        
        result1.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the lowest score
                    fingerWithLowestQualityRightHand = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result2.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the lowest score
                    fingerWithLowestQualityRightThumb = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result3.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the lowest score
                    fingerWithLowestQualityLeftHand = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        result4.map {
            $0.forEach {
                if((($0 as AnyObject).nfiqScore ?? 0) != 0){
                    // get the lowest score
                    fingerWithLowestQualityLeftThumb = Int(($0 as AnyObject).nfiqScore ?? 0)
                }
            }
        }
        
        if(fingerWithLowestQualityRightHand < fingerWithLowestQualityRightThumb && fingerWithLowestQualityRightHand < fingerWithLowestQualityLeftHand && fingerWithLowestQualityRightHand < fingerWithLowestQualityLeftThumb){
            fingerWithLowestQuality = "Right Hand"
        }else if(fingerWithLowestQualityRightThumb < fingerWithLowestQualityRightHand && fingerWithLowestQualityRightThumb < fingerWithLowestQualityLeftHand && fingerWithLowestQualityRightThumb < fingerWithLowestQualityLeftThumb){
            fingerWithLowestQuality = "Right Thumb"
        }else if(fingerWithLowestQualityLeftHand < fingerWithLowestQualityRightHand && fingerWithLowestQualityLeftHand < fingerWithLowestQualityRightThumb && fingerWithLowestQualityLeftHand < fingerWithLowestQualityLeftThumb){
            fingerWithLowestQuality = "Left Hand"
        }else if(fingerWithLowestQualityLeftThumb < fingerWithLowestQualityRightHand && fingerWithLowestQualityLeftThumb < fingerWithLowestQualityRightThumb && fingerWithLowestQualityLeftThumb < fingerWithLowestQualityLeftHand){
            fingerWithLowestQuality = "Left Thumb"
        }
        
        return fingerWithLowestQuality
    }
    
    public func getTotalCapturedFingers() -> Int{
        var numberOfFingersCaptured: Int = 0
        if(self.isRightFingerScan){
            numberOfFingersCaptured += 4
        }
        if(self.isLeftFingerScan){
            numberOfFingersCaptured += 4
        }
        
        if(self.isRightThumbScan){
            numberOfFingersCaptured += 1
        }
        if(self.isLeftThumbScan){
            numberOfFingersCaptured += 1
        }
        return numberOfFingersCaptured
    }
    
    public func clearData(){
        self.rightFingerResult = nil
        self.rightThumbResult = nil
        self.leftFingerResult = nil
        self.leftThumbResult = nil
        self.touchlessEnrollmentProgress = 0
        self.isRightFingerScan = false
        self.isRightThumbScan = false
        self.isLeftFingerScan = false
        self.isLeftThumbScan = false
        
    }
    
    @objc public func cancel(
    
    ){
        self.dismissModal = true
        print("clicked")
    }
}
