//
//  PhoneNumberViewController.swift
//  AuthenticateYourself
//
//  Created by Ahmed Sadiq on 17/03/2022.
//

import UIKit
import SKCountryPicker

class PhoneNumberViewController: UIViewController {
    
    // MARK: - Initializers -
    var countryCode: String = ""
    
    private var viewModel: PhoneNumberViewModel!
    
    // MARK: - Outlets -
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!{
        didSet {
            self.txtPhoneNumber.placeholderColor(.gray)
        }
    }
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var flagCountry: UIImageView!
    
    required convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = PhoneNumberViewModel()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = PhoneNumberViewModel()
        guard let country = CountryManager.shared.currentCountry else {
            self.lblCountryCode.text = ""
            self.flagCountry.image = nil
            return
        }
        self.countryCode = country.dialingCode ?? ""
        self.flagCountry.image = country.flag
        self.lblCountryCode.text = country.dialingCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bindViewModel(self.viewModel)
    }
    
    // MARK: - Methods -
    func bindViewModel(_ viewModel: PhoneNumberViewModel){
        viewModel.apiResponse = { result in
            let errNo = result["errNum"] as! String
            let message = result["message"] as! String
            if errNo == "0"{
                let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as!  OTPViewController
                otpVC.countryCode = self.countryCode
                otpVC.phoneNumber = self.txtPhoneNumber.text ?? ""
                otpVC.msisdn = "\(self.countryCode)\(self.txtPhoneNumber.text ?? "")"
                self.navigationController?.pushViewController(otpVC, animated: true)
            } else {
                self.view.makeToast(message)
            }
        }
      viewModel.didError = { error in
          self.view.makeToast(error.localizedDescription)
            self.view.endEditing(true)
        }
    }
    
    // MARK: - Actions -
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.viewModel.registerPhoneNo(countyCode: countryCode, txtPhoneNumber: self.txtPhoneNumber.text ?? "")
    }
    @IBAction func countryCodePressed(_ sender: Any) {
        CountryPickerWithSectionViewController.presentController(on: self, configuration: { controller in
                    controller.configuration.flagStyle = .corner
                    controller.configuration.detailColor = .lightGray
                }) { [weak self] (country: Country) in
                guard let self = self else { return }
                self.lblCountryCode.text = country.countryCode + " " + (country.dialingCode ?? "")
                self.countryCode = country.dialingCode ?? ""
                self.flagCountry.image = country.flag

                }

    }
}

