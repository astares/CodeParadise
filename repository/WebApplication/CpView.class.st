"
I am a View in a Model-View-Presenter pattern.
I only live in a ClientEnvironnent.
"
Class {
	#name : #CpView,
	#superclass : #CpTemplateComponent,
	#instVars : [
		'announcer'
	],
	#category : #'WebApplication-Core'
}

{ #category : #'web resources' }
CpView class >> template [

	<webResource: #html>

	^ '<div>&lt;empty&gt;</div>'
]

{ #category : #announcing }
CpView >> announce: anAnnouncement [

	self announcer announce: anAnnouncement
]

{ #category : #accessing }
CpView >> announcer [

	^ announcer
]

{ #category : #initialization }
CpView >> initialize [

	super initialize.

	announcer := Announcer new
]

{ #category : #dependencies }
CpView >> release [

	announcer ifNotNil: [
		announcer subscriptions reset.
		announcer := nil ].

	super release
]

{ #category : #announcing }
CpView >> when: anAnnouncementClass do: aBlock [

	self announcer when: anAnnouncementClass do: aBlock
]
