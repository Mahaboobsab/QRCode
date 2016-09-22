//
//  ViewController.swift
//  QRCodeGen
//
//  Created by Mahaboobsab Nadaf on 20/09/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var qrcodeImage : CIImage!
    
    @IBOutlet weak var textFieldVal: UITextField!
    @IBOutlet weak var geterate: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var qrImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func slider(sender: AnyObject) {
        qrImage.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }
    
    @IBAction func geterate(sender: AnyObject) {
        
        if qrcodeImage == nil {
            if textFieldVal.text == "" {
                return
            }
            
            let data = textFieldVal.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            
            textFieldVal.resignFirstResponder()
            
            geterate.setTitle("Clear", forState: UIControlState.Normal)
            
            displayQRCodeImage()
        }
        else {
            qrImage.image = nil
            qrcodeImage = nil
            geterate.setTitle("Generate", forState: UIControlState.Normal)
        }
        
        textFieldVal.enabled = !textFieldVal.enabled
        slider.hidden = !slider.hidden


}
    func displayQRCodeImage() {
        let scaleX = qrImage.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrImage.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        qrImage.image = UIImage(CIImage: transformedImage)
}
}
