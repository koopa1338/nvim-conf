;; inherits: rust

;; function keyword
((function_item "fn" @keyword) (#set! conceal "󰊕"))

;; unsafe keyword
((unsafe_block "unsafe" @keyword) (#set! conceal ""))
((function_modifiers "unsafe" @keyword) (#set! conceal ""))

;; delimiters
((function_item "->" @punctuation.delimiter) (#set! conceal ""))
((match_arm "=>" @punctuation.delimiter) (#set! conceal ""))

;; operators
((binary_expression operator: "!=" @operator) (#set! conceal "≠"))
((binary_expression operator: ">=" @operator) (#set! conceal "≥"))
((binary_expression operator: "<=" @operator) (#set! conceal "≤"))
((binary_expression operator: "==" @operator) (#set! conceal ""))
((binary_expression operator: "||" @operator) (#set! conceal "∨"))
((binary_expression operator: "&&" @operator) (#set! conceal "∧"))
