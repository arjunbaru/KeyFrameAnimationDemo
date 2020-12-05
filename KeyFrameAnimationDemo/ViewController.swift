//
//  ViewController.swift
//  KeyFrameAnimationDemo
//
//  Created by Arjun Baru on 07/11/20.
//

import UIKit

class ViewController: UIViewController {

    let topView: UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    let middleView: UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bottomView: UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    let dotButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "ellipsis")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let crossButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView, middleView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(vStackView)
        view.addSubview(dotButton)
        view.addSubview(crossButton)
        setConstraints()

        dotButton.addTarget(nil, action: #selector(onTapOfDotButton), for: .touchUpInside)
        crossButton.addTarget(nil, action: #selector(onTapOfCrossButton), for: .touchUpInside)
    }

    fileprivate func setConstraints() {
        let layoutmargin = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            vStackView.trailingAnchor.constraint(equalTo: layoutmargin.trailingAnchor, constant: -20),
            vStackView.bottomAnchor.constraint(equalTo: dotButton.topAnchor, constant: -15),
            dotButton.bottomAnchor.constraint(equalTo: layoutmargin.bottomAnchor, constant: -10),
            dotButton.centerXAnchor.constraint(equalTo: vStackView.centerXAnchor),
            crossButton.centerXAnchor.constraint(equalTo: dotButton.centerXAnchor),
            crossButton.centerYAnchor.constraint(equalTo: dotButton.centerYAnchor)
        ])

        self.topView.transform = Position.rightAligned.transform(view: topView)
        self.middleView.transform = Position.rightAligned.transform(view: middleView)
        self.bottomView.transform = Position.rightAligned.transform(view: bottomView)
    }

    @objc func onTapOfDotButton() {
        showOptions()
    }

    @objc func onTapOfCrossButton() {
        hideOptions()
    }

}

extension ViewController {
    func showOptions() {
        crossButton.isHidden = false

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0/0.5, relativeDuration: 0.3/0.5, animations: {
                self.bottomView.transform = Position.reset.transform(view: self.bottomView)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1/0.5, relativeDuration: 0.3/0.5, animations: {
                self.middleView.transform = Position.reset.transform(view: self.middleView)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2/0.5, relativeDuration: 0.3/0.5, animations: {
                self.topView.transform = Position.reset.transform(view: self.topView)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2/0.5, relativeDuration: 0.3/0.5, animations: {
                self.dotButton.alpha = 0
                self.dotButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)

                self.crossButton.alpha = 1
                self.crossButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
            })
        }, completion: {_ in
            self.dotButton.isHidden = true
        })
    }

    func hideOptions() {
        self.dotButton.isHidden = false

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubic], animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3/0.5, animations: {
                self.topView.transform = Position.rightAligned.transform(view: self.topView)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.1/0.5, relativeDuration: 0.3/0.5, animations: {
                self.middleView.transform = Position.rightAligned.transform(view: self.middleView)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.2/0.5, relativeDuration: 0.3/0.5, animations: {
                self.bottomView.transform = Position.rightAligned.transform(view: self.bottomView)
            })

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3/0.5, animations: {
                self.dotButton.alpha = 1
                self.dotButton.transform = .identity

                self.crossButton.alpha = 0
                self.crossButton.transform = .identity
            })
        }, completion: {_ in
            self.crossButton.isHidden = true
        })
    }
}

enum Position {
    case reset
    case rightAligned

    func  transform(view: UIView) -> CGAffineTransform {
        switch self {
        case .reset:
            return .identity
        case .rightAligned:
            return CGAffineTransform(translationX: view.frame.maxX + 100, y: 0)
        }
    }
}
