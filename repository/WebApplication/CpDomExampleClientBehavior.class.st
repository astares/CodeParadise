"
I am the client behavior for the DOM Example Server Application.
I only live in the ClientEnvironment.
"
Class {
	#name : #CpDomExampleClientBehavior,
	#superclass : #Object,
	#category : #'WebApplication-Examples'
}

{ #category : #accessing }
CpDomExampleClientBehavior class >> cpRequiredClasses [

	^ super cpRequiredClasses, { CpHtmlElement . CpSvgElement . CpMathElement . CpBrowserEventHandler }
]

{ #category : #examples }
CpDomExampleClientBehavior class >> someValue [

	^ 3 + 4
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleCreateRandomBlocks [

	<example: 'Create 1000 random blocks' order: 100>

	| outputElement |
	
	outputElement := self outputElement.

	1000 timesRepeat: [
		| block left top |
		block := CpDomElement newWithTag: #div.
		left := 100 atRandom.
		top := 100 atRandom.

		"Set individual style elements (see #exampleCreateRandomEllipses for alternative)."
		"The following is more readable then #exampleCreateRandomEllipses, but less performant."
		block
			styleAt: #position put: #absolute ;
			styleAt: #left put: left printString, '%' ;
			styleAt: #top put: top printString, '%' ;
			styleAt: #width put: (100 - left) atRandom printString, '%' ;
			styleAt: #height put: (100 - top) atRandom printString, '%' ;
			styleAt: #'background-color' put: 'rgb(', 255 atRandom printString, ',', 255 atRandom printString, ',', 255 atRandom printString, ')'.

		"Only append DOM element once it is fully constructed (to prevent redrawing)"
		outputElement appendChild: block ]
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleCreateRandomEllipses [

	<example: 'Create 1000 random ellipses' order: 100>

	| outputElement |
	
	outputElement := self outputElement.

	1000 timesRepeat: [
		| ellipse style left top width height |

		ellipse := CpDomElement newWithTag: #div.
		left := 100 atRandom.
		top := 100 atRandom.
		width := (100 - left) atRandom.
		height := (100 -top) atRandom.

		"Create single style value (see #exampleCreateRandomBlocks for alternative)."
		"The following is less readable then #exampleCreateRandomBlocks, but more performant."
		"On MacBook Pro (mid 2015) with i7 using Safari 1000 creates takes around 430ms vs 720ms."
		"It might also be more error-prone to construct the style, but YMMV."
		style := String streamContents: [ :stream |
			stream nextPutAll: 'position: absolute; border-radius: 50%; left: '.
			left printOn: stream.
			stream nextPutAll: '%; top: '.
			top printOn: stream.
			stream nextPutAll: '%; width: '.
			width printOn: stream.
			stream nextPutAll: '%; height: '.
			height printOn: stream.
			stream nextPutAll: '%; background-color: rgb('.
			255 atRandom printOn: stream.
			stream nextPut: $,.
			255 atRandom printOn: stream.
			stream nextPut: $,.
			255 atRandom printOn: stream.
			stream nextPutAll: ');' ].
		ellipse attributeAt: #style put: style.

		"Only append DOM element once it is fully constructed (to prevent redrawing)"
		outputElement appendChild: ellipse ]
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleHelloWorld [

	<example: 'Hello world' order: 10>

	| outputElement |

	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #h1)
		textContent: 'Hello world' ;
		yourself).
	outputElement appendChild: ((CpHtmlElement newWithTag: #section)
		markupContent: '<p>Change <code>', self class name, ' >> #someValue</code> in the ServerEnvironment, save it and then click again on my link in the menu on the left. Without needing to reload this page, the application has updated this ClientEnvironment.</p><p>Remember that all methods in this class are actually executed in the ClientEnvironment (here in the browser). This means there are many restrictions on what you can do. Trying to show an inspector will not work yet...</p><p>Please do try this out on other examples as well.</p><p>Since this code is still work in progress, some things might break. Please register any issues and/or consider contributing any fixes you find.</p>' ;
		yourself).
	outputElement appendChild: ((CpHtmlElement newWithTag: #p)
		styleAt: #'font-size' put: '4em' ;
		textContent: self class someValue printString ;
		yourself)
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleMathFormula [

	<example: 'MathML formula' order: 200>

	| outputElement mathElement |

	outputElement := self outputElement.

	"Content is created through markup instead of DOM manipulation."
	"Compare this with #exampleSVGSimple"
	outputElement markupContent: '<h1>MathML formula</h1>
	<p>The following formula might not be visible on all browsers</p>'.

	mathElement := outputElement appendChild: (CpMathElement newWithTag: #math).
	mathElement markupContent: '<mtable columnalign="left"><mtr><mtd><mrow><mrow><mrow><mrow> <mi>a</mi> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mi>x</mi> </mrow> <mo> + </mo> <mi>c</mi> </mrow> <mo>=</mo> <mn>0</mn> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mi>a</mi> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mi>b</mi> <mi>x</mi> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mrow> <mo>=</mo> <mo>-</mo><mi> c</mi><mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mi>x</mi> </mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>c</mi> </mrow> <mi>a</mi> </mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Divide out leading coefficient.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mi>x</mi> <mn>2</mn> </msup></mrow> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mi>a</mi> </mfrac> <mi>x</mi> <mo> + </mo> <msup> <mfenced> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow> </mfrac> </mfenced> <mn>2</mn> </msup> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi>c</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow> <mrow> <mi>a</mi> <mo>(</mo> <mn>4</mn> <mi>a</mi> <mo>)</mo> </mrow></mfrac> </mrow> <mo> + </mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Complete the square.</mtext> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">Discriminant revealed.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <msup> <mrow> <mo>(</mo> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>)</mo> </mrow> <mn>2</mn> </msup> <mo>=</mo> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> <mo> + </mo> <mfrac> <mrow> <mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mo>=</mo> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo><mi>b</mi> </mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <mfrac> <mrow> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </mrow> <mrow> <mn>4</mn> <msup> <mi>a</mi> <mn>2</mn> </msup> </mrow></mfrac> </msqrt> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace><mrow><mtext mathcolor="red" mathsize="10pt">There''s the vertex formula.</mtext> </mrow> </mrow> </mtd> </mtr> <mtr> <mtd> <mrow> <mrow> <mspace depth="1ex" height="0.5ex" width="2.5ex"></mspace> <mrow> <mi>x</mi> </mrow> <mo>=</mo> <mfrac> <mrow> <mo>-</mo> <mi> b</mi> <mo>±</mo><mrow><mo>{</mo><mi>C</mi><mo>}</mo></mrow> <msqrt> <msup> <mi>b</mi> <mn>2</mn> </msup> <mo> - </mo> <mn>4</mn> <mi>a</mi> <mi>c</mi> </msqrt></mrow> <mrow> <mn>2</mn> <mi>a</mi> </mrow></mfrac> </mrow> <mspace depth="1ex" height="0.5ex" width="2ex"></mspace> <mrow><mtext mathcolor="red" mathsize="10pt"></mtext> </mrow> </mrow> </mtd> </mtr> </mtable>'
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleSVGSimple [

	<example: 'Simple SVG' order: 200>

	| outputElement svgElement |
	
	outputElement := self outputElement.

	"Content is created through DOM manipulation instead of markup."
	"Compare this with #exampleMathFormula"
	svgElement := outputElement appendChild: ((CpSvgElement newWithTag: #svg)
		attributeAt: #viewBox put: '0 0 250 250' ;
		attributeAt: #width put: '250px' ;
		attributeAt: #height put: '250px' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #rect)
		attributeAt: #x put: '50' ;
		attributeAt: #y put: '50' ;
		attributeAt: #width put: '150' ;
		attributeAt: #height put: '150' ;
		attributeAt: #transform put: 'rotate(10 125 125)' ;
		attributeAt: #stroke put: 'green' ;
		attributeAt: #'stroke-width' put: '5' ;
		attributeAt: #fill put: 'grey' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #circle)
		attributeAt: #cx put: '200' ;
		attributeAt: #cy put: '200' ;
		attributeAt: #r put: '45' ;
		attributeAt: #stroke put: 'yellow' ;
		attributeAt: #'stroke-width' put: '3' ;
		attributeAt: #fill put: 'blue' ;
		yourself).
	svgElement appendChild: ((CpSvgElement newWithTag: #path)
		attributeAt: #d put: 'M 10,30 A 20,20 0,0,1 50,30 A 20,20 0,0,1 90,30 Q 90,60 50,90 Q 10,60 10,30 z' ;
		attributeAt: #fill put: 'red' ;
		yourself).
]

{ #category : #examples }
CpDomExampleClientBehavior >> exampleToDo [

	<example: 'ToDo List' order: 1000>

	| outputElement listElement |
	
	outputElement := self outputElement.

	outputElement appendChild: ((CpHtmlElement newWithTag: #h1)
		textContent: 'ToDo List' ;
		yourself).
	listElement := outputElement appendChild: (CpHtmlElement newWithTag: #ul).

	{
		'Add real debugging options to ClientEnvironment' .
		'Add better event handling to ClientEnvironment' .
		'Allow full keyboard input to ClientEnvironment' .
		'Add (full) set of WebComponents and Views' .
		'Add better session management to ServerEnvironment' .
		'Add Fraction and ScaledDecimal to ClientEnvironment' .
		'Add Date and Time classes to ClientEnvironment' .
		'Add animation capabilities to ClientEnvironment' .
		'Document' .
		'Test test test' .
		'Add more examples' .
		'And so much more...'
	} do: [ :each | listElement appendChild: ((CpHtmlElement newWithTag: #li)
		textContent: each ;
		yourself) ]
]

{ #category : #events }
CpDomExampleClientBehavior >> handleEvent: anEvent [

	| selector output |

	anEvent class = CpClickEvent
		ifFalse: [ ^ self ].

	"Find example selector"
	selector := anEvent target
		ifNotNil: [ :target | target id ]
		ifNil: [ ^ self ].

	"Wipe out existing output"
	output := self outputElement.
	output ifNil: [ ^ self ].
	output textContent: ''.

	"Create new output by performing selector"
	[ self perform: selector asSymbol ] on: Error do: [ :error | output textContent: 'Error: ', error description ]
]

{ #category : #initialization }
CpDomExampleClientBehavior >> initialize [

	super initialize.

	self
		installBrowserEventHandler ;
		showIndex
]

{ #category : #initialization }
CpDomExampleClientBehavior >> installBrowserEventHandler [

	"Install receiver as actual event handler"

	CpBrowserEventHandler current
		delegate: self
]

{ #category : #accessing }
CpDomExampleClientBehavior >> outputElement [

	^ CpHtmlElement documentBody firstDescendantMatching: '#output'
]

{ #category : #examples }
CpDomExampleClientBehavior >> showIndex [

	| body list items |

	CpHtmlElement documentHead appendChild: ((CpHtmlElement newWithTag: #style)
		textContent: '
			#menu {
				display: inline-block;
				width: 20em;
				height: calc(100vh - 6em);
				border-right: 1px solid #999;
			}
			#menu li { 
				cursor: pointer;
			}
			#result {
				position: absolute;
				display: inline-block;
				width: calc(100% - 24em);
				height: calc(100vh - 10em);
				padding: 2em;
			}
			#output {
				position: relative;
				width: 100%;
				height: 100%;
			}
		' ;
		yourself).
	body := CpHtmlElement documentBody.
	body markupContent: '<h1>DOM Examples</h1>
		<div style="width: 100%; margin: 0; padding: 0;">
			<div id="menu"><ul id="list"></ul></div><div id="result"><div id="output"></div></div>
		</div>
	'.

	list := body firstDescendantMatching: '#list'.

	"Collect items from example methods"

	items := 	OrderedCollection new.
	(self class selectors select: [ :each | each beginsWith: #example ]) do: [ :selector |
		(self class >> selector) properties ifNotNil: [ :properties |
			(properties at: #example:order:) ifNotNil: [ :pragma |
				items add: selector -> pragma arguments ] ] ].

	"Sort items (a and b are associations where the value contains the pragma arguments #title and #order)"
	items sort: [ :a :b |
		"Either the order of a is lower than order of b"
		(a value second < b value second) or: [
			"or the have the same order and a comes before b alphabetically" 
			(a value second = b value second) and: [ a value first < b value first ] ] ].

	"Render items onto DOM"
	items do: [ :item |
		| example |
				
		example := list appendChild: ((CpHtmlElement newWithTag: 'li')
			attributeAt: #id put: item key ;	"ie selector"
			textContent: item value first ;	"ie title"
			yourself).

		"Register interest in events on the list item"
		CpBrowserEventHandler current registerInterestIn: example ]
]
