import UIKit

class FloatingPlaceholderTextField: UITextField {
    
    private let floatingLabel = UILabel()
    private var floatingLabelTopConstraint: NSLayoutConstraint!
    
    private let shape = CAShapeLayer()
    
    override var placeholder: String? {
        didSet {
            floatingLabel.text = placeholder
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
                .foregroundColor: UIColor.clear
            ]) // Hide the default placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        let labelFrame = floatingLabel.frame.insetBy(dx: -4, dy: -2)
        let labelPath = UIBezierPath(rect: labelFrame)
        path.append(labelPath)
        path.usesEvenOddFillRule = true
        
        shape.path = path.cgPath
        shape.fillRule = .evenOdd
        shape.fillColor = UIColor.appTeal.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 1.0
    }
    
    private func setup() {
        
        layer.addSublayer(shape)
        
        // Base styling (optional)
        borderStyle = .none
        
        // Floating label setup
        floatingLabel.textColor = .white
        
        addSubview(floatingLabel)
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        floatingLabelTopConstraint = floatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        floatingLabel.bringSubviewToFront(self)
    
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            floatingLabelTopConstraint
        ])
        
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
        
        animateFloating(up: false) // Initial state
    }
    
    @objc private func editingBegan() {
        animateFloating(up: true)
    }
    
    @objc private func editingEnded() {
        if text?.isEmpty ?? true {
            animateFloating(up: false)
            floatingLabel.text = placeholder // Restore placeholder text
        }
    }
    
    @objc private func editingChanged() {
        if !(text?.isEmpty ?? true) {
            animateFloating(up: true)
        }
    }
    
    private func animateFloating(up: Bool) {
        floatingLabel.font = up
        ? UIFont.systemFont(ofSize: 12)
        : UIFont.systemFont(ofSize: 15)
        
        floatingLabelTopConstraint.constant = up ? -7 : 8
//        floatingLabel.backgroundColor = .red // up ? .appTeal : .clear
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            
            self.layoutIfNeeded()
        }
    }
    
    override var text: String? {
        didSet {
            if let text = text, !text.isEmpty {
                animateFloating(up: true)
            } else {
                animateFloating(up: false)
            }
        }
    }
}
