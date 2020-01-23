Class {
	#name : #ColorStrategy,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-CallTree-RoassalElementColorStrategy'
}

{ #category : #private }
ColorStrategy class >> accept: aMooseAdapter [
  ^self subclassResponsibility
]

{ #category : #private }
ColorStrategy class >> colorFor: aMooseAdapter [
  ^(self subclasses detect: [:class |  class accept: aMooseAdapter ]) new color
]

{ #category : #accessing }
ColorStrategy >> color [
  ^self subclassResponsibility
]
