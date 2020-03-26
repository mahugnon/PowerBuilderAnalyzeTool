Class {
	#name : #QueryIncomingInvocationSenders,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSenders class >> accept: aString [
	^ self subclassResponsibility
]
