#define WINVER          0x0500
#define _WIN32_WINNT    0x0501
#define _WIN32_IE       0x0501
#define _RICHEDIT_VER   0x0200

#if defined _M_IX86
  #pragma comment(linker, "/manifestdependency:\"type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='x86' publicKeyToken='6595b64144ccf1df' language='*'\"")
#elif defined _M_IA64
  #pragma comment(linker, "/manifestdependency:\"type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='ia64' publicKeyToken='6595b64144ccf1df' language='*'\"")
#elif defined _M_X64
  #pragma comment(linker, "/manifestdependency:\"type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='amd64' publicKeyToken='6595b64144ccf1df' language='*'\"")
#else
  #pragma comment(linker, "/manifestdependency:\"type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"")
#endif

//#pragma comment(linker, "/entry:WinMainCRTStartup /subsystem:console")
//#pragma comment(lib, "../OutputDebug/Test.lib")

#include <windows.h>
#include <stdio.h>
#include <memory.h>
#include <string.h>

extern     int my_sum(int,int);
extern "C" int my_sub(int,int);
extern     int my_mul(int,int);
extern "C" int my_div(int,int);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE /*hPrevInstance*/, LPTSTR lpstrCmdLine, int nCmdShow)
{
	char text[1024];
	int a,b;


	a=2;
	b=2;

	sprintf(text, 
		"sum(%d,%d)=%d\r\n" 
		"sub(%d,%d)=%d\r\n" 
		"mul(%d,%d)=%d\r\n" 
		"div(%d,%d)=%d", 
		a,b,my_sum(a,b), 
		a,b,my_sub(a,b), 
		a,b,my_mul(a,b), 
		a,b,my_div(a,b)
		);

	MessageBox (NULL, text, "test", MB_OK);

	return 0;
}
