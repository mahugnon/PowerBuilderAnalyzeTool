Class {
	#name : #PWBLog,
	#superclass : #Object,
	#instVars : [
		'logger'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #activation }
PWBLog >> activate [
	self subclassResponsibility
]

{ #category : #accessing }
PWBLog >> application [
	^ self logger application
]

{ #category : #accessing }
PWBLog >> logger [
	^ logger
]

{ #category : #accessing }
PWBLog >> logger: aPWBLogger [
	logger := aPWBLogger
]
