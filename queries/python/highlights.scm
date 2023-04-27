;; inherits: python
((function_definition "def" @keyword) (#set! conceal ""))
((comparison_operator operators: "!=" @operator) (#set! conceal "≠"))
((comparison_operator operators: ">=" @operator) (#set! conceal "≥"))
((comparison_operator operators: "<=" @operator) (#set! conceal "≤"))
((comparison_operator operators: "==" @operator) (#set! conceal ""))
((boolean_operator operator: "or" @operator) (#set! conceal "∨"))
((boolean_operator operator: "and" @operator) (#set! conceal "∧"))
