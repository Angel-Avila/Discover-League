//
//  LandingFormView.swift
//  Discover League
//
//  Created by Angel Avila on 16/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import SwiftUI
import PinLayout

class LandingFormView: UIView {
    
    lazy private var floatingContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.float()
        view.layer.cornerRadius = 15
        view.alpha = 0
        return view
    }()
    
    private let textFieldHeight: CGFloat = 32
    
    lazy private var usernameTextField: UITextField = {
        let textField = TextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "username".localize()
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = textFieldHeight / 2
        return textField
    }()
    
    lazy private var serverTextField: UITextField = {
        let textField = TextField()
        textField.placeholder = "server".localize()
        textField.autocorrectionType = .no
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = textFieldHeight / 2
        textField.inputView = serverPicker
        return textField
    }()
    
    private let serverPicker = UIPickerView()
    private let pickerDataSource = ServerPickerDataSource()
    
    lazy private var enterButton = UIButton.colorButton(color: .systemOrange, height: 50, font: .bold, textColor: .white, localizableTitle: "enter", buttonType: .rounded, shadowType: .defaultShadow)
    
    lazy private var skipButton = UIButton.colorButton(color: .clear, height: 20, font: .regular, textColor: .tertiaryLabel, localizableTitle: "skip", buttonType: .rectangular, shadowType: .none)
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        float()
        layer.cornerRadius = 15
        
        pickerDataSource.delegate = self
        serverTextField.delegate = self
        
        serverPicker.dataSource = pickerDataSource
        serverPicker.delegate = pickerDataSource
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not supp")
    }
    
    private func addSubviews() {
        addSubview(usernameTextField)
        addSubview(serverTextField)
        addSubview(enterButton)
        addSubview(skipButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let vMargin: CGFloat = 30
        
        usernameTextField.pin
            .horizontally(20)
            .top(40)
            .height(textFieldHeight)
        
        serverTextField.pin
            .horizontally(20)
            .below(of: usernameTextField)
            .marginTop(vMargin)
            .height(textFieldHeight)
        
        enterButton.pin
            .below(of: serverTextField)
            .hCenter()
            .size(.init(width: 140, height: 50))
            .marginTop(vMargin)
        
        skipButton.pin
            .below(of: enterButton)
            .hCenter()
            .size(.init(width: 40, height: 20))
            .marginTop(vMargin/2)
    }
}

extension LandingFormView: UIPickerListening {
    func pickerView(_ pickerView: UIPickerView, didSelectObject object: Any) {
        guard let name = object as? String else { return }
        serverTextField.text = name
    }
}

extension LandingFormView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === self.serverTextField && textField.text == "" {
            pickerDataSource.pickerView(serverPicker, didSelectRow: 0, inComponent: 0)
        }
    }
}

protocol UIPickerListening: class {
    func pickerView(_ pickerView: UIPickerView, didSelectObject object: Any)
}

class ServerPickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let servers = ["NA", "LAN", "EUNE", "EUW", "LAS", "JP", "KR", "OCE", "TR", "BR"]
    
    weak var delegate: UIPickerListening?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        servers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        servers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectObject: servers[row])
    }
}



fileprivate class LandingFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = LandingFormView()
        view.addSubview(v)
        v.pin.vCenter()
            .horizontally(20)
            .height(280)
        view.backgroundColor = .systemBackground
    }
}

struct LandingFormPreview: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.dark, ColorScheme.light], id: \.self) { scheme in
            PreviewView().edgesIgnoringSafeArea(.all)
                .environment(\.colorScheme, scheme)
        }
        
    }
    
    struct PreviewView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<LandingFormPreview.PreviewView>) -> UIViewController {
            return LandingFormViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LandingFormPreview.PreviewView>) {
        }
    }
}
