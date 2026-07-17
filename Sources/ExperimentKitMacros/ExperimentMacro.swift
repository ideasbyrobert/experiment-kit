import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ExperimentMacro: ExpressionMacro
{
	public static func expansion(
		of node: some FreestandingMacroExpansionSyntax,
		in context: some MacroExpansionContext
	) -> ExprSyntax
	{
		guard let expression = node.arguments.first?.expression else
		{
			fatalError("The experiment macro requires an expression")
		}

		let source = expression.trimmedDescription

		return """
			{
				let value = \(expression)

				return ExperimentKit.Experiment(
					source: \(literal: source),
					result: String(describing: value),
					resultType: String(reflecting: Swift.type(of: value))
				)
			}()
			"""
	}
}
