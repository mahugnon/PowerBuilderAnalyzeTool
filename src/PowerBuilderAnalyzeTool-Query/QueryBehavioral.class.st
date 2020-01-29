Class {
	#name : #QueryBehavioral,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryBehavioral >> runOn: aCollection [
	^ aCollection collectAsSet: [ :var | var behavioralForIfDead ]
]
