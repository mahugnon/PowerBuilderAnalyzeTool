Class {
	#name : #QueryIncomingInvocationSendersWithEntities,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersWithEntities class >> accept: aString [
	^ aString = 'InvocationWithEntities'
]

{ #category : #running }
QueryIncomingInvocationSendersWithEntities >> runOn: anEntity [
	^ self
		clean: (anEntity incomingInvocationsSendersWith: options selectedEntities)
]
