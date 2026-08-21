# ExperimentKit

A freestanding Swift expression macro that captures an expression, its value,
and its static type in one term.

```swift
import ExperimentKit

let result = #experiment(two == four)

result.source      // "two == four"
result.result      // "false"
result.resultType  // "Swift.Bool"
```

The problem it solves is that a printed value loses the expression that produced
it. `print(two == four)` writes `false` and throws away the question. `#experiment`
keeps the question, the answer, and the type together, so a notebook, a teaching
transcript, or a test log can show what was asked rather than only what came
back.

## How it works

`#experiment` is declared as `@freestanding(expression)` and generic over the
expression type, and it forwards to `ExperimentMacro` in a separate
`.macro` target built on SwiftSyntax. The expansion takes the source text from
the syntax node itself, then binds the expression once to a local so that a
value with side effects is evaluated a single time:

```swift
{
    let value = two == four

    return ExperimentKit.Experiment(
        source: "two == four",
        result: String(describing: value),
        resultType: String(reflecting: Swift.type(of: value))
    )
}()
```

`String(describing:)` gives the readable value and `String(reflecting:)` gives
the fully qualified type. The generated call is spelled `ExperimentKit.Experiment`
rather than `Experiment`, so the macro cannot be captured by a type of the same
name at the call site.

## Building

Swift tools 5.9, macOS 12 or later, iOS 15 or later. One dependency,
[swift-syntax](https://github.com/swiftlang/swift-syntax) 602 or later.

```
swift test
```

The suite uses `SwiftSyntaxMacrosTestSupport` to assert the expansion text
exactly, and skips rather than passes when the macro plugin cannot be built for
the host.
