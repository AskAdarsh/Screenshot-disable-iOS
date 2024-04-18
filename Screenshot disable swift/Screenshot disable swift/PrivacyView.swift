//
//  PrivacyView.swift
//  Screenshot disable swift
//
//  Created by Adarsh s kumar on 18/04/24.
//

import UIKit

class privacyView:UIView{
    // outlet from bacground View created as ScreenshotDisable.xib
    @IBOutlet var screenShotText: UILabel!
    // textFieild which we extract the view with screenshot diabling  aka _UITextLayoutCanvasView
    fileprivate let textfield = UITextField()
    // view with screenshot diabling  aka _UITextLayoutCanvasView
    var contentView :UIView!
    
    var  disableText = "Screenshot Blocked!"
    // toggle screenshot disabling
   @IBInspectable var isSecure : Bool = true{
        didSet{
            textfield.isSecureTextEntry = isSecure
        }
    }
    // toggle background color of content view
    @IBInspectable  var bgColor: UIColor = .white {
        didSet {
            if contentView != nil{
                contentView.backgroundColor = bgColor
            }
        }
    }
    // initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
 // setup views for screenshot disabling
    private func setupView(){
        textfield.isSecureTextEntry = isSecure
        let subViews = self.subviews
        
        // getting _UITextLayoutCanvasView form TextField
        let container = textfield.subviews.filter({
            type(of: $0).description() == "_UITextLayoutCanvasView"
        })
        if let canvasView  = container.first {
            contentView = canvasView
            addSubview(contentView)
            contentView.backgroundColor = bgColor
            
            // setting up constraints for screenshot disabling view aka contentView
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            // moving views inside the main view to contentView
            // you can skip this methord by addyind your views directly to content view
            
            for subview in subViews {
                contentView.addSubview(subview)
            }
            // adding a background image / view for you custom message you can display while taking screenshots
            // here i am using xib file for view you can use an uiImageview or create you own view and use  ' addBgview(your_view) '
            if let bgView = Bundle(for: privacyView.self).loadNibNamed("ScreenshotDisable", owner: self, options: nil)?.first as? UIView {
                addBgview(bgView)
            }
        }
    }
    
    private func addBgview(_ backgroundView : UIView){
        self.insertSubview(backgroundView, at: 0)
        self.isUserInteractionEnabled = true
        topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        screenShotText.text = disableText
    }
}

