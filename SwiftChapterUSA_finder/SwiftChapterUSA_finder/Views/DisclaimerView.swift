//
//  DisclaimerView.swift
//  SwiftChapterUSA Finder
//
//  Created on November 15, 2025.
//

import SwiftUI

struct DisclaimerView: View {
    @Binding var isPresented: Bool
    @State private var hasAgreed = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Icon
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.yellow)
                
                // Title
                Text("Important Disclaimer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Disclaimer Text
                VStack(alignment: .leading, spacing: 15) {
                    Text("This application is NOT the official Turning Point USA app.")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("This app is an independent tool created to help people find local Turning Point USA chapters and connect with other members.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("For the official Turning Point USA app and resources, please visit:")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Link(destination: URL(string: "https://www.tpusa.com")!) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                            Text("www.tpusa.com")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(15)
                
                // Agreement Toggle
                Toggle(isOn: $hasAgreed) {
                    Text("I understand and agree to continue")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                
                // Continue Button
                Button(action: {
                    if hasAgreed {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(hasAgreed ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(hasAgreed ? Color.green : Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                .disabled(!hasAgreed)
                
                Spacer()
            }
            .padding()
        }
    }
}
