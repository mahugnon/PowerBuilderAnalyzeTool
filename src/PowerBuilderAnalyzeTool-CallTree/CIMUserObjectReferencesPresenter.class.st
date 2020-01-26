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
CIMUserObjectReferencesPresenter >> drawOn1: aView [
  | userObjects userObjectElement userObjectElements shapeBuilder methods methodElements |
  aView @ RTDraggableView.
  shapeBuilder := RTShapeBuilder new.
  shapeBuilder rectangle size: [:m |  m numberOfLinesOfCode min: 60 max: 5 ].
  userObjectElements := RTGroup new.
  userObjects := self pbModel collect: #pbModel.
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
	es := (RTEllipse new color: Color blue) elementsOn: self pbModel.
	aView addAll: es.
	es @ RTDraggable.
	es
		@
			(ElementClick new
				model: self guiModel;
				yourself).
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
		horizontalGap: 20.0.
	es
		@
			((RTMenuActivable item: #globalSelect action: [ :elt |  ])
				item: #MarkAsObsolet
					action: [ :elt | elt model tag: FamixPWBTag isCIMObsolette ];
				item: #MarkAsToRefactor
					action: [ :elt | elt model tag: FamixPWBTag toRefactor ];
				item: #MarkAsNotSure
					action: [ :elt | elt model tag: FamixPWBTag notSure ];
				item: #RunDuplication action: [ :elt |  ]).
	^ aView build
]
