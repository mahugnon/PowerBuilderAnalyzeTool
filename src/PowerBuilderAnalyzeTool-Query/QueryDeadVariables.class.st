Class {
	#name : #QueryDeadVariables,
	#superclass : #AbstractDuplicationQuery,
	#instVars : [
		'result'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #accessing }
QueryDeadVariables >> arguments [
	^ (result select: [ :each | each name matchesRegex: 'a.*' ]) asSet
]

{ #category : #accessing }
QueryDeadVariables >> instanceVariables [
	^ (result select: [ :each | each name matchesRegex: 'i.*' ]) asSet
]

{ #category : #accessing }
QueryDeadVariables >> localVariables [
	^ (result select: [ :each | each name matchesRegex: 'l.*' ]) asSet
]

{ #category : #running }
QueryDeadVariables >> runOn: anObject [
	| variables |
	variables := anObject content flatCollectAsSet: #variables.
	variables addAll: anObject attributes.
	result := variables select: [ :each | each incomingAccesses isEmpty ]
]
