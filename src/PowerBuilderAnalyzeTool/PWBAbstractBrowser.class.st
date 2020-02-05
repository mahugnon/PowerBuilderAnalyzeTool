Class {
	#name : #PWBAbstractBrowser,
	#superclass : #PWBPresenter,
	#instVars : [
		'model',
		'freeze'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #visiting }
PWBAbstractBrowser >> accept: anObject [
	^ self subclassResponsibility
]

{ #category : #accessing }
PWBAbstractBrowser >> freeze: aBoolean [
	freeze := aBoolean
]

{ #category : #enumerating }
PWBAbstractBrowser >> globallySelect: anEntity [
	self application globallySelect: anEntity
]

{ #category : #initialization }
PWBAbstractBrowser >> initialize [
	super initialize.
	freeze := false
]

{ #category : #initialization }
PWBAbstractBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 400
]

{ #category : #accessing }
PWBAbstractBrowser >> isFreeze [
	^ freeze
]

{ #category : #testing }
PWBAbstractBrowser >> isNotFreeze [
	^ self isFreeze not
]

{ #category : #testing }
PWBAbstractBrowser >> isPWBBrowser [
	^ true
]

{ #category : #accessing }
PWBAbstractBrowser >> model [
	^ model
]

{ #category : #accessing }
PWBAbstractBrowser >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
PWBAbstractBrowser >> needUpdate: anEntity [
	^ anEntity ~= model selected
]

{ #category : #accessing }
PWBAbstractBrowser >> selectEntity: anEntity [
	self subclassResponsibility
]
