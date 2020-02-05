Class {
	#name : #ColorToGray,
	#superclass : #ColorFunction,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorToGray class >> accept: aMooseAdapter [
  ^aMooseAdapter outgoingInvocationsCandidates isNotEmpty and: [ aMooseAdapter incomingInvocations isNotEmpty ]
]

{ #category : #accessing }
ColorToGray >> color [
  ^Color gray
]
