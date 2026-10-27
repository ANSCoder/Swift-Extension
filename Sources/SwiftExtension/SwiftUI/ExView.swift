//  ExView.swift
//  Swift-Extension
//
//  MIT License, see LICENSE in the repository root.

#if canImport(UIKit)
import SwiftUI

/// Small, composable `View` helpers. Each one is a single modifier you can copy on its own.
public extension View {

    /// Applies a transform to the view when a condition is true.
    ///
    /// ```swift
    /// Text("Pro").if(isHighlighted) { $0.foregroundStyle(.orange) }
    /// ```
    ///
    /// Changing `condition` changes the view's type, so SwiftUI treats the result as a new view and resets its state. For values that change often, use a ternary on a single modifier instead.
    ///
    /// - Parameters:
    ///   - condition: Whether to apply the transform.
    ///   - transform: A closure that returns the modified view.
    /// - Returns: The transformed view, or the original view when `condition` is `false`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Applies a transform to the view when an optional value is present.
    ///
    /// ```swift
    /// Text("Profile").ifLet(user.nickname) { view, name in view.accessibilityLabel(name) }
    /// ```
    ///
    /// - Parameters:
    ///   - value: The optional value. The transform runs only when it isn't `nil`.
    ///   - transform: A closure that receives the view and the unwrapped value.
    /// - Returns: The transformed view, or the original view when `value` is `nil`.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }

    /// Hides the view while keeping its layout space, when a condition is true.
    ///
    /// Hidden views are also removed from the accessibility tree.
    ///
    /// - Parameter condition: Whether to hide the view.
    /// - Returns: The view, hidden when `condition` is `true`.
    @ViewBuilder
    func hidden(if condition: Bool) -> some View {
        if condition {
            self.hidden()
        } else {
            self
        }
    }

    /// Runs an action the first time the view appears, and ignores later appearances.
    ///
    /// ```swift
    /// DashboardView().onFirstAppear { analytics.track(.dashboardOpened) }
    /// ```
    ///
    /// - Parameter action: The closure to run once.
    /// - Returns: The view with the one-time action attached.
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(FirstAppearModifier(action: action))
    }

    /// Calls an action with the rendered size of the view whenever that size changes.
    ///
    /// ```swift
    /// @State private var size = CGSize.zero
    ///
    /// Text("Measure me").onSizeChange { size = $0 }
    /// ```
    ///
    /// - Parameter action: The closure to call with the new size.
    /// - Returns: The view with size reporting attached.
    func onSizeChange(perform action: @escaping (CGSize) -> Void) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }

    /// Dims the view, shows a spinner, and blocks interaction while loading.
    ///
    /// ```swift
    /// Form { ... }.loadingOverlay(viewModel.isSaving)
    /// ```
    ///
    /// - Parameter isLoading: Whether the loading overlay is visible.
    /// - Returns: The view with the overlay attached.
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

    /// Shows an OK alert whenever the message becomes non-`nil`, then clears the message.
    ///
    /// ```swift
    /// @State private var errorMessage: String?
    ///
    /// Button("Save") { errorMessage = "The server didn't respond." }
    ///     .errorAlert(message: $errorMessage)
    /// ```
    ///
    /// - Parameters:
    ///   - title: The alert title.
    ///   - message: The text to show. Dismissing the alert sets it to `nil`.
    /// - Returns: The view with the alert attached.
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
    /// VStack { TextField("Name", text: $name) }.dismissKeyboardOnTap()
    /// ```
    ///
    /// - Important: This uses `UIApplication`, so it isn't available in app extensions.
    /// - Returns: The view with the tap gesture attached.
    @available(iOSApplicationExtension, unavailable, message: "UIApplication.shared is not available in app extensions.")
    func dismissKeyboardOnTap() -> some View {
        contentShape(Rectangle()).onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    /// Adds a padded card with a rounded system background and a soft shadow.
    ///
    /// ```swift
    /// Text("Hello").cardStyle(cornerRadius: 16)
    /// ```
    ///
    /// - Parameter cornerRadius: The corner radius of the card background.
    /// - Returns: The view styled as a card.
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
    ///
    /// - Parameters:
    ///   - color: The color of the border.
    ///   - width: The line width of the border, in points.
    ///   - cornerRadius: The corner radius of the border.
    /// - Returns: The view with the border drawn over it.
    func roundedBorder(_ color: Color = .secondary, width: CGFloat = 1, cornerRadius: CGFloat = 12) -> some View {
        overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(color, lineWidth: width)
        }
    }
}
#endif
