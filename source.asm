.386
.model flat, stdcall
option casemap : none

include \masm32\include\windows.inc
include \masm32\macros\macros.asm
uselib kernel32, user32, masm32, comctl32

.data 

    hUSER32 dd ?
    hMSGBOX dd ? 
    
    pszUSER32 db 'user32.dll', 0 
    pszMSGBOX db 'MessageBoxA', 0 
    
    
    pszSuccessCaption db 'OK', 0 
    pszSuccessMessage db 'Function successfully imported and called', 0 
    
    
.code

error:

    push EXIT_FAILURE
    call ExitProcess
    
start:
    
    push offset pszUSER32  
    call LoadLibraryA
    
    cmp eax, NULL
    jz error
    
    mov hUSER32, eax 

    
    push offset pszMSGBOX 
    push hUSER32
    call GetProcAddress
    
    cmp eax, NULL
    jz error
    
    mov hMSGBOX, eax
    
    push MB_OK + MB_ICONINFORMATION
    push offset pszSuccessCaption
    push offset pszSuccessMessage
    push NULL
    
    call hMSGBOX
     
    ret
    end start