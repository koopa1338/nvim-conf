;; inherits: rust
;; keywords
((function_item "fn" @keyword) (#set! conceal "󰊕"))
((function_signature_item "fn" @keyword) (#set! conceal "󰊕"))
(unsafe_block"unsafe" @keyword (#set! conceal ""))
(function_modifiers"unsafe" @keyword (#set! conceal ""))
;; delimiter
((function_item "->" @punctuation.delimiter) (#set! conceal ""))
((function_signature_item "->" @punctuation.delimiter) (#set! conceal ""))
((match_arm "=>" @punctuation.delimiter) (#set! conceal ""))
;; operator
((binary_expression operator: "!=" @operator) (#set! conceal "≠"))
((binary_expression operator: ">=" @operator) (#set! conceal "≥"))
((binary_expression operator: "<=" @operator) (#set! conceal "≤"))
((binary_expression operator: "==" @operator) (#set! conceal ""))
((binary_expression operator: "==" @operator) (#set! conceal ""))
((binary_expression operator: "||" @operator) (#set! conceal "∨"))
((binary_expression operator: "&&" @operator) (#set! conceal "∧"))

