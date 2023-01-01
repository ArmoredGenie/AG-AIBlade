/*
Original code by Newbitcat from from https://www.autohotkey.com/boards/viewtopic.php?t=84389, 
modified by ArmoredGenie for AG-AIblade project
Thank you - Most of this started from https://www.autohotkey.com/boards/viewtopic.php?t=14978
*/

/* Instructions
Find what comm port arduino is sitting at (My arduino is at port 3. NOTE: Only port 1 to 9 works, nothing higher. )
open notepad, and write the following into this file :
	Echo off
	MODE COM3:115200,N,8,1
Name it Set_COM3.bat (make sure extension is .bat not .txt!) and place into root of  C drive. Example:
	Set_COM3.bat

Important NOTES:
- The second PC sees the arduino as a keyboard so mouse button keybinds are not supported on the second PC. You need 
  to bind a keyboard key to "fire all weapons" in the second PC's game options - I used "\"
- if you want different KB/mouse controls on the main PC, you will need to edit the blocks in the main loop section
- Use a controller remapping program like Joystick Gremlin/T.A.R.G.E.T/Joytokey to press the keyboard/mouse keys 
  when joystick buttons are pressed on main PC - in autohotkey you can use joystick buttons directly instead of 
  keyboard key presses too - see Ahutohotkey documentation (untested).

Controls:
right mouse button to press "\" on second PC for fire
"t" on main PC to press "t" on second PC for target
"'" on main PC to press "c" on second PC for center turret
*/


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
#HotkeyInterval 2000
#MaxHotkeysPerInterval 2000

RUN C:\Set_COM3.bat
sleep , 2000
port := FileOpen("COM3", "w") ; Open for writing only, not reading/appending.

loop {

~':: ; apostrophe key pressed...
port := FileOpen("COM3", "w") ; Open for writing only, not reading/appending.
while(getKeyState("'")){    ;loop to keep pressing key while key is held
	port.Write("c") ; Write a letter to serial. Change character in quotes to send different key
	port.__Handle ; This flushes the write buffer.
}
port.Close() ; close the Port
return

~t:: ; t key pressed
port := FileOpen("COM3", "w") ; Open for writing only, not reading/appending.
port.Write("t") ; Write a letter to serial. Change character in quotes to send different key
port.__Handle ; This flushes the write buffer.
port.Close() ; and close the Port
return

~RButton:: ; Right Mouse Button pressed
port := FileOpen("COM3", "w") ; Open for writing only, not reading/appending.
while(getKeyState("RButton")){    ;loop to keep pressing key while mouse button is held
	port.Write("\") ; Write a letter to serial. Change character in quotes to send different key
	port.__Handle ; This flushes the write buffer.
}
port.Close() ; and close the Port
return

}

^q::ExitApp		; Control Q to exit