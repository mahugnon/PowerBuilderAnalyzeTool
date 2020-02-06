Class {
	#name : #PWBAbstractBrowser,
	#superclass : #PWBPresenter,
	#instVars : [
		'model',
		'freeze',
		'follow',
		'highlight',
		'currentState'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBAbstractBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #follow expand: false;
				add: #highlight expand: false;
				add: #freeze expand: false;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		yourself
]

{ #category : #visiting }
PWBAbstractBrowser >> accept: anObject [
	^ self subclassResponsibility
]

{ #category : #initialization }
PWBAbstractBrowser >> connectPresenters [
	freeze whenActivatedDo: [ self toFrozen ].
	follow whenDeactivatedDo: [ self toFollow ].
	highlight whenChangedDo: [ self toHighlight ]
]

{ #category : #enumerating }
PWBAbstractBrowser >> globallySelect: anEntity [
	self application globallySelect: anEntity
]

{ #category : #initialization }
PWBAbstractBrowser >> initializePresenters [
	freeze := self newRadioButton.
	follow := self newRadioButton.
	highlight := self newRadioButton.
	follow
		associatedRadioButtons:
			{freeze.
			highlight}.
	freeze label: 'Freeze'.
	follow label: 'Follow'.
	highlight label: 'Highlight'.
	follow state: true.
	self toFollow
]

{ #category : #initialization }
PWBAbstractBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 500
]

{ #category : #initialization }
PWBAbstractBrowser >> isFollow [
	^ currentState = 'Follow'
]

{ #category : #accessing }
PWBAbstractBrowser >> isFreeze [
	^ currentState = 'Freeze'
]

{ #category : #initialization }
PWBAbstractBrowser >> isHighlight [
	^ currentState = 'Highlight'
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

{ #category : #initialization }
PWBAbstractBrowser >> toFollow [
	currentState := 'Follow'
]

{ #category : #initialization }
PWBAbstractBrowser >> toFrozen [
	currentState := 'Freeze'
]

{ #category : #initialization }
PWBAbstractBrowser >> toHighlight [
	currentState := 'Highlight'
]
