//  ExView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

/// Small, composable `View` helpers. Each one is a single modifier you can copy on its own.
public extension View {

    /// Applies `transform` only when `condition` is `true`.
    ///
    /// ```swift
    /// Text("Pro")
    ///     .if(isHighlighted) { $0.foregroundStyle(.orange).bold() }
    /// ```
    /// - Note: Changing `condition` swaps the view type, so SwiftUI treats it as a new view and
    ///   resets its state. Prefer a ternary on a single modifier for values that change often.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Applies `transform` only when `value` is non-nil, passing the unwrapped value.
    ///
    /// ```swift
    /// Text("Profile")
    ///     .ifLet(user.nickname) { view, name in view.accessibilityLabel(name) }
    /// ```
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }

    /// Hides the view but keeps its layout space when `condition` is `true`.
    /// Hidden views are also removed from VoiceOver.
    ///
    /// ```swift
    /// Text("Invalid email").hidden(if: email.isEmpty)
    /// ```
    @ViewBuilder
    func hidden(if condition: Bool) -> some View {
        if condition {
            self.hidden()
        } else {
            self
        }
    }

    /// Runs `action` the first time the view appears and ignores later appearances.
    ///
    /// ```swift
    /// DashboardView()
    ///     .onFirstAppear { analytics.track(.dashboardOpened) }
    /// ```
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }

    /// Calls `action` with the rendered size of the view whenever it changes.
    ///
    /// ```swift
    /// @State private var size = CGSize.zero
    ///
    /// Text("Measure me")
    ///     .onSizeChange { size = $0 }
    /// ```
    func onSizeChange(perform action: @escaping (CGSize) -> Void) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }

    /// Dims the view, shows a spinner and blocks interaction while `isLoading` is `true`.
    ///
    /// ```swift
    /// Form { ... }
    ///     .loadingOverlay(viewModel.isSaving)
    /// ```
    func loadingOverlay(_ isLoading: Bool) -> some View {
        overlay {
            if isLoading {
                ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
            }
        }
        .disabled(isLoading)
    }

    /// Shows an OK alert whenever `message` becomes non-nil, then clears it.
    ///
    /// ```swift
    /// @State private var errorMessage: String?
    ///
    /// Button("Save") { errorMessage = "Could not reach the server." }
    ///     .errorAlert(message: $errorMessage)
    /// ```
    /// - Parameters:
    ///   - title: Alert title. Defaults to "Something went wrong".
    ///   - message: The text to show. Setting it to `nil` dismisses the alert.
    func errorAlert(_ title: String = "Something went wrong", message: Binding<String?>) -> some View {
        alert(
            title,
            isPresented: Binding(
                get: { message.wrappedValue != nil },
                set: { if !$0 { message.wrappedValue = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(message.wrappedValue ?? "")
        }
    }

    /// Dismisses the keyboard when the user taps an empty area of the view.
    ///
    /// ```swift
    /// VStack { TextField("Name", text: $name) }
    ///     .dismissKeyboardOnTap()
    /// ```
    /// - Important: Uses `UIApplication`, so it is unavailable in app extensions.
    @available(iOSApplicationExtension, unavailable, message: "UIApplication.shared is not available in app extensions.")
    func dismissKeyboardOnTap() -> some View {
        contentShape(Rectangle()).onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    /// A padded card with a rounded system background and a soft shadow.
    ///
    /// ```swift
    /// Text("Hello").cardStyle(cornerRadius: 16)
    /// ```
    func cardStyle(cornerRadius: CGFloat = 12) -> some View {
        padding()
            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.08), radius: 8, y: 4)
    }

    /// Strokes a rounded border around the view.
    ///
    /// ```swift
    /// Text("Selected").padding().roundedBorder(.indigo, width: 2)
    /// ```
    func roundedBorder(_ color: Color = .secondary, width: CGFloat = 1, cornerRadius: CGFloat = 12) -> some View {
        overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(color, lineWidth: width)
        }
    }
}
#endif
