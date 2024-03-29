//
//  RootViewModel.swift
//  WeirdDeliBot
//
//  Created by 정영준 on 2023/02/16.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class RootViewModel: ObservableObject {
    @Published var token: Token? = nil           // 토큰
    @Published var user: User?
    
    
    // 토큰 받아오기
    func setToken(token: Token) {
        self.token = token
        UserDefaults.standard.set(token.token, forKey: "token")
        loadUser()

    }
    
    // 토큰 불러오기
    func loadToken() {
        let token = UserDefaults.standard.string(forKey: "token")
        if(token != nil) {
            self.token = Token(token: token!)
        }
    }

    
    // 유저 정보 불러오기
    func loadUser() {
        UserRepository.getUserInfo() { result in
            switch(result) {
            case .success(let value):
                self.user = value.result
                //print(value)
                break
            case .failure(let error):
                print("loadUser: \(error)")
                break
            }
        }
    }
    
    func updateUser(location: DropdownMenuOption?, phone: String) {
        let addressDesc: String
        let latitude: String
        let longitude: String
        let newPhone: String
        
        if location == nil {
            addressDesc = user!.addressDesc
            latitude = user!.latitude
            longitude = user!.longitude
        } else {
            addressDesc = location!.option
            latitude = location!.latitude
            longitude = location!.longitude
        }
        if !phone.regexMatches(phoneRegex) {
            newPhone = user!.phone
        } else {
            newPhone = phone
        }
        
        UserRepository.updateUserInfo(addressDesc: addressDesc, latitude: latitude, longitude: longitude, phone: newPhone) { result in
            switch(result) {
            case .success(let value):
                self.user = value.result
                break
            case .failure(let error):
                print("updateUser: \(error)")
                break
            }
        }
    }
    
    func logOut() {
        self.token = nil
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
}

