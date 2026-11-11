import UIKit

class KeyboardViewController: UIInputViewController {

    private let pasteButton = UIButton(type: .system)
    private let globeButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        pasteButton.setTitle("粘贴剪贴板", for: .normal)
        pasteButton.titleLabel?.font = .systemFont(ofSize: 16)
        pasteButton.backgroundColor = .systemBlue
        pasteButton.setTitleColor(.white, for: .normal)
        pasteButton.layer.cornerRadius = 8

        pasteButton.addTarget(
            self,
            action: #selector(pasteFromClipboard),
            for: .touchUpInside
        )

        globeButton.setTitle("🌐", for: .normal)
        globeButton.titleLabel?.font = .systemFont(ofSize: 22)

        globeButton.addTarget(
            self,
            action: #selector(switchKeyboard),
            for: .touchUpInside
        )

        let stack = UIStackView(
            arrangedSubviews: [globeButton, pasteButton]
        )

        stack.axis = .horizontal
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            stack.heightAnchor.constraint(equalToConstant: 44),
            view.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    @objc private func pasteFromClipboard() {
        guard let text = UIPasteboard.general.string,
              !text.isEmpty else {
            return
        }

        textDocumentProxy.insertText(text)
    }

    @objc private func switchKeyboard() {
        advanceToNextInputMode()
    }
}

