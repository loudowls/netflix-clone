//
//  OTPTypes.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 28/12/25.
//

import SwiftUI

enum CodeType: Int, CaseIterable {
    case four = 4
    case six = 6
    
    var stringValue: String {
        "\(rawValue) Digit"
    }
}

enum TypingState {
    case typing
    case valid
    case invalid
}

enum TextFieldStyle: String, CaseIterable {
    case rounderBorder = "Rounded Border"
    case underline = "Underline"
}

struct VerificationFieldConfiguration {
    struct ColorConfig {
        var typing: Color
        var active: Color
        var valid: Color
        var invalid: Color
        var text: Color
        var loadingText: Color
        
        init(
            typing: Color = .gray,
            active: Color = .primary,
            valid: Color = .green,
            invalid: Color = .red,
            text: Color = .primary,
            loadingText: Color = Color.gray.opacity(0.5)
        ) {
            self.typing = typing
            self.active = active
            self.valid = valid
            self.invalid = invalid
            self.text = text
            self.loadingText = loadingText
        }
        
        static let `default` = ColorConfig()
    }
    
    struct SizeConfig {
        var fieldWidth: CGFloat
        var fieldHeight: CGFloat
        var spacing: CGFloat
        var underlineSpacing: CGFloat
        
        init(
            fieldWidth: CGFloat = 50,
            fieldHeight: CGFloat = 55,
            spacing: CGFloat = 8,
            underlineSpacing: CGFloat = 12
        ) {
            self.fieldWidth = fieldWidth
            self.fieldHeight = fieldHeight
            self.spacing = spacing
            self.underlineSpacing = underlineSpacing
        }
        
        static let `default` = SizeConfig()
    }
    
    struct BorderConfig {
        var width: CGFloat
        var cornerRadius: CGFloat
        var underlineHeight: CGFloat
        
        init(
            width: CGFloat = 1,
            cornerRadius: CGFloat = 8,
            underlineHeight: CGFloat = 1
        ) {
            self.width = width
            self.cornerRadius = cornerRadius
            self.underlineHeight = underlineHeight
        }
        
        static let `default` = BorderConfig()
    }
    
    struct TypographyConfig {
        var font: Font
        var fontWeight: Font.Weight
        
        init(
            font: Font = .title2,
            fontWeight: Font.Weight = .semibold
        ) {
            self.font = font
            self.fontWeight = fontWeight
        }
        
        static let `default` = TypographyConfig()
    }
    
    var colors: ColorConfig
    var sizes: SizeConfig
    var borders: BorderConfig
    var typography: TypographyConfig
    
    init(
        colors: ColorConfig = .default,
        sizes: SizeConfig = .default,
        borders: BorderConfig = .default,
        typography: TypographyConfig = .default
    ) {
        self.colors = colors
        self.sizes = sizes
        self.borders = borders
        self.typography = typography
    }
    
    static let `default` = VerificationFieldConfiguration()
    
    // Builder methods remain the same
    func withColors(_ colors: ColorConfig) -> VerificationFieldConfiguration {
        var config = self
        config.colors = colors
        return config
    }
    
    func withSizes(_ sizes: SizeConfig) -> VerificationFieldConfiguration {
        var config = self
        config.sizes = sizes
        return config
    }
    
    func withBorders(_ borders: BorderConfig) -> VerificationFieldConfiguration {
        var config = self
        config.borders = borders
        return config
    }
    
    func withTypography(_ typography: TypographyConfig) -> VerificationFieldConfiguration {
        var config = self
        config.typography = typography
        return config
    }
}
