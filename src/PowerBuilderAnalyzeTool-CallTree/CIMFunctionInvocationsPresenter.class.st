Class {
	#name : #CIMFunctionInvocationsPresenter,
	#superclass : #CIMRoassalPresenter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #examples }
CIMFunctionInvocationsPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> drawOn1: aView [
	| es eb  |
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTEllipse new
		size: 15;
		color: Color blue) elementsOn: pbModel.
	aView addAll: es.
	eb := RTEdgeBuilder new.
	eb shape lineDualWidth
		color: Color blue trans;
		withShorterDistanceAttachPoint;
		widthFrom:
				[ :anEdge | (anEdge from pwbMooseModel numberOfInvocationToward: anEdge to pwbMooseModel) sqrt * 4 ];
		widthTo:
				[ :anEdge | (anEdge to pwbMooseModel numberOfInvocationToward: anEdge from pwbMooseModel) sqrt * 4 ].
	eb
		view: aView;
		noRepetition;
		noBidirectional;
		connectToAll: [ :each | self adapterFrom: each outgoingInvocationsCandidatesName asSet ].
	RTMetricNormalizer new
		elements: es;
		normalizeSize: [ :e | 
			e numberOfLinesOfCode < 0
				ifTrue: [ 1 ]
				ifFalse: [ e numberOfLinesOfCode ] ]
			using: #sqrt.
	RTCircleLayout new on: aView elements.
	^ aView
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> drawOn: aView [
	| es eb lb |
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTEllipse new
		size: 15;
		color: [ :elt | ColorFunction colorFor: elt ])
		elementsOn: self pwbMooseModel.
	aView addAll: es.
	es @ RTDraggable.
	es
		@
			(RTPopup
				text: [ :method | 
					(method parentType
						ifNotNil: [ method parentType name , '.' ]
						ifNil: [ '' ]) , method name ]).
	es
		@
			(ElementClick new
				model: self guiModel;
				application: self application;
				yourself).
	eb := RTEdgeBuilder new.
	eb shape arrowedLine.
	eb
		view: aView;
		highlightable;
		elements: es;
		moveBehind;
		connectToAll: [ :each | each outgoingInvocationsCandidates ].
	RTMetricNormalizer new
		elements: es;
		normalizeSize: #cyclomaticComplexity.
	RTTreeLayout new on: aView elements.

	"===============legend================="
	lb := RTLegendBuilder new.
	lb view: aView.
	lb right.
	lb
		nestDo: [ :n :e :g | 
			n padding: 10.
			n on: e nest: g.
			n resizeWithoutRecursion: e for: g ].
	lb backgroundShape
		box;
		borderColor: Color red;
		color: Color transparent;
		borderWidth: 2.
	lb backgroundShape shape borderStyle dash.
	lb addText: 'System call Tree'.
	lb addObject: FamixPWBFunction text: 'svbnm,j.mgdf'.
	lb
		addColorFadingFrom: Color black
		to: Color red
		text: 'number of lines of code'.
	lb build.
	^ aView build
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> initializeModel [
	pbModel := PWBCallTreeBrowserModel new
]
