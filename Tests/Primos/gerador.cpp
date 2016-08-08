#include<stdio.h>

int main()
{
    int i=2;
    int b=2;
    int c=0;
    char q;
    while(1)
    {
        while(b<i)
        
        {
            if(i % b == 0)
            {
                c=1;
                printf("%d", i);
                break;
            }
            b++;
        }

        b=2;

        if(c==0)
        {
            printf("%d", i);
            q=getchar();
            if(q=='q')
                return 0;
        }

        c=0;

        i++;
    }
    
    return 1;
}
