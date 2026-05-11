import UIKit

protocol MainViewDelegateProtocol: AnyObject {
    func tapAnswer(tag: Int)
    func tapHintOne()
    func tapHintTwo()
    func tapHintThree()
}

final class MainView: UIView {
    
    weak var delegate: MainViewDelegateProtocol?
    
    private let titleQuestionLabel = UILabel(text: "Кто хочет стать миллионером?", size: 32, weight: .bold)
    
    private let costQuestionLabel = UILabel(text: "Стоимость вопроса:\n 100 монет", size: 20, weight: .regular)
    
    private let bankLabel = UILabel(text: "Банк: 2 000₽", size: 20, weight: .regular)
    private var bankView: UIView = {
        let bankView = UIView()
        bankView.backgroundColor = .systemCyan
        return bankView
    }()
    
    private let notFireSumLabel: UILabel = {
        let notFireSumLabel = UILabel(text: "Несгораемая сумма:\n  0 ₽", size: 20, weight: .regular)
        notFireSumLabel.numberOfLines = 2
        notFireSumLabel.textAlignment = .right
        return notFireSumLabel
    }()
    private var notFireSumView: UIView = {
        let notFireSumView = UIView()
        notFireSumView.backgroundColor = .systemCyan
        return notFireSumView
    }()
    
    private let number = UILabel(text: "1", size: 70, weight: .bold)
    private let numberLabel = UILabel(text: "вопрос", size: 20, weight: .regular)
    private var numberQuestionView: UIView = {
        let numberQuestionView = UIView()
        numberQuestionView.backgroundColor = .systemCyan
        numberQuestionView.layer.cornerRadius = 65
        numberQuestionView.layer.masksToBounds = true
        return numberQuestionView
    }()
    
    
    private lazy var answerOne: UIButton = {
        let answerOne = UIButton(text: "ответ 1", tag: 0)
        answerOne.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return answerOne
    }()
    
    private lazy var answerTwo: UIButton = {
        let answerTwo = UIButton(text: "ответ 2", tag: 1)
        answerTwo.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return answerTwo
    }()
    
    private lazy var answerThree: UIButton = {
        let answerThree = UIButton(text: "ответ 3", tag: 2)
        answerThree.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return answerThree
    }()
    
    private lazy var answerFour: UIButton = {
        let answerFour = UIButton(text: "ответ 4", tag: 3)
        answerFour.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        return answerFour
    }()
    
    private lazy var hintOne: UIButton = {
        let hintOne = UIButton(icon: "phone")
        hintOne.addTarget(self, action: #selector(hintOneTapped(_:)), for: .touchUpInside)
        hintOne.translatesAutoresizingMaskIntoConstraints = false
        return hintOne
    }()
    
    private lazy var hintTwo: UIButton = {
        let hintTwo = UIButton(icon: "percent")
        hintTwo.addTarget(self, action: #selector(hintTwoTapped(_:)), for: .touchUpInside)
        hintTwo.translatesAutoresizingMaskIntoConstraints = false
        return hintTwo
    }()
    
    private var hintTwoOn = 0
    
    private lazy var hintThree: UIButton = {
        let hintThree = UIButton(icon: "person.3")
        hintThree.addTarget(self, action: #selector(hintThreeTapped(_:)), for: .touchUpInside)
        hintThree.translatesAutoresizingMaskIntoConstraints = false
        return hintThree
    }()
    
    private lazy var answerButtons: UIStackView = {
        let answerButtons = UIStackView(arrangedSubviews: [
            answerOne,
            answerTwo,
            answerThree,
            answerFour
        ])
        answerButtons.axis = .vertical
        answerButtons.spacing = 12
        answerButtons.alignment = .fill
        answerButtons.distribution = .fillEqually
        return answerButtons
    }()
    
    private lazy var hints: UIStackView = {
        let hints = UIStackView(arrangedSubviews: [
            hintOne, hintTwo, hintThree
        ])
        hints.axis = .horizontal
        
        hints.distribution = .equalSpacing
        return hints
    }()
    
    init(delegate: MainViewDelegateProtocol) {
        super.init(frame: CGRect())
        self.delegate = delegate
        backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([bankView,
                     notFireSumView,
                     titleQuestionLabel,
                     numberQuestionView,
                     costQuestionLabel,
                     hints,
                     answerButtons])
        bankView.addSubviews([bankLabel])
        notFireSumView.addSubviews([notFireSumLabel])
        numberQuestionView.addSubviews([number, numberLabel])
    }
    
    func configure(with question: Question, bank: Int, notFireSumViewLabel: String, currentIndex: Int) {
        bankView.subviews.forEach { view in
            if let label = view as? UILabel {
                label.text = "Банк: \(bank)₽"
            }
        }
        notFireSumView.subviews.forEach { view in
            if let label = view as? UILabel {
                label.text = "Несгораемая сумма:\n " + notFireSumViewLabel + "  ₽"
            }
        }
        if let number = numberQuestionView.subviews[0] as? UILabel {
            number.text = "\(currentIndex + 1)"
        }
        titleQuestionLabel.text = question.title
        costQuestionLabel.text = "Стоимость вопроса:\n \(question.costQuestion) монет"
        
        answerOne.setTitle(question.answers[0], for: .normal)
        answerTwo.setTitle(question.answers[1], for: .normal)
        answerThree.setTitle(question.answers[2], for: .normal)
        answerFour.setTitle(question.answers[3], for: .normal)
        if !hintTwo.isEnabled, hintTwoOn < 2 {
            hideAnswers(setAnswersForHidn: [0, 1, 2, 3], isHidden: false)
        }
    }
    
    @objc private func answerTapped(_ sender: UIButton) {
        delegate?.tapAnswer(tag: sender.tag)
    }
    
    @objc private func hintOneTapped(_ sender: UIButton) {
        delegate?.tapHintOne()
        sender.isEnabled = false
        sender.alpha = 0.5
    }
    
    @objc private func hintTwoTapped(_ sender: UIButton) {
        delegate?.tapHintTwo()
        sender.isEnabled = false
        sender.alpha = 0.5
    }
    
    @objc private func hintThreeTapped(_ sender: UIButton) {
        delegate?.tapHintThree()
        sender.isEnabled = false
        sender.alpha = 0.5
    }
    
    func hideAnswers(setAnswersForHidn: Set<Int>, isHidden: Bool = true) {
        guard hintTwoOn < 2 else { return }
        if hintTwoOn == 1 {
            hintTwoOn += 1
        }
        var setAnswersForBigger: Set<Int> = [0, 1, 2, 3]
        let buttunsAnswers = [
            answerOne,
            answerTwo,
            answerThree,
            answerFour,
        ]
        if isHidden {
            setAnswersForBigger = setAnswersForBigger.subtracting(setAnswersForHidn)
            hintTwoOn += 1
        }
        UIView.animate(withDuration: 0.3) {
            print("animate true \(self.hintTwoOn)")
            setAnswersForHidn.forEach { buttunsAnswers[$0].isHidden = isHidden }
        }
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            bankLabel.centerYAnchor.constraint(equalTo: bankView.centerYAnchor),
            bankLabel.centerXAnchor.constraint(equalTo: bankView.centerXAnchor),
            bankView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bankView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bankView.widthAnchor.constraint(equalToConstant: 130),
            bankView.heightAnchor.constraint(equalToConstant: 46),
            
            notFireSumLabel.centerYAnchor.constraint(equalTo: notFireSumView.centerYAnchor),
            notFireSumLabel.centerXAnchor.constraint(equalTo: notFireSumView.centerXAnchor),
            notFireSumView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            notFireSumView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            notFireSumView.widthAnchor.constraint(equalToConstant: 210),
            notFireSumView.heightAnchor.constraint(equalToConstant: 60),
            
            titleQuestionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            titleQuestionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            number.centerXAnchor.constraint(equalTo: numberQuestionView.centerXAnchor),
            number.centerYAnchor.constraint(equalTo: numberQuestionView.centerYAnchor, constant: -20),
            numberLabel.centerXAnchor.constraint(equalTo: numberQuestionView.centerXAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: numberQuestionView.bottomAnchor, constant: -20),
            numberQuestionView.widthAnchor.constraint(equalToConstant: 130),
            numberQuestionView.heightAnchor.constraint(equalToConstant: 130),
            numberQuestionView.bottomAnchor.constraint(equalTo: titleQuestionLabel.topAnchor, constant: -30),
            numberQuestionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            costQuestionLabel.topAnchor.constraint(equalTo: titleQuestionLabel.bottomAnchor, constant: 30),
            costQuestionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            hintOne.heightAnchor.constraint(equalToConstant: 80),
            hintOne.widthAnchor.constraint(equalTo: hintOne.heightAnchor),
            hintTwo.heightAnchor.constraint(equalToConstant: 80),
            hintTwo.widthAnchor.constraint(equalTo: hintTwo.heightAnchor),
            hintThree.heightAnchor.constraint(equalToConstant: 80),
            hintThree.widthAnchor.constraint(equalTo: hintThree.heightAnchor),
            
            hints.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 60),
            hints.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hints.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            answerButtons.topAnchor.constraint(equalTo: hints.bottomAnchor, constant: 20),
            answerButtons.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            answerButtons.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answerButtons.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}
