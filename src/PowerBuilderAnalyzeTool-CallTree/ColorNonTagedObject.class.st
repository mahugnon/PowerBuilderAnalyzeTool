Class {
	#name : #ColorNonTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorNonTagedObject class >> accept: anEntity [
self halt.
	^ ((anEntity allTags collect: #name) & self futureActionTags) isEmpty
]

{ #category : #accessing }
ColorNonTagedObject >> color [
	^ Color gray
]
