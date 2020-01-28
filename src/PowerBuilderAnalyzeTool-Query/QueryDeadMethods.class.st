Class {
	#name : #QueryDeadMethods,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadMethods >> runOn: anObject [
	^ anObject methods asSet
		select: [ :method | 
			method outgoingInvocations isEmpty
				and: [ method incomingInvocations isEmpty ] ]
]
