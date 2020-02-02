Class {
	#name : #PWBMooseModelBrowserModel,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'selected'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #initialization }
PWBMooseModelBrowserModel >> initialize [
	| liq_cal |
	super initialize.
	liq_cal := (MooseModel root first allWithType: FamixPWBUserObject)
		detect: [ :each | each name = 'uo_traitement_liq_cal' ].
	pbModel := liq_cal allReferences
]

{ #category : #accessing }
PWBMooseModelBrowserModel >> pbModel [
	^ pbModel
]

{ #category : #accessing }
PWBMooseModelBrowserModel >> selected: anEntity [
	selected := anEntity
]
