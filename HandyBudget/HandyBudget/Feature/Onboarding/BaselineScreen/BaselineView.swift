//
//  BaselineView.swift
//  HandyBudget
//
//  Created by Jadson on 20/11/2025.
//

import UIKit

class BaselineView: UIView {
    
    private var selectedBaseline: BaselineCycle?
    
    private lazy var baselineExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var baselineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Please select your financial baseline:"
        return label
    }()
    
    private lazy var selectBaselineButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .primary("Select an option")
        return button
    }()
    
    // StackView to hold label and baseline button
    private lazy var baselineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [baselineLabel, selectBaselineButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //GPT RECOMMENDATION
    
    private lazy var daySelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .primary("Select day")
        button.isHidden = true   // start hidden unless monthly is selected
        return button
    }()

    private lazy var dynamicOptionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private func setupDayMenu() {
        let actions: [UIAction] = (1...31).map { day in
            UIAction(title: "\(day)") { [weak self] _ in
                self?.daySelectionButton.setTitle("Day \(day)", for: .normal)
                self?.updateSummaryLabel(baseline: .monthly, selectedDay: day)
            }
        }
        daySelectionButton.menu = UIMenu(title: "Select a day", children: actions)
        daySelectionButton.showsMenuAsPrimaryAction = true
        daySelectionButton.addTarget(self, action: #selector(daySelected), for: .touchUpInside)
        
    }

    @objc private func daySelected(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        // Convert symbol → Weekday enum
        let weekdays = Weekday.allCases
        let found = weekdays.first { $0.weekdaySymbol == title || $0.shortWeekdaySymbol == title }
        
        guard let selectedWeekday = found else { return }
        
        // Read the active baseline
        guard let baselineText = selectBaselineButton.title(for: .normal),
              let baseline = BaselineCycle(rawValue: baselineText)
        else { return }
        
        // Update summary
        updateSummaryLabel(
            baseline: baseline,
            selectedWeekday: baseline == .monthly ? nil : selectedWeekday
        )
    }
    
    private func updateDynamicOptions(for option: BaselineCycle) {
        
        // Remove existing buttons
        dynamicOptionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let labels: [String]
        
        switch option {
            case .weekly, .fortnightly:
                labels = Calendar.current.shortWeekdaySymbols
                
                for label in labels {
                    let btn = UIButton(type: .system)
                    btn.setTitle(label, for: .normal)
                    btn.titleLabel?.font = .systemFont(ofSize: 14)
                    btn.layer.cornerRadius = 6
                    btn.backgroundColor = UIColor(white: 1.0, alpha: 0.15)
                    btn.setTitleColor(.white, for: .normal)
                    btn.addTarget(self, action: #selector(daySelected), for: .touchUpInside)
                    dynamicOptionsStack.addArrangedSubview(btn)
                }
            case .monthly:
                setupDayMenu()
        }
    }
    
    private func updateSummaryLabel( baseline: BaselineCycle, selectedWeekday: Weekday? = nil, selectedDay: Int? = nil) {
        let summary = BaselineCalculator.endCycleDescription(
            baseline: baseline,
            startWeekday: selectedWeekday,
            startDay: selectedDay
        )
        summaryLabel.isHidden = false
        summaryLabel.text = summary
    }
    
    //END OF GPT RECOMMENDATION
    
    func setupMenuButton() {
        
        let weeklyOptionAction = UIAction(title: BaselineCycle.weekly.rawValue, handler: { [weak self] _ in
            self?.selectedBaseline = .weekly
            self?.selectBaselineButton.setTitle(BaselineCycle.weekly.rawValue, for: .normal)
            self?.updateDynamicOptions(for: .weekly)
            self?.daySelectionButton.isHidden = true
            self?.summaryLabel.text = ""
            self?.summaryLabel.isHidden = true
        })
        
        let fortnightlyOptionAction = UIAction(title: BaselineCycle.fortnightly.rawValue, handler: { [weak self] _ in
            self?.selectedBaseline = .fortnightly
            self?.selectBaselineButton.setTitle(BaselineCycle.fortnightly.rawValue, for: .normal)
            self?.updateDynamicOptions(for: .fortnightly)
            self?.daySelectionButton.isHidden = true
            self?.summaryLabel.text = ""
            self?.summaryLabel.isHidden = true
        })
        let monthlyOptionAction = UIAction(title: BaselineCycle.monthly.rawValue, handler: { [weak self] _ in
            self?.selectedBaseline = .monthly
            self?.selectBaselineButton.setTitle(BaselineCycle.monthly.rawValue, for: .normal)
            self?.updateDynamicOptions(for: .monthly)
            self?.daySelectionButton.isHidden = false
            self?.summaryLabel.text = ""
            self?.summaryLabel.isHidden = true
            
        })
        
        let menu = UIMenu(title: "Select an option", children: [weeklyOptionAction, fortnightlyOptionAction, monthlyOptionAction])
        selectBaselineButton.menu = menu
        selectBaselineButton.showsMenuAsPrimaryAction = true // This makes the menu appear on a tap
        selectBaselineButton.setTitle("Select an option", for: .normal)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
        baselineExplanationLabel.text = "To get started, we need to establish your financial baseline. This involves understanding your current income and expenses so we can create a budget that works for you. Don't worry, this information is kept secure and private."
        
        setupMenuButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaselineView: ViewCode {
    func addSubViews() {
        addSubview(baselineExplanationLabel)
        addSubview(baselineStackView)
        addSubview(dynamicOptionsStack)
        addSubview(daySelectionButton)
        addSubview(summaryLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            baselineExplanationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            baselineExplanationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            baselineExplanationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            baselineStackView.topAnchor.constraint(equalTo: baselineExplanationLabel.bottomAnchor, constant: 30),
            baselineStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            baselineStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            dynamicOptionsStack.topAnchor.constraint(equalTo: baselineStackView.bottomAnchor, constant: 24),
            dynamicOptionsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dynamicOptionsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dynamicOptionsStack.heightAnchor.constraint(equalToConstant: 44),
            
            daySelectionButton.topAnchor.constraint(equalTo: baselineStackView.bottomAnchor, constant: 24),
            daySelectionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            daySelectionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            daySelectionButton.heightAnchor.constraint(equalToConstant: 44),
            
            summaryLabel.topAnchor.constraint(equalTo: dynamicOptionsStack.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .appTeal
    }
    
}
