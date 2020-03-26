Class {
	#name : #OptionParameters,
	#superclass : #Object,
	#instVars : [
		'action',
		'maxLevel',
		'selectedEntities'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
OptionParameters >> action: aString [
	action := aString
]

{ #category : #initialization }
OptionParameters >> initialize [
	selectedEntities := OrderedCollection new.
	maxLevel := 1
]

{ #category : #'accessing ' }
OptionParameters >> maxLevel: anInteger [
	maxLevel := anInteger
]

{ #category : #'add-remove' }
OptionParameters >> removeEntities: anObject [
	selectedEntities remove: anObject
]

{ #category : #accesing }
OptionParameters >> selectEntity: aFamixPWBUserObject [
	(selectedEntities includes: aFamixPWBUserObject)
		ifFalse: [ selectedEntities add: aFamixPWBUserObject ]
]

{ #category : #accessing }
OptionParameters >> selectedEntities [
	^ selectedEntities
]
