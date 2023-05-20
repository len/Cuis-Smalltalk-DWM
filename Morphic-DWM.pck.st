'From Cuis 6.0 [latest update: #5801] on 18 May 2023 at 5:45:37 pm'!
'Description Dynamic tiling window manager for Cuis Smalltalk.'!
!provides: 'Morphic-DWM' 1 69!
SystemOrganization addCategory: 'Morphic-DWM'!


!classDefinition: #WindowStackMorph category: 'Morphic-DWM'!
LayoutMorph subclass: #WindowStackMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowStackMorph class' category: 'Morphic-DWM'!
WindowStackMorph class
	instanceVariableNames: ''!

!classDefinition: #WindowTilingMorph category: 'Morphic-DWM'!
LayoutMorph subclass: #WindowTilingMorph
	instanceVariableNames: 'mainWindow stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowTilingMorph class' category: 'Morphic-DWM'!
WindowTilingMorph class
	instanceVariableNames: ''!

!classDefinition: #WindowManagerMorph category: 'Morphic-DWM'!
BoxedMorph subclass: #WindowManagerMorph
	instanceVariableNames: 'pages currentPage ownerExtent'
	classVariableNames: 'Current'
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerMorph class' category: 'Morphic-DWM'!
WindowManagerMorph class
	instanceVariableNames: ''!

!classDefinition: #DWMTheme category: 'Morphic-DWM'!
Theme subclass: #DWMTheme
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'DWMTheme class' category: 'Morphic-DWM'!
DWMTheme class
	instanceVariableNames: ''!

!classDefinition: #WindowManagerPage category: 'Morphic-DWM'!
Object subclass: #WindowManagerPage
	instanceVariableNames: 'tilingMorph windows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerPage class' category: 'Morphic-DWM'!
WindowManagerPage class
	instanceVariableNames: ''!


!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/18/2015 03:14'!
privateAddMorph: aMorph atIndex: anInteger
	aMorph owner == self ifTrue: [^ self].
	super privateAddMorph: aMorph atIndex: anInteger! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:15:44'!
privateMoveFrontMorph: aMorph
	aMorph owner == self ifTrue: [^ self].
	^ super privateMoveFrontMorph: aMorph! !

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

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:14:40'!
privateMoveBackMorph: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super privateMoveBackMorph: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:14:02'!
privateMoveFrontMorph: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super privateMoveFrontMorph: aMorph! !

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

!WindowManagerMorph methodsFor: 'drawing' stamp: 'len 5/22/2020 15:49:34'!
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
			at: rect topLeft + (2@1)
			font: font
			color: (page == currentPage ifTrue: [Color white] ifFalse: [page isEmpty ifTrue: [Color black] ifFalse: [Color gray]]).
		rect _ rect translatedBy: w@0].
"	activeWindowLabel ifNotNil:
		[:aString|
		aCanvas drawString: activeWindowLabel asString
			at: rect topRight + (w@1)
			font: font
			color: Color black]"! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 5/22/2020 13:09:35'!
keyStroke: aKeyboardEvent morph: aMorph
	"Handle global shortcuts. Return true if the event was handled, false otherwise."
	| i |
	"Global shortcuts should use command (Mac) / alt (PC) key.
	Control key is reserved for normal shortcuts (local shortcuts, defined by a morph)."
	(aKeyboardEvent controlKeyPressed or: [aKeyboardEvent commandAltKeyPressed not]) ifTrue: [^false].

	aKeyboardEvent isEsc
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w fullScreen. ^true]].
	aKeyboardEvent keyCharacter = $w
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w delete. ^true]].
	aKeyboardEvent keyCharacter = $t
		ifTrue: [aMorph owningWindow ifNotNil: [:w| currentPage windowToggleTiling: w windowsArea: self windowsArea. ^true]].

	(aKeyboardEvent keyValue between: $1 asciiValue and: $8 asciiValue)
		ifTrue: [self switchToPage: aKeyboardEvent keyValue - $1 asciiValue + 1. ^true].
	(i _ #(33 64 35 36 37 94 38 42) indexOf: aKeyboardEvent keyValue) > 0
		ifTrue: [aMorph owningWindow ifNotNil: [:w| self moveWindow: w toPage: i; switchToPage: i. ^true]].

	"Shortcuts to open new windows:"
	aKeyboardEvent keyCharacter = $B
		ifTrue: [BrowserWindow openBrowser. ^true].
	aKeyboardEvent keyCharacter = $W
		ifTrue: [Workspace new contents: ''; openLabel: 'Workspace'. ^true].
	aKeyboardEvent keyCharacter = $T
		ifTrue: [TranscriptWindow openTranscript. ^true].
	aKeyboardEvent keyCharacter = $P
		ifTrue: [CodePackageListWindow openPackageList. ^true].
	aKeyboardEvent keyCharacter = $F
		ifTrue: [FileListWindow openFileList. ^true].
	aKeyboardEvent keyCharacter = $C
		ifTrue: [ChangeSorterWindow open: ChangeSorter new label: nil. ^true].
	aKeyboardEvent keyCharacter = $R
		ifTrue: [TestRunnerWindow openTestRunner. ^true].
	aKeyboardEvent keyCharacter = $M
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

!WindowManagerMorph methodsFor: 'events' stamp: 'len 1/28/2022 12:33:32'!
windowOpen: aSystemWindow
	currentPage windowOpen: aSystemWindow.
"	aSystemWindow addHalo"! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 5/22/2020 15:41:20'!
initialize
	super initialize.
	self color: (Color white alpha: 0.15).
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 5/22/2020 09:15:01'!
reset
	pages do: [:each| each delete].
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first.
	SystemWindow allSubInstances do: [:each|each isInWorld ifTrue: [self addWindow: each]]! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 1/28/2022 15:41:29'!
step
	| newOwnerExtent |
	self comeToFront.
	newOwnerExtent _ owner morphExtent.
	ownerExtent = newOwnerExtent ifFalse: [self updateBounds. ownerExtent _ newOwnerExtent]! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 1/28/2022 12:29:04'!
stepTime
	^ 1000! !

!WindowManagerMorph methodsFor: 'submorphs-accessing' stamp: 'len 1/28/2022 15:40:05'!
noteNewOwner: aMorph
	"I have just been added as a submorph of aMorph"
	Current ifNotNil: [:m| Current delete].
	Current _ self.
	super noteNewOwner: aMorph.
	self reset.
	self updateBounds! !

!WindowManagerMorph methodsFor: 'submorphs-add/remove' stamp: 'len 1/28/2022 15:39:38'!
delete
	pages do: [:each| each delete].
	super delete.
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

!WindowManagerMorph methodsFor: 'private' stamp: 'len 3/24/2021 14:01:30'!
font
	^ (FontFamily familyNamed: FontFamily defaultFamilyName) atPointSize: 12! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/25/2020 08:09:00'!
updateBounds
	| world newPosition area |
	world _ self world ifNil: [^ self].
	newPosition _ world morphWidth - self defaultWidth @ (world morphHeight - self defaultHeight).
	self morphPosition rounded = newPosition rounded ifTrue: [^ self].
	self morphPosition: newPosition extent: self defaultWidth @ self defaultHeight.
	area _ self windowsArea.
	pages do: [:each| each updateBounds: area]! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/25/2020 08:07:35'!
windowsArea
	| allowedArea |
	allowedArea _ Display boundingBox.
	self world ifNotNil: [:w| allowedArea _ allowedArea intersect: w viewBox].
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

!DWMTheme methodsFor: 'colors' stamp: 'len 12/27/2022 12:28:29'!
paneBackgroundFrom: aColor
"	^ aColor adjustSaturation: 0 brightness: -0.7"
	^ aColor alphaMixed: 0.14 with: Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:39'!
scrollbarButtonColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:58'!
scrollbarColor
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:36'!
scrollbarSliderShadowColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 5/27/2020 16:42:18'!
shout
	^ {
		#selector  				-> nil.
		#defaults 				-> #white.
		#undefined 				-> #white. "#(lightRed lighter lighter lighter lighter)."
		#comment 				-> #(lightGray lighter).
		#literals 				-> #(lightBlue lighter).
		#pseudoVariables 		-> '#FF709C'. "and bold"
		#messages 				-> #(white).
		#incompleteMessages	-> #(white).
		#arguments 				-> #(lightYellow lighter).
		#instVar 				-> #(lightGreen).
		#tempBar 				-> #(white darker).
		#tempVars				-> '#F0FFC4'.
"		#blockTemps				-> '#5CFFA7'."
		#blockTemps				-> '#ADFFD3'.
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

!DWMTheme methodsFor: 'colors' stamp: 'len 3/26/2021 18:09:44'!
windowLabel
	^ `Color gray: 0.2`! !

!DWMTheme methodsFor: 'icons' stamp: 'len 3/27/2021 06:02:22'!
closeIcon
	^ self cancelIcon! !

!DWMTheme methodsFor: 'initialization' stamp: 'len 5/18/2023 17:45:29'!
initialize
	super initialize.
"
	TrueTypeFontFamily readAllTrueTypeFontsIn: DirectoryEntry smalltalkImageDirectory / 'TrueTypeFonts' / 'DejaVu' / 'DejaVuSans'.
	PreferenceSet
		setDefaultFont: 'DejaVu Sans'
		spec: #(
			(standardListFont 15)
			(standardMenuFont 15)
			(windowTitleFont 13)
			(standardCodeFont 15)
			(standardButtonFont 15)).
	DisplayScreen runningWorld ifNotNil: [ :world | world fontPreferenceChanged ].
"
	Preferences
		at: #biggerCursors put: false;
		at: #dismissAllOnOptionClose put: true;
		at: #subPixelRenderColorFonts put: true;
		at: #italicsInShout put: true;
		at: #shoutInWorkspaces put: true;
		at: #optionalButtons put: false;
		at: #showAnnotations put: true;
		at: #usePreDebugWindow put: false.

	SHTextStylerST80 initialize.

	Smalltalk garbageCollect.
	UISupervisor ui borderWidth: 0.
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

!DWMTheme methodsFor: 'other options' stamp: 'len 8/5/2022 08:26:40'!
buttonPaneHeight
	"Answer the user's preferred default height for button panes."

	^(Preferences at: #standardButtonFont) lineSpacing * 10 // 8! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/13/2015 18:23'!
embossedTitles
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 01:23'!
fullScreenDeskMargin
	^ 0! !

!DWMTheme methodsFor: 'other options' stamp: 'len 3/24/2021 15:19:57'!
layoutAdjusterThickness
	^ 2! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:15'!
roundButtons
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 8/6/2022 08:16:38'!
roundWindowCorners
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:10'!
useTaskbar
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/17/2015 22:36'!
useUniformColors
	^false! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:15'!
browser
	^ Color lightGreen duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:47:12'!
changeList
	^ Color lightCyan duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:26:06'!
changeSorter
	^ Color lightCyan duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/22/2020 18:08:30'!
debugger
	^ Color lightRed darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/16/2015 02:16'!
defaultWindowColor
	^ Color gray darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:03:55'!
fileContentsBrowser
	^ Color tan! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:21:54'!
fileList
	^ Color lightMagenta duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:27'!
messageNames
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:35'!
messageSet
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:03:15'!
packageList
	^ Color tan! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:06:47'!
testRunner
	^ Color blue quiteWhiter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/25/2016 20:25'!
transcript
	^ Color lightOrange! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:35:48'!
versionsBrowser
	^ Color pink whiter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:42:16'!
workspace
	^ Color lightYellow duller! !

!DWMTheme methodsFor: 'widget colors' stamp: 'len 11/13/2015 19:11'!
textPane
	^ Color black! !

!DWMTheme methodsFor: 'private - shout mappings' stamp: 'len 12/18/2022 09:57:31'!
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
		{self assignment . nil . #bold}.
		{self return . nil . #bold}.
		{self tempVars . colors at: #tempVars . self italic}.
		{self blockTemps . colors at: #blockTemps . self italic}
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
		{#unfinishedComment . colors at: #undefined . self italic}.
		{#comment . colors at: #comment . self italic}.
		{#string . colors at: #literals . #normal}.
		{#literal . nil . self italic}.
		{#incompleteIdentifier . colors at: #incompleteMessages . {#italic. #underlined}}.
		{#classVar . colors at: #instVar . #bold}.
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

!WindowManagerPage methodsFor: 'actions' stamp: 'len 3/24/2021 13:46:04'!
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
			[aSystemWindow setProperty: #floatingBounds toValue: aSystemWindow displayBounds.
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

!WindowManagerPage methodsFor: 'printing' stamp: 'len 11/16/2015 15:36'!
printOn: aStream
	aStream nextPut: $[.
	windows do: [:each | aStream print: each] separatedBy: [aStream nextPutAll: '; '].
	aStream nextPut: $]! !

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

!WindowManagerPage methodsFor: 'private' stamp: 'len 5/26/2020 11:42:44'!
updateBounds: windowsArea
	tilingMorph ifNotNil: [tilingMorph morphPosition: windowsArea topLeft extent: windowsArea extent].
	windows do: [:each| (each hasProperty: #originalBounds) ifTrue: [each morphPosition: windowsArea topLeft extent: windowsArea extent]]
! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'jmv 8/18/2021 19:52:01'!
quit
	"Just quit. No questions asked. No validations done.
	Smalltalk quit.
	"
	self snapshot: false andQuit: true embedded: false clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'len 1/28/2022 08:37:54'!
save
	^ self snapshot: true andQuit: false embedded: false clearAllClassState: false! !

!SystemDictionary methodsFor: '*Morphic-DWM' stamp: 'jmv 8/18/2021 21:03:40'!
saveAndQuit
	"Save image and quit. No questions asked.
	Smalltalk saveAndQuit.
	"
	ChangeSet zapAllChangeSets.
	^ self
		snapshot: true
		andQuit: true
		embedded: false
		clearAllClassState: false.! !

!RealEstateAgent class methodsFor: '*morphic-dwm' stamp: 'len 5/30/2020 16:27:52'!
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

!KeyboardEvent methodsFor: '*morphic-dwm-dispatching' stamp: 'len 3/24/2021 12:49:16'!
sendEventTo: aMorph
	"Dispatch the receiver into aMorph."
	type == #keystroke
		ifTrue:
			[^ (WindowManagerMorph current ifNotNil: [:m| m keyStroke: self morph: aMorph] ifNil: [false])
				ifFalse: [aMorph processKeystroke: self]].
	type == #keyDown ifTrue: [^ aMorph processKeyDown: self].
	type == #keyUp ifTrue: [^ aMorph processKeyUp: self].
	^ super sendEventTo: aMorph! !
