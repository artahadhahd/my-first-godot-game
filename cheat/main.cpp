#include <Windows.h>
#include <cstdio>

int
main ()
{
    STARTUPINFO SI;
    PROCESS_INFORMATION PI;
    memset(&SI,0,sizeof(SI));
    memset(&PI,0,sizeof(PI));
    SI.cb = sizeof(SI);
    if(!CreateProcess(NULL, (char *)"Notepad.exe", NULL, NULL, false, 0, NULL, NULL, &SI, &PI)) {
        printf("Error %d",GetLastError());
        return 1;
    }
    DWORD ExitCode;
    do
    {
        GetExitCodeProcess(PI.hProcess, &ExitCode);
        Sleep(100);
    } while (ExitCode == STILL_ACTIVE);
}