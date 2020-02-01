Class {
	#name : #PWBLogBrower,
	#superclass : #PWBPresenter,
	#instVars : [
		'logsPresenter'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #accessing }
PWBLogBrower >> logger [
	^ self application logger
]
