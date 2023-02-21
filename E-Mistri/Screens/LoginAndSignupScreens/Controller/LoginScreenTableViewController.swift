//
//  LoginScreenTableViewController.swift
//  E-Mistri
//
//  Created by gurzu on 04/01/2023.
//
import UIKit
import Alamofire
import KeychainSwift

class LoginScreenTableViewController: UITableViewController {

    static let identifier: String = "LoginScreenTableViewController"
    var userData: UserData = Storage.shared.load(key: Text.userKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tableView.register(
            UINib(
                nibName: HeaderTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: HeaderTableViewCell.identifier
        )
        tableView.register(
            UINib(
                nibName: LoginFormTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: LoginFormTableViewCell.identifier
        )
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource

extension LoginScreenTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            if let headerCell = tableView.dequeueReusableCell(
                withIdentifier: HeaderTableViewCell.identifier,
                for: indexPath
            ) as? HeaderTableViewCell {
                headerCell.primaryText?.text = Text.welcomeText
                headerCell.secondaryText?.text = Text.loginScreenSecondaryText
                headerCell.separatorInset = UIEdgeInsets.zero
                headerCell.layoutMargins = UIEdgeInsets.zero
                return headerCell
            }
        } else {
            if let bodyCell = tableView.dequeueReusableCell(
                withIdentifier: LoginFormTableViewCell.identifier
            ) as? LoginFormTableViewCell {
                bodyCell.delegate = self
                return bodyCell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - LoginFormTableViewCellDelegate

extension LoginScreenTableViewController: LoginFormTableViewCellDelegate {
    func tappedLoginButton(isOkay: Bool,
                           signupEmail: String,
                           signupPassword: String) {
        if isOkay {
            let getResponse = { postResponse in
                print("API response:::::::", postResponse)
            }
            createPost(completion: getResponse,
                       userEmail: signupEmail,
                       userPassword: signupPassword)
        } else {
            tableView.reloadData()
        }
    }
    
    func createPost(completion: @escaping (LoginAndSignUpResponse) -> Void,
                    userEmail: String,
                    userPassword: String) {
        let body = CustomerSignin(
            customer: LoginDetails(
                email: userEmail,
                password: userPassword
            )
        )
        AF.request(
            ApiURL.signInURL,
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default
        ).validate().responseDecodable(
            of: LoginAndSignUpResponse.self
        ) { response in
            switch response.result {
            case .success(let postResponse):
                debugPrint("Success::::::", postResponse)
                guard let userId = response.value?.status?.data?.id,
                      let fullName = response.value?.status?.data?.fullName,
                      let email = response.value?.status?.data?.email,
                      let phoneNumber = response.value?.status?.data?.phoneNumber,
                      let profilePicturePath = response.value?.status?.data?.displayPicturePath else {
                    print("Field empty")
                    return
                }
                self.userData.userId = userId
                self.userData.userName = fullName
                self.userData.userEmail = email
                self.userData.userPhoneNumber = phoneNumber
                self.userData.userAddress = response.value?.status?.data?.address
                self.userData.userIsActive = true
                self.userData.userProfilePicturePath = profilePicturePath
                Storage.shared.save(value: self.userData, key: Text.userKey)
                
                let dashboardScreenStoryboard = UIStoryboard(name: Storyboards.DashboardScreen, bundle: nil)
                guard let viewController = dashboardScreenStoryboard.instantiateViewController(
                    withIdentifier: TabBarController.identifier) as? TabBarController else {
                    return
                }
                self.navigationController?.pushViewController(viewController, animated: true)
                guard let token = response.response?.headers.value(for: Text.tokenHeader) else {
                    return
                }
                KeyChain.setKeyChain(userToken: token)
                completion(postResponse)
                
            case .failure(let error):
                let statusCode = response.error?.responseCode
                switch statusCode {
                case 401:
                    print("Invalid user name or password")
                    self.showErrorToast(message: "Invalid user name or password")
                default:
                    print("Connection lost with server")
                    self.showErrorToast(message: "Connection lost with server")
                }
                print("Error:::::::", error)
            }
        }
    }
    
    func tappedJoinUsButton() {
        if let toSignupScreen = storyboard?.instantiateViewController(
            withIdentifier: SignupScreenTableViewController.identifier
        ) as? SignupScreenTableViewController {
            navigationController?.pushViewController(toSignupScreen, animated: true)
        }
    }
}
