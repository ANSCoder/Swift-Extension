# Swift-Extension

Swift-Extension Files for easy to use in **Swift 4.1** version. Need to download file and drag and drop in your Xcode Project.

# Documentation 

[Check here.](https://anscoder.github.io/Swift-Extension/)

# Installation

Drag and drop [Extension](https://github.com/ANSCoder/Swift-Extension/tree/master/Swift-Extension/Extensions) folder inside your project and use it.

Or directly you can copy and paste inside your class. 🚀

### Contents  🎉
 
 - **Array**
 ```swift
 extension Array {
    func atIndex(_ index: Int) -> Element? {
        if index < 0 || index > self.count - 1 {
            return nil
        }
        return self[index]
    }
}
```
 
 - **UILabel**
 ```swift
 extension UILabel{
    
    func setLeft(){
        self.textAlignment = .left
    }
    
    func setRight(){
        self.textAlignment = .right
    }
    
    func attribute(_ with: String, effect: String){
        let mainString = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: self.font.fontName, size: self.font.pointSize)!]
        let effectString = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: self.font.pointSize)]
        
        let partOne = NSMutableAttributedString(string: with, attributes: mainString)
        let partTwo = NSMutableAttributedString(string: effect, attributes: effectString)
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        self.attributedText = combination
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
 ```
 
 - **UIViewController**
 ```swift
 extension UIViewController{
    
    //MARK:- Aleart View
    func showAleartViewwithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(_ message: String, with completion: (() -> Void)?){
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            alertController.dismiss(animated: true, completion: nil)
            completion?()
        })
    }
    
}
 ```
 - **UIScrollView**
 ```swift
 extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            UIView.animate(withDuration: 0.4, animations: {
                // Get the Y position of your child view
                let childStartPoint = origin.convert(view.frame.origin, to: self)
                // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
                self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y, width:1, height:self.frame.height), animated: animated)
            })
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
 ```
 - **UINavigationBar**
 ```swift
 public extension UINavigationBar {
    
    /// SwifterSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    public func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedStringKey: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
    
    /// SwifterSwift: Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }
    
    /// SwifterSwift: Set navigationBar background and text colors
    ///
    /// - Parameters:
    ///   - background: backgound color
    ///   - text: text color
    public func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: .default)
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }
}
 ```
 - **String**
 ```swift
 extension String {
    
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var trim: String {
        if self.isNotEmpty {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }else{
            return ""
        }
    }
    
    var trimLine: String {
        if self.isNotEmpty {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }else{
            return ""
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isEmail: Bool {
        guard !self.isEmpty else{
            return false
        }
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    var isMobile: Bool {
        guard !self.isEmpty else{
            return false
        }
        let phoneRegix = "[123456789][0-9]{8}([0-9]{1})?"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegix)
        return phoneTest.evaluate(with: self)
    }
    
    func changeDate(_ mydate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "yyyy/M/dd"
        let convertedDate = dateFormatter.date(from: mydate)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let date = dateFormatter.string(from: convertedDate!)
        return date
    }
    
    //MARK : - For First Capital letter of String
    private func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    //MARK: - Removing space from String
    var removeSpace: String {
        if self.isNotEmpty {
            return self.components(separatedBy: .whitespaces).joined()
        }else{
            return ""
        }
    }
}
 ```
 - **UITextField**
 ```swift
 extension UITextField {
    
    func setBorderAndCorner(){
        DispatchQueue.main.async {
            self.layer.borderWidth = 1.0
            self.layer.borderColor = ExFunction.hexStringToUIColor(hex: "61906B").cgColor
            self.layer.cornerRadius = 5
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text ?? "")
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self.text ?? "", options: [], range: NSMakeRange(0, (self.text ?? "").count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == (self.text ?? "").count && (self.text ?? "").count == 10
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}
 ```
 - **Date**
 ```swift
 extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
 ```
 - **NSMutableAttributedString**
 ```swift
 extension NSMutableAttributedString {
    
    @discardableResult
    func bold(_ text: String) -> NSMutableAttributedString {
        let attrs = [NSAttributedStringKey.font : UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult
    func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
 ```
 - **UIColor (HEX)**
 ```swift
  extension UIColor {
    convenience init(hex: String) {
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
 ```
 
 - **UIImage**
 ```swift
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
 ```
 - **UIImageView**
 ```swift
 extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadious() {
        let radius = self.frame.height / 20
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
 ```
 - **ExFunction (Public functions for String to Dictionary & Dictionary to String)**
 
 ```swift
 public struct ExFunction {
    
    //MARK:- String to Dictionary Conversion
    static func convertStringToDictionary(_ json: String) -> [String: Any] {
        if let data = json.data(using: String.Encoding.utf8) {
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
                return json ?? [:]
            }catch{
                print(error)
            }
        }
        return [:]
    }
    
    static func getRawJSON(from dictionary:[String: Any]) -> String{
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            //Handle Error here
            return ""
        }
        let jsonString = String(data: theJSONData, encoding: .ascii) ?? ""
        return jsonString
    }
    
    static func hexStringToUIColor(hex:String) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
 ```
