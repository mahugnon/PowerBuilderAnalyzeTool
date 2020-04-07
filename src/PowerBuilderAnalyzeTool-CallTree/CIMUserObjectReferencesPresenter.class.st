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
CIMUserObjectReferencesPresenter >> buildEdgeOn: aCanvas [
	| borderWhite arrows |
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	arrows := RSEdgeBuilder arrowedLine.
	arrows
		canvas: aCanvas;
		withBorderAttachPoint;
		objects: self pwbMooseModel;
		markerEnd:
			((RSShapeFactory triangle
				extent: 10 @ 15;
				color: Color red;
				border: borderWhite;
				yourself) asMarker
				offset: 25;
				yourself);
		moveBehind;
		width: 3;
		connectFromAll: [ :each | 
			each = self guiModel selected
				ifTrue: [ each incomingInvocationsSenders ]
				ifFalse: [ #() ] ]
			to: #yourself

	"self buildePopupOnEdges: arrows"
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> buildLayoutOn: aCanvas [
	layout := RSEquidistantCircleLayout new on: aCanvas nodes
]

{ #category : #'as yet unclassified' }
CIMUserObjectReferencesPresenter >> buildPopupOn: aCanvas [
	| names text |
	aCanvas edges
		do: [ :aRSEdge | 
			names := ((aRSEdge to model methods reject: #isNoisyMethod)
				flatCollectAsSet: [ :method | 
					method incomingInvocationsSenders
						select: [ :meth | meth parentType = aRSEdge from model ] ])
				collectAsSet: #name.
			text := Text new.
			text
				append:
					(Text
						string: 'Senders:'
						attributes:
							{(TextColor new color: Color blue).
							TextEmphasis bold}).
			text
				append:
					(String
						streamContents: [ :stream | 
							stream cr.
							names
								do: [ :name | 
									stream
										<< name;
										cr ] ]).
			aRSEdge @ (RSPopup text: text) ]
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> buildShapesOn: aCanvas [

	aCanvas
		addAll:
			((self pwbMooseModel
				collect: [ :modelElement | 
					| elipse lbl |
					lbl := RSLabel new
						text: modelElement name;
						yourself.
					elipse := RSEllipse new
						size: lbl extent;
						extent: lbl extent + 10;
						model: modelElement;
						color: (ColorObject colorFor: modelElement);
						yourself.
					elipse
						when: RSMouseClick
						do: [ :event | self processEntityClickEvent: event ].
					RSComposite new
						draggable;
						model: modelElement;
						shapes: (RSGroup with: elipse with: lbl);
						yourself ]) as: RSGroup)
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
CIMUserObjectReferencesPresenter >> contextMenuOn: aCanvas [
	aCanvas nodes
		@
			(RSMenuActivable new
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
				yourself)
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
	self buildPopupOn: aCanvas.
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
