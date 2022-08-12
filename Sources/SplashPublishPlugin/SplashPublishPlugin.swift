/**
*  Splash-plugin for Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Publish
import Splash
import Ink

public extension Plugin {
    /// - withClassPrefix: A string to be appended to each HTML tag's class attribute
    /// - withGrammars: A tuple containing the `Grammar` itself as well as the tag to look for inside of markdown. 
    static func splash(withClassPrefix classPrefix: String, withGrammars grammars: [(grammar: Grammar, name: String)] = [(SwiftGrammar(), "swift")]) -> Self {
        Plugin(name: "Splash") { context in
            context.markdownParser.addModifier(
                .splashCodeBlocks(withFormat: HTMLOutputFormat(
                    classPrefix: classPrefix
                ), withGrammars: grammars)
            )
        }
    }
}

public extension Modifier {
    static func splashCodeBlocks(withFormat format: HTMLOutputFormat = .init(), withGrammars grammars: [(grammar: Grammar, name: String)] = [(SwiftGrammar(), "swift")]) -> Self {
        var highlighter = SyntaxHighlighter(format: format)

        return Modifier(target: .codeBlocks) { html, markdown in
            var markdown = markdown.dropFirst("```".count)

            guard !markdown.hasPrefix("no-highlight") else {
                return html
            }
            
            grammars.forEach({ grammar, name in
                if markdown.hasPrefix(name) {
                    highlighter = SyntaxHighlighter(format: format, grammar: grammar)
                }
            })

            markdown = markdown
                .drop(while: { !$0.isNewline })
                .dropFirst()
                .dropLast("\n```".count)

            let highlighted = highlighter.highlight(String(markdown))
            return "<pre><code>" + highlighted + "\n</code></pre>"
        }
    }
}

