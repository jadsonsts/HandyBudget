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
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var baselineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.text = "Please select your financial baseline:"
        return label
    }()
    
    private lazy var selectBaselineButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .primary("Select an option")
        return button
    }()
    
    // StackView to hold label and baseline button
    private lazy var baselineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [baselineLabel, selectBaselineButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var finishOnboardButton = UIButton(
        configuration: .primary("Save Settings"),
        primaryAction: .init(handler: { [weak self]_ in
        // Add delegate call to handle button tap
    })
    )
    
    //GPT RECOMMENDATION
    private lazy var daySelectionButton: UIButton = {
        let button = UIButton(type: .system)
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
        return stack
    }()

    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
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
        
        baselineExplanationLabel.text = "We need to establish your financial baseline (determine when the app will reset the bills to pay). This helps us provide accurate budgeting and expense tracking."
        
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
        addSubview(finishOnboardButton)
    }
    
    func setupConstraints() {
        baselineExplanationLabel
            .fillHorizontally()
            .setConstraint([
                baselineExplanationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
            ])
        
        baselineStackView
            .fillHorizontally()
            .setConstraint([
                baselineStackView.topAnchor.constraint(equalTo: baselineExplanationLabel.bottomAnchor, constant: 30)
        ])
        
        dynamicOptionsStack
            .fillHorizontally()
            .setConstraint([
                dynamicOptionsStack.topAnchor.constraint(equalTo: baselineStackView.bottomAnchor, constant: 20),
                dynamicOptionsStack.heightAnchor.constraint(equalToConstant: 44)
            ])
        
        daySelectionButton
            .fillHorizontally()
            .setConstraint([
            daySelectionButton.topAnchor.constraint(equalTo: baselineStackView.bottomAnchor, constant: 20),
            daySelectionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        summaryLabel
            .fillHorizontally()
            .setConstraint([
                summaryLabel.topAnchor.constraint(equalTo: dynamicOptionsStack.bottomAnchor, constant: 20)
            ])
        
        finishOnboardButton
            .fillHorizontally()
            .setConstraint([
                finishOnboardButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

    }
    
    func setupStyle() {
        backgroundColor = .appTeal
    }
    
}
    
