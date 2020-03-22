Class {
	#name : #CIMUserObjectReferencesPresenter,
	#superclass : #CIMRoassalPresenter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #examples }
CIMUserObjectReferencesPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> contextMenu [
	^ RSMenuActivable new
		menuDo: [ :menu :element | 
			menu
				add: 'Tag element'
					target: element
					selector: #addTag
					argument: #();
				add: 'Remove tag'
					target: element
					selector: #unMark
					argument: #() ];
		yourself
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> drawOn: aCanvas [
	| es eb borderWhite |
	aCanvas @ RSDraggableCanvas @ RSZoomToFitCanvas.
	es := RSEllipse new color: [ :elt | ColorObject colorFor: elt ].
	es := (self pwbMooseModel
		collect: [ :modelElement | 
			| elipse |
			elipse := RSEllipse new
				draggable;
				size: 50;
				model: modelElement;
				color: (ColorObject colorFor: modelElement);
				yourself.
			elipse
				when: RSMouseClick
				do: [ :event | self processEntityClickEvent: event ] ])
		as: RSGroup.
	es @ RSLabeled.
	aCanvas addAll: es.
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	eb := RSEdgeBuilder arrowedLine
		canvas: aCanvas;
		shapes: es;
		markerEnd:
			((RSShapeFactory triangle
				extent: 10 @ 20;
				color: Color red;
				border: borderWhite;
				yourself) asMarker
				offset: 35;
				yourself);
		moveBehind;
		width: 2;
		connectFromAll: [ :each | each incomingReferencesSenders ].
	"RSNormalizer size
		shapes: es;
		normalize: #numberOfMethods."
	RSHorizontalTreeLayout new
		horizontalGap: 250;
		on: aCanvas nodes;
		verticalGap: 20.
	es @ self contextMenu.
	self legend: aCanvas.
	"	onDemand: 'Show legend';"
	aCanvas @ RSCanvasController.
	view := aCanvas.
	^ aCanvas
]

{ #category : #util }
CIMUserObjectReferencesPresenter >> highlight: anEntity [
	self
		colorSelectedElement: (view shapes detect: [ :el | el model = anEntity ])
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> legend: aCanvas [
	| legend |
	legend := RSLegend new.
	legend defaultLabel fontSize: 30.
	legend
		container: aCanvas;
		text: 'Each circle is a Powerbuilder user object ';
		text:
			'Each arrow is a refence from its source user objet to the target object';
		text: 'Selected user object' withCircleColor: Color paleGreen;
		text: 'User object to remove' withCircleColor: Color red;
		text: 'User object to remove refactor'
			withCircleColor: Color orange;
		text: 'Not sure of action to perform about the user object'
			withCircleColor: Color yellow;
		build
]
