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
    
    lazy private var descriptionLabel = UILabel(font: .regular, text: "Select a language", fontSize: 15, textColor: .secondaryLabel, textAlignment: .left)
    
    private let textFieldHeight: CGFloat = 32
    
    lazy private var languageTextField: UITextField = {
        let textField = TextField()
        textField.placeholder = "Language"
        textField.autocorrectionType = .no
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = textFieldHeight / 2
        textField.inputView = languagePicker
        return textField
    }()
    
    private let languagePicker = UIPickerView()
    private let pickerDataSource = LanguagePickerDataSource()
    
    lazy private var enterButton = UIButton.colorButton(color: .systemOrange, height: 50, font: .bold, textColor: .white, localizableTitle: "enter", buttonType: .rounded, shadowType: .defaultShadow)
    
    var languageCode: String? {
        get {
            pickerDataSource.languageCode(forLanguage: languageTextField.text ?? "")
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .secondarySystemBackground
        float()
        layer.cornerRadius = 15
        
        pickerDataSource.delegate = self
        languageTextField.delegate = self
        
        languagePicker.dataSource = pickerDataSource
        languagePicker.delegate = pickerDataSource
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not supp")
    }
    
    func addEnterButtonTarget(target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        enterButton.addTarget(target, action: action, for: controlEvent)
    }
    
    private func addSubviews() {
        addSubview(descriptionLabel)
        addSubview(languageTextField)
        addSubview(enterButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        descriptionLabel.pin
            .horizontally(28)
            .top(30)
            .sizeToFit(.width)
        
        languageTextField.pin
            .horizontally(20)
            .below(of: descriptionLabel)
            .height(textFieldHeight)
            .marginTop(10)
        
        enterButton.pin
            .below(of: languageTextField)
            .hCenter()
            .size(.init(width: 140, height: 50))
            .marginTop(30)
        
        if languageTextField.text == "" {
            enterButton.disable()
        }
    }
}

extension LandingFormView: UIPickerListening {
    func pickerView(_ pickerView: UIPickerView, didSelectObject object: Any) {
        guard let name = object as? String else { return }
        languageTextField.text = name
    }
}

extension LandingFormView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            pickerDataSource.pickerView(languagePicker, didSelectRow: 0, inComponent: 0)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            enterButton.enable()
        }
    }
}

protocol UIPickerListening: class {
    func pickerView(_ pickerView: UIPickerView, didSelectObject object: Any)
}

class LanguagePickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let languages: [String: String] = ["English": "en", "Español": "es-419", "Deutsch": "de"]
    
    weak var delegate: UIPickerListening?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages.keys.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(pickerView, didSelectObject: languages.keys.sorted()[row])
    }
    
    func languageCode(forLanguage language: String) -> String? {
        languages[language]
    }
}



fileprivate class LandingFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = LandingFormView()
        view.addSubview(v)
        v.pin.vCenter()
            .horizontally(20)
            .height(200)
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
