/* FOO_OS -- ������� ������������ �������
 * (c) 2003, Kolia Morev <kolia39@mail.ru>
 *
 * ������� ������.
 */

#define VERSION "npuBeT u3 protected mode\n" \
                "build: "__TIME__", "__DATE__"\n"
#define GOODBYE "DocBuDaHu9I!!!\n"

void puts(char *string);

void main(void)
{
        puts(VERSION);
        puts(GOODBYE);
}




int pos = 640;

/* ������� ������ �� ����� */
#define putc(c,pos,attr)        \
        _AL = c;                \
        _AH = attr;             \
        _DI = pos;              \
        __asm stosw;

/* ������� �� ����� ������ � ������� �������
 * � �����������.
 */
void puts(char *string) 
{
        int i = 0;

        while(string[i]!=0) {
                _AL = string[i];
                if(_AL==0x0a) {
                        pos += 80*2 - pos%(80*2);
                } else {
                        putc(_AL,pos,7);
                        pos += 2;
                }
                i++;
        }
}

