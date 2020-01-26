Class {
	#name : #DuplicationBrowserRoassalViewByEntity,
	#superclass : #DuplicationBrowserRoassalView,
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-roassal'
}

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalViewByEntity class >> viewName [
	^ 'View by cloned entities'
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> drawDuplicationDiagramOn: aView [
	| es locationClick |
	locationClick := InsideBoxClick new model: model.
	aView @ RTDraggableView.
	aView @ RTZoomableView.
	es := (RTBox new
		fillColor: Color white;
		borderColor: Color gray) elementsOn: model duplicationEntities keys.
	aView addAll: es.
	RTNest new
		for: es
		add: [ :group :each | 
			group
				addAll:
					(RTBox new
						fillColor: [ :elt | model colorFor: elt ];
						elementsOn: (model duplicationEntities at: each)).
			group @ locationClick.
			group
				@
					(RTPopup new
						text: [ :el | 
							'entité: ' , el entity name , String cr , 'Ligne debut: '
								, el startLine printString , String cr , '  Ligne fin: '
								, el endLine printString , String cr , 'Taux : '
								, (el endLine - el startLine + 1) asString , ' lignes sur:  '
								, el entitySourceCode lineCount asString ];
						yourself).
			RTGridLayout new
				gapSize: 5;
				applyOn: group ].
	RTGridLayout new
		gapSize: 60;
		applyOn: es.
	es @ RTDraggable.
	es
		@
			(RTPopup new
				text: [ :entity | 
					'nom: ' , entity name , String cr , 'Loc: '
						, entity numberOfLinesOfCode asString , String cr
						, 'Nbr clone: ' , entity cloneLocations size asString ];
				yourself).
	es
		@
			(RTLabeled new
				text: #name;
				fontSize: 5;
				top).
	es @ (OutSideBoxClick new model: model).
	locationClick view: aView.
	^ aView
]
