'From Cuis 5.0 [latest update: #4163] on 22 May 2020 at 12:55:13 pm'!
'Description Dynamic tiling window manager for Cuis Smalltalk.'!
!provides: 'Morphic-DWM' 1 39!
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

!classDefinition: #WindowManagerMorph category: #'Morphic-DWM'!
RectangleLikeMorph subclass: #WindowManagerMorph
	instanceVariableNames: 'pages currentPage'
	classVariableNames: 'Current'
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerMorph class' category: #'Morphic-DWM'!
WindowManagerMorph class
	instanceVariableNames: ''!

!classDefinition: #DWMTheme category: #'Morphic-DWM'!
Theme subclass: #DWMTheme
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'DWMTheme class' category: #'Morphic-DWM'!
DWMTheme class
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

!WindowTilingMorph methodsFor: 'initialization' stamp: 'len 11/19/2015 07:24'!
initialize
	super initialize.
	self sticky: true! !

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

!WindowTilingMorph methodsFor: 'private' stamp: 'len 5/22/2020 09:13:49'!
refresh
	mainWindow isNil ifTrue: [self popWindow].
	stack isNil ifFalse: [stack hasSubmorphs not ifTrue: [self removeStack]].
	stack isNil ifFalse: [stack layoutSubmorphs].
	self layoutSubmorphs! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/16/2015 04:38'!
removeStack
	stack isNil ifTrue: [^ self].
	stack delete.
	stack _ nil! !

!WindowManagerMorph methodsFor: 'actions' stamp: 'len 5/22/2020 10:33:53'!
moveWindow: aSystemWindow toPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	newPage == currentPage ifTrue: [^ self].
	(aSystemWindow hasProperty: #floatingBounds) ifTrue: [^ self].

	currentPage windowClosed: aSystemWindow.
	aSystemWindow removeHalo.
	aSystemWindow visible: false.
	newPage windowOpen: aSystemWindow.
	
	self step.
	self redrawNeeded! !

!WindowManagerMorph methodsFor: 'actions' stamp: 'len 5/22/2020 10:33:39'!
switchToPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	currentPage == newPage ifTrue: [^ self].
"	newPage isEmpty ifTrue: [^ currentPage flash]."
	currentPage hide.
	currentPage _ newPage.
	currentPage show.
	self step.
	self redrawNeeded! !

!WindowManagerMorph methodsFor: 'drawing' stamp: 'len 5/22/2020 12:48:49'!
drawOn: aCanvas
	| font w rect |
	aCanvas fillRectangle: self morphLocalBounds color: color.
	font _ self font.
	w _ font lineSpacing.
	rect _ 0@0 extent: w@w.
	pages withIndexDo: [:page :i|
		page == currentPage
			ifTrue: [aCanvas fillRectangle: (rect insetBy: 1) color: Color black].
		aCanvas
			drawString: i printString
			at: rect topLeft + (3@1)
			font: font
			color: (page == currentPage ifTrue: [Color white] ifFalse: [page isEmpty ifTrue: [Color black] ifFalse: [Color gray]]).
		rect _ rect translatedBy: w@0].
"	activeWindowLabel ifNotNil:
		[:aString|
		aCanvas drawString: activeWindowLabel asString
			at: rect topRight + (w@1)
			font: font
			color: Color black]"! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 5/22/2020 11:03:11'!
keyStroke: aKeyboardEvent morph: aMorph
	"Handle global shortcuts. Return true if the event was handled, false otherwise."
	| i |
	"Global shortcuts should use command (Mac) / alt (PC) key.
	Control key is reserved for normal shortcuts (local shortcuts, defined by a morph)."
	(aKeyboardEvent controlKeyPressed or: [aKeyboardEvent commandAltKeyPressed not]) ifTrue: [^false].

	aKeyboardEvent keyValue = $w asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w delete. ^true]].
	aKeyboardEvent keyValue = 27
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w fullScreen. ^true]].
	aKeyboardEvent keyValue = $t asciiValue
		ifTrue: [aMorph owningWindow ifNotNil: [:w| currentPage windowToggleTiling: w windowsArea: self windowsArea. ^true]].

	(aKeyboardEvent keyValue between: $1 asciiValue and: $8 asciiValue)
		ifTrue: [self switchToPage: aKeyboardEvent keyValue - $1 asciiValue + 1. ^true].
	(i _ #(33 64 35 36 37 94 38 42) indexOf: aKeyboardEvent keyValue) > 0
		ifTrue: [aMorph owningWindow ifNotNil: [:w| self moveWindow: w toPage: i; switchToPage: i. ^true]].

	"Shortcuts to open new windows:"
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
		ifTrue: [MessageNamesWindow open: MessageNames new label: 'Message Names'. ^true].
	^ false! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 5/22/2020 08:43:45'!
windowClosed: aSystemWindow
	currentPage windowClosed: aSystemWindow.
"	currentPage isEmpty ifTrue:
		[| currentIndex |
		currentIndex _ pages indexOf: currentPage.
		(currentIndex - 1 to: 1 by: -1), (currentIndex + 1 to: pages size)
			do: [:i| (pages at: i) isEmpty ifFalse: [^ self switchToPage: i]]]"! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 5/22/2020 08:43:48'!
windowOpen: aSystemWindow
	currentPage windowOpen: aSystemWindow.
	aSystemWindow addHalo! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 5/22/2020 12:39:43'!
initialize
	super initialize.
	self color: (Color white alpha: 0.2).
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 5/22/2020 09:15:01'!
reset
	pages do: [:each| each delete].
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first.
	SystemWindow allSubInstances do: [:each|each isInWorld ifTrue: [self addWindow: each]]! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 5/22/2020 12:36:35'!
step
"	| window hand |
	hand _ self runningWorld activeHand.
	window _ (hand keyboardFocus ifNil: [hand world submorphs detect: [:one| one morphContainsPoint: hand morphPosition] ifNone: []]) ifNotNil: [:aMorph| aMorph owningWindow].
	window == activeWindow
		ifFalse:
			[(activeWindow _ window) isNil
				ifTrue:
					[color _ Color veryDarkGray.
					activeWindowLabel _ '']
				ifFalse:
					[color _ activeWindow borderColor.
					activeWindowLabel _ activeWindow label].
			self redrawNeeded.
			^ self].
	(activeWindow notNil and: [activeWindow label ~~ activeWindowLabel])
	 	ifTrue:
			[activeWindowLabel _ activeWindow label.
			self redrawNeeded]."
	self comeToFront! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 5/22/2020 12:36:46'!
stepTime
	^ 500! !

!WindowManagerMorph methodsFor: 'submorphs-accessing' stamp: 'len 5/22/2020 09:30:25'!
noteNewOwner: aMorph
	"I have just been added as a submorph of aMorph"
	Current ifNotNil: [:m| Display removeActionsWithReceiver: m. Current delete].
	Current _ self.
	super noteNewOwner: aMorph.
	self reset.
	Display
		when: #screenSizeChanged
		send: #screenSizeChanged
		to: self.
	self updateBounds! !

!WindowManagerMorph methodsFor: 'submorphs-add/remove' stamp: 'len 5/22/2020 09:17:45'!
delete
	pages do: [:each| each delete].
	super delete.
	Display removeActionsWithReceiver: self.
	Current == self ifTrue: [Current _ nil]! !

!WindowManagerMorph methodsFor: 'testing' stamp: 'len 5/19/2020 12:23:50'!
isSticky
	^true! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 08:41:44'!
addWindow: aSystemWindow
	currentPage windowOpen: aSystemWindow! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 07:53:35'!
defaultHeight
	^ self font lineSpacing! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 12:52:26'!
defaultWidth
	^ self font lineSpacing * 8 + 2! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 10:49:27'!
font
	^ (FontFamily familyNamed: FontFamily defaultFamilyName) aroundPointSize: 8! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 08:09:22'!
screenSizeChanged
	UISupervisor whenUIinSafeState: [self updateBounds]! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 12:43:56'!
updateBounds
	| area |
"at bottom:
	self world ifNotNil: [:w| self morphPosition: 0@(w morphHeight - self defaultHeight) extent: w morphExtent x @ self defaultHeight].
at top:
	self world ifNotNil: [:w| self morphPosition: 0@0 extent: w morphExtent x @ self defaultHeight]."
	self world ifNotNil: [:w| self morphPosition: w morphWidth - self defaultWidth @(w morphHeight - self defaultHeight) extent: w morphExtent x @ self defaultHeight].
	area _ self windowsArea.
	pages do: [:each| each updateBounds: area]! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 12:40:47'!
windowsArea
	| allowedArea |
	allowedArea _ Display boundingBox.
	self world ifNotNil: [:w|
		allowedArea _ allowedArea intersect: w viewBox.
		"self morphBoundsInWorld ifNotNil: [:r| allowedArea _ (allowedArea areasOutside: r) first ]"].
	^allowedArea! !

!WindowManagerMorph class methodsFor: 'as yet unclassified' stamp: 'len 5/22/2020 08:33:15'!
current
	^ Current! !

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

!DWMTheme methodsFor: 'colors' stamp: 'len 5/25/2019 05:17:17'!
paneBackgroundFrom: aColor
	^ aColor alphaMixed: 0.11 with: Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:39'!
scrollbarButtonColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:58'!
scrollbarColor
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:36'!
scrollbarSliderShadowColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 5/24/2019 07:09:24'!
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

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/24/2019 12:19:09'!
browser
	^ Color lightGreen duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/24/2019 12:35:34'!
changeSorter
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/9/2016 00:06'!
debugger
	^ Color lightRed! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/16/2015 02:16'!
defaultWindowColor
	^ Color gray darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/24/2019 12:25:09'!
fileList
	^ Color lightMagenta lighter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/1/2020 06:26:42'!
messageNames
	^ Color lightGreen! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/1/2020 06:25:52'!
messageSet
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/24/2019 12:20:11'!
packageList
	^ Color lightOrange duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/1/2020 06:27:27'!
testRunner
	^ Color lightBlue! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/25/2016 20:25'!
transcript
	^ Color lightOrange! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/1/2020 06:27:39'!
versionsBrowser
	^ Color lightBlue! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/24/2019 12:22:05'!
workspace
	^ Color lightYellow duller! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/19/2020 04:12:25'!
buttonPaneHeight
	"Answer the user's preferred default height for button panes."

	^Preferences standardButtonFont lineSpacing * 10 // 8! !

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

!DWMTheme methodsFor: 'initialization' stamp: 'len 5/22/2020 12:37:07'!
initialize
	super initialize.
"	family _ 'DejaVu Sans'.
	codeFamily _ 'DejaVu Sans'.
	Preferences setDefaultFonts: {
		{#setSystemFontTo:. family. 10}.
		{#setListFontTo:. family. 10}.
		{#setMenuFontTo:. family. 9}.
		{#setWindowTitleFontTo:. family. 10}.
		{#setCodeFontTo:. codeFamily. 10}.
		{#setButtonFontTo:. family. 9}}.
	DisplayScreen runningWorld ifNotNil: [ :world | world fontPreferenceChanged ].
"
	Preferences disable: #biggerCursors.
	Preferences enable: #dismissAllOnOptionClose.
	Preferences enable: #subPixelRenderColorFonts.
	Preferences enable: #italicsInShout.
	Preferences disable: #shoutInWorkspaces.
	Preferences enable: #optionalButtons.

	SHTextStylerST80 initialize.

"	StrikeFont allInstancesDo: [:each| each useLeftArrow].
	TTFontDescription allInstancesDo: [:each| each useLeftArrow].
"
	Preferences installHaloSpecsFromArray: self iconicHaloSpecifications.
	
	Smalltalk garbageCollect.
	WindowManagerMorph new openInWorld startStepping! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menu
	^ Color darkGray darker darker! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menuText
	^ Color white! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:59'!
menuTitleBar
	^ self menu darker! !

!DWMTheme methodsFor: 'widget colors' stamp: 'len 11/13/2015 19:11'!
textPane
	^ Color black! !

!DWMTheme methodsFor: 'private - shout mappings' stamp: 'len 5/24/2019 07:08:49'!
generateShoutConfig

	| styles colors |
	styles := OrderedCollection new.
	colors := self shout as: Dictionary.

	{
		{self undefined. colors at: #undefined}.
		{self defaults . colors at: #defaults}.
		{self pseudoVariables . colors at: #pseudoVariables. #bold}.
		{self literals . colors at: #literals}.
		{self instVar . colors at: #instVar}.
		{self messages . colors at: #messages}.
		{self blockLevelZero . colors at: #blockLevelZero}.
		{self blockLevelOne . colors at: #blockLevelOne}.
		{self blockLevelTwo . colors at: #blockLevelTwo}.
		{self blockLevelThree . colors at: #blockLevelThree}.
		{self blockLevelFour . colors at: #blockLevelFour}.
		{self blockLevelFive . colors at: #blockLevelFive}.
		{self blockLevelSix . colors at: #blockLevelSix}.
		{self blockLevelSeven . colors at: #blockLevelSeven}.
		{self tempBar . colors at: #tempBar}.
		{self methodTags . colors at: #methodTags . #bold}.
		{self globals . colors at: #defaults . #bold}.
		{self incompleteMessages . colors at: #incompleteMessages . #underlined}.
		{self argumentTypes . colors at: #arguments . self italic}.
		{self symbols . colors at: #messages . #bold}.
		{self pattern . colors at: #selector . #bold}.
		{self ansiAssignment . nil . #bold}.
		{self assignment . nil . #(#bold #withST80Glyphs)}.
		{self return . nil . #(#bold #withST80Glyphs)}.
		{self tempVars . colors at: #tempVars . self italic}.
		{self blockTemps . colors at: #tempBar . self italic}
	} do: [ :style |
		styles addAll:
			(style first
				collect: [ :category | | elements |
					elements _ style asOrderedCollection.
					elements at: 1 put: category.
					Array withAll: elements ])].

	"Miscellaneous remainder after factoring out commonality:"
	styles addAll: {
		{#unfinishedString . colors at: #undefined . #normal}.
		{#undefinedIdentifier . colors at: #undefined .#bold}.
		{#unfinishedComment . colors at: #pseudoVariables . self italic}.
		{#comment . colors at: #comment . self italic}.
		{#string . colors at: #instVar . #normal}.
		{#literal . nil . self italic}.
		{#incompleteIdentifier . colors at: #tempVars . {#italic. #underlined}}.
		{#classVar . colors at: #tempVars . #bold}.
	}.

	^ styles! !

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

!WindowManagerPage methodsFor: 'actions' stamp: 'len 5/22/2020 09:04:47'!
windowToggleTiling: aSystemWindow windowsArea: windowsArea
	| possibleBounds |
	aSystemWindow isInWorld ifFalse: [^ self].
	aSystemWindow removeHalo.
	tilingMorph isNil
		ifTrue:
			[tilingMorph _ WindowTilingMorph newRow.
			aSystemWindow world addMorphBack: tilingMorph.
			self updateBounds: windowsArea].
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

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 23:05'!
windowClosed: aSystemWindow
	windows remove: aSystemWindow ifAbsent: [].
	self refresh! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 02:28'!
windowOpen: aSystemWindow
	windows add: aSystemWindow.
	self refresh! !

!WindowManagerPage methodsFor: 'initialization' stamp: 'len 5/22/2020 09:15:31'!
delete
	tilingMorph ifNotNil: [tilingMorph delete. tilingMorph _ nil]! !

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

!WindowManagerPage methodsFor: 'private' stamp: 'len 5/22/2020 09:02:53'!
updateBounds
	self runningWorld submorphs do: [:one| (one isKindOf: WindowManagerMorph) ifTrue: [^ self updateBounds: one windowsArea]]! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 5/22/2020 08:56:43'!
updateBounds: windowsArea
	tilingMorph ifNotNil: [tilingMorph morphPosition: windowsArea topLeft extent: windowsArea extent]! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:44'!
quit
	^ self snapshot: false andQuit: true clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:42'!
save
	^ self snapshot: true andQuit: false clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 11/19/2015 07:42'!
saveAndQuit
	^ self snapshot: true andQuit: true clearAllClassState: false! !

!RealEstateAgent class methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 10:07:46'!
screenTopSetback
	^ 16! !

!Morph methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 05:54:44'!
focusKeyboardFor: aKeyboardEvent
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

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 08:59:41'!
delete
	| thisWorld |
	self okToChange ifFalse: [^self].
	thisWorld _ self world.
	SystemWindow noteTopWindowIn: thisWorld but: self.
	self sendToBack.
	self removeHalo.
	super delete.
	self model: nil.
	WindowManagerMorph current ifNotNil: [:m| m windowClosed: self]! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 09:00:26'!
openInWorld
	"Ensure all widgets have proper colors before opening"
	self widgetsColor: self windowColor.
	super openInWorld.
	WindowManagerMorph current ifNotNil: [:m| m windowOpen: self]! !

!KeyboardEvent methodsFor: '*morphic-dwm-dispatching' stamp: 'len 5/22/2020 08:59:19'!
sentTo: aMorph localPosition: positionInAMorph
	"Dispatch the receiver into aMorph."
	type == #keystroke ifTrue: [
		"First, give a chance to the window manager to handle the event.
		This is used for global shortcuts such as command-w for closing a window."
		(WindowManagerMorph current ifNotNil: [:m| m keyStroke: self morph: aMorph] ifNil: [false])
			ifFalse:
				[^ aMorph
					processKeystroke: self
					localPosition: positionInAMorph ]].
	type == #keyDown ifTrue: [
		^ aMorph
			processKeyDown: self
			localPosition: positionInAMorph ].
	type == #keyUp ifTrue: [ 
		^ aMorph
			processKeyUp: self
			localPosition: positionInAMorph ].
	^ super
		sentTo: aMorph
		localPosition: positionInAMorph.! !
