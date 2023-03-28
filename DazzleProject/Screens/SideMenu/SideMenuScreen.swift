//
//  SideMenuScreen.swift
//  DazzleProject
//
//  Created by 정영준 on 2022/10/12.
//

import SwiftUI

struct SideMenuScreen: View {
    @EnvironmentObject var viewModel: SideMenuViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.6
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(viewModel.isSideMenu ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: viewModel.isSideMenu)
            .onTapGesture {
                viewModel.toggleIsSideMenu()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                Color.white
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 60)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    Divider()
                    NavigationLink(destination: CartScreen()) {
                        HStack(spacing: 0) {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Cart")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)
                    }
                    Divider()
                    NavigationLink(destination: LocationScreen()) {
                        HStack(spacing: 0) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("Location")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)
                    }
                    Divider()
                    Spacer()
                    Divider()
                    Button(action: {rootViewModel.logOut()}) {
                        HStack(spacing: 0) {
                            Image(systemName: "door.left.hand.open")
                                .foregroundColor(.red)
                                .imageScale(.large)
                            Text("Log Out")
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)
                    }
                    .padding(.bottom, 30)
                }
            }
            .frame(width: sideBarWidth)
            .offset(x: viewModel.isSideMenu ? 0 : -sideBarWidth)
            .animation(.default, value: viewModel.isSideMenu)
            
            Spacer()
        }
    }
}


