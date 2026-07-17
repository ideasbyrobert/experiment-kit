public struct Experiment: Equatable, Sendable
{
	public let source: String
	public let result: String
	public let resultType: String

	public init(
		source: String,
		result: String,
		resultType: String
	)
	{
		self.source = source
		self.result = result
		self.resultType = resultType
	}
}
