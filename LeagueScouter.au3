

#include <Inet.au3>
#include <String.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <WinAPIFiles.au3>

$sListOfChampions = "Aatrox|Ahri|Akali|Alistar|Amumu|Anivia|Annie|Ashe|Aurelion Sol|Azir|Bard|Blitzcrank|Brand|Braum|Caitlyn|Cassiopeia|Cho'Gath|Corki|Darius|Diana|Dr. Mundo|Draven|Ekko|Elise|Evelynn|Ezreal|Fiddlesticks|Fiora|Fizz|Galio|Gangplank|Garen|Gnar|Gragas|Graves|Hecarim|Heimerdinger|Illaoi|Irelia|Janna|Jarvan IV|Jax|Jayce|Jhin|Jinx|Kalista|Karma|Karthus|Kassadin|Katarina|Kayle|Kennen|Kha'Zix|Kindred|Kog'Maw|LeBlanc|Lee Sin|Leona|Lissandra|Lucian|Lulu|Lux|Malphite|Malzahar|Maokai|Master Yi|Miss Fortune|Mordekaiser|Morgana|Nami|Nasus|Nautilus|Nidalee|Nocturne|Nunu|Olaf|Orianna|Pantheon|Poppy|Quinn|Rammus|Rek'Sai|Renekton|Rengar|Riven|Rumble|Ryze|Sejuani|Shaco|Shen|Shyvana|Singed|Sion|Sivir|Skarner|Sona|Soraka|Swain|Syndra|Tahm Kench|Talon|Taric|Teemo|Thresh|Tristana|Trundle|Tryndamere|Twisted Fate|Twitch|Udyr|Urgot|Varus|Vayne|Veigar|Vel'Koz|Vi|Viktor|Vladimir|Volibear|Warwick|Wukong|Xerath|Xin Zhao|Yasuo|Yorick|Zac|Zed|Ziggs|Zilean|Zyra"


GUICreate("Champion Counter", 450, 500, @DesktopWidth / 2 + 200, @DesktopHeight / 2 - 400, -1, $WS_EX_TOPMOST)


	Local $iChampionSelection = GUICtrlCreateCombo("Champion", 215, 25, 200, 20)
	GUICtrlSetData($iChampionSelection, $sListOfChampions)

	GUISetState(@SW_SHOW)




	; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
			Case $iChampionSelection
				;~ 	Read inputs
				Local $sChampion = GUICtrlRead($iChampionSelection)
				If $sChampion <> "Champion" Then
					GetCounterInfo()
				EndIf
;~             Case $idBtn
;~ 				If $sSourceXML == "" Or $sOrderID == "" Or $sConsumerDirectory == "" Then
;~ 					MsgBox(0,"", "Fields cannot be empty")
;~ 					GUISetState(@SW_DISABLE)
;~ 					Main()
;~ 					Exit
;~ 				EndIf
;~ 				Executes below code
;~                 ExitLoop
        EndSwitch
    WEnd



Func GetMasteryKeystoneInfo($aMasteryList)

	Local $sMasteryURL
	For $i = 0 To UBound($aMasteryList) - 1
		Switch $aMasteryList[$i]
			;Ferocity Tree
			Case "6161" ;Warlord's Bloodlust
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/6/6d/Mastery_Warlord%27s_Bloodlust.png/50px-Mastery_Warlord%27s_Bloodlust.png'
			Case "6162" ;Fervor of Battle
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/4/4b/Mastery_Fervor_of_Battle.png/50px-Mastery_Fervor_of_Battle.png'
			Case "6164" ;Deathfire Touch
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/5/5e/Mastery_Deathfire_Touch.png/50px-Mastery_Deathfire_Touch.png'

			;Cunning Tree
			Case "6361" ;Stormraider's Surge
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/a/aa/Mastery_Stormraider%27s_Surge.png/50px-Mastery_Stormraider%27s_Surge.png'
			Case "6362" ;Thunderlord's Decree
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/8/84/Mastery_Thunderlord%27s_Decree.png/50px-Mastery_Thunderlord%27s_Decree.png'
			Case "6363" ;Windspeaker's Blessing
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/7/71/Mastery_Windspeaker%27s_Blessing.png/50px-Mastery_Windspeaker%27s_Blessing.png'

			;Resolve Tree
			Case "6261" ;Grasp of the Undying
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/a/a0/Mastery_Grasp_of_the_Undying.png/50px-Mastery_Grasp_of_the_Undying.png'
			Case "6262" ;Strength of the Ages
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/6/60/Mastery_Strength_of_the_Ages.png/50px-Mastery_Strength_of_the_Ages.png'
			Case "6263" ;Bond of Stone
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/e/e2/Mastery_Bond_of_Stone.png/50px-Mastery_Bond_of_Stone.png'
		EndSwitch
	Next
	Return $sMasteryURL
EndFunc





Func GetCounterInfo()

;~     Local $sFile
;~     GUICreate("_GetURLImage()", 320, 115)
;~     $sFile = _GetURLImage("http://leagueoflegends.wikia.com/wiki/Category:Champion_squares?file=AatroxSquare.png", @TempDir)
;~     If @error = 0 Then
;~         0xFF0000($sFile, 0, 0, 320, 115, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS)) ; Make Sure You Set The Correct Width & Height.
;~     EndIf


;~ ;===Modify Champion selected for use in URL===
	;Removes spaces and periods
	$sChampion = StringReplace(StringReplace($sChampion, " ", ""), ".", "")

	;Removes apostrohpe in Champion names (ie. Vel'Koz, Cho'Gath)
	If StringInStr($sChampion,"'") Then
		$sChampion = StringReplace($sChampion, "'", "")
		$sChampion = StringLeft($sChampion,1) & StringLower(StringMid($sChampion,2))
	EndIf

	$sWeak = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/weak')
	$sStrong = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/strong')
	$sMostFrequentMastery = _INetGetSource('https://champion.gg/champion/' & $sChampion)

	$aBetweenWeak = _StringBetween($sWeak, "a class='left' href='/champions/", "'><div")
	$aBetweenStrong = _StringBetween($sStrong, "a class='left' href='/champions/", "'><div")


	$aMasteryList = _StringBetween($sMostFrequentMastery, ' mastery-active" champion-tip api-type="masteries" api-primary-id="',  '" api-secondary-id="')




;~ 		For $i = 0 To UBound($aMasteryList) - 1
;~ 			$aMasteryList[$i] = StringLeft($aMasteryList[$i], 4)
;~ 		Next







	$idListview = GUICtrlCreateListView("", 2, 2, 210, 425)

  ; Enable extended control styles
    _GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))



	_GDIPlus_Startup()
	Local  $STM_SETIMAGE = 0x0172

	Local $hBmp = _GDIPlus_BitmapCreateFromMemory(InetRead("https://ddragon.leagueoflegends.com/cdn/6.8.1/img/champion/" & $sChampion & ".png"), True) ;to load an image from the net
;~ 	Local $hBmp = _GDIPlus_BitmapCreateFromMemory(InetRead("https://raw.githubusercontent.com/Gravebot/Gravebot/master/web/images/leagueoflegends/champs/" & StringLower($sChampion) & ".png"), True) ;to load an image from the net
	Global  $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	Global  $iWidth = _GDIPlus_ImageGetWidth($hBitmap)
	Global  $iHeight = _GDIPlus_ImageGetHeight($hBitmap)
	Global  $idPic = GUICtrlCreatePic("", 250, 150, $iWidth, $iHeight)
	_WinAPI_DeleteObject(GUICtrlSendMsg($idPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp))



	Local $sMasteryURL = ""
	Local $aFrequentMasteryList[10]
	Local $aMostWinsMasteryList[10]


;~ 	Find/Load KeystoneMastery images

	For $i = 0 To UBound($aMasteryList)/2 - 1

		$aFrequentMasteryList[$i] = $aMasteryList[$i]
		$aMostWinsMasteryList[$i] = $aMasteryList[$i+5]
	Next



	GUICtrlCreateLabel("Frequent Keystone Mastery: ",230, 50,50,40,)

	$sFrequentKeystone = GetMasteryKeystoneInfo($aFrequentMasteryList)
	If $sFrequentKeystone <> "" Then
		GetPNGFromURL($sFrequentKeystone, 250, 150)
	EndIf

	$sMostWinKeystone = GetMasteryKeystoneInfo($aMostWinsMasteryList)
	If $sMostWinKeystone <> "" Then
		GetPNGFromURL($sMostWinKeystone, 250, 250)
	EndIf
;~ 	_ArrayDisplay($aFrequentMasteryList, "1D display")



;~     ; Download the file in the background with the selected option of 'force a reload from the remote site.'
;~     Local $hDownload = InetGet("https://raw.githubusercontent.com/Gravebot/Gravebot/master/web/images/leagueoflegends/champs/aatrox.png", $sFilePath, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

;~  ; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
;~     Do
;~         Sleep(250)
;~     Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

;~     ; Retrieve the number of total bytes received and the filesize.
;~     Local $iBytesSize = InetGetInfo($hDownload, $INET_DOWNLOADREAD)
;~     Local $iFileSize = FileGetSize($sFilePath)
;~    ; Close the handle returned by InetGet.
;~     InetClose($hDownload)

;~     ; Display details about the total number of bytes read and the filesize.
;~     MsgBox($MB_SYSTEMMODAL, "", "The total download size: " & $iBytesSize & @CRLF & _
;~             "The total filesize: " & $iFileSize)






    GUISetState(@SW_SHOW)






;~ 	GUICtrlSetImage($image_pic, @ScriptDir&"\"&$sFilePath)



    ; Load images
	$hImage = _GUIImageList_Create()
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0xFF0000, 16, 16))
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x00FF00, 16, 16))

    _GUICtrlListView_SetImageList($idListview, $hImage, 1)

    ; Add columns
    _GUICtrlListView_AddColumn($idListview, "WEAK", 100)
    _GUICtrlListView_AddColumn($idListview, "STRONG", 100)



    ; Add items
	For $i = 0 To UBound($aBetweenWeak) - 1
		_GUICtrlListView_AddItem($idListview, $aBetweenWeak[$i])
		For $j = 0 To UBound($aBetweenStrong) - 1
			_GUICtrlListView_AddSubItem($idListview, $j, $aBetweenStrong[$j], 1, 1)
		Next
;~ 		_GUICtrlListView_AddSubItem($idListview, 0, "Row 1: Col 3", 2, 2)
;~ 		_GUICtrlListView_AddItem($idListview, "Row 2: Col 1", 1)
;~ 		_GUICtrlListView_AddSubItem($idListview, 1, "Row 2: Col 2", 1, 2)
;~ 		_GUICtrlListView_AddItem($idListview, "Row 3: Col 1", 2)
	Next
EndFunc


Func GetPNGFromURL($sMasteryURL, $iPosX, $iPosY)
	Local  $STM_SETIMAGE = 0x0172
	Local $hBmp = _GDIPlus_BitmapCreateFromMemory(InetRead($sMasteryURL), True) ;to load an image from the net
	Global  $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	Global  $iWidth = _GDIPlus_ImageGetWidth($hBitmap)
	Global  $iHeight = _GDIPlus_ImageGetHeight($hBitmap)
	Global  $idPic = GUICtrlCreatePic("", $iPosX, $iPosY, $iWidth, $iHeight)
	_WinAPI_DeleteObject(GUICtrlSendMsg($idPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp))
EndFunc


Func _GetURLImage($sURL, $sDirectory = @ScriptDir)
    Local $hDownload, $sFile
    $sFile = StringRegExpReplace($sURL, "^.*/", "")
    If @error Then
        Return SetError(1, 0, $sFile)
    EndIf
    If StringRight($sDirectory, 1) <> "\" Then
        $sDirectory = $sDirectory & "\"
    EndIf
    $sDirectory = $sDirectory & $sFile
    If FileExists($sDirectory) Then
        Return $sDirectory
    EndIf
    $hDownload = InetGet($sURL, $sDirectory, 17, 1)
    While InetGetInfo($hDownload, 2) = 0
        If InetGetInfo($hDownload, 4) <> 0 Then
            InetClose($hDownload)
            Return SetError(1, 0, $sDirectory)
        EndIf
        Sleep(105)
    WEnd
    InetClose($hDownload)
    Return $sDirectory
EndFunc   ;==>_GetURLImage