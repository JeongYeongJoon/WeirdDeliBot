//
//  EditViewModel.swift
//  WeirdDeliBot
//
//  Created by 정영준 on 2023/03/27.
//

import Foundation
import Alamofire

class EditViewModel: ObservableObject, OptionProtocol {
    @Published var tempOrderItem: OrderItem?
    @Published var menu: [Menu]? = nil
    @Published var option: [Option]? = nil
    @Published var status: Bool? = nil
    
    func setOrderItem(orderItem: OrderItem) {
        self.tempOrderItem = orderItem
    }
    
    func getItemInfo() {
        StoreRepository.getItemInfo(itemCode: self.tempOrderItem?.id ?? "") { response in
            switch(response) {
            case .success(let value):
                self.menu = value.result
                if(self.status != false) { self.status = true }
                break
            case .failure(let error) :
                print("getItemInfo: \(error)")
                self.status = false
                break
            }
        }
    }
    
    func getOptionList() {
        StoreRepository.getOptionList(itemCode: self.tempOrderItem?.id ?? "") { response in
            switch(response) {
            case .success(let value):
                self.option = value.result
                if(self.status != false) { self.status = true }
                break
            case .failure(let error) :
                print("getOptionList: \(error)")
                self.status = false
                break
            }
        }
    }
    
    func isOptionSelected(option: Option) -> Bool {
        let index = self.tempOrderItem?.options.firstIndex(where: { $0.id == option.id })
        return self.tempOrderItem?.options[index!].amount == 1
    }
    
    func getItemAmount() -> Int {
        return tempOrderItem?.amount ?? 0
    }
    func addItemAmount() {
        self.tempOrderItem?.amount += 1
    }
    
    func subItemAmount() {
        if(self.tempOrderItem?.amount ?? 0 > 1) {
            self.tempOrderItem?.amount -= 1
        }
    }
    
    func addOptionAmount(option: Option) {
        let index = self.tempOrderItem?.options.firstIndex(where: { $0.id == option.id })
        self.tempOrderItem?.options[index!].amount += 1
    }
    
    func subOptionAmount(option: Option) {
        let index = self.tempOrderItem?.options.firstIndex(where: { $0.id == option.id })
        self.tempOrderItem?.options[index!].amount -= 1
    }

    
    func totalPrice() -> Int {
        let itemPrice: Int = self.menu?[0].price ?? 0
        var optionPrice: Int = 0
        if(self.option != nil) {
            for option in self.option! {
                let price: Int = option.price * (self.tempOrderItem?.options[self.tempOrderItem?.options.firstIndex(where: { $0.id == option.id }) ?? 0].amount ?? 0)
                optionPrice += price
            }
        }
        return (itemPrice + optionPrice) * (tempOrderItem?.amount ?? 0)
    }

}
