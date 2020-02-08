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
	^ RTMenuActivable new
		item: 'Mark as dead'
			action: [ :elt | 
			elt model tag: FamixPWBTag isCIMObsolette.
			elt color: (ColorObject colorFor: elt model) ];
		item: 'Mark as to refactor'
			action: [ :elt | 
			elt model tag: FamixPWBTag toRefactor.
			elt color: (ColorObject colorFor: elt model) ];
		item: 'Mark as not sure'
			action: [ :elt | 
			elt model tag: FamixPWBTag notSure.
			elt color: (ColorObject colorFor: elt model) ];
		item: 'Unmark'
			action: [ :elt | 
			elt model tag: nil.
			elt color: (ColorObject colorFor: elt model) ];
		item: 'add new Tags ...' action: [ :elt |  ]
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> drawOn1: aView [
  | userObjects userObjectElement userObjectElements shapeBuilder methods methodElements |
  aView @ RTDraggableView.
  shapeBuilder := RTShapeBuilder new.
  shapeBuilder rectangle size: [:m |  m numberOfLinesOfCode min: 60 max: 5 ].
  userObjectElements := RTGroup new.
  userObjects := self pwbMooseModel collect: #pwbMooseModel.
  userObjects do: [:userObject |  userObjectElement := (RTBox new color: (Color blue alpha: 0.4)) elementOn: userObject.
        userObjectElement @ RTPopup.
        aView add: userObjectElement.
        methods := userObject methods.
        methodElements := shapeBuilder elementsOn: methods.
        aView addAll: methodElements.
        RTEdgeBuilder new
           view: aView;
           objects: methods;
           connectFrom: #yourself toAll: [:m |  m outgoingInvocations flatCollectAsSet: #candidates ].
        RTTreeLayout on: methodElements.
        methodElements @ RTDraggable @ RTPopup.
        RTNest new on: userObjectElement nest: methodElements.
        userObjectElement @ RTDraggable.
        userObjectElements add: userObjectElement ].
  RTEdgeBuilder new
     view: aView;
     shape: (RTLine new attachPoint: RTVerticalAttachPoint instance);
     objects: userObjects;
     connectToAll: [:each |  each incomingReferences collect: #from ].
  RTTreeLayout on: userObjectElements.
  ^aView
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> drawOn: aView [
	| es eb |
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTEllipse new color: [ :elt | ColorObject colorFor: elt ])
		elementsOn: self pwbMooseModel.
	aView addAll: es.
	es @ RTDraggable.
	es
		@
			((RTLabeled new text: #name)
				fontSize: 5;
				top).
	eb := RTEdgeBuilder new.
	eb shape arrowedLine.
	eb
		view: aView;
		highlightable;
		elements: es;
		moveBehind;
		connectFromAll: [ :each | each incomingReferencesSenders ].
	RTMetricNormalizer new
		elements: es;
		normalizeSize: #numberOfMethods.
	RTHorizontalTreeLayout new
		on: aView elements;
		verticalGap: 50;
		horizontalGap: 50.
	es @ self contextMenu.
	es
		@
			(ElementClick new
				model: self guiModel;
				application: self application;
				yourself).
	self legend: aView.
	"	onDemand: 'Show legend';"
	^ aView build
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> legend: aView [
	RTLegendBuilder new
		textSize: 3;
		gapSize: 1;
		"	onDemand: 'Show legend';"
			view: aView;
		below;
		addText: 'Each circle is a Powerbuilder user object ';
		addText:
			'Each arrow is a refence from its source user objet to the target object';
		addColor: Color paleGreen text: 'Selected user object';
		addColor: Color red text: 'User object to remove';
		addColor: Color orange text: 'User object to remove refactor';
		addColor: Color yellow
			text: 'Not sure of action to perform about the user object';
		build
]
