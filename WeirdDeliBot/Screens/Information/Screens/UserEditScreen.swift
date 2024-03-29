//
//  UserEditScreen.swift
//  WeirdDeliBot
//
//  Created by 정영준 on 2023/05/14.
//

import SwiftUI

struct UserEditScreen: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var selectedOption: DropdownMenuOption? = nil
    @State var phoneNumber: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(systemName: "person.fill")
                    .imageSize(135)
                    .foregroundColor(.myGray)
                    .background(Color.myGray.opacity(0.2))
                    .clipShape(Circle())
                
                Button(action: {()}) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .imageSize(45)
                            .foregroundColor(.basic)
                        Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                            .imageSize(28)
                            .foregroundStyle(Color.basic, Color.myWhite)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
            }
            .frame(width: 135, height: 135)
            .padding(.top, 45)
            .padding(.bottom, 32)
            
            Divider()
                .background(Color.basic)
                .padding(.horizontal, 24)
                .padding(.bottom, 26)
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(rootViewModel.user?.name ?? "")")
                        .padding(.bottom, 8)
                    Text("\(rootViewModel.user?.account ?? "")")
                        .padding(.bottom, 8)
                    Text("\(rootViewModel.user?.address ?? "")")
                }
                .size16Regular()
                .foregroundColor(.myBlack)
                
                Spacer()
            }
            .padding(.bottom, 22)
            .padding(.horizontal, 32)
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    PhoneNumberFormatter(placeholder: "\(rootViewModel.user?.phone ?? "")", text: $phoneNumber)
                        .placeholder(when: phoneNumber.isEmpty) {
                            Text("\(rootViewModel.user?.phone ?? "")")
                                .foregroundColor(.myBlack)
                        }
                        .frame(height: 63)
                        .size18Regular()
                        .padding(.leading, 23)
                        .background(Rectangle().fill(Color.myWhite).cornerRadius(10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.basic, lineWidth: 1)
                                
                        }
                        
                        .padding(.bottom, 16)
                        .padding(.horizontal, 28)
                    if selectedOption != nil || phoneNumber.regexMatches(phoneRegex) {
                        CustomButton(action: {
                            rootViewModel.updateUser(location: selectedOption, phone: phoneNumber)
                            presentation.wrappedValue.dismiss()
                        },
                                     text: "변경",
                                     textColor: .myWhite,
                                     height: 63,
                                     backgroundColor: .basic)
                    } else {
                        Text("변경")
                            .size18Regular()
                            .frame(maxWidth: .infinity, maxHeight: 63)
                            .foregroundColor(.myWhite)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.myGray.opacity(0.5)))
                            .padding(.horizontal, 28)
                    }
                    
                    Divider()
                        .background(Color.basic)
                        .padding(24)
                    
                    CustomButton(action: { rootViewModel.logOut() },
                                 text: "로그아웃",
                                 textColor: .myWhite,
                                 height: 63,
                                 backgroundColor: .myRed)
                }
                .padding(.top, 79)
                DropdownMenu(selectedOption: self.$selectedOption, placeholder: rootViewModel.user?.addressDesc ?? "", options: DropdownMenuOption.locations)
            }
            
            Spacer()
        }
        .customToolBar("Edit Info", showCartButton: false, showInfoButton: false)
    }
}

