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
	aCanvas @ RSDraggableCanvas @ RSZoomToFitCanvas.
	self buildShapesOn: aCanvas.
	self buildEdgeOn: aCanvas.
	self buildLayoutOn: aCanvas.
	self contextMenuOn: aCanvas.
	self legend: aCanvas.
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
