Class {
	#name : #QueryDeadArguments,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadArguments >> runOn: aCollection [
	^ aCollection select: #isArgument
]
