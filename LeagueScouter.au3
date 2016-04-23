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
				GetCounterInfo()

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







Func GetCounterInfo()

;~     Local $sFile
;~     GUICreate("_GetURLImage()", 320, 115)
    $sFile = _GetURLImage("http://leagueoflegends.wikia.com/wiki/Category:Champion_squares?file=AatroxSquare.png", @TempDir)
;~     If @error = 0 Then
;~         0xFF0000($sFile, 0, 0, 320, 115, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS)) ; Make Sure You Set The Correct Width & Height.
;~     EndIf




$sWeak = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/weak')
$sStrong = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/strong')

$aBetweenWeak = _StringBetween($sWeak, "a class='left' href='/champions/", "'><div")
$aBetweenStrong = _StringBetween($sStrong, "a class='left' href='/champions/", "'><div")


$idListview = GUICtrlCreateListView("", 2, 2, 210, 425)
  ; Enable extended control styles
    _GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))



	_GDIPlus_Startup()
	Local  $STM_SETIMAGE = 0x0172
	Local $hBmp = _GDIPlus_BitmapCreateFromMemory(InetRead("https://raw.githubusercontent.com/Gravebot/Gravebot/master/web/images/leagueoflegends/champs/" & StringLower($sChampion) & ".png"), True) ;to load an image from the net
	Global  $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	Global  $iWidth = _GDIPlus_ImageGetWidth($hBitmap)
	Global  $iHeight = _GDIPlus_ImageGetHeight($hBitmap)
	Global  $idPic = GUICtrlCreatePic("", 250, 150, $iWidth, $iHeight)
	_WinAPI_DeleteObject(GUICtrlSendMsg($idPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp))



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