Class {
	#name : #QueryDeadVariables,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadVariables >> runOn: anObject [
	| variables |
	variables := anObject methods asSet flatCollectAsSet: #variables.
	variables addAll: anObject attributes.
	^ variables select: [ :each | each incomingAccesses isEmpty ]
]
