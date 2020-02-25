Class {
	#name : #ColorTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorTagedObject class >> accept: anEntity [
	^ (anEntity allTags & self futureActionTags) isNotEmpty
]

{ #category : #accessing }
ColorTagedObject >> color [
	^ (entity allTags & self class futureActionTags) anyOne color
]
