import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 60)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    // MARK: - Properties
    
    var currentNumber: Double = 0
    var previousNumber: Double = 0
    var selectedOperator = ""
    var isTypingNumber = false
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        setupUI()
    }
    
    
    func setupUI() {
        view.backgroundColor = .calculatorBackground
        view.addSubview(resultLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resultLabel.heightAnchor.constraint(equalToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - Button Actions
    
    @objc func buttonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            // Handle button tap based on the title
            switch title {
            case "0"..."9", ".":
                handleNumberButton(title)
            case "+", "-", "x", "/":
                handleOperatorButton(title)
            case "=":
                calculateResult()
            case "C":
                resetCalculator()
//            case "+/-":
//                toggleSign()
//            case "%":
//                calculatePercentage()
            default:
                break
            }
        }
    }
    
    func handleNumberButton(_ title: String) {
        if isTypingNumber {
            if title == "." && resultLabel.text!.contains(".") {
                return
            }
            resultLabel.text! += title
        } else {
            resultLabel.text = title
            isTypingNumber = true
        }
    }
    
    func handleOperatorButton(_ title: String) {
        if isTypingNumber {
            calculateResult()
        }
        selectedOperator = title
        previousNumber = Double(resultLabel.text!) ?? 0
        isTypingNumber = false
    }
    
    func calculateResult() {
        if isTypingNumber {
            let current = Double(resultLabel.text!) ?? 0
            switch selectedOperator {
            case "+":
                resultLabel.text = String(previousNumber + current)
            case "-":
                resultLabel.text = String(previousNumber - current)
            case "x":
                resultLabel.text = String(previousNumber * current)
            case "/":
                if current != 0 {
                    resultLabel.text = String(previousNumber / current)
                } else {
                    resultLabel.text = "Error"
                }
            default:
                break
            }
            isTypingNumber = false
        }
    }
    
    func resetCalculator() {
        resultLabel.text = "0"
        currentNumber = 0
        previousNumber = 0
        selectedOperator = ""
        isTypingNumber = false
    }
}

extension CalculatorViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
        let title = buttonTitles[indexPath.item]
        cell.button.setTitle(title, for: .normal)
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.button.backgroundColor = buttonBackground(for: title)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 70) / 4
        return CGSize(width: width, height: width)
    }

}

