Class {
	#name : #QueryIncomingInvocationSendersUpToLevel,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersUpToLevel class >> accept: aString [
	^ aString = 'InvocationAtLevel'
]

{ #category : #running }
QueryIncomingInvocationSendersUpToLevel >> runOn: anEntity [
	^ anEntity incomingInvocationsSenders: options maxLevel
]
