//
//  VerificationField.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 28/12/25.
//
import SwiftUI
import AVKit

struct VerificationField: View {
    var type: CodeType
    var style: TextFieldStyle = .rounderBorder
    @Binding var isInValid: Bool
    var isLoading: Bool = false
    var onChange: (_ value: String) -> Void
    var onComplete: (_ value: String) async -> Void
    var configuration: VerificationFieldConfiguration = .default
    
    @State private var value: String = ""
    @State private var state: TypingState = .typing
    @State private var invalidTrigger: Bool = false
    @FocusState private var isActive: Bool
    @State private var hasCompleted: Bool = false
    
    var body: some View {
        HStack(
            spacing: style == .rounderBorder ? configuration.sizes.spacing : configuration.sizes.underlineSpacing
        ) {
            ForEach(0..<type.rawValue, id: \.self) { i in
                CharacterView(i)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: value)
        .animation(.easeInOut(duration: 0.2), value: isActive)
        .compositingGroup()
        // Invalid Phase Animator
        .phaseAnimator([0, 10, -10, 10, -5, 5, 0], trigger: invalidTrigger, content: { content, offset in
            content.offset(x: offset)
        }, animation: { _ in
                .linear(duration: 0.06)
        })
        .background {
            TextField("", text: $value)
                .focused($isActive)
                .keyboardType(.numberPad)
                .foregroundStyle(isLoading ? .gray.opacity(0.5) : .black)
                .mask(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                }
                .allowsHitTesting(false)
                .disabled(isLoading)
        }
        .contentShape(.rect)
        .onTapGesture {
            isActive = true
        }
        .onChange(of: isInValid, { oldValue, newValue in
            if newValue {
                state = .invalid
                hasCompleted = false
                if state == .invalid {
                    invalidTrigger.toggle()
                }
            }
        })
        .onChange(of: value) { oldValue, newValue in
            let trimmedValue = String(newValue.prefix(type.rawValue))
            
            if value != trimmedValue {
                value = trimmedValue
            }
            
            Task { @MainActor in
                if trimmedValue.count < type.rawValue {
                    onChange(trimmedValue)
                    state = .typing
                    hasCompleted = false
                } else if value.count == type.rawValue {
                    if !hasCompleted {
                        hasCompleted = true
                        state = .valid
                        onChange(trimmedValue)
                        await onComplete(trimmedValue)
                    }
                } else {
                    state = .invalid
                }
            }
        }
        
    }
    
    // MARK: - Computed Properties
       private var spacing: CGFloat {
           style == .rounderBorder
               ? configuration.sizes.spacing
               : configuration.sizes.underlineSpacing
       }
       
       private var textColor: Color {
           isLoading
               ? configuration.colors.loadingText
               : configuration.colors.text
       }
       
       private var fieldWidth: CGFloat {
           style == .rounderBorder
               ? configuration.sizes.fieldWidth
               : configuration.sizes.fieldWidth - 10
       }
    
    @ViewBuilder
    func CharacterView(_ index: Int) -> some View {
        Group {
            if style == .rounderBorder {
                RoundedRectangle(cornerRadius: configuration.borders.cornerRadius)
                    .stroke(
                        borderColor(index),
                        lineWidth: configuration.borders.width
                    )
            } else {
                Rectangle()
                    .fill(borderColor(index))
                    .frame(height: configuration.borders.underlineHeight)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(width: fieldWidth, height: configuration.sizes.fieldHeight)
        .overlay {
            let stringValue = string(index)
            
            if stringValue != "" {
                Text(stringValue)
                    .font(configuration.typography.font)
                    .fontWeight(configuration.typography.fontWeight)
                    .transition(.blurReplace)
                    .foregroundStyle(textColor)
                    .transition(.blurReplace)
                    .disabled(isLoading)
            }
        }
    }
    
    func string(_ index: Int) -> String {
        if value.count > index {
            let startIndex = value.startIndex
            let stringIndex = value.index(startIndex, offsetBy: index)
            
            return String(value[stringIndex])
        }
        
        return ""
    }
    
    func borderColor(_ index: Int) -> Color {
        let loadingOpacity = isLoading ? 0.5 : 1.0
        switch state {
        case .typing:
            return value.count == index && isActive
            ? configuration.colors.active.opacity(loadingOpacity)
            : configuration.colors.typing.opacity(loadingOpacity)
        case .valid:
            return configuration.colors.valid.opacity(loadingOpacity)
        case .invalid:
            return configuration.colors.invalid
        }
    }
}

#Preview {
    ContentView()
}
