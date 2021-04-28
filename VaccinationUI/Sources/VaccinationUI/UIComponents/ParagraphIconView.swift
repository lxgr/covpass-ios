//
//  ParagraphIconView.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import UIKit

@IBDesignable
public class ParagraphIconView: XibView {
    @IBOutlet public var stackView: UIStackView!
    @IBOutlet public var textStackView: UIStackView!
    @IBOutlet public var icon: UIImageView!
    @IBOutlet public var title: UILabel!
    @IBOutlet public var body: LinkTextView!

    public var titleText: String? {
        didSet {
            if let text = titleText {
                title.text = text
                hasTitle = !text.isEmpty
                checkVisibility()
                setupAccessibility()
            }
        }
    }

    public var spacing: CGFloat? {
        didSet {
            guard let spacing = spacing else { return }
            textStackView.spacing = spacing
        }
    }

    public var bodyText: String? {
        didSet {
            body.linkText = bodyText
            checkVisibility()
            setupAccessibility()
        }
    }

    public var bodyFont: UIFont? {
        didSet {
            guard let bodyFont = bodyFont else { return }
            let newFont = UIFont(descriptor: bodyFont.fontDescriptor, size: bodyFont.fontDescriptor.pointSize)
            body.adjustsFontForContentSizeCategory = true
            body.linkTextFont = newFont
        }
    }

    @IBInspectable internal var hasTitle: Bool = false {
        didSet {
            if !hasTitle {
                title.removeFromSuperview()
            }
        }
    }

    required init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override func initView() {
        super.initView()
        setupView()
    }

    private func checkVisibility() {
        isHidden = (bodyText?.isEmpty ?? true) && !hasTitle
    }

    private func setupAccessibility() {
        let accessibilityLabelText = "\(titleText ?? "") \(bodyText ?? "")"
        enableAccessibility(label: accessibilityLabelText, traits: .staticText)
    }

    internal func setupView() {
        layoutMargins = .init(top: 0, left: 24, bottom: 0, right: 24)
        stackView.setCustomSpacing(15, after: icon)
        title.font = UIConstants.Font.semiBold
        title.adjustsFontForContentSizeCategory()
        title.textColor = UIConstants.BrandColor.onBackground100
        bodyFont = UIConstants.Font.regular
        body.textColor = UIConstants.BrandColor.onBackground100
    }
}
