Class {
	#name : #PWBAbstractBrowser,
	#superclass : #PWBPresenter,
	#instVars : [
		'model'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #enumerating }
PWBAbstractBrowser >> globallySelect: anEntity [
	self application globallySelect: anEntity
]

{ #category : #testing }
PWBAbstractBrowser >> isPWBBrowser [
	^ true
]

{ #category : #accessing }
PWBAbstractBrowser >> selectEntity: anEntity [
	self subclassResponsibility
]
