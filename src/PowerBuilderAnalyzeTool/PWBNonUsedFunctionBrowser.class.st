Class {
	#name : #PWBNonUsedFunctionBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'diagram',
		'view',
		'focusEntity',
		'pbModel'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBNonUsedFunctionBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		"position: 90 percent;"
		add: #diagram;
		yourself
]

{ #category : #'as yet unclassified' }
PWBNonUsedFunctionBrowser class >> lunchOn: anObject [
	^ self basicNew
		focusEntity: anObject;
		initialize;
		openWithSpec
]

{ #category : #visiting }
PWBNonUsedFunctionBrowser >> accept: anObject [
	^ anObject class = FamixPWBUserObject
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> diagram [
	^ diagram
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> diagram: anObject [
	diagram := anObject
]

{ #category : #drawing }
PWBNonUsedFunctionBrowser >> drawOn: aView [
	| es |
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTBox new
		size: 15;
		color: Color gray) elementsOn: self pbModel.
	aView addAll: es.
	es @ RTDraggable.
	es
		@
			(RTLabeled new
				fontSize: 5;
				top;
				text: [ :method | 
					(method parentType
						ifNotNil: [ method parentType name , '.' ]
						ifNil: [ '' ]) , method name ]).
	RTMetricNormalizer new
		elements: es;
		normalizeSize: #numberOfLinesOfCode.
	RTCircleLayout new on: aView elements.
	^ aView build
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> focusEntity [
	^ focusEntity
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> focusEntity: anObject [
	focusEntity := anObject.
	self refreshPbModel
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> initializeDiagram [
	diagram := self instantiate: RoassalModel.
	diagram
		script: [ :aView :canvas | 
			self drawOn: aView.
			view := aView.
			aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> initializeWidgets [
	self initializeDiagram
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 600
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> pbModel [
	^ pbModel
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> refreshPbModel [
	pbModel := QueryDeadMethods runOn: focusEntity
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> selectEntity: anEntity [
	self focusEntity: anEntity
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> title [
	^ 'Dead methods Browser'
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> view [
	^ view
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> view: anObject [
	view := anObject
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> zoomIn [
	RTZoomInMove on: view
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> zoomOut [
	RTZoomOutMove on: view
]
