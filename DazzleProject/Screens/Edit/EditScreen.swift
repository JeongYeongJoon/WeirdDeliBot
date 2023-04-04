//
//  EditScreen.swift
//  DazzleProject
//
//  Created by 정영준 on 2023/03/27.
//

import SwiftUI

struct EditScreen: View {
    @StateObject var viewModel: EditViewModel = EditViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.presentationMode) var presentation
    var index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if(viewModel.menu == nil || viewModel.option == nil){
                if(viewModel.status == nil) {
                    ProgressView(label: {
                        VStack(spacing: 0) {
                            Text("로딩 중..")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    ).progressViewStyle(CircularProgressViewStyle())
                } else if viewModel.status == false { //로딩 실패 시 실패 메세지 출력.
                    Spacer()
                    Text("Loading Failed.")
                }
            } else {
                MenuDescRow(menu: viewModel.menu![0])
                    .padding()
                
                Text("Options")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 19))
                    .padding(.leading, 16)
                    .padding(.top, 0)
                
                ScrollView() {
                    ForEach(viewModel.option!){ option in
                        EditOptionRow(option: option)
                            .environmentObject(viewModel)
                    }
                }
            }
            
            Spacer()
            HStack(spacing: 0) {
                
                HStack(spacing: 0) {
                    if(viewModel.tempOrderItem?.amount ?? 100 >= 99) {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "plus.square")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .onTapGesture {
                                //viewModel.addItemAmount()
                            }
                    }
                }
                .frame(width: 20)
                .padding(.leading, 16)
                
                
                Text("\(viewModel.tempOrderItem?.amount ?? 0)잔")
                    .frame(width: 40)
                
                HStack(spacing: 0) {
                    if(viewModel.tempOrderItem?.amount ?? 0 == 0) {
                        Image(systemName: "minus.square")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "minus.square")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .onTapGesture {
                                //viewModel.subItemAmount()
                            }
                    }
                }
                .frame(width: 20)
                .padding(.trailing, 8)
                Text("Total : \(viewModel.totalPrice())₩")
                    .font(Font.system(size: 19, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 30)
                    .padding(.trailing, 16)
            }
            Button(action: {
                //viewModel.setUserOption()
                //cartViewModel.addOrderItem(item: viewModel.userMenu!, price: viewModel.totalPrice())
                self.presentation.wrappedValue.dismiss()    //option 모두 고른 menu를 cart에 넣고 직전 화면으로 돌아감.
            }) {
                Text("장바구니")
                    .frame(width: 227, height: 50)
                    .font(Font.system(size: 20))
                    .foregroundColor(Color.white)
                    .background(Capsule().fill(Color.black))
                    .padding(.bottom, 20)
            }
            
        }
        .onAppear() {
            viewModel.setOrderItem(orderItem: cartViewModel.userOrderList[index])
            viewModel.getItemInfo(token: rootViewModel.token?.token ?? "")
            viewModel.getOptionList(token: rootViewModel.token?.token ?? "")
        }
        .navigationBarTitle(Text("Edit"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar{ ToolBarBackButton(presentation: presentation) }
        
    }
}
