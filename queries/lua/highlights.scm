;; inherits: lua
((function_definition "function" @keyword) (#set! conceal ""))
((binary_expression "~=" @operator) (#set! conceal "≠"))
((binary_expression ">=" @operator) (#set! conceal "≥"))
((binary_expression "<=" @operator) (#set! conceal "≤"))
((binary_expression "==" @operator) (#set! conceal ""))
((binary_expression "or" @operator) (#set! conceal "∨"))
((binary_expression "and" @operator) (#set! conceal "∧"))
