#include "mex.h"
#include "matrix.h"

/* 
This is a naive implementation of stick-breaking.
It ONLY takes normalized probability vectors and requires random numbers as argument.
*/

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *p, *r;
    double *c;

    p = mxGetDoubles(prhs[0]);
    r = mxGetDoubles(prhs[1]);

    mwSize H, W;
    H = mxGetM(prhs[0]);
    W = mxGetN(prhs[0]);

    plhs[0] = mxCreateDoubleMatrix(H, 1, mxREAL);
    c = mxGetDoubles(plhs[0]);

    double s;
    size_t h, w;

    for (h = 0; h < H; h++)
    {
        w = 0;
        s = p[h];
        while (r[h] > s)
        {
            r[h] -= s;
            w++;
            s = p[h + w * H];
        }
        c[h] = w + 1;
    }
}