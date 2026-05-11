import UIKit

class MainController: UIViewController {

    private lazy var mainView = MainView(delegate: self)
    
    private let questions = DataStore().questions
    
    private var currentIndex: Int = 0
    private var bank: Int = 0
    
    private var notFireBankLabel: String {
        switch bank {
            case 1000...1999 : "1 000"
            case 2000...2999 : "2 000"
            case 3000...3999 : "3 000"
            case 4000...4999 : "4 000"
            default: "0"
        }
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        mainView.configure(with: questions[currentIndex], bank: bank,  notFireSumViewLabel: notFireBankLabel, currentIndex: currentIndex)
    }
    
    private func showAlertTrue() {
        let isFinishAnswer = currentIndex == questions.count - 1
        let title = isFinishAnswer
        ? "Поздравляем! Вы стали миллионером!"
        : "Поздравляем! \nВы выбрали правильный ответ"
        
        let titleAction = isFinishAnswer
        ? "Начать заново"
        : "Следующий вопрос"
        let alert = UIAlertController(title: title,
                                      message: "Ваша сумма: \(bank)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleAction, style: .default) { _ in
            if isFinishAnswer {
                self.bank = 0
                self.currentIndex = 0
            } else {
                self.currentIndex += 1
            }
            self.setupUI()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func showAlertFalse() {
        
        let alert = UIAlertController(title: "Ответ неверный",
                                      message: "Ваша сумма: \(notFireBankLabel)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Попробовать еще раз", style: .default)
        let newStartAction = UIAlertAction(title: "Начать заново", style: .default) { _ in
            self.bank = 0
            self.currentIndex = 0
            self.setupUI()
        }
        alert.addAction(newStartAction)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension MainController: MainViewDelegateProtocol {
    func tapAnswer(tag: Int) {
        if questions[currentIndex].trueAnswer == tag {
            bank += questions[currentIndex].costQuestion
            showAlertTrue()
        } else {
            showAlertFalse()
        }
    }
    
    func tapHintOne() {
        let trueAnswer = questions[currentIndex].answers[questions[currentIndex].trueAnswer]
        let alert = UIAlertController(title: "Ответ друга",
                                      message: "\(trueAnswer)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func tapHintTwo() {
        var setAnswersForHidn: Set<Int> = [0, 1, 2, 3]
        setAnswersForHidn.remove(questions[currentIndex].trueAnswer)
        let numFromRandom = setAnswersForHidn.randomElement() ?? 0
        setAnswersForHidn.remove(numFromRandom)
        mainView.hideAnswers(setAnswersForHidn: setAnswersForHidn)
    }
    
    func tapHintThree() {
        var dictAnswers: [Int: Int] = [
            0: -1,
            1: -1,
            2: -1,
            3: -1
        ]
        dictAnswers[questions[currentIndex].trueAnswer] = Int.random(in: 30...80)
        var tempRandomAnswer = 100 - (dictAnswers[questions[currentIndex].trueAnswer] ?? 0)
        var strAnswer = ""
        dictAnswers.forEach { (key: Int, value: Int) in
            if value < 0 {
                dictAnswers[key] = Int.random(in: 0...tempRandomAnswer)
                tempRandomAnswer -= dictAnswers[key] ?? 0
            }
            strAnswer += questions[currentIndex].answers[key] + ": \(dictAnswers[key] ?? 0) % \n"
        }
        
        let alert = UIAlertController(title: "Ответ зала",
                                      message: "\(strAnswer)",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
