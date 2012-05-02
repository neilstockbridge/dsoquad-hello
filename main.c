
#include "BIOS.h"

#define  TRUE  1

#define  BLACK  0x0000
#define  WHITE  0xffff

#define  SCREEN_WIDTH   400
#define  SCREEN_HEIGHT  240

int main()
{
  __Clear_Screen( BLACK);
  int  x = (SCREEN_WIDTH - 8*20) / 2; // 22 is strlen("Hello DSO Quad World")
  int  y = (SCREEN_HEIGHT - FONT_HEIGHT) / 2;
  __Display_Str( x, y, WHITE, 0, "Hello DSO Quad World");
  while( TRUE)
  {
  }
}

