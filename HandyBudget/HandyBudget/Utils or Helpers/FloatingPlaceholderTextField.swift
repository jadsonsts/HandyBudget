import UIKit

class FloatingPlaceholderTextField: UITextField {

    private var floatingLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()

    override var placeholder: String? {
        didSet {
            floatingLabel.text = placeholder
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFloatingLabel()
        addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFloatingLabel() {
        addSubview(floatingLabel)
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: -2)
        ])
    }

    @objc private func textFieldEditingDidBegin() {
        animateFloatingLabel(up: true)
    }

    @objc private func textFieldEditingDidEnd() {
        if text?.isEmpty == true {
            animateFloatingLabel(up: false)
        }
    }

    @objc private func textFieldEditingChanged() {
        if text?.isEmpty == false {
            animateFloatingLabel(up: true)
        }
    }

    private func animateFloatingLabel(up: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.floatingLabel.alpha = up ? 1.0 : 0.0
        }
    }
}
//
//class FloatingPlaceholderTextField: UITextField {
//    
//    private let floatingLabel = UILabel()
//    private var floatingLabelTopConstraint: NSLayoutConstraint!
//    
//    override var placeholder: String? {
//        didSet {
//            floatingLabel.text = placeholder
//            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [
//                .foregroundColor: UIColor.clear
//            ]) // Hide the default placeholder
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        // Base styling (optional)
//        borderStyle = .roundedRect
//        
//        // Floating label setup
//        floatingLabel.font = UIFont.systemFont(ofSize: 16)
//        floatingLabel.textColor = .white
//        floatingLabel.alpha = 0.0
//        
//        addSubview(floatingLabel)
//        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        floatingLabelTopConstraint = floatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
//        
//        NSLayoutConstraint.activate([
//            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            floatingLabelTopConstraint
//        ])
//        
//        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
//        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
//        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
//    }
//    
//    @objc private func editingBegan() {
//        animateFloating(up: true)
//    }
//    
//    @objc private func editingEnded() {
//        if text?.isEmpty ?? true {
//            animateFloating(up: false)
//            floatingLabel.text = placeholder // Restore placeholder text
//        }
//    }
//    
//    @objc private func editingChanged() {
//        if !(text?.isEmpty ?? true) {
//            animateFloating(up: true)
//        }
//    }
//    
//    private func animateFloating(up: Bool) {
//        floatingLabel.font = up
//        ? UIFont.systemFont(ofSize: 12)
//        : UIFont.systemFont(ofSize: 10)
//        
//        floatingLabelTopConstraint.constant = up ? -8 : 12
//        
//        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
//            self.floatingLabel.alpha = up ? 1 : 0
//            self.layoutIfNeeded()
//        }
//    }
//    
//    override var text: String? {
//        didSet {
//            if let text = text, !text.isEmpty {
//                animateFloating(up: true)
//            } else {
//                animateFloating(up: false)
//            }
//        }
//    }
//}
