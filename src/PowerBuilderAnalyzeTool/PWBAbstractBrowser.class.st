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
	freeze whenActivatedDo: [ self frozen ].
	follow whenDeactivatedDo: [ self follow ].
	highlight whenChangedDo: [ self highlight ]
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
	highlight label: 'Highlight'
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
