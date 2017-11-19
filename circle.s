	.file	"circle.c"
	.comm	dpy,8,8
	.comm	win,8,8
	.comm	gc,8,8
	.comm	backBuffer,8,8
	.comm	swapInfo,16,16
	.globl	xres
	.data
	.align 4
	.type	xres, @object
	.size	xres, 4
xres:
	.long	640
	.globl	yres
	.align 4
	.type	yres, @object
	.size	yres, 4
yres:
	.long	480
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$208, %rsp
	movl	$0, -4(%rbp)
	movl	$0, %edi
	call	time
	movl	%eax, %edi
	call	srand
	movl	$0, %eax
	call	initializeX11
	jmp	.L2
.L5:
	jmp	.L3
.L4:
	movq	dpy(%rip), %rax
	leaq	-208(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XNextEvent
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkResize
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkMouse
	leaq	-208(%rbp), %rax
	movq	%rax, %rdi
	call	checkKeys
	movl	%eax, -4(%rbp)
.L3:
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XPending
	testl	%eax, %eax
	jne	.L4
	movl	$0, %eax
	call	physics
	movl	$0, %eax
	call	render
	movq	dpy(%rip), %rax
	movl	$1, %edx
	movl	$swapInfo, %esi
	movq	%rax, %rdi
	call	XdbeSwapBuffers
	movl	$2000, %edi
	call	usleep
.L2:
	cmpl	$0, -4(%rbp)
	je	.L5
	movl	$0, %eax
	call	cleanupX11
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC0:
	.string	"2240 lab"
	.text
	.globl	setWindowTitle
	.type	setWindowTitle, @function
setWindowTitle:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	win(%rip), %rcx
	movq	dpy(%rip), %rax
	movl	$.LC0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XStoreName
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	setWindowTitle, .-setWindowTitle
	.section	.rodata
	.align 8
.LC1:
	.string	"Error: unable to fetch Xdbe Version."
	.text
	.globl	initializeX11
	.type	initializeX11, @function
initializeX11:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movl	$0, %edi
	call	XOpenDisplay
	movq	%rax, dpy(%rip)
	movq	$163919, -56(%rbp)
	movl	$2, -88(%rbp)
	movl	$1, -64(%rbp)
	movl	$0, -40(%rbp)
	movq	$0, -120(%rbp)
	movq	dpy(%rip), %rax
	movq	232(%rax), %rdx
	movq	dpy(%rip), %rax
	movl	224(%rax), %eax
	cltq
	salq	$7, %rax
	addq	%rdx, %rax
	movq	16(%rax), %rax
	movq	%rax, -8(%rbp)
	movl	yres(%rip), %eax
	movl	%eax, %edi
	movl	xres(%rip), %eax
	movl	%eax, %ecx
	movq	dpy(%rip), %rax
	movq	-8(%rbp), %rsi
	leaq	-128(%rbp), %rdx
	pushq	%rdx
	pushq	$3650
	pushq	$0
	pushq	$1
	pushq	$0
	pushq	$0
	movl	%edi, %r9d
	movl	%ecx, %r8d
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateWindow
	addq	$48, %rsp
	movq	%rax, win(%rip)
	movq	win(%rip), %rsi
	movq	dpy(%rip), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	XCreateGC
	movq	%rax, gc(%rip)
	movq	dpy(%rip), %rax
	leaq	-136(%rbp), %rdx
	leaq	-132(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XdbeQueryExtension
	testl	%eax, %eax
	jne	.L9
	movl	$.LC1, %edi
	call	puts
	movq	gc(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XFreeGC
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XDestroyWindow
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XCloseDisplay
	movl	$1, %edi
	call	exit
.L9:
	movq	win(%rip), %rcx
	movq	dpy(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XdbeAllocateBackBufferName
	movq	%rax, backBuffer(%rip)
	movq	backBuffer(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XdbeGetBackBufferAttributes
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, swapInfo(%rip)
	movb	$0, swapInfo+8(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	XFree
	movl	$0, %eax
	call	setWindowTitle
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XMapWindow
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XRaiseWindow
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	initializeX11, .-initializeX11
	.section	.rodata
	.align 8
.LC2:
	.string	"Error: deallocating backBuffer!"
	.text
	.globl	cleanupX11
	.type	cleanupX11, @function
cleanupX11:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	backBuffer(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XdbeDeallocateBackBufferName
	testl	%eax, %eax
	jne	.L11
	movl	$.LC2, %edi
	call	puts
.L11:
	movq	gc(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XFreeGC
	movq	win(%rip), %rdx
	movq	dpy(%rip), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XDestroyWindow
	movq	dpy(%rip), %rax
	movq	%rax, %rdi
	call	XCloseDisplay
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	cleanupX11, .-cleanupX11
	.globl	checkResize
	.type	checkResize, @function
checkResize:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -104(%rbp)
	movq	-104(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$22, %eax
	jne	.L12
	movq	-104(%rbp), %rax
	movq	(%rax), %rdx
	movq	%rdx, -96(%rbp)
	movq	8(%rax), %rdx
	movq	%rdx, -88(%rbp)
	movq	16(%rax), %rdx
	movq	%rdx, -80(%rbp)
	movq	24(%rax), %rdx
	movq	%rdx, -72(%rbp)
	movq	32(%rax), %rdx
	movq	%rdx, -64(%rbp)
	movq	40(%rax), %rdx
	movq	%rdx, -56(%rbp)
	movq	48(%rax), %rdx
	movq	%rdx, -48(%rbp)
	movq	56(%rax), %rdx
	movq	%rdx, -40(%rbp)
	movq	64(%rax), %rdx
	movq	%rdx, -32(%rbp)
	movq	72(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movq	80(%rax), %rax
	movq	%rax, -16(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, xres(%rip)
	movl	-36(%rbp), %eax
	movl	%eax, yres(%rip)
	movl	$0, %eax
	call	setWindowTitle
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	checkResize, .-checkResize
	.globl	clearScreen
	.type	clearScreen, @function
clearScreen:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	gc(%rip), %rcx
	movq	dpy(%rip), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground
	movl	yres(%rip), %eax
	movl	%eax, %ecx
	movl	xres(%rip), %eax
	movl	%eax, %edi
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	subq	$8, %rsp
	pushq	%rcx
	movl	%edi, %r9d
	movl	$0, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	XFillRectangle
	addq	$16, %rsp
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	clearScreen, .-clearScreen
	.globl	setColor
	.type	setColor, @function
setColor:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movq	$0, -8(%rbp)
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	salq	$8, -8(%rbp)
	movl	-24(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	salq	$8, -8(%rbp)
	movl	-28(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	movq	gc(%rip), %rcx
	movq	dpy(%rip), %rax
	movq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	XSetForeground
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	setColor, .-setColor
	.globl	checkMouse
	.type	checkMouse, @function
checkMouse:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$5, %eax
	jne	.L18
	jmp	.L17
.L18:
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$4, %eax
	movq	-8(%rbp), %rax
	movl	64(%rax), %edx
	movl	savex.6479(%rip), %eax
	cmpl	%eax, %edx
	jne	.L21
	movq	-8(%rbp), %rax
	movl	68(%rax), %edx
	movl	savey.6480(%rip), %eax
	cmpl	%eax, %edx
	je	.L17
.L21:
	movq	-8(%rbp), %rax
	movl	64(%rax), %eax
	movl	%eax, savex.6479(%rip)
	movq	-8(%rbp), %rax
	movl	68(%rax), %eax
	movl	%eax, savey.6480(%rip)
.L17:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	checkMouse, .-checkMouse
	.globl	checkKeys
	.type	checkKeys, @function
checkKeys:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	XLookupKeysym
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	cmpl	$65307, %eax
	je	.L24
	cmpl	$65307, %eax
	jg	.L25
	cmpl	$97, %eax
	jmp	.L23
.L25:
	subl	$65361, %eax
	cmpl	$3, %eax
	ja	.L23
	jmp	.L23
.L24:
	movl	$1, %eax
	jmp	.L28
.L23:
	movl	$0, %eax
.L28:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	checkKeys, .-checkKeys
	.globl	physics
	.type	physics, @function
physics:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	physics, .-physics
	.globl	setPixel
	.type	setPixel, @function
setPixel:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	movl	-8(%rbp), %edi
	movl	-4(%rbp), %ecx
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	XDrawPoint
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	setPixel, .-setPixel
	.globl	BresenhamCircle
	.type	BresenhamCircle, @function
BresenhamCircle:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movl	%edx, -60(%rbp)
	movl	$0, -4(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-60(%rbp), %eax
	addl	%eax, %eax
	movl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -12(%rbp)
	jmp	.L32
.L35:
	movl	-52(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
	movl	-52(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-52(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -24(%rbp)
	movl	-52(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-56(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -32(%rbp)
	movl	-56(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-56(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -40(%rbp)
	movl	-56(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-16(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-16(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	cmpl	$0, -12(%rbp)
	jns	.L33
	movl	-4(%rbp), %eax
	sall	$2, %eax
	addl	$6, %eax
	addl	%eax, -12(%rbp)
	jmp	.L34
.L33:
	movl	-8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, -8(%rbp)
	movl	-4(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	$10, %eax
	addl	%eax, -12(%rbp)
.L34:
	addl	$1, -4(%rbp)
.L32:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jle	.L35
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	BresenhamCircle, .-BresenhamCircle
	.globl	inlineBresenhamCircle
	.type	inlineBresenhamCircle, @function
inlineBresenhamCircle:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	movl	%edx, -60(%rbp)
	movl	$0, -4(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-60(%rbp), %eax
	addl	%eax, %eax
	movl	$3, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -12(%rbp)
	jmp	.L37
.L40:
	movl	-52(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
	movl	-52(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-52(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -24(%rbp)
	movl	-52(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-56(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -32(%rbp)
	movl	-56(%rbp), %eax
	subl	-4(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-56(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -40(%rbp)
	movl	-56(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-16(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-16(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-20(%rbp), %edx
	movl	-44(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-24(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	movl	-28(%rbp), %edx
	movl	-36(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	setPixel
	cmpl	$0, -12(%rbp)
	jns	.L38
#APP
# 281 "circle.c" 1
	mov $200, %rdi
# 0 "" 2
#NO_APP
	movl	-4(%rbp), %eax
	sall	$2, %eax
	addl	$6, %eax
	addl	%eax, -12(%rbp)
	jmp	.L39
.L38:
	movl	-8(%rbp), %eax
	leal	-1(%rax), %edx
	movl	%edx, -8(%rbp)
	movl	-4(%rbp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	$10, %eax
	addl	%eax, -12(%rbp)
.L39:
	addl	$1, -4(%rbp)
.L37:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jle	.L40
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	inlineBresenhamCircle, .-inlineBresenhamCircle
	.globl	render
	.type	render, @function
render:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, %eax
	call	clearScreen
	movl	$200, -4(%rbp)
	movl	$200, -8(%rbp)
	movl	$255, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-8(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	showDot
	movl	$255, %edx
	movl	$200, %esi
	movl	$160, %edi
	call	setColor
	movabsq	$7882179172777484620, %rax
	movq	%rax, -32(%rbp)
	movabsq	$13568189076960112, %rax
	movq	%rax, -24(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, %edi
	movq	gc(%rip), %rdx
	movq	backBuffer(%rip), %rsi
	movq	dpy(%rip), %rax
	subq	$8, %rsp
	leaq	-32(%rbp), %rcx
	pushq	%rdi
	movq	%rcx, %r9
	movl	$15, %r8d
	movl	$15, %ecx
	movq	%rax, %rdi
	call	XDrawString
	addq	$16, %rsp
	movl	$0, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	movl	$160, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	movl	$10, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movl	$0, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	movl	$100, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	movl	$10, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	BresenhamCircle
	movl	$0, %edx
	movl	$255, %esi
	movl	$255, %edi
	call	setColor
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	movl	$148, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	inlineBresenhamCircle
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	render, .-render
	.local	savex.6479
	.comm	savex.6479,4,4
	.local	savey.6480
	.comm	savey.6480,4,4
	.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
