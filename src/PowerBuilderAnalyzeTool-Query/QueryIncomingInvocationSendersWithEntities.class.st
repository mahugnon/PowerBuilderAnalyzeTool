Class {
	#name : #QueryIncomingInvocationSendersWithEntities,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersWithEntities class >> accept: aString [
	^ aString = 'entity'
]

{ #category : #running }
QueryIncomingInvocationSendersWithEntities >> runOn: anEntity [
	^ anEntity incomingInvocationsSendersWith: options selectedEntities
]
