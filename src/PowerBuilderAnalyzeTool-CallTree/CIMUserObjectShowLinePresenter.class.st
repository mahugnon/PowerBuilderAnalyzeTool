Class {
	#name : #CIMUserObjectShowLinePresenter,
	#superclass : #CIMRoassalPresenter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #initialization }
CIMUserObjectShowLinePresenter >> drawOn: v [
	| es model |
	model := MooseModel root first allWithType: FamixPWBUserObject.
	model := model reject: [ :each | each methods size = 0 ].
	v @ RTDraggableView @ RTZoomableView.
	es := (RTBox new
		fillColor: Color white;
		borderColor: Color gray) elementsOn: model.
	v addAll: es.
	RTNest new
		for: es
		add: [ :group :each | 
			group addAll: (RTBox new elementsOn: each methods).
			group
				@
					(RTShowEdge new
						connectToAll: [ :elt | (elt outgoingInvocations flatCollect: #candidates) asSet ];
						shape: (RTLine new color: Color green);
						yourself).
			group
				@
					(RTShowLabel new
						color: Color red;
						highlight: [ :elt | (elt outgoingInvocations flatCollect: #candidates) asSet ]).
			RTMetricNormalizer new
				elements: group;
				normalizeColor: #numberOfLinesOfCode.
			RTGridLayout on: group ].
	es
		@
			(RTShowEdge new
				connectToAll: [ :elt | elt outgoingReferencesTarget collectAsSet: #target ];
				shape: (RTLine new color: Color red);
				yourself).
	es
		@
			(RTShowLabel new
				color: Color red;
				highlight: [ :elt | elt outgoingReferencesTarget collectAsSet: #target ];
				top;
				yourself).
	RTMetricNormalizer new
		elements: es;
		normalizeColor: #cyclomaticComplexity.
	RTGridLayout on: es.
	^ v
]
