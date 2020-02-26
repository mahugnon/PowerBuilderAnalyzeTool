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
	| locationClick |
	locationClick := InsideBoxClick new model: model.
	aCanvas @ RSDraggableCanvas.
	aCanvas @ RSZoomableCanvas.
	etitiesShapes := model duplicationEntities keys
		collect: [ :anEntity | 
			| composite border cloneBoxs |
			cloneBoxs := (model duplicationEntities at: anEntity)
				collect: [ :clone | 
					| box |
					box := RSBox new
						model: clone;
						color: (model colorFor: clone);
						size: 20;
						yourself.
					box
						when: RSMouseLeftClick
						do: [ :evt | self processCloneClickEvent: evt ] ]
				as: RSGroup.

			"cloneShapes
				@
					(RSPopup new
						text: [ :el | 
							'entité: ' , el entity name , String cr , 'Ligne debut: '
								, el startLine printString , String cr , '  Ligne fin: '
								, el endLine printString , String cr , 'Taux : '
								, (el endLine - el startLine + 1) asString , ' lignes sur:  '
								, el entitySourceCode lineCount asString ];
						yourself)."
			RSGridLayout on: cloneBoxs.
			border := RSBorder new
				color: Color black;
				width: 2.
			composite := RSComposite new.
		
			composite shapes: cloneBoxs.
			composite border: border.
			composite color: Color white.
			composite model: anEntity.
			composite @ RSAnimatedPopup @ RSDraggable.
			composite padding: 10.
			composite
				when: RSMouseClick
				do:
					[ :event | "composite@ (OutSideBoxClick new model: model)." self processEntityClickEvent: event ] ]
		as: RSGroup.
	RSGridLayout new
		on: etitiesShapes;
		gapSize: 20.
	"	es
		@
			(RSPopup new
				text: [ :entity | 
					'nom: ' , entity name , String cr , 'Loc: '
						, entity numberOfLinesOfCode asString , String cr
						, 'Nbr clone: ' , entity cloneLocations size asString ];
				yourself)."
	etitiesShapes @ (RSLabeled new text: [ :elt | elt mooseName ]).
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
