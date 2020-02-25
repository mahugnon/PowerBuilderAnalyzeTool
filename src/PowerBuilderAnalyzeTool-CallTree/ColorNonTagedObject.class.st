Class {
	#name : #ColorNonTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorNonTagedObject class >> accept: anEntity [
	^ (anEntity allTags & self futureActionTags) isEmpty
]

{ #category : #accessing }
ColorNonTagedObject >> color [
	^ Color gray
]
