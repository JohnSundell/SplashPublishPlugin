/**
*  Splash-plugin for Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import XCTest
import SplashPublishPlugin
import Ink
import Splash

final class SplashPublishPluginTests: XCTestCase {
    func testHighlightingMarkdown() {
        let parser = MarkdownParser(modifiers: [.splashCodeBlocks()])
        let html = parser.html(from: """
        Some text
        ```
        let int = 7
        ```
        More text
        ```no-highlight
        not.highlighted()
        ```
        """)

        XCTAssertEqual(html, """
        <p>Some text</p><pre><code><span class="keyword">let</span> int = <span class="number">7</span>
        </code></pre><p>More text</p><pre><code class="language-no-highlight">not.highlighted()
        </code></pre>
        """)
    }
    
    func testHighlightingMultipleGrammarsMarkdown() {
        let parser = MarkdownParser(modifiers: [.splashCodeBlocks(withGrammars: [(TestGrammar(), "test"), (SwiftGrammar(), "swift")])])
        let html = parser.html(from: """
        Some text
        ```test
        some should be a keyword
        ```
        here's some fake text
        ```swift
        let int = 7
        ```
        fake text
        ```no-highlight
        not.highlighted()
        ```
        """)
        XCTAssertEqual(html, """
        <p>Some text</p><pre><code><span class=\"keyword\">some</span> should be a keyword\n</code></pre><p>here\'s some fake text</p><pre><code><span class=\"keyword\">let</span> int = <span class=\"number\">7</span>\n</code></pre><p>fake text</p><pre><code class=\"language-no-highlight\">not.highlighted()\n</code></pre>
        """)
    }

    static var allTests = [
        ("testHighlightingMarkdown", testHighlightingMarkdown)
    ]
}

public struct TestGrammar: Grammar {
    public var delimiters: CharacterSet
    public var syntaxRules: [SyntaxRule]
    
    public init() {
        var delimiters = CharacterSet.alphanumerics.inverted
        delimiters.remove("_")
        delimiters.remove("-")
        delimiters.remove("\"")
        delimiters.remove("#")
        delimiters.remove("@")
        delimiters.remove("$")
        self.delimiters = delimiters
        
        syntaxRules = [
            KeywordRule(),
        ]
    }
    
    public func isDelimiter(_ delimiterA: Character, mergableWith delimiterB: Character) -> Bool {
        switch (delimiterA, delimiterB) {
        case (_, ":"):
            return false
        case (":", "/"):
            return true
        case (":", _):
            return false
        case ("-", _):
            return false
        case ("#", _):
            return false
        default:
            return true
        }
    }
    
    static let keywords = ([
        "some", "fake", "keywords"
    ] as Set<String>)
    
    struct KeywordRule: SyntaxRule {
        var tokenType: TokenType { return .keyword }
        
        func matches(_ segment: Segment) -> Bool {
            return keywords.contains(segment.tokens.current)
        }
    }
}
