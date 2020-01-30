Class {
	#name : #QueryDeadLocalVariables,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadLocalVariables >> runOn: aCollection [
	^ aCollection select: #isLocal
]
