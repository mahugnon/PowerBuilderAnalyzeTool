Class {
	#name : #CIMInterrestingEntityAnnoucement,
	#superclass : #Announcement,
	#instVars : [
		'interrestingEntity'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-Interaction'
}

{ #category : #accessing }
CIMInterrestingEntityAnnoucement >> interrestingEntity [
	^ interrestingEntity
]

{ #category : #accessing }
CIMInterrestingEntityAnnoucement >> interrestingEntity: anObject [
	interrestingEntity := anObject
]
