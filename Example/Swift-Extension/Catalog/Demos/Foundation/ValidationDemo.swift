//  ValidationDemo.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

import SwiftUI
import SwiftExtension

struct ValidationDemo: View {
    let play: Int
    @State private var email = ""
    @State private var mobile = ""

    static let info = ExampleInfo(
        category: .foundation,
        title: "Email & mobile validation",
        summary: "String.isEmail and isMobile use Swift Regex with whole-string matches.",
        code: #"""
        "john.doe@example.com".isEmail   // true
        "9876543210".isMobile            // true
        "0876543210".isMobile            // false
        """#
    )

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            Label(email.isEmail ? "Valid email" : "Invalid email",
                  systemImage: email.isEmail ? "checkmark.circle" : "xmark.circle")
                .font(.footnote)
                .foregroundStyle(.secondary)

            TextField("Mobile", text: $mobile)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            Label(mobile.isMobile ? "Valid mobile" : "Invalid mobile",
                  systemImage: mobile.isMobile ? "checkmark.circle" : "xmark.circle")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .onChange(of: play) { _, _ in
            withAnimation {
                email = "hi@swift.org"
                mobile = "9876543210"
            }
        }
    }
}
