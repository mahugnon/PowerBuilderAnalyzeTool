Class {
	#name : #ColorNonTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorNonTagedObject class >> accept: anEntity [
	^ anEntity tag isNil
]

{ #category : #accessing }
ColorNonTagedObject >> color [
	^ Color gray
]
