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
				add: 'Mark as dead'
					target: element
					selector: #markAs:
					argument: #('Obsolette');
				add: 'Mark as to refactor'
					target: element
					selector: #markAs:
					argumentList: #('To be refactored');
				add: 'Mark as not sure'
					target: element
					selector: #markAs:
					argumentList: #('Not sure');
				add: 'Unmark'
					target: element
					selector: #unMark
					argument: #();
				add: 'add new Tags ...'
					target: element
					selector: #newTag:
					argument: #(element) ];
		yourself
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
CIMUserObjectReferencesPresenter >> drawOn: aCanvas [
	| es eb |
	aCanvas @ RSDraggableCanvas @ RSZoomToFitCanvas.
	es := RSEllipse new color: [ :elt | ColorObject colorFor: elt ].
	es := (self pwbMooseModel
		collect: [ :modelElement | 
			| elipse |
			elipse := RSEllipse new
				draggable;
				model: modelElement;
				color: (ColorObject colorFor: modelElement);
				yourself ]) as: RSGroup.
	es @ RSLabeled.
	aCanvas addAll: es.
	eb := RSEdgeBuilder arrowedLine
		canvas: aCanvas;
		shapes: es;
		moveBehind;
		connectFromAll: [ :each | each incomingReferencesSenders ].
	RSNormalizer size
		shapes: es;
		normalize: #numberOfMethods.
	RSHorizontalTreeLayout new
		horizontalGap: 250;
		on: aCanvas nodes;
		verticalGap: 20.
	es @ self contextMenu.
	es
		@
			(ElementClick new
				model: self guiModel;
				application: self application;
				yourself).
	self legend: aCanvas.
	"	onDemand: 'Show legend';"
	aCanvas @ RSCanvasController.
	^ aCanvas
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
