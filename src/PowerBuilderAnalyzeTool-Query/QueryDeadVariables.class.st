Class {
	#name : #QueryDeadVariables,
	#superclass : #AbstractDuplicationQuery,
	#instVars : [
		'result'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #accessing }
QueryDeadVariables >> instanceVariables [
	self halt.
	^ (result select: [ :each | each name matchesRegex: 'i.*' ])
		asOrderedCollection
]

{ #category : #running }
QueryDeadVariables >> runOn: anObject [
	| variables |
	variables := anObject content flatCollectAsSet: #variables.
	variables addAll: anObject attributes.
	result := variables select: [ :each | each incomingAccesses isEmpty ]
]

{ #category : #accessing }
QueryDeadVariables >> variables [
	^ (result reject: [ :each | each name matchesRegex: 'i.*' ])
		asCollection
]
