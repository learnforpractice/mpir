/* 
mpz_get_ux(mpz z) -- return a uintmax_t integer that is the corresponding
least significant integer part of z, ignoring its sign.

Copyright 2011 Brian Gladman

This file is part of the GNU MP Library.

The GNU MP Library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or (at your
option) any later version.

The GNU MP Library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public License
along with the GNU MP Library; see the file COPYING.LIB.  If not, write to
the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA. */

#define HAVE_STDINT_H

#include "mpir.h"
#include "gmp-impl.h"

#ifdef HAVE_UINTMAX_T

#define NLIMBS ((8 * SIZEOF_UINTMAX + GMP_NUMB_BITS  - 1) / GMP_NUMB_BITS)

uintmax_t
mpz_get_ux (mpz_srcptr z)
{
#if GMP_NUMB_BITS >= 8 * SIZEOF_UINTMAX
    return (uintmax_t)(z->_mp_size ? z->_mp_d[0] : 0);
#else
    uintmax_t v = 0, n = MIN(NLIMBS, ABS(z->_mp_size));
    while(n--)
        v = (v << GMP_NUMB_BITS) | z->_mp_d[n];
    return v;
#endif
}

#endif
