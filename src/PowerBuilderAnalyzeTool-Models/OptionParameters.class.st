Class {
	#name : #OptionParameters,
	#superclass : #Object,
	#instVars : [
		'action',
		'maxLevel',
		'selectedEntities',
		'typeToFilter'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
OptionParameters >> action [
	^ action
]

{ #category : #accessing }
OptionParameters >> action: aString [
	action := aString
]

{ #category : #accesing }
OptionParameters >> addEntity: aFamixPWBUserObject [
	(selectedEntities includes: aFamixPWBUserObject)
		ifFalse: [ selectedEntities add: aFamixPWBUserObject ]
]

{ #category : #api }
OptionParameters >> addTypeToFilter: aClass [
	typeToFilter add: aClass
]

{ #category : #initialization }
OptionParameters >> initialize [
	selectedEntities := OrderedCollection new.
	typeToFilter := OrderedCollection new.
	maxLevel := 1
]

{ #category : #accessing }
OptionParameters >> maxLevel [
	^ maxLevel
]

{ #category : #'accessing ' }
OptionParameters >> maxLevel: anInteger [
	maxLevel := anInteger
]

{ #category : #'add-remove' }
OptionParameters >> removeEntities: anObject [
	selectedEntities remove: anObject
]

{ #category : #api }
OptionParameters >> removeTypeToFilter: aClass [
	typeToFilter remove: aClass
]

{ #category : #accessing }
OptionParameters >> selectedEntities [
	^ selectedEntities
]

{ #category : #accessing }
OptionParameters >> typeTofilter [
	^ typeToFilter
]
