Class {
	#name : #ColorToBlack,
	#superclass : #ColorFunction,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorToBlack class >> accept: aMooseAdapter [
  ^aMooseAdapter outgoingInvocationsCandidates isEmpty or: [ aMooseAdapter incomingInvocations isEmpty ]
]

{ #category : #accessing }
ColorToBlack >> color [
  ^Color black
]
