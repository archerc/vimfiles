" Use gvim as an external editor for Windows apps
" See https://vim.fandom.com/wiki/Use_gvim_as_an_external_editor_for_Windows_apps
"
"
" Script setupEdit
" 
" Download the following scripts and place them in your Vim plugin directory:
" 
"     clipbrd.vim
"     genutils.vim
"     multvals.vim 
" 
" The vbscript below should be saved as something like runvim.vbs and put it in a directory such as C:\Program Files\Vim\Vim63. Modify the run line to show the correct path to your gvim executable. Create a shortcut to runvim.vbs on your desktop. Right-click on the shortcut, select "Properties" from the context menu, click the "Shortcut" tab and add a "Shortcut Key" – something like "Ctrl-Alt-V". 
"
" 
" ```vb
" set oShell = CreateObject("WScript.Shell")
" oShell.SendKeys"^a"
" oShell.SendKeys"^c"
" oShell.SendKeys"^{Home}"
" ReturnCode = oShell.run ("""C:\\Program Files\\Vim\\Vim63\\Gvim.exe"" +ClipBrd +only",0,True)
" oShell.SendKeys"^a"
" oShell.SendKeys"^v"
" oShell.SendKeys"^{Home}"
" ```
