'From Cuis 5.0 of 7 November 2016 [latest update: #3741] on 12 May 2019 at 1:02:20 pm'!
'Description Please enter a description for this package'!
!provides: 'Morphic-DWM' 1 25!
SystemOrganization addCategory: #'Morphic-DWM'!


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
	instanceVariableNames: 'mainWindow stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowTilingMorph class' category: #'Morphic-DWM'!
WindowTilingMorph class
	instanceVariableNames: ''!

!classDefinition: #DWMTheme category: #'Morphic-DWM'!
Theme subclass: #DWMTheme
	instanceVariableNames: 'windowManager'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'DWMTheme class' category: #'Morphic-DWM'!
DWMTheme class
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


!WindowManager methodsFor: 'printing' stamp: 'len 11/16/2015 15:40'!
printOn: aStream
	super printOn: aStream.
	(1 to: pages size) do: [:i | aStream print: i; nextPut: $:; print: (pages at: i)] separatedBy: [aStream space].
	aStream nextPutAll: ' current: '; print: (pages indexOf: currentPage)! !

!WindowManagerPage methodsFor: 'printing' stamp: 'len 11/16/2015 15:36'!
printOn: aStream
	aStream nextPut: $[.
	windows do: [:each | aStream print: each] separatedBy: [aStream nextPutAll: '; '].
	aStream nextPut: $]! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/18/2015 03:14'!
privateAddMorph: aMorph atIndex: anInteger
	aMorph owner == self ifTrue: [^ self].
	super privateAddMorph: aMorph atIndex: anInteger! !

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

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/18/2015 03:15'!
privateAddMorph: aMorph atIndex: anInteger
	aMorph owner == self ifTrue: [^ self].
	super privateAddMorph: aMorph atIndex: anInteger! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:56'!
removedMorph: aMorph
	aMorph == mainWindow
		ifTrue: [mainWindow _ nil]
		ifFalse: [aMorph == stack ifTrue: [stack _ nil]]! !

!WindowTilingMorph methodsFor: 'initialization' stamp: 'len 11/19/2015 07:24'!
initialize
	super initialize.
	self sticky: true! !

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

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:58'!
acceptButton
	^ self successColor! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:23'!
background
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 04:53'!
buttonColorFrom: paneColor
	^ paneColor! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:45'!
buttonLabel
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:58'!
cancelButton
	^ self errorColor! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:51'!
errorColor
	^ Color lightRed! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 18:01'!
failureColor
	^ Color yellow duller! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:11'!
focusIndicator
	^ self textHighlight lighter! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:55'!
listMultiHighlightFocused: aBoolean
	^ (self listHighlightFocused: aBoolean) 
		adjustSaturation: 0.0 brightness: 0.15! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:25'!
paneBackgroundFrom: aColor
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:39'!
scrollbarButtonColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:58'!
scrollbarColor
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:36'!
scrollbarSliderShadowColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 5/12/2019 12:43:16'!
shout
	^ {
		#selector  				-> nil.
		#defaults 				-> #white.
		#undefined 				-> #(lightRed lighter lighter lighter lighter).
		#comment 				-> #(lightGray lighter).
		#literals 				-> #(lightBlue lighter lighter).
		#pseudoVariables 		-> '#FF709C'. "and bold"
		#messages 				-> #(white).
		#incompleteMessages	-> #(white).
		#arguments 				-> #(lightYellow lighter).
		#instVar 				-> '#95CBFF'.
		#classVar 				-> '#95CBFF'. "but bold"
		#tempBar 				-> #(white darker).
		#tempVars 				-> '#E6DAA6'.
		#blockTemps				-> '#5CFFA7'.
"		#block 					-> #(white)."
		#blockLevelZero		-> #(white).
		#blockLevelOne 		-> #(red muchLighter).
		#blockLevelTwo 		-> #(yellow muchLighter).
		#blockLevelThree 		-> #(green muchLighter).
		#blockLevelFour 		-> #(blue muchLighter).
		#blockLevelFive 		-> #(white darker).
		#blockLevelSix 		-> #(white darker).
		#blockLevelSeven 		-> #(white darker).
		#methodTags 			-> #(lightGray lighter). "#(hotPink)"
	}
	
"
		SHTextStylerST80 initialize
" 
! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:57'!
successColor
	^ Color lightGreen duller! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:57'!
text
	^ Color white! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:10'!
textCursor
	^ Color white! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 22:41'!
textHighlight
	^ Color darkGray "Color r: 0.2 g: 0.35 b: 0.45"! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:34'!
unfocusedTextHighlightFrom: aColor
	^aColor adjustSaturation: 0.0 brightness: -0.15! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:58'!
windowLabel
	^ Color white! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/18/2015 06:39'!
changeSorter
	^ Color lightBlue lighter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/9/2016 00:06'!
debugger
	^ Color lightRed! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/16/2015 02:16'!
defaultWindowColor
	^ Color gray darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/18/2015 06:38'!
packageList
	^ Color lightOrange lighter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/25/2016 20:25'!
transcript
	^ Color lightOrange! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:23'!
embossedTitles
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 01:23'!
fullScreenDeskMargin
	^ 0! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/14/2015 03:38'!
layoutAdjusterThickness
	^ 1! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:25'!
minimalWindows
	^true! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:15'!
roundButtons
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:15'!
roundWindowCorners
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/14/2015 04:29'!
scrollbarThickness
	^ 6! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:10'!
useTaskbar
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/17/2015 22:36'!
useUniformColors
	^false! !

!DWMTheme methodsFor: 'initialization' stamp: 'len 11/17/2015 22:57'!
iconicHaloSpecifications

^ #(
	"selector						horiz				vert					color info						icon key 						balloon help
	 ---------						------				-----------			-------------------------------		---------------"
	(addDebugHandle:			right				topCenter		(orange)						haloDebugIcon 				'Debug')
	(addDismissHandle:			left				top				(red)							haloDismissIcon 				'Remove')
"	(addRotateHandle:			left				bottom			(blue)							haloRotateIcon 				'Rotate')"
	(addMenuHandle:			leftCenter		top				(blue lighter)					haloMenuIcon 				'Menu')
	(addGrabHandle:				center			top				(black)							haloGrabIcon 				'Pick up')
	(addDragHandle:				rightCenter		top				(brown)						haloDragIcon 				'Move')
"	(addDupHandle:				right				top				(green)						haloDuplicateIcon 			'Duplicate')	"
"	(addHelpHandle:				center			bottom			(lightBlue)					haloHelpIcon 				'Help')"
	(addGrowHandle:			right				bottom			(yellow)						haloScaleIcon 				'Change size')
	(addFontSizeHandle:		leftCenter		bottom			(lightGreen)					haloFontSizeIcon 			'Change font')
	(addFontEmphHandle:		rightCenter		bottom			(lightBrown darker)			haloFontEmphasisIcon 		'Emphasis & alignment')
"	(addRecolorHandle:			right				bottomCenter	(magenta darker)			haloColorIcon 				'Change color')"
)! !

!DWMTheme methodsFor: 'initialization' stamp: 'len 12/11/2016 13:48:12'!
initialize
	| family codeFamily |
	super initialize.
	windowManager _ WindowManager new.
" install fonts, manually remove 'DejaVu' and make a new 'DejaVu' that points to 'DejaVu Sans'
StrikeFont install: 'DejaVu Sans Mono'.
StrikeFont install: 'DejaVu'.
StrikeFont buildMathFont
"
	family _ 'DejaVu Sans Mono'.
	codeFamily _ 'DejaVu Sans Mono'.
	Preferences setDefaultFonts: {
		{#setSystemFontTo:. family. 10}.
		{#setListFontTo:. family. 10}.
		{#setMenuFontTo:. family. 9}.
		{#setWindowTitleFontTo:. family. 10}.
		{#setCodeFontTo:. codeFamily. 10}.
		{#setButtonFontTo:. family. 9}}.
	DisplayScreen runningWorld ifNotNil: [ :world | world fontPreferenceChanged ].

	Preferences disable: #biggerCursors.
	Preferences enable: #dismissAllOnOptionClose.
	Preferences enable: #subPixelRenderColorFonts.
	Preferences disable: #italicsInShout.
"	Preferences disable: #shoutInWorkspaces."

	SHTextStylerST80 initialize.

"	StrikeFont allInstancesDo: [:each| each useLeftArrow]."

	Preferences installHaloSpecsFromArray: self iconicHaloSpecifications.
	
	Smalltalk garbageCollect.
	SystemWindow allSubInstances do: [:each|each isInWorld ifTrue: [windowManager addWindow: each]]! !

!DWMTheme methodsFor: 'keyboard shortcuts' stamp: 'len 11/16/2015 15:31'!
keyStroke: aKeyboardEvent morph: aMorph
		^windowManager keyStroke: aKeyboardEvent morph: aMorph! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menu
	^ Color darkGray darker darker! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menuText
	^ Color white! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:59'!
menuTitleBar
	^ self menu darker! !

!DWMTheme methodsFor: 'menus' stamp: 'len 11/16/2015 02:37'!
menuDecorations
	^ Dictionary new! !

!DWMTheme methodsFor: 'widget colors' stamp: 'len 11/13/2015 19:11'!
textPane
	^ Color black! !

!DWMTheme methodsFor: 'window management' stamp: 'len 11/16/2015 15:31'!
windowClosed: aSystemWindow
	windowManager windowClosed: aSystemWindow! !

!DWMTheme methodsFor: 'window management' stamp: 'len 11/16/2015 15:31'!
windowOpen: aSystemWindow
	windowManager windowOpen: aSystemWindow! !

!WindowManager methodsFor: 'initialization' stamp: 'len 11/17/2015 23:02'!
addWindow: aSystemWindow
	currentPage windowOpen: aSystemWindow! !

!WindowManager methodsFor: 'initialization' stamp: 'len 11/18/2015 07:15'!
initialize
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first! !

!WindowManager methodsFor: 'private' stamp: 'len 5/3/2018 21:58:32'!
compactPages
	| index |
	index _ pages indexOf: currentPage.
	pages _ pages sort: [:a :b| a isEmpty not or: [b isEmpty]]. "put empty pages at the end"
	currentPage isEmpty ifTrue:
		[index to: 1 by: -1 do: [:i| (pages at: i) isEmpty ifFalse: [^ self switchToPage: i]]]! !

!WindowManager methodsFor: 'events' stamp: 'len 5/4/2018 00:23:41'!
keyStroke: aKeyboardEvent morph: aMorph
	| i |
	aKeyboardEvent controlKeyPressed ifTrue: [^false].
	aKeyboardEvent commandAltKeyPressed ifFalse: [^false].

	aKeyboardEvent keyValue = $w asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | w delete. ^true ]].
	aKeyboardEvent keyValue = 27
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | w fullScreen. ^true ]].
	aKeyboardEvent keyValue = $t asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | currentPage windowToggleTiling: w. ^true ]].

	(aKeyboardEvent keyValue between: $1 asciiValue and: $8 asciiValue)
		ifTrue: [self switchToPage: aKeyboardEvent keyValue - $1 asciiValue + 1. ^true].
	(i _ #(33 64 35 36 37 94 38 42) indexOf: aKeyboardEvent keyValue) > 0
		ifTrue: [aMorph owningWindow ifNotNil: [ :w | self moveWindow: w toPage: i; switchToPage: i. ^true ]].

	"open new windows"
	aKeyboardEvent keyValue = $B asciiValue
		ifTrue: [BrowserWindow openBrowser. ^true].
	aKeyboardEvent keyValue = $W asciiValue
		ifTrue: [Workspace new contents: ''; openLabel: 'Workspace'. ^true].
	aKeyboardEvent keyValue = $T asciiValue
		ifTrue: [TranscriptWindow openTranscript. ^true].
	aKeyboardEvent keyValue = $P asciiValue
		ifTrue: [CodePackageListWindow openPackageList. ^true].
	aKeyboardEvent keyValue = $F asciiValue
		ifTrue: [FileListWindow openFileList. ^true].
	aKeyboardEvent keyValue = $C asciiValue
		ifTrue: [ChangeSorterWindow open: ChangeSorter new label: nil. ^true].
	aKeyboardEvent keyValue = $R asciiValue
		ifTrue: [TestRunnerWindow openTestRunner. ^true].
	aKeyboardEvent keyValue = $M asciiValue
		ifTrue: [MessageNamesWindow open: MessageNames new label: 'Message Names'].
	^ false! !

!WindowManager methodsFor: 'events' stamp: 'len 5/5/2018 00:45:39'!
windowClosed: aSystemWindow
	currentPage windowClosed: aSystemWindow.
	currentPage isEmpty ifTrue:
		[| currentIndex |
		currentIndex _ pages indexOf: currentPage.
		(currentIndex - 1 to: 1 by: -1), (currentIndex + 1 to: pages size)
			do: [:i| (pages at: i) isEmpty ifFalse: [^ self switchToPage: i]]]! !

!WindowManager methodsFor: 'events' stamp: 'len 11/17/2015 17:30'!
windowOpen: aSystemWindow
	currentPage windowOpen: aSystemWindow.
	aSystemWindow addHalo! !

!WindowManager methodsFor: 'actions' stamp: 'len 11/17/2015 22:46'!
moveWindow: aSystemWindow toPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	newPage == currentPage ifTrue: [^ self].
	(aSystemWindow hasProperty: #floatingBounds) ifTrue: [^ self].

	currentPage windowClosed: aSystemWindow.
	aSystemWindow removeHalo.
	aSystemWindow visible: false.
	newPage windowOpen: aSystemWindow! !

!WindowManager methodsFor: 'actions' stamp: 'len 5/3/2018 22:06:18'!
switchToPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	currentPage == newPage ifTrue: [^ self].
	newPage isEmpty ifTrue: [^ currentPage flash].
	currentPage hide.
	currentPage _ newPage.
	currentPage show! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 5/5/2018 19:08:29'!
flash
	tilingMorph ifNotNil: [:aMorph| aMorph world ifNotNil: [:aWorld| aWorld flash. ^ self]].
	windows do: [:each| each world ifNotNil: [:aWorld| aWorld flash. ^ self]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 7/10/2016 08:52'!
hide
	tilingMorph notNil ifTrue: [tilingMorph visible: false].
	windows do: [:each | (each owner notNil and: [each isReallyVisible]) ifTrue: [each removeHalo; visible: false]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/17/2015 02:50'!
show
	tilingMorph notNil ifTrue: [tilingMorph visible: true].
	windows do: [:each | each visible ifFalse: [each visible: true]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/17/2015 22:46'!
windowToggleTiling: aSystemWindow
	| possibleBounds |
	aSystemWindow isInWorld ifFalse: [^ self].
	aSystemWindow removeHalo.
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

!WindowManagerPage methodsFor: 'initialization' stamp: 'len 11/16/2015 15:00'!
initialize
	windows _ OrderedCollection new! !

!WindowManagerPage methodsFor: 'testing' stamp: 'len 5/3/2018 21:06:42'!
isEmpty
	^ windows isEmpty! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 11/17/2015 02:30'!
refresh
	tilingMorph isNil ifTrue: [^ self].
	tilingMorph refresh.
	tilingMorph hasSubmorphs ifFalse: [tilingMorph delete].
	tilingMorph isInWorld ifFalse: [tilingMorph _ nil]! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 23:05'!
windowClosed: aSystemWindow
	windows remove: aSystemWindow ifAbsent: [].
	self refresh! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 02:28'!
windowOpen: aSystemWindow
	windows add: aSystemWindow.
	self refresh! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:44'!
quit
	^ self snapshot: false andQuit: true clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:42'!
save
	^ self snapshot: true andQuit: false clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:42'!
saveAndQuit
	^ self snapshot: true andQuit: true clearAllClassState: false! !

!Morph methodsFor: '*morphic-dwm' stamp: 'len 5/12/2019 13:01:50'!
focusKeyboardFor: aKeyboardEvent

	(Theme current keyStroke: aKeyboardEvent morph: self)
		ifTrue: [^ true].

	"If aKeyboardEvent ctrl-tab or shift-ctrl-tab use it to navigate keyboard focus.
	Warning: This doesn't work on Windows... the event is not sent"
	(aKeyboardEvent keyValue = 9 and: [ aKeyboardEvent controlKeyPressed and: [ aKeyboardEvent rawMacOptionKeyPressed not ]])
		ifTrue: [
			aKeyboardEvent shiftPressed
				ifTrue: [ aKeyboardEvent hand keyboardFocusPrevious ]
				ifFalse: [ aKeyboardEvent hand keyboardFocusNext ].
			^ true ].
	"On Windows use at least some keystroke to navigate morphs... even shift-Tab that should navigate backwards"
"
	(aKeyboardEvent keyValue = 9 and: [ aKeyboardEvent shiftPressed and: [ aKeyboardEvent rawMacOptionKeyPressed not ]])
		ifTrue: [
			aKeyboardEvent hand keyboardFocusNext.
			^ true ].
"

	"Cycle through windows with cmdAlt + < and cmdAlt + >.
	VM and platform peculiarities are hidden in #isCmdAltLessThan and #isCmdAltGreaterThan"
	"This was done as an attempt to mimic the Mac OSX keystrokes for 'Move focus to next window in active application'. Unfortunately, it only works if OS X is set to use any other keys for this. If (as for example, with German defaults), OS-X uses these keystrokes, then they are not sent to the VM. This is a long standing issues in Chromium and PhotoShop, for example..."
	self disableCode: [
		aKeyboardEvent isCmdAltLessThan ifTrue: [
			aKeyboardEvent hand activatePreviousWindow.
			^true ].
		aKeyboardEvent isCmdAltGreaterThan ifTrue: [
			aKeyboardEvent hand activateNextWindow.
			^true ]].
	"Alternative for Mac OS-X: option-Tab and option-shift-Tab"
	(aKeyboardEvent keyValue = 9 and: [ aKeyboardEvent rawMacOptionKeyPressed ])
		ifTrue: [
			aKeyboardEvent shiftPressed
				ifTrue: [ aKeyboardEvent hand activatePreviousWindow ]
				ifFalse: [ aKeyboardEvent hand activateNextWindow ].
			^ true ].
	"Alternative for non-Mac OS-X: alt-< and alt->"
	(aKeyboardEvent commandAltKeyPressed and: [ aKeyboardEvent keyCharacter = $< ]) ifTrue: [
		aKeyboardEvent hand activatePreviousWindow.
		^true ].
	(aKeyboardEvent commandAltKeyPressed and: [ aKeyboardEvent keyCharacter = $> ]) ifTrue: [
		aKeyboardEvent hand activateNextWindow.
		^true ].
	^false! !

!Morph methodsFor: '*morphic-dwm' stamp: 'len 5/12/2019 12:58:21'!
keyStroke: aKeyboardEvent
	"Handle a keystroke event."

	(Theme current keyStroke: aKeyboardEvent morph: self)
		ifTrue: [^ self].

	(self focusKeyboardFor: aKeyboardEvent)
		ifTrue: [ ^ self ].
		
	"Allow instances to dynamically use properties for handling common events."
	self 
		valueOfProperty: #'keyStroke:'
		ifPresentDo: [ :handler | handler value: aKeyboardEvent ]! !

!Theme methodsFor: '*morphic-dwm' stamp: 'len 5/12/2019 12:55:59'!
keyStroke: aKeyboardEvent morph: aMorph
	^ false! !
