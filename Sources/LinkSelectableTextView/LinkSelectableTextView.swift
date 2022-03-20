//
//  LinkSelectableTextView.swift
//  LinkSelectableTextView
//
//  Created by treastrain on 2022/03/21.
//

import UIKit

/// A selectable (text link range only), scrollable, multiline text region.
open class LinkSelectableTextView: UITextView {
    /// For retrieving link attribute information.
    public enum AttributeRange {
        /// The range used as the argument to `attributedText.attribute(_:at:effectiveRange:)`.
        ///
        /// If you need the maximum range, use `longestEffective(range:limit:)`.
        case effective(range: NSRangePointer?)
        /// The range used for the arguments of attributedText.`attribute(_:at:longestEffectiveRange:in:)`.
        ///
        /// If you don’t need the longest effective range, it’s far more efficient to use the `effective(range:)` to retrieve the attribute value.
        case longestEffective(range: NSRangePointer?, limit: NSRange)
    }
    
    /// A constant that indicates a certain granularity of text unit.
    open var granularity: UITextGranularity = Default.granularity
    /// A constant that indicates a direction relative to position. The constant can be of type UITextStorageDirection or UITextLayoutDirection.
    open var direction: UITextDirection = Default.direction
    /// A constant that indicates the range of text link attributes.
    open var attributeRange: AttributeRange = Default.attributeRange
}

extension LinkSelectableTextView {
    public enum Default {
        public static let granularity: UITextGranularity = .character
        public static let direction: UITextDirection = .layout(.left)
        public static let attributeRange: AttributeRange = .effective(range: nil)
    }
}

extension LinkSelectableTextView {
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let position = closestPosition(to: point),
              let range = tokenizer.rangeEnclosingPosition(position, with: granularity, inDirection: direction) else {
            return false
        }
        let location = offset(from: beginningOfDocument, to: range.start)
        switch attributeRange {
        case let .effective(range: effectiveRange):
            return attributedText.attribute(.link, at: location, effectiveRange: effectiveRange) != nil
        case let .longestEffective(range: longestEffectiveRange, limit: rangeLimit):
            return attributedText.attribute(.link, at: location, longestEffectiveRange: longestEffectiveRange, in: rangeLimit) != nil
        }
    }
    
    open override func becomeFirstResponder() -> Bool {
        return false
    }
}
