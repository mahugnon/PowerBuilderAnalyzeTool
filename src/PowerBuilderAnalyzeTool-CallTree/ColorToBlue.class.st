Class {
	#name : #ColorToBlue,
	#superclass : #ColorFunction,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorToBlue class >> accept: aMooseAdapter [
  ^aMooseAdapter outgoingInvocationsCandidates isNotEmpty and: [ aMooseAdapter incomingInvocations isNotEmpty ]
]

{ #category : #accessing }
ColorToBlue >> color [
  ^Color blue
]
