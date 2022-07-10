//
//  MainViewController.swift
//  Xylophone
//
//  Created by Vadlet on 04.07.2022.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    private lazy var player = AVAudioPlayer()
    
    private lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 8
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createButton()
        addSubviews()
    }
}

//MARK: - settingsButton

extension MainViewController {
    private func createButton(){
        
        let widthWindow = UIScreen.main.bounds.width - 20
        let noteName = ["C", "D", "E", "F", "G", "A", "B"]
        
        for noteCount in noteName.indices {
            let button = UIButton(type: .system)
            button.setTitle(noteName[noteCount], for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
            button.tintColor = .black
            button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
            button.backgroundColor = UIColor(named: noteName[noteCount])
            button.layer.cornerRadius = 10
            button.widthAnchor.constraint(equalToConstant: widthWindow - CGFloat(20 * noteCount)).isActive = true
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    private func playSound(_ title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "wav") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
     
    @objc private func actionButton(_ sender: UIButton) {
        if let title = sender.currentTitle { playSound(title) }
    }

}

//MARK: - setupConstraints
extension MainViewController {
    
    private func addSubviews() {
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
