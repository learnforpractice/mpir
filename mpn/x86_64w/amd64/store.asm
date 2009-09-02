
;  mpn_store

;  Copyright 2009 Jason Moxham

;  This file is part of the MPIR Library.
;  The MPIR Library is free software; you can redistribute it and/or modify
;  it under the terms of the GNU Lesser General Public License as published
;  by the Free Software Foundation; either verdxon 2.1 of the License, or (at
;  your option) any later verdxon.
;  The MPIR Library is distributed in the hope that it will be useful, but
;  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
;  License for more details.
;  You should have received a copy of the GNU Lesser General Public License
;  along with the MPIR Library; see the file COPYING.LIB.  If not, write
;  to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;  Boston, MA 02110-1301, USA.
;
;	mpn_store(mp_ptr rcx ,mp_size_t rdx, mp_limb_t rax)
;	(rcx,rdx)=rax

%include "..\yasm_mac.inc"

    CPU  Core2
    BITS 64

	LEAF_PROC mpn_store
	movsxd  rax, edx
	mov	    rdx, 3
	lea	    rcx, [rcx+rax*8-24]
	sub     rdx, rax
	mov     rax, r8
	jnc     L_skiplp
	xalign  16
L_lp:
	add	    rdx, 4
	mov	    [rcx+rdx*8-32], rax
	mov	    [rcx+rdx*8+8-32], rax
	mov	    [rcx+rdx*8+16-32], rax
	mov	    [rcx+rdx*8+24-32], rax
	jnc     L_lp
L_skiplp:
	cmp     rdx, 2
	ja	    theend
	mov	    [rcx+rdx*8], rax
	je	    theend
	mov	    [rcx+rdx*8+8], rax
	jp	    theend
	mov	    [rcx+rdx*8+16], rax
theend:
	ret
	end
