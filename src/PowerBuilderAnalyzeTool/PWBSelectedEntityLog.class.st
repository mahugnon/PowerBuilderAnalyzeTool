Class {
	#name : #PWBSelectedEntityLog,
	#superclass : #PWBLog,
	#instVars : [
		'entity'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #accessing }
PWBSelectedEntityLog class >> entity: aSelectedEntity [
	^ self new entity: aSelectedEntity
]

{ #category : #activation }
PWBSelectedEntityLog >> activate [
	self application refreshBrowsersWith: self entity
]
