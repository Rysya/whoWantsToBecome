struct Question {
    let title: String
    let description: String
    let answers: [String]
    var trueAnswer: Int
    var costQuestion: Int
}

final class DataStore {
    
    var questions: [Question]
    
    let icons: [String: (String, Bool)] = [
        "phone": ("phone", false),
        "percent": ("percent", false),
        "person": ("person.3", false)]
    
    init() {
        questions = [
            Question(
                title: "Как называется столица Казахстан?",
                description: "География",
                answers: ["Алматы", "Шымкент", "Астана", "Караганда"],
                trueAnswer: 2,
                costQuestion: 100
            ),
            Question(
                title: "Сколько планет в Солнечной системе?",
                description: "Астрономия",
                answers: ["7", "8", "9", "10"],
                trueAnswer: 1,
                costQuestion: 200
            ),
            Question(
                title: "Кто написал «Война и мир»?",
                description: "Литература",
                answers: ["Достоевский", "Толстой", "Пушкин", "Тургенев"],
                trueAnswer: 1,
                costQuestion: 300
            ),
            Question(
                title: "Какой элемент имеет символ O?",
                description: "Химия",
                answers: ["Золото", "Кислород", "Озон", "Олово"],
                trueAnswer: 1,
                costQuestion: 400
            ),
            Question(
                title: "Сколько минут в одном часе?",
                description: "Общее знание",
                answers: ["50", "60", "100", "120"],
                trueAnswer: 1,
                costQuestion: 500
            ),
            Question(
                title: "Какая самая большая планета?",
                description: "Астрономия",
                answers: ["Земля", "Марс", "Юпитер", "Сатурн"],
                trueAnswer: 2,
                costQuestion: 600
            ),
            Question(
                title: "Кто был физиком?",
                description: "Наука",
                answers: ["Эйнштейн", "Пикассо", "Шекспир", "Моцарт"],
                trueAnswer: 0,
                costQuestion: 700
            ),
            Question(
                title: "Какой язык разработала Apple?",
                description: "Программирование",
                answers: ["Java", "Swift", "Python", "C#"],
                trueAnswer: 1,
                costQuestion: 800
            ),
            Question(
                title: "Процесс превращения воды в пар?",
                description: "Физика",
                answers: ["Конденсация", "Испарение", "Замерзание", "Плавление"],
                trueAnswer: 1,
                costQuestion: 900
            ),
            Question(
                title: "Сколько континентов на Земле?",
                description: "География",
                answers: ["5", "6", "7", "8"],
                trueAnswer: 2,
                costQuestion: 1000
            )
        ]
    }
}
