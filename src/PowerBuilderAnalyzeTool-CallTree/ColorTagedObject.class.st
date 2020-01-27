Class {
	#name : #ColorTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorTagedObject class >> accept: anEntity [
	^ anEntity tag isNotNil
]

{ #category : #accessing }
ColorTagedObject >> color [
	^ entity tag color
]
