'From Cuis 4.2 of 25 July 2013 [latest update: #2580] on 17 November 2015 at 6:12:31.151194 am'!
'Description Please enter a description for this package'!
!provides: 'Morphic-DWM' 1 1!
!classDefinition: #WindowStackMorph category: #'Morphic-DWM'!
LayoutMorph subclass: #WindowStackMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowStackMorph class' category: #'Morphic-DWM'!
WindowStackMorph class
	instanceVariableNames: ''!

!classDefinition: #WindowTilingMorph category: #'Morphic-DWM'!
LayoutMorph subclass: #WindowTilingMorph
	instanceVariableNames: 'mainWindow stack dirty'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowTilingMorph class' category: #'Morphic-DWM'!
WindowTilingMorph class
	instanceVariableNames: ''!

!classDefinition: #MinimalTheme category: #'Morphic-DWM'!
Theme subclass: #MinimalTheme
	instanceVariableNames: 'windowManager'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'MinimalTheme class' category: #'Morphic-DWM'!
MinimalTheme class
	instanceVariableNames: ''!

!classDefinition: #WindowManager category: #'Morphic-DWM'!
Object subclass: #WindowManager
	instanceVariableNames: 'pages currentPage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManager class' category: #'Morphic-DWM'!
WindowManager class
	instanceVariableNames: ''!

!classDefinition: #WindowManagerPage category: #'Morphic-DWM'!
Object subclass: #WindowManagerPage
	instanceVariableNames: 'tilingMorph windows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerPage class' category: #'Morphic-DWM'!
WindowManagerPage class
	instanceVariableNames: ''!


!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:58'!
addMorphBack: aMorph
	aMorph owner == self ifTrue: [^ self].
	^ super addMorphBack: aMorph! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 04:30'!
addMorphFront: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the current order) when clicking on them"
	^ super addMorphFront: aMorph! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:57'!
removedMorph: aMorph
	super removedMorph: aMorph.
"	owner notNil ifTrue: [owner stackChanged]."
	self layoutSubmorphs! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:58'!
addMorphBack: aMorph
	aMorph owner == self ifTrue: [^ self].
	^ super addMorphBack: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 04:31'!
addMorphFront: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super addMorphFront: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/16/2015 05:45'!
addWindow: aSystemWindow
	aSystemWindow layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	self addMorphBack: aSystemWindow.
	mainWindow notNil ifTrue: [self pushWindow].
	mainWindow _ aSystemWindow.! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/16/2015 13:45'!
popWindow
	"There's no main window, pop a window from the stack and set it as main window."
	stack isNil ifTrue: [^ self].
	mainWindow _ stack submorphs detect: [:one | one is: #SystemWindow] ifNone: [].
	mainWindow isNil ifTrue: [^ self removeStack].
	self addMorphBack: mainWindow.
	stack hasSubmorphs ifFalse: [self removeStack]! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/17/2015 03:35'!
pushWindow
	"Make room available for a new main window. Push the current main window to the stack."
	mainWindow isNil ifTrue: [^ self].
	stack isNil
		ifTrue:
			[stack _ direction == #vertical
				ifTrue: [WindowStackMorph newRow layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1); yourself]
				ifFalse: [WindowStackMorph newColumn layoutSpec: (LayoutSpec proportionalWidth: 0.8 proportionalHeight: 1); yourself].
			stack color: self color.
			self addMorphFront: stack].
	stack addMorphBack: mainWindow! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/17/2015 05:56'!
refresh
	mainWindow isNil ifTrue: [self popWindow].
	stack isNil ifFalse: [stack hasSubmorphs not ifTrue: [self removeStack]].
	stack isNil	ifFalse: [stack layoutSubmorphs].
	self layoutSubmorphs! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/16/2015 04:38'!
removeStack
	stack isNil ifTrue: [^ self].
	stack delete.
	stack _ nil! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:56'!
removedMorph: aMorph
	aMorph == mainWindow
		ifTrue: [mainWindow _ nil]
		ifFalse: [aMorph == stack ifTrue: [stack _ nil]]! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:23'!
background
	^ Color black! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 04:53'!
buttonColorFrom: paneColor
	^ paneColor! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:27'!
buttonLabel
	^ Color white! !

!MinimalTheme methodsFor: 'tool colors' stamp: 'len 11/17/2015 01:03'!
debugger
	^Color red! !

!MinimalTheme methodsFor: 'tool colors' stamp: 'len 11/16/2015 02:16'!
defaultWindowColor
	^ Color gray darker! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:23'!
embossedTitles
	^false! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 05:09'!
focusIndicator
	^ self textHighlight lighter! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/16/2015 01:23'!
fullScreenDeskMargin
	^ 0! !

!MinimalTheme methodsFor: 'initialization' stamp: 'len 11/16/2015 15:48'!
initialize
	super initialize.
	windowManager _ WindowManager new.
	Preferences setDefaultFonts: #(
		(setSystemFontTo: 'DejaVu Sans Mono' 10)
		(setListFontTo: 'DejaVu Sans Mono' 10)
		(setMenuFontTo: 'DejaVu Sans Mono' 9)
		(setWindowTitleFontTo: 'DejaVu Sans Mono' 10)
		(setCodeFontTo: 'DejaVu Sans Mono' 10)
		(setButtonFontTo: 'DejaVu Sans Mono' 9)).
	Preferences disable: #biggerCursors.
	StrikeFont useLeftArrow.

	Smalltalk garbageCollect.
	SystemWindow allSubInstances do: [:each|each isInWorld ifTrue: [windowManager windowOpen: each]]! !

!MinimalTheme methodsFor: 'keyboard shortcuts' stamp: 'len 11/16/2015 15:31'!
keyStroke: aKeyboardEvent morph: aMorph
		^windowManager keyStroke: aKeyboardEvent morph: aMorph! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/14/2015 03:38'!
layoutAdjusterThickness
	^ 1! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:55'!
listMultiHighlightFocused: aBoolean
	^ (self listHighlightFocused: aBoolean) 
		adjustSaturation: 0.0 brightness: 0.15! !

!MinimalTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menu
	^ Color darkGray darker darker! !

!MinimalTheme methodsFor: 'menus' stamp: 'len 11/16/2015 02:37'!
menuDecorations
	^ Dictionary new! !

!MinimalTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menuText
	^ Color white! !

!MinimalTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:59'!
menuTitleBar
	^ self menu darker! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:25'!
minimalWindows
	^true! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:25'!
paneBackgroundFrom: aColor
	^ Color black! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:15'!
roundButtons
	^ false! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:15'!
roundWindowCorners
	^ false! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:39'!
scrollbarButtonColor
	^Color black! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:36'!
scrollbarSliderShadowColor
	^Color black! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/14/2015 04:29'!
scrollbarThickness
	^ 6! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/16/2015 03:32'!
shout
	^ {
		#defaults 				-> #white.
		#undefined 				-> #(cyan lighter).
		#methodTags 			-> #(gray lighter).
		#pseudoVariables 		-> #(orange).
		#messages 				-> #(white).
		#arguments 				-> #(yellow).
		#instVar 					-> #(lightBlue).
		#incompleteMessages -> #(white darker).
		#blockLevelFour 		-> #(magenta).
		#blockLevelFive 		-> #(orange negated).
		#blockLevelSix 			-> #(green).
		#blockLevelSeven 		-> #blue.
		#tempBar 				-> #(gray veryMuchLighter lighter).
		#tempVars 				-> #(gray muchLighter).
	}! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:57'!
text
	^ Color white! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 04:44'!
textCursor
	^ self focusIndicator lighter! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 05:14'!
textHighlight
	^ Color r: 0.2 g: 0.35 b: 0.45! !

!MinimalTheme methodsFor: 'widget colors' stamp: 'len 11/13/2015 19:11'!
textPane
	^ Color black! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:34'!
unfocusedTextHighlightFrom: aColor
	^aColor adjustSaturation: 0.0 brightness: -0.15! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:10'!
useTaskbar
	^false! !

!MinimalTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:31'!
useUniformColors
	^true! !

!MinimalTheme methodsFor: 'window management' stamp: 'len 11/16/2015 15:31'!
windowClosed: aSystemWindow
	windowManager windowClosed: aSystemWindow! !

!MinimalTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:58'!
windowLabel
	^ Color white! !

!MinimalTheme methodsFor: 'window management' stamp: 'len 11/16/2015 15:31'!
windowOpen: aSystemWindow
	windowManager windowOpen: aSystemWindow! !

!WindowManager methodsFor: 'initialization' stamp: 'len 11/16/2015 15:03'!
initialize
	pages _ (1 to: 9) collect: [:each | WindowManagerPage new].
	currentPage _ pages first! !

!WindowManager methodsFor: 'events' stamp: 'len 11/17/2015 02:19'!
keyStroke: aKeyboardEvent morph: aMorph
	| i |
	aKeyboardEvent controlKeyPressed ifTrue: [^false].
	aKeyboardEvent commandAltKeyPressed ifFalse: [^false].

	aKeyboardEvent keyValue = $x asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | w delete. ^true ]].
	aKeyboardEvent keyValue = 27
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | w fullScreen. ^true ]].
	aKeyboardEvent keyValue = $t asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | currentPage windowToggleTiling: w. ^true ]].

	(aKeyboardEvent keyValue between: $1 asciiValue and: $9 asciiValue)
		ifTrue: [self switchToPage: aKeyboardEvent keyValue - $1 asciiValue + 1. ^true].
	(i _ #(33 64 35 36 37 94 38 42 40 41) indexOf: aKeyboardEvent keyValue) > 0
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | self moveWindow: w toPage: i. ^true ]].

	"open new windows"
	aKeyboardEvent keyValue = $B asciiValue
		ifTrue: [BrowserWindow openBrowser. ^true].
	aKeyboardEvent keyValue = $W asciiValue
		ifTrue: [Workspace new contents: ''; openLabel: 'Worksspace'. ^true].
	aKeyboardEvent keyValue = $T asciiValue
		ifTrue: [TranscriptWindow openTranscript. ^true].
	aKeyboardEvent keyValue = $P asciiValue
		ifTrue: [CodePackageListWindow openPackageList. ^true].
	aKeyboardEvent keyValue = $F asciiValue
		ifTrue: [FileListWindow openFileList. ^true].
	aKeyboardEvent keyValue = $C asciiValue
		ifTrue: [ChangeSorterWindow open: ChangeSorter new label: nil. ^true].

	^ false! !

!WindowManager methodsFor: 'actions' stamp: 'len 11/16/2015 16:23'!
moveWindow: aSystemWindow toPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	newPage == currentPage ifTrue: [^ self].
	(aSystemWindow hasProperty: #floatingBounds) ifTrue: [^ self].

	currentPage windowClosed: aSystemWindow.
	aSystemWindow visible: false.
	newPage windowOpen: aSystemWindow! !

!WindowManager methodsFor: 'printing' stamp: 'len 11/16/2015 15:40'!
printOn: aStream
	super printOn: aStream.
	(1 to: pages size) do: [:i | aStream print: i; nextPut: $:; print: (pages at: i)] separatedBy: [aStream space].
	aStream nextPutAll: ' current: '; print: (pages indexOf: currentPage)! !

!WindowManager methodsFor: 'actions' stamp: 'len 11/16/2015 15:42'!
switchToPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	currentPage == newPage ifTrue: [^ self].
	currentPage hide.
	currentPage _ newPage.
	currentPage show! !

!WindowManager methodsFor: 'events' stamp: 'len 11/16/2015 14:47'!
windowClosed: aSystemWindow
	currentPage windowClosed: aSystemWindow! !

!WindowManager methodsFor: 'events' stamp: 'len 11/16/2015 14:47'!
windowOpen: aSystemWindow
	currentPage windowOpen: aSystemWindow! !

!WindowManager class methodsFor: 'as yet unclassified' stamp: 'len 11/16/2015 15:01'!
new
	^ super new initialize! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/17/2015 02:48'!
hide
	tilingMorph notNil ifTrue: [tilingMorph visible: false].
	windows do: [:each | each isReallyVisible ifTrue: [each visible: false]]! !

!WindowManagerPage methodsFor: 'initialization' stamp: 'len 11/16/2015 15:00'!
initialize
	windows _ OrderedCollection new! !

!WindowManagerPage methodsFor: 'printing' stamp: 'len 11/16/2015 15:36'!
printOn: aStream
	aStream nextPut: $[.
	windows do: [:each | aStream print: each] separatedBy: [aStream nextPutAll: '; '].
	aStream nextPut: $]! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 11/17/2015 02:30'!
refresh
	tilingMorph isNil ifTrue: [^ self].
	tilingMorph refresh.
	tilingMorph hasSubmorphs ifFalse: [tilingMorph delete].
	tilingMorph isInWorld ifFalse: [tilingMorph _ nil]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/17/2015 02:50'!
show
	tilingMorph notNil ifTrue: [tilingMorph visible: true].
	windows do: [:each | each visible ifFalse: [each visible: true]]! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 02:28'!
windowClosed: aSystemWindow
	windows remove: aSystemWindow.
	self refresh! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 02:28'!
windowOpen: aSystemWindow
	windows add: aSystemWindow.
	self refresh! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/16/2015 16:19'!
windowToggleTiling: aSystemWindow
	| possibleBounds |
	aSystemWindow isInWorld ifFalse: [^ self].
	tilingMorph isNil
		ifTrue:
			[tilingMorph _ WindowTilingMorph newRow.
			aSystemWindow world addMorphBack: tilingMorph.
			tilingMorph morphPosition:	0 @ 0 extent: (RealEstateAgent maximumUsableAreaInWorld: aSystemWindow world) extent].
	aSystemWindow owner == aSystemWindow world
		ifTrue:
			[aSystemWindow setProperty: #floatingBounds toValue: aSystemWindow morphBoundsInWorld.
			tilingMorph addWindow: aSystemWindow]
		ifFalse:
			[aSystemWindow world addMorphFront: aSystemWindow.
			possibleBounds _ aSystemWindow valueOfProperty: #floatingBounds.
			aSystemWindow removeProperty: #floatingBounds.
			aSystemWindow morphPosition: possibleBounds topLeft extent: possibleBounds extent].
	tilingMorph refresh.
	tilingMorph hasSubmorphs ifFalse: [tilingMorph delete. tilingMorph _ nil]! !

!WindowManagerPage class methodsFor: 'as yet unclassified' stamp: 'len 11/16/2015 15:01'!
new
	^ super new initialize! !
