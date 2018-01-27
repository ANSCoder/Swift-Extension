//
//  ExUIImage.swift
//  Swift-Extensionn
//
//  Created by Anand Nimje on 27/01/18.
//  Copyright © 2018 Anand. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit


extension UIImage {
    
    var toBase64String:String {
        let imageData = UIImagePNGRepresentation(self)
        return imageData!.base64EncodedString(options: .lineLength64Characters)
    }
    
    // Return half- Size version of Current image
    var halfSizeImage: UIImage? {
        
//        let halfWidth = 250
//        let halfHeight = 250
        
       let halfWidth = self.size.width / 2
       let halfHeight = self.size.height / 2
        
        UIGraphicsBeginImageContext(CGSize(width: halfWidth, height: halfHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: halfWidth, height: halfHeight))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // Return Quarter- Size version of Current image
    var quarterhalfSizeImage:UIImage? {
        
        let halfWidth = self.size.width / 4
        let halfHeight = self.size.height / 4
        
        UIGraphicsBeginImageContext(CGSize(width: halfWidth, height: halfHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: halfWidth, height: halfHeight))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    //Loading Image From Document Directory
    func loadImageFromDocumentDirPath(_ path: String) -> UIImage? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        if (data != nil){
            let image = UIImage(data: data!)
            return image
        }else{
            return nil
        }
    }
    
}
