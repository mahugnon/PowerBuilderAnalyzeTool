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
		objects: self pwbMooseModel;
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
		connectFromAll: [ :each | each incomingInvocationsSenders ]
			to: #yourself.
	"RSNormalizer size
		shapes: es;
		normalize: #numberOfMethods."
	layout := RSHorizontalTreeLayout new.
	layout
		horizontalGap: 250;
		verticalGap: 10;
		on: es.
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
		text: 'Each circle is a Powerbuilder class ';
		text:
			'Each arrow is a group of invocation from its source user class to the target class';
		text: 'Selected user class' withCircleColor: Color paleGreen;
		text: 'Deprecated class' withCircleColor: Color red;
		text: 'User object to refactor'
			withCircleColor: Color orange;
		text: 'Not sure of action to perform about the class'
			withCircleColor: Color yellow;
		build
]
