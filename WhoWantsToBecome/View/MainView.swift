import UIKit

protocol MainViewDelegateProtocol: AnyObject {
    func tapAnswer(tag: Int)
    func tapHintOne()
    func tapHintTwo()
    func tapHintThree()
}

class MainView: UIView {
    
    private let dataStore = DataStore()
    weak var delegate: MainViewDelegateProtocol?
    
    let titleQuestionLabel = UILabel(text: "Кто хочет стать миллионером?", size: 32, weight: .bold)
    let costQuestionLabel = UILabel(text: "Стоимость вопроса:\n 100 монет", size: 20, weight: .regular)
    
    lazy var bankView: UIView = {
        let bankLabel = UILabel(text: "Банк: 2 000₽", size: 20, weight: .regular)
        let view = UIView()
        view.addSubviews([bankLabel])
        view.backgroundColor = .systemCyan
        bankLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bankLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalToConstant: 130).isActive = true
        view.heightAnchor.constraint(equalToConstant: 46).isActive = true
        return view
    }()
    
    lazy var notFireSumView: UIView = {
        let notFireSumLabel = UILabel(text: "Несгораемая сумма:\n  0 ₽", size: 20, weight: .regular)
        notFireSumLabel.numberOfLines = 2
        notFireSumLabel.textAlignment = .right
        let view = UIView()
        view.addSubviews([notFireSumLabel])
        notFireSumLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        notFireSumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.backgroundColor = .systemCyan
        view.widthAnchor.constraint(equalToConstant: 210).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    lazy var numberQuestionView: UIView = {
        let number = UILabel(text: "1", size: 70, weight: .bold)
        let numberLabel = UILabel(text: "вопрос", size: 20, weight: .regular)
        let view = UIView()
        view.addSubviews([number, numberLabel])
        number.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        number.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        view.backgroundColor = .systemCyan
        view.widthAnchor.constraint(equalToConstant: 130).isActive = true
        view.heightAnchor.constraint(equalToConstant: 130).isActive = true
        view.layer.cornerRadius = 65
        view.layer.masksToBounds = true
        return view
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
        return hintOne
    }()
    
    private lazy var hintTwo: UIButton = {
        let hintTwo = UIButton(icon: "percent")
        hintTwo.addTarget(self, action: #selector(hintTwoTapped(_:)), for: .touchUpInside)
        return hintTwo
    }()
    
    private lazy var hintThree: UIButton = {
        let hintThree = UIButton(icon: "person.3")
        hintThree.addTarget(self, action: #selector(hintThreeTapped(_:)), for: .touchUpInside)
        return hintThree
    }()
    
    lazy var answerButtons = UIStackView(views: [answerOne, answerTwo, answerThree, answerFour], axis: .vertical, spacing: 12, aligment: .fill)
    
    lazy var hints: UIStackView = {
        let stack = UIStackView(views: [hintOne, hintTwo, hintThree], axis: .horizontal, spacing: 0, aligment: .fill)
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var answerOneHeight = answerOne.heightAnchor.constraint(equalToConstant: 60)
    private lazy var answerTwoHeight = answerTwo.heightAnchor.constraint(equalToConstant: 60)
    private lazy var answerThreeHeight = answerThree.heightAnchor.constraint(equalToConstant: 60)
    private lazy var answerFourHeight = answerFour.heightAnchor.constraint(equalToConstant: 60)
    private lazy var buttunsAnswersHeight = [
        answerOneHeight, answerTwoHeight, answerThreeHeight, answerFourHeight,
    ]
    
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
    
    func setupUI(){
        addSubviews([bankView, notFireSumView, titleQuestionLabel, numberQuestionView, costQuestionLabel, hints, answerButtons])
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
        hideAnswers(setAnswersForHidn: [0, 1, 2, 3], isHidden: false)
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
        var setAnswersForBigger: Set<Int> = [0, 1, 2, 3]
        let buttunsAnswers = [
            answerOne,
            answerTwo,
            answerThree,
            answerFour,
        ]
        if isHidden {
            setAnswersForBigger = setAnswersForBigger.subtracting(setAnswersForHidn)
        }
        setAnswersForHidn.forEach { buttunsAnswers[$0].isHidden = isHidden }
        setAnswersForBigger.forEach {
            self.buttunsAnswersHeight[$0].isActive = false
            self.buttunsAnswersHeight[$0].constant = isHidden ? 132 : 60
        }
        UIView.animate(withDuration: 0.3) {
            setAnswersForBigger.forEach { self.buttunsAnswersHeight[$0].isActive = true }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            bankView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            bankView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            notFireSumView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            notFireSumView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleQuestionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleQuestionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            titleQuestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleQuestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            numberQuestionView.bottomAnchor.constraint(equalTo: titleQuestionLabel.topAnchor, constant: -30),
            numberQuestionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            costQuestionLabel.topAnchor.constraint(equalTo: titleQuestionLabel.bottomAnchor, constant: 30),
            costQuestionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            costQuestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            costQuestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            hints.bottomAnchor.constraint(equalTo: answerButtons.topAnchor, constant: -20),
            hints.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hints.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            answerOneHeight, answerTwoHeight, answerThreeHeight, answerFourHeight,
            
            answerButtons.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            answerButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            answerButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
