"
I am a simple WebApplication based on Model-View-Presenter pattern.
I only live in the ServerEnvironment.
"
Class {
	#name : #CpCounterWebApplication,
	#superclass : #CpWebApplication,
	#classVars : [
		'GlobalCounter'
	],
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpCounterWebApplication class >> app [

	^ #counter
]

{ #category : #accessing }
CpCounterWebApplication class >> clientBehaviorClass [

	^ CpCounterClientBehavior
]

{ #category : #accessing }
CpCounterWebApplication class >> globalCounter [

	^ GlobalCounter ifNil: [ GlobalCounter := CpCounterModel new ]
]

{ #category : #dependencies }
CpCounterWebApplication class >> release [

	GlobalCounter ifNotNil: [
		GlobalCounter release.
		GlobalCounter := nil ].

	super release
]

{ #category : #initialization }
CpCounterWebApplication >> setUp [

	"Set up the receiver with default Presenters"

	super setUp.

	"Create one global and one application specific counter.
	These presenters will be installed when #load or #reload is called on the receiver."
	self createPresenter: CpCounterPresenter forModel: (self addModel: self class globalCounter).
	self createPresenter: CpCounterPresenter forModel: (self addModel: CpCounterModel new)
]
