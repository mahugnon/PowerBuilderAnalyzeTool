Class {
	#name : #DuplicationBrowserRoassalViewByEntity,
	#superclass : #DuplicationBrowserRoassalView,
	#instVars : [
		'etitiesShapes',
		'cloneShapes'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-roassal'
}

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalViewByEntity class >> viewName [
	^ 'View by cloned entities'
]

{ #category : #accessing }
DuplicationBrowserRoassalViewByEntity >> cloneShapes [
	cloneShapes
		ifNil: [ cloneShapes := etitiesShapes flatCollect: #nodes ].
	^ cloneShapes
]

{ #category : #hooks }
DuplicationBrowserRoassalViewByEntity >> colorBoxsUsing: element [
	model updateFragmentColorFor: element model.
	PWBApplication current globallySelect: element model.
	model selected: element model.
	^ self cloneShapes
		do:
			[ :aCloneShape | aCloneShape color: (model colorFor: aCloneShape model) ]
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> drawOn: aCanvas [
	| labelIteraction |
	aCanvas @ RSDraggableCanvas.
	aCanvas @ RSZoomableCanvas.
	labelIteraction := RSLabeled new
		text: [ :elt | elt mooseName ];
		yourself.
	labelIteraction shapeBuilder labelShape fontSize: 5.
	self buildEntityShapes.
	RSGridLayout new
		gapSize: 100;
		on: etitiesShapes.
	etitiesShapes @ labelIteraction.
	aCanvas addAll: etitiesShapes.
	aCanvas @ RSCanvasController.
	canvas := aCanvas.
	^ aCanvas
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> processCloneClickEvent: evt [
	| shape |
	shape := evt shape.
	self cloneShapes
		do: [ :aCloneShape | 
			aCloneShape model clonedFragment = shape model clonedFragment
				ifTrue: [ aCloneShape color: Color lightGreen ]
				ifFalse: [ aCloneShape color: Color gray ] ].
	model selectedFragmentLocation: shape model.
	PWBApplication current globallySelect: shape model
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> processEntityClickEvent: evt [
	self colorBoxsUsing: evt shape
]
