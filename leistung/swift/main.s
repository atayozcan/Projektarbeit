
main:     file format elf64-x86-64


Disassembly of section .init:

0000000000000d38 <_init>:
 d38:	f3 0f 1e fa          	endbr64
 d3c:	48 83 ec 08          	sub    $0x8,%rsp
 d40:	48 8b 05 49 22 00 00 	mov    0x2249(%rip),%rax        # 2f90 <__gmon_start__>
 d47:	48 85 c0             	test   %rax,%rax
 d4a:	74 02                	je     d4e <_init+0x16>
 d4c:	ff d0                	call   *%rax
 d4e:	48 83 c4 08          	add    $0x8,%rsp
 d52:	c3                   	ret

Disassembly of section .plt:

0000000000000d60 <swift_addNewDSOImage@plt-0x10>:
 d60:	ff 35 8a 22 00 00    	push   0x228a(%rip)        # 2ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
 d66:	ff 25 8c 22 00 00    	jmp    *0x228c(%rip)        # 2ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
 d6c:	90                   	nop
 d6d:	90                   	nop
 d6e:	90                   	nop
 d6f:	90                   	nop

0000000000000d70 <swift_addNewDSOImage@plt>:
 d70:	ff 25 8a 22 00 00    	jmp    *0x228a(%rip)        # 3000 <swift_addNewDSOImage>
 d76:	68 00 00 00 00       	push   $0x0
 d7b:	e9 e0 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000d80 <swift_getTypeByMangledNameInContext2@plt>:
 d80:	ff 25 82 22 00 00    	jmp    *0x2282(%rip)        # 3008 <swift_getTypeByMangledNameInContext2>
 d86:	68 01 00 00 00       	push   $0x1
 d8b:	e9 d0 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000d90 <$sSa28_allocateBufferUninitialized15minimumCapacitys016_ContiguousArrayB0VyxGSi_tFZ@plt>:
 d90:	ff 25 7a 22 00 00    	jmp    *0x227a(%rip)        # 3010 <$sSa28_allocateBufferUninitialized15minimumCapacitys016_ContiguousArrayB0VyxGSi_tFZ>
 d96:	68 02 00 00 00       	push   $0x2
 d9b:	e9 c0 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000da0 <memset@plt>:
 da0:	ff 25 72 22 00 00    	jmp    *0x2272(%rip)        # 3018 <memset@GLIBC_2.2.5>
 da6:	68 03 00 00 00       	push   $0x3
 dab:	e9 b0 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000db0 <swift_release@plt>:
 db0:	ff 25 6a 22 00 00    	jmp    *0x226a(%rip)        # 3020 <swift_release>
 db6:	68 04 00 00 00       	push   $0x4
 dbb:	e9 a0 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000dc0 <swift_allocObject@plt>:
 dc0:	ff 25 62 22 00 00    	jmp    *0x2262(%rip)        # 3028 <swift_allocObject>
 dc6:	68 05 00 00 00       	push   $0x5
 dcb:	e9 90 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>:
 dd0:	ff 25 5a 22 00 00    	jmp    *0x225a(%rip)        # 3030 <$ss5print_9separator10terminatoryypd_S2StF>
 dd6:	68 06 00 00 00       	push   $0x6
 ddb:	e9 80 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000de0 <$ss11_StringGutsV4growyySiF@plt>:
 de0:	ff 25 52 22 00 00    	jmp    *0x2252(%rip)        # 3038 <$ss11_StringGutsV4growyySiF>
 de6:	68 07 00 00 00       	push   $0x7
 deb:	e9 70 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000df0 <swift_bridgeObjectRelease@plt>:
 df0:	ff 25 4a 22 00 00    	jmp    *0x224a(%rip)        # 3040 <swift_bridgeObjectRelease>
 df6:	68 08 00 00 00       	push   $0x8
 dfb:	e9 60 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000e00 <$ss23CustomStringConvertibleP11descriptionSSvgTj@plt>:
 e00:	ff 25 42 22 00 00    	jmp    *0x2242(%rip)        # 3048 <$ss23CustomStringConvertibleP11descriptionSSvgTj>
 e06:	68 09 00 00 00       	push   $0x9
 e0b:	e9 50 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000e10 <$sSS6appendyySSF@plt>:
 e10:	ff 25 3a 22 00 00    	jmp    *0x223a(%rip)        # 3050 <$sSS6appendyySSF>
 e16:	68 0a 00 00 00       	push   $0xa
 e1b:	e9 40 ff ff ff       	jmp    d60 <_init+0x28>

0000000000000e20 <$s20FoundationEssentials4DateVACycfC@plt>:
 e20:	ff 25 32 22 00 00    	jmp    *0x2232(%rip)        # 3058 <$s20FoundationEssentials4DateVACycfC>
 e26:	68 0b 00 00 00       	push   $0xb
 e2b:	e9 30 ff ff ff       	jmp    d60 <_init+0x28>

Disassembly of section .text:

0000000000000e30 <_start>:
     e30:	f3 0f 1e fa          	endbr64
     e34:	31 ed                	xor    %ebp,%ebp
     e36:	49 89 d1             	mov    %rdx,%r9
     e39:	5e                   	pop    %rsi
     e3a:	48 89 e2             	mov    %rsp,%rdx
     e3d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
     e41:	50                   	push   %rax
     e42:	54                   	push   %rsp
     e43:	45 31 c0             	xor    %r8d,%r8d
     e46:	31 c9                	xor    %ecx,%ecx
     e48:	48 8d 3d 51 05 00 00 	lea    0x551(%rip),%rdi        # 13a0 <main>
     e4f:	ff 15 33 21 00 00    	call   *0x2133(%rip)        # 2f88 <__libc_start_main@GLIBC_2.34>
     e55:	f4                   	hlt
     e56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     e5d:	00 00 00 

0000000000000e60 <deregister_tm_clones>:
     e60:	48 8d 3d 19 22 00 00 	lea    0x2219(%rip),%rdi        # 3080 <completed.0>
     e67:	48 8d 05 12 22 00 00 	lea    0x2212(%rip),%rax        # 3080 <completed.0>
     e6e:	48 39 f8             	cmp    %rdi,%rax
     e71:	74 15                	je     e88 <deregister_tm_clones+0x28>
     e73:	48 8b 05 1e 21 00 00 	mov    0x211e(%rip),%rax        # 2f98 <_ITM_deregisterTMCloneTable>
     e7a:	48 85 c0             	test   %rax,%rax
     e7d:	74 09                	je     e88 <deregister_tm_clones+0x28>
     e7f:	ff e0                	jmp    *%rax
     e81:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
     e88:	c3                   	ret
     e89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000000e90 <register_tm_clones>:
     e90:	48 8d 3d e9 21 00 00 	lea    0x21e9(%rip),%rdi        # 3080 <completed.0>
     e97:	48 8d 35 e2 21 00 00 	lea    0x21e2(%rip),%rsi        # 3080 <completed.0>
     e9e:	48 29 fe             	sub    %rdi,%rsi
     ea1:	48 89 f0             	mov    %rsi,%rax
     ea4:	48 c1 ee 3f          	shr    $0x3f,%rsi
     ea8:	48 c1 f8 03          	sar    $0x3,%rax
     eac:	48 01 c6             	add    %rax,%rsi
     eaf:	48 d1 fe             	sar    $1,%rsi
     eb2:	74 14                	je     ec8 <register_tm_clones+0x38>
     eb4:	48 8b 05 e5 20 00 00 	mov    0x20e5(%rip),%rax        # 2fa0 <_ITM_registerTMCloneTable>
     ebb:	48 85 c0             	test   %rax,%rax
     ebe:	74 08                	je     ec8 <register_tm_clones+0x38>
     ec0:	ff e0                	jmp    *%rax
     ec2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     ec8:	c3                   	ret
     ec9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000000ed0 <__do_global_dtors_aux>:
     ed0:	f3 0f 1e fa          	endbr64
     ed4:	80 3d a5 21 00 00 00 	cmpb   $0x0,0x21a5(%rip)        # 3080 <completed.0>
     edb:	75 33                	jne    f10 <__do_global_dtors_aux+0x40>
     edd:	55                   	push   %rbp
     ede:	48 83 3d c2 20 00 00 	cmpq   $0x0,0x20c2(%rip)        # 2fa8 <__cxa_finalize@GLIBC_2.2.5>
     ee5:	00 
     ee6:	48 89 e5             	mov    %rsp,%rbp
     ee9:	74 0d                	je     ef8 <__do_global_dtors_aux+0x28>
     eeb:	48 8b 3d 76 21 00 00 	mov    0x2176(%rip),%rdi        # 3068 <__dso_handle>
     ef2:	ff 15 b0 20 00 00    	call   *0x20b0(%rip)        # 2fa8 <__cxa_finalize@GLIBC_2.2.5>
     ef8:	e8 63 ff ff ff       	call   e60 <deregister_tm_clones>
     efd:	c6 05 7c 21 00 00 01 	movb   $0x1,0x217c(%rip)        # 3080 <completed.0>
     f04:	5d                   	pop    %rbp
     f05:	c3                   	ret
     f06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
     f0d:	00 00 00 
     f10:	c3                   	ret
     f11:	0f 1f 40 00          	nopl   0x0(%rax)
     f15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
     f1c:	00 00 00 00 

0000000000000f20 <frame_dummy>:
     f20:	f3 0f 1e fa          	endbr64
     f24:	e9 67 ff ff ff       	jmp    e90 <register_tm_clones>
     f29:	0f 1f 00             	nopl   (%rax)
     f2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000000f30 <_ZL23swift_image_constructorv>:
     f30:	55                   	push   %rbp
     f31:	48 89 e5             	mov    %rsp,%rbp
     f34:	48 c7 05 49 21 00 00 	movq   $0x4,0x2149(%rip)        # 3088 <_ZN12_GLOBAL__N_18sectionsE>
     f3b:	04 00 00 00 
     f3f:	48 8d 3d 42 21 00 00 	lea    0x2142(%rip),%rdi        # 3088 <_ZN12_GLOBAL__N_18sectionsE>
     f46:	48 8d 05 1b 21 00 00 	lea    0x211b(%rip),%rax        # 3068 <__dso_handle>
     f4d:	48 89 05 3c 21 00 00 	mov    %rax,0x213c(%rip)        # 3090 <_ZN12_GLOBAL__N_18sectionsE+0x8>
     f54:	48 c7 05 39 21 00 00 	movq   $0x0,0x2139(%rip)        # 3098 <_ZN12_GLOBAL__N_18sectionsE+0x10>
     f5b:	00 00 00 00 
     f5f:	48 c7 05 36 21 00 00 	movq   $0x0,0x2136(%rip)        # 30a0 <_ZN12_GLOBAL__N_18sectionsE+0x18>
     f66:	00 00 00 00 
     f6a:	48 8d 05 2f 09 00 00 	lea    0x92f(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     f71:	48 89 05 30 21 00 00 	mov    %rax,0x2130(%rip)        # 30a8 <_ZN12_GLOBAL__N_18sectionsE+0x20>
     f78:	48 8d 0d 21 09 00 00 	lea    0x921(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     f7f:	48 29 c1             	sub    %rax,%rcx
     f82:	48 89 0d 27 21 00 00 	mov    %rcx,0x2127(%rip)        # 30b0 <_ZN12_GLOBAL__N_18sectionsE+0x28>
     f89:	48 8d 05 10 09 00 00 	lea    0x910(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     f90:	48 89 05 21 21 00 00 	mov    %rax,0x2121(%rip)        # 30b8 <_ZN12_GLOBAL__N_18sectionsE+0x30>
     f97:	48 8d 0d 02 09 00 00 	lea    0x902(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     f9e:	48 29 c1             	sub    %rax,%rcx
     fa1:	48 89 0d 18 21 00 00 	mov    %rcx,0x2118(%rip)        # 30c0 <_ZN12_GLOBAL__N_18sectionsE+0x38>
     fa8:	48 8d 05 f1 08 00 00 	lea    0x8f1(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     faf:	48 89 05 12 21 00 00 	mov    %rax,0x2112(%rip)        # 30c8 <_ZN12_GLOBAL__N_18sectionsE+0x40>
     fb6:	48 8d 0d e3 08 00 00 	lea    0x8e3(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     fbd:	48 29 c1             	sub    %rax,%rcx
     fc0:	48 89 0d 09 21 00 00 	mov    %rcx,0x2109(%rip)        # 30d0 <_ZN12_GLOBAL__N_18sectionsE+0x48>
     fc7:	48 8d 05 d2 08 00 00 	lea    0x8d2(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     fce:	48 89 05 03 21 00 00 	mov    %rax,0x2103(%rip)        # 30d8 <_ZN12_GLOBAL__N_18sectionsE+0x50>
     fd5:	48 8d 0d ce 08 00 00 	lea    0x8ce(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
     fdc:	48 29 c1             	sub    %rax,%rcx
     fdf:	48 89 0d fa 20 00 00 	mov    %rcx,0x20fa(%rip)        # 30e0 <_ZN12_GLOBAL__N_18sectionsE+0x58>
     fe6:	48 8d 05 b3 08 00 00 	lea    0x8b3(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     fed:	48 89 05 f4 20 00 00 	mov    %rax,0x20f4(%rip)        # 30e8 <_ZN12_GLOBAL__N_18sectionsE+0x60>
     ff4:	48 8d 0d a5 08 00 00 	lea    0x8a5(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
     ffb:	48 29 c1             	sub    %rax,%rcx
     ffe:	48 89 0d eb 20 00 00 	mov    %rcx,0x20eb(%rip)        # 30f0 <_ZN12_GLOBAL__N_18sectionsE+0x68>
    1005:	48 8d 05 94 08 00 00 	lea    0x894(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    100c:	48 89 05 e5 20 00 00 	mov    %rax,0x20e5(%rip)        # 30f8 <_ZN12_GLOBAL__N_18sectionsE+0x70>
    1013:	48 8d 0d 86 08 00 00 	lea    0x886(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    101a:	48 29 c1             	sub    %rax,%rcx
    101d:	48 89 0d dc 20 00 00 	mov    %rcx,0x20dc(%rip)        # 3100 <_ZN12_GLOBAL__N_18sectionsE+0x78>
    1024:	48 8d 05 75 08 00 00 	lea    0x875(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    102b:	48 89 05 d6 20 00 00 	mov    %rax,0x20d6(%rip)        # 3108 <_ZN12_GLOBAL__N_18sectionsE+0x80>
    1032:	48 8d 0d 67 08 00 00 	lea    0x867(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    1039:	48 29 c1             	sub    %rax,%rcx
    103c:	48 89 0d cd 20 00 00 	mov    %rcx,0x20cd(%rip)        # 3110 <_ZN12_GLOBAL__N_18sectionsE+0x88>
    1043:	48 8d 05 60 08 00 00 	lea    0x860(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    104a:	48 89 05 c7 20 00 00 	mov    %rax,0x20c7(%rip)        # 3118 <_ZN12_GLOBAL__N_18sectionsE+0x90>
    1051:	48 8d 0d 52 08 00 00 	lea    0x852(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    1058:	48 29 c1             	sub    %rax,%rcx
    105b:	48 89 0d be 20 00 00 	mov    %rcx,0x20be(%rip)        # 3120 <_ZN12_GLOBAL__N_18sectionsE+0x98>
    1062:	48 8d 05 41 08 00 00 	lea    0x841(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    1069:	48 89 05 b8 20 00 00 	mov    %rax,0x20b8(%rip)        # 3128 <_ZN12_GLOBAL__N_18sectionsE+0xa0>
    1070:	48 8d 0d 33 08 00 00 	lea    0x833(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    1077:	48 29 c1             	sub    %rax,%rcx
    107a:	48 89 0d af 20 00 00 	mov    %rcx,0x20af(%rip)        # 3130 <_ZN12_GLOBAL__N_18sectionsE+0xa8>
    1081:	48 8d 05 18 08 00 00 	lea    0x818(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    1088:	48 89 05 a9 20 00 00 	mov    %rax,0x20a9(%rip)        # 3138 <_ZN12_GLOBAL__N_18sectionsE+0xb0>
    108f:	48 8d 0d 0a 08 00 00 	lea    0x80a(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    1096:	48 29 c1             	sub    %rax,%rcx
    1099:	48 89 0d a0 20 00 00 	mov    %rcx,0x20a0(%rip)        # 3140 <_ZN12_GLOBAL__N_18sectionsE+0xb8>
    10a0:	48 8d 05 f9 07 00 00 	lea    0x7f9(%rip),%rax        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    10a7:	48 89 05 9a 20 00 00 	mov    %rax,0x209a(%rip)        # 3148 <_ZN12_GLOBAL__N_18sectionsE+0xc0>
    10ae:	48 8d 0d eb 07 00 00 	lea    0x7eb(%rip),%rcx        # 18a0 <symbolic _____yypG s23_ContiguousArrayStorageC>
    10b5:	48 29 c1             	sub    %rax,%rcx
    10b8:	48 89 0d 91 20 00 00 	mov    %rcx,0x2091(%rip)        # 3150 <_ZN12_GLOBAL__N_18sectionsE+0xc8>
    10bf:	48 8d 05 e4 07 00 00 	lea    0x7e4(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    10c6:	48 89 05 8b 20 00 00 	mov    %rax,0x208b(%rip)        # 3158 <_ZN12_GLOBAL__N_18sectionsE+0xd0>
    10cd:	48 8d 0d d6 07 00 00 	lea    0x7d6(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    10d4:	48 29 c1             	sub    %rax,%rcx
    10d7:	48 89 0d 82 20 00 00 	mov    %rcx,0x2082(%rip)        # 3160 <_ZN12_GLOBAL__N_18sectionsE+0xd8>
    10de:	48 8d 05 c5 07 00 00 	lea    0x7c5(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    10e5:	48 89 05 7c 20 00 00 	mov    %rax,0x207c(%rip)        # 3168 <_ZN12_GLOBAL__N_18sectionsE+0xe0>
    10ec:	48 8d 0d b7 07 00 00 	lea    0x7b7(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    10f3:	48 29 c1             	sub    %rax,%rcx
    10f6:	48 89 0d 73 20 00 00 	mov    %rcx,0x2073(%rip)        # 3170 <_ZN12_GLOBAL__N_18sectionsE+0xe8>
    10fd:	48 8d 05 a6 07 00 00 	lea    0x7a6(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    1104:	48 89 05 6d 20 00 00 	mov    %rax,0x206d(%rip)        # 3178 <_ZN12_GLOBAL__N_18sectionsE+0xf0>
    110b:	48 8d 0d 98 07 00 00 	lea    0x798(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    1112:	48 29 c1             	sub    %rax,%rcx
    1115:	48 89 0d 64 20 00 00 	mov    %rcx,0x2064(%rip)        # 3180 <_ZN12_GLOBAL__N_18sectionsE+0xf8>
    111c:	48 8d 05 87 07 00 00 	lea    0x787(%rip),%rax        # 18aa <__start_swift5_accessible_functions>
    1123:	48 89 05 5e 20 00 00 	mov    %rax,0x205e(%rip)        # 3188 <_ZN12_GLOBAL__N_18sectionsE+0x100>
    112a:	48 8d 0d 79 07 00 00 	lea    0x779(%rip),%rcx        # 18aa <__start_swift5_accessible_functions>
    1131:	48 29 c1             	sub    %rax,%rcx
    1134:	48 89 0d 55 20 00 00 	mov    %rcx,0x2055(%rip)        # 3190 <_ZN12_GLOBAL__N_18sectionsE+0x108>
    113b:	5d                   	pop    %rbp
    113c:	e9 2f fc ff ff       	jmp    d70 <swift_addNewDSOImage@plt>
    1141:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    1148:	0f 1f 84 00 00 00 00 
    114f:	00 

0000000000001150 <__swift_instantiateConcreteTypeFromMangledName>:
    1150:	48 8b 07             	mov    (%rdi),%rax
    1153:	48 85 c0             	test   %rax,%rax
    1156:	78 01                	js     1159 <__swift_instantiateConcreteTypeFromMangledName+0x9>
    1158:	c3                   	ret
    1159:	55                   	push   %rbp
    115a:	48 89 e5             	mov    %rsp,%rbp
    115d:	53                   	push   %rbx
    115e:	50                   	push   %rax
    115f:	48 89 c6             	mov    %rax,%rsi
    1162:	48 c1 fe 20          	sar    $0x20,%rsi
    1166:	48 f7 de             	neg    %rsi
    1169:	48 98                	cltq
    116b:	48 01 f8             	add    %rdi,%rax
    116e:	48 89 fb             	mov    %rdi,%rbx
    1171:	48 89 c7             	mov    %rax,%rdi
    1174:	31 d2                	xor    %edx,%edx
    1176:	31 c9                	xor    %ecx,%ecx
    1178:	e8 03 fc ff ff       	call   d80 <swift_getTypeByMangledNameInContext2@plt>
    117d:	48 89 03             	mov    %rax,(%rbx)
    1180:	48 83 c4 08          	add    $0x8,%rsp
    1184:	5b                   	pop    %rbx
    1185:	5d                   	pop    %rbp
    1186:	c3                   	ret
    1187:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    118e:	00 00 

0000000000001190 <$s4main11sumOfPrimesys5Int64VSiF>:
    1190:	41 57                	push   %r15
    1192:	41 56                	push   %r14
    1194:	41 54                	push   %r12
    1196:	53                   	push   %rbx
    1197:	50                   	push   %rax
    1198:	49 89 ff             	mov    %rdi,%r15
    119b:	4c 8d 77 01          	lea    0x1(%rdi),%r14
    119f:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    11a6:	ff ff 7f 
    11a9:	48 39 c7             	cmp    %rax,%rdi
    11ac:	73 2f                	jae    11dd <$s4main11sumOfPrimesys5Int64VSiF+0x4d>
    11ae:	48 8b 35 fb 1d 00 00 	mov    0x1dfb(%rip),%rsi        # 2fb0 <$sSbN>
    11b5:	4c 89 f7             	mov    %r14,%rdi
    11b8:	e8 d3 fb ff ff       	call   d90 <$sSa28_allocateBufferUninitialized15minimumCapacitys016_ContiguousArrayB0VyxGSi_tFZ@plt>
    11bd:	48 89 c3             	mov    %rax,%rbx
    11c0:	4c 89 70 10          	mov    %r14,0x10(%rax)
    11c4:	c6 40 20 01          	movb   $0x1,0x20(%rax)
    11c8:	49 89 c4             	mov    %rax,%r12
    11cb:	49 83 c4 20          	add    $0x20,%r12
    11cf:	4d 85 ff             	test   %r15,%r15
    11d2:	75 21                	jne    11f5 <$s4main11sumOfPrimesys5Int64VSiF+0x65>
    11d4:	c6 43 20 00          	movb   $0x0,0x20(%rbx)
    11d8:	e9 9a 00 00 00       	jmp    1277 <$s4main11sumOfPrimesys5Int64VSiF+0xe7>
    11dd:	48 8b 1d d4 1d 00 00 	mov    0x1dd4(%rip),%rbx        # 2fb8 <_swiftEmptyArrayStorage>
    11e4:	4d 85 f6             	test   %r14,%r14
    11e7:	0f 84 82 00 00 00    	je     126f <$s4main11sumOfPrimesys5Int64VSiF+0xdf>
    11ed:	c6 43 20 01          	movb   $0x1,0x20(%rbx)
    11f1:	4c 8d 63 20          	lea    0x20(%rbx),%r12
    11f5:	48 8d 7b 21          	lea    0x21(%rbx),%rdi
    11f9:	be 01 00 00 00       	mov    $0x1,%esi
    11fe:	4c 89 fa             	mov    %r15,%rdx
    1201:	e8 9a fb ff ff       	call   da0 <memset@plt>
    1206:	66 c7 43 20 00 00    	movw   $0x0,0x20(%rbx)
    120c:	49 83 ff 04          	cmp    $0x4,%r15
    1210:	7d 17                	jge    1229 <$s4main11sumOfPrimesys5Int64VSiF+0x99>
    1212:	41 0f b6 44 24 02    	movzbl 0x2(%r12),%eax
    1218:	41 89 c6             	mov    %eax,%r14d
    121b:	45 01 f6             	add    %r14d,%r14d
    121e:	49 83 ff 02          	cmp    $0x2,%r15
    1222:	75 63                	jne    1287 <$s4main11sumOfPrimesys5Int64VSiF+0xf7>
    1224:	e9 5e 01 00 00       	jmp    1387 <$s4main11sumOfPrimesys5Int64VSiF+0x1f7>
    1229:	b9 04 00 00 00       	mov    $0x4,%ecx
    122e:	b8 02 00 00 00       	mov    $0x2,%eax
    1233:	eb 1a                	jmp    124f <$s4main11sumOfPrimesys5Int64VSiF+0xbf>
    1235:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    123c:	00 00 00 00 
    1240:	48 ff c0             	inc    %rax
    1243:	48 89 c1             	mov    %rax,%rcx
    1246:	48 0f af c8          	imul   %rax,%rcx
    124a:	4c 39 f9             	cmp    %r15,%rcx
    124d:	7f c3                	jg     1212 <$s4main11sumOfPrimesys5Int64VSiF+0x82>
    124f:	4c 39 f9             	cmp    %r15,%rcx
    1252:	7f ec                	jg     1240 <$s4main11sumOfPrimesys5Int64VSiF+0xb0>
    1254:	41 f6 04 04 01       	testb  $0x1,(%r12,%rax,1)
    1259:	74 e5                	je     1240 <$s4main11sumOfPrimesys5Int64VSiF+0xb0>
    125b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    1260:	41 c6 04 0c 00       	movb   $0x0,(%r12,%rcx,1)
    1265:	48 01 c1             	add    %rax,%rcx
    1268:	4c 39 f9             	cmp    %r15,%rcx
    126b:	7e f3                	jle    1260 <$s4main11sumOfPrimesys5Int64VSiF+0xd0>
    126d:	eb d1                	jmp    1240 <$s4main11sumOfPrimesys5Int64VSiF+0xb0>
    126f:	c6 43 20 00          	movb   $0x0,0x20(%rbx)
    1273:	4c 8d 63 20          	lea    0x20(%rbx),%r12
    1277:	c6 43 21 00          	movb   $0x0,0x21(%rbx)
    127b:	41 0f b6 44 24 02    	movzbl 0x2(%r12),%eax
    1281:	41 89 c6             	mov    %eax,%r14d
    1284:	45 01 f6             	add    %r14d,%r14d
    1287:	49 8d 7f fe          	lea    -0x2(%r15),%rdi
    128b:	49 83 c7 fd          	add    $0xfffffffffffffffd,%r15
    128f:	89 f9                	mov    %edi,%ecx
    1291:	83 e1 03             	and    $0x3,%ecx
    1294:	49 83 ff 03          	cmp    $0x3,%r15
    1298:	73 1a                	jae    12b4 <$s4main11sumOfPrimesys5Int64VSiF+0x124>
    129a:	bf 02 00 00 00       	mov    $0x2,%edi
    129f:	31 f6                	xor    %esi,%esi
    12a1:	ba 02 00 00 00       	mov    $0x2,%edx
    12a6:	48 85 c9             	test   %rcx,%rcx
    12a9:	0f 85 a7 00 00 00    	jne    1356 <$s4main11sumOfPrimesys5Int64VSiF+0x1c6>
    12af:	e9 d3 00 00 00       	jmp    1387 <$s4main11sumOfPrimesys5Int64VSiF+0x1f7>
    12b4:	48 83 e7 fc          	and    $0xfffffffffffffffc,%rdi
    12b8:	48 f7 df             	neg    %rdi
    12bb:	41 b8 02 00 00 00    	mov    $0x2,%r8d
    12c1:	ba 03 00 00 00       	mov    $0x3,%edx
    12c6:	31 f6                	xor    %esi,%esi
    12c8:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    12ce:	66 90                	xchg   %ax,%ax
    12d0:	a8 01                	test   $0x1,%al
    12d2:	4c 0f 44 c6          	cmove  %rsi,%r8
    12d6:	49 8d 04 10          	lea    (%r8,%rdx,1),%rax
    12da:	41 80 3c 14 00       	cmpb   $0x0,(%r12,%rdx,1)
    12df:	4c 0f 45 f0          	cmovne %rax,%r14
    12e3:	4c 0f 45 c0          	cmovne %rax,%r8
    12e7:	49 8d 04 10          	lea    (%r8,%rdx,1),%rax
    12eb:	48 ff c0             	inc    %rax
    12ee:	41 80 7c 14 01 00    	cmpb   $0x0,0x1(%r12,%rdx,1)
    12f4:	4c 0f 45 f0          	cmovne %rax,%r14
    12f8:	4c 0f 45 c0          	cmovne %rax,%r8
    12fc:	41 80 7c 14 02 00    	cmpb   $0x0,0x2(%r12,%rdx,1)
    1302:	49 8d 44 10 02       	lea    0x2(%r8,%rdx,1),%rax
    1307:	4d 89 f2             	mov    %r14,%r10
    130a:	4c 0f 45 d0          	cmovne %rax,%r10
    130e:	4c 89 c6             	mov    %r8,%rsi
    1311:	48 0f 45 f0          	cmovne %rax,%rsi
    1315:	41 0f b6 44 14 03    	movzbl 0x3(%r12,%rdx,1),%eax
    131b:	4d 8d 04 31          	lea    (%r9,%rsi,1),%r8
    131f:	49 83 c0 04          	add    $0x4,%r8
    1323:	49 83 c1 04          	add    $0x4,%r9
    1327:	4c 8d 34 16          	lea    (%rsi,%rdx,1),%r14
    132b:	49 83 c6 03          	add    $0x3,%r14
    132f:	84 c0                	test   %al,%al
    1331:	4d 0f 44 f2          	cmove  %r10,%r14
    1335:	4c 8d 14 17          	lea    (%rdi,%rdx,1),%r10
    1339:	49 83 c2 04          	add    $0x4,%r10
    133d:	48 83 c2 04          	add    $0x4,%rdx
    1341:	49 83 fa 03          	cmp    $0x3,%r10
    1345:	75 89                	jne    12d0 <$s4main11sumOfPrimesys5Int64VSiF+0x140>
    1347:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    134b:	48 ff cf             	dec    %rdi
    134e:	48 ff ca             	dec    %rdx
    1351:	48 85 c9             	test   %rcx,%rcx
    1354:	74 31                	je     1387 <$s4main11sumOfPrimesys5Int64VSiF+0x1f7>
    1356:	4c 8d 42 01          	lea    0x1(%rdx),%r8
    135a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    1360:	a8 01                	test   $0x1,%al
    1362:	48 0f 45 f7          	cmovne %rdi,%rsi
    1366:	43 0f b6 04 04       	movzbl (%r12,%r8,1),%eax
    136b:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    136f:	48 ff c7             	inc    %rdi
    1372:	48 ff c2             	inc    %rdx
    1375:	4e 8d 0c 06          	lea    (%rsi,%r8,1),%r9
    1379:	84 c0                	test   %al,%al
    137b:	4d 0f 45 f1          	cmovne %r9,%r14
    137f:	49 ff c0             	inc    %r8
    1382:	48 ff c9             	dec    %rcx
    1385:	75 d9                	jne    1360 <$s4main11sumOfPrimesys5Int64VSiF+0x1d0>
    1387:	48 89 df             	mov    %rbx,%rdi
    138a:	e8 21 fa ff ff       	call   db0 <swift_release@plt>
    138f:	4c 89 f0             	mov    %r14,%rax
    1392:	48 83 c4 08          	add    $0x8,%rsp
    1396:	5b                   	pop    %rbx
    1397:	41 5c                	pop    %r12
    1399:	41 5e                	pop    %r14
    139b:	41 5f                	pop    %r15
    139d:	c3                   	ret
    139e:	66 90                	xchg   %ax,%ax

00000000000013a0 <main>:
    13a0:	55                   	push   %rbp
    13a1:	41 57                	push   %r15
    13a3:	41 56                	push   %r14
    13a5:	41 55                	push   %r13
    13a7:	41 54                	push   %r12
    13a9:	53                   	push   %rbx
    13aa:	48 83 ec 18          	sub    $0x18,%rsp
    13ae:	48 c7 05 df 1d 00 00 	movq   $0x989680,0x1ddf(%rip)        # 3198 <$s4main1NSivp>
    13b5:	80 96 98 00 
    13b9:	48 8d 3d b8 1c 00 00 	lea    0x1cb8(%rip),%rdi        # 3078 <$ss23_ContiguousArrayStorageCyypGMD>
    13c0:	e8 8b fd ff ff       	call   1150 <__swift_instantiateConcreteTypeFromMangledName>
    13c5:	49 89 c6             	mov    %rax,%r14
    13c8:	be 40 00 00 00       	mov    $0x40,%esi
    13cd:	ba 07 00 00 00       	mov    $0x7,%edx
    13d2:	48 89 c7             	mov    %rax,%rdi
    13d5:	e8 e6 f9 ff ff       	call   dc0 <swift_allocObject@plt>
    13da:	49 89 c7             	mov    %rax,%r15
    13dd:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    13e4:	00 
    13e5:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    13ec:	00 
    13ed:	48 8d 05 0c 04 00 00 	lea    0x40c(%rip),%rax        # 1800 <_fini+0x8>
    13f4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    13fb:	00 00 80 
    13fe:	48 09 c8             	or     %rcx,%rax
    1401:	49 89 cc             	mov    %rcx,%r12
    1404:	48 8b 0d b5 1b 00 00 	mov    0x1bb5(%rip),%rcx        # 2fc0 <$sSSN>
    140b:	49 89 4f 38          	mov    %rcx,0x38(%r15)
    140f:	48 bd 19 00 00 00 00 	movabs $0xd000000000000019,%rbp
    1416:	00 00 d0 
    1419:	48 8d 4d 0a          	lea    0xa(%rbp),%rcx
    141d:	49 89 4f 20          	mov    %rcx,0x20(%r15)
    1421:	49 89 47 28          	mov    %rax,0x28(%r15)
    1425:	48 bb 00 00 00 00 00 	movabs $0xe100000000000000,%rbx
    142c:	00 00 e1 
    142f:	be 20 00 00 00       	mov    $0x20,%esi
    1434:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1439:	4c 89 ff             	mov    %r15,%rdi
    143c:	48 89 da             	mov    %rbx,%rdx
    143f:	49 89 d8             	mov    %rbx,%r8
    1442:	e8 89 f9 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    1447:	4c 89 ff             	mov    %r15,%rdi
    144a:	e8 61 f9 ff ff       	call   db0 <swift_release@plt>
    144f:	48 8b 3d 62 1b 00 00 	mov    0x1b62(%rip),%rdi        # 2fb8 <_swiftEmptyArrayStorage>
    1456:	be 20 00 00 00       	mov    $0x20,%esi
    145b:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1460:	48 89 da             	mov    %rbx,%rdx
    1463:	49 89 d8             	mov    %rbx,%r8
    1466:	e8 65 f9 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    146b:	be 40 00 00 00       	mov    $0x40,%esi
    1470:	ba 07 00 00 00       	mov    $0x7,%edx
    1475:	4c 89 f7             	mov    %r14,%rdi
    1478:	e8 43 f9 ff ff       	call   dc0 <swift_allocObject@plt>
    147d:	49 89 c7             	mov    %rax,%r15
    1480:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    1487:	00 
    1488:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    148f:	00 
    1490:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    1497:	00 
    1498:	48 b8 00 00 00 00 00 	movabs $0xe000000000000000,%rax
    149f:	00 00 e0 
    14a2:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    14a7:	49 89 e5             	mov    %rsp,%r13
    14aa:	bf 21 00 00 00       	mov    $0x21,%edi
    14af:	e8 2c f9 ff ff       	call   de0 <$ss11_StringGutsV4growyySiF@plt>
    14b4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    14b9:	e8 32 f9 ff ff       	call   df0 <swift_bridgeObjectRelease@plt>
    14be:	48 8d 05 7b 03 00 00 	lea    0x37b(%rip),%rax        # 1840 <_IO_stdin_used+0x30>
    14c5:	4c 09 e0             	or     %r12,%rax
    14c8:	48 8d 4d 06          	lea    0x6(%rbp),%rcx
    14cc:	48 89 0c 24          	mov    %rcx,(%rsp)
    14d0:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    14d5:	48 8b 05 bc 1c 00 00 	mov    0x1cbc(%rip),%rax        # 3198 <$s4main1NSivp>
    14dc:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    14e1:	48 8b 3d e0 1a 00 00 	mov    0x1ae0(%rip),%rdi        # 2fc8 <$sSiN>
    14e8:	48 8b 35 e1 1a 00 00 	mov    0x1ae1(%rip),%rsi        # 2fd0 <$sSis23CustomStringConvertiblesWP>
    14ef:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    14f4:	e8 07 f9 ff ff       	call   e00 <$ss23CustomStringConvertibleP11descriptionSSvgTj@plt>
    14f9:	49 89 d4             	mov    %rdx,%r12
    14fc:	49 89 e5             	mov    %rsp,%r13
    14ff:	48 89 c7             	mov    %rax,%rdi
    1502:	48 89 d6             	mov    %rdx,%rsi
    1505:	e8 06 f9 ff ff       	call   e10 <$sSS6appendyySSF@plt>
    150a:	4c 89 e7             	mov    %r12,%rdi
    150d:	e8 de f8 ff ff       	call   df0 <swift_bridgeObjectRelease@plt>
    1512:	66 0f 10 04 24       	movupd (%rsp),%xmm0
    1517:	4c 8b 25 a2 1a 00 00 	mov    0x1aa2(%rip),%r12        # 2fc0 <$sSSN>
    151e:	4d 89 67 38          	mov    %r12,0x38(%r15)
    1522:	66 41 0f 11 47 20    	movupd %xmm0,0x20(%r15)
    1528:	be 20 00 00 00       	mov    $0x20,%esi
    152d:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1532:	4c 89 ff             	mov    %r15,%rdi
    1535:	48 89 da             	mov    %rbx,%rdx
    1538:	49 89 d8             	mov    %rbx,%r8
    153b:	e8 90 f8 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    1540:	4c 89 ff             	mov    %r15,%rdi
    1543:	e8 68 f8 ff ff       	call   db0 <swift_release@plt>
    1548:	be 20 00 00 00       	mov    $0x20,%esi
    154d:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1552:	48 8b 3d 5f 1a 00 00 	mov    0x1a5f(%rip),%rdi        # 2fb8 <_swiftEmptyArrayStorage>
    1559:	48 89 da             	mov    %rbx,%rdx
    155c:	49 89 d8             	mov    %rbx,%r8
    155f:	e8 6c f8 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    1564:	be 40 00 00 00       	mov    $0x40,%esi
    1569:	ba 07 00 00 00       	mov    $0x7,%edx
    156e:	4c 89 f7             	mov    %r14,%rdi
    1571:	e8 4a f8 ff ff       	call   dc0 <swift_allocObject@plt>
    1576:	49 89 c7             	mov    %rax,%r15
    1579:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    1580:	00 
    1581:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    1588:	00 
    1589:	48 8d 05 d0 02 00 00 	lea    0x2d0(%rip),%rax        # 1860 <_IO_stdin_used+0x50>
    1590:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    1597:	00 00 80 
    159a:	48 09 c8             	or     %rcx,%rax
    159d:	4d 89 67 38          	mov    %r12,0x38(%r15)
    15a1:	49 89 6f 20          	mov    %rbp,0x20(%r15)
    15a5:	49 89 47 28          	mov    %rax,0x28(%r15)
    15a9:	be 20 00 00 00       	mov    $0x20,%esi
    15ae:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15b3:	4c 89 ff             	mov    %r15,%rdi
    15b6:	48 89 da             	mov    %rbx,%rdx
    15b9:	49 89 d8             	mov    %rbx,%r8
    15bc:	e8 0f f8 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    15c1:	4c 89 ff             	mov    %r15,%rdi
    15c4:	e8 e7 f7 ff ff       	call   db0 <swift_release@plt>
    15c9:	e8 52 f8 ff ff       	call   e20 <$s20FoundationEssentials4DateVACycfC@plt>
    15ce:	f2 0f 11 05 ca 1b 00 	movsd  %xmm0,0x1bca(%rip)        # 31a0 <$s4main5start20FoundationEssentials4DateVvp>
    15d5:	00 
    15d6:	48 8b 3d bb 1b 00 00 	mov    0x1bbb(%rip),%rdi        # 3198 <$s4main1NSivp>
    15dd:	e8 ae fb ff ff       	call   1190 <$s4main11sumOfPrimesys5Int64VSiF>
    15e2:	48 89 05 bf 1b 00 00 	mov    %rax,0x1bbf(%rip)        # 31a8 <$s4main6results5Int64Vvp>
    15e9:	e8 32 f8 ff ff       	call   e20 <$s20FoundationEssentials4DateVACycfC@plt>
    15ee:	f2 0f 11 05 ba 1b 00 	movsd  %xmm0,0x1bba(%rip)        # 31b0 <$s4main3end20FoundationEssentials4DateVvp>
    15f5:	00 
    15f6:	f2 0f 5c 05 a2 1b 00 	subsd  0x1ba2(%rip),%xmm0        # 31a0 <$s4main5start20FoundationEssentials4DateVvp>
    15fd:	00 
    15fe:	f2 0f 59 05 12 02 00 	mulsd  0x212(%rip),%xmm0        # 1818 <_IO_stdin_used+0x8>
    1605:	00 
    1606:	f2 0f 11 05 aa 1b 00 	movsd  %xmm0,0x1baa(%rip)        # 31b8 <$s4main8durationSdvp>
    160d:	00 
    160e:	be 40 00 00 00       	mov    $0x40,%esi
    1613:	ba 07 00 00 00       	mov    $0x7,%edx
    1618:	4c 89 f7             	mov    %r14,%rdi
    161b:	e8 a0 f7 ff ff       	call   dc0 <swift_allocObject@plt>
    1620:	49 89 c7             	mov    %rax,%r15
    1623:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    162a:	00 
    162b:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    1632:	00 
    1633:	4c 89 60 38          	mov    %r12,0x38(%rax)
    1637:	4c 89 e5             	mov    %r12,%rbp
    163a:	48 b8 2d 2d 2d 20 52 	movabs $0x75736552202d2d2d,%rax
    1641:	65 73 75 
    1644:	49 89 47 20          	mov    %rax,0x20(%r15)
    1648:	48 b8 6c 74 20 2d 2d 	movabs $0xee002d2d2d20746c,%rax
    164f:	2d 00 ee 
    1652:	49 89 47 28          	mov    %rax,0x28(%r15)
    1656:	be 20 00 00 00       	mov    $0x20,%esi
    165b:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1660:	4c 89 ff             	mov    %r15,%rdi
    1663:	48 89 da             	mov    %rbx,%rdx
    1666:	49 89 d8             	mov    %rbx,%r8
    1669:	e8 62 f7 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    166e:	4c 89 ff             	mov    %r15,%rdi
    1671:	e8 3a f7 ff ff       	call   db0 <swift_release@plt>
    1676:	be 40 00 00 00       	mov    $0x40,%esi
    167b:	ba 07 00 00 00       	mov    $0x7,%edx
    1680:	4c 89 f7             	mov    %r14,%rdi
    1683:	e8 38 f7 ff ff       	call   dc0 <swift_allocObject@plt>
    1688:	49 89 c7             	mov    %rax,%r15
    168b:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    1692:	00 
    1693:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    169a:	00 
    169b:	48 b8 53 75 6d 3a 20 	movabs $0x203a6d7553,%rax
    16a2:	00 00 00 
    16a5:	48 89 04 24          	mov    %rax,(%rsp)
    16a9:	48 b8 00 00 00 00 00 	movabs $0xe500000000000000,%rax
    16b0:	00 00 e5 
    16b3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    16b8:	48 8b 05 e9 1a 00 00 	mov    0x1ae9(%rip),%rax        # 31a8 <$s4main6results5Int64Vvp>
    16bf:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    16c4:	48 8b 3d 0d 19 00 00 	mov    0x190d(%rip),%rdi        # 2fd8 <$ss5Int64VN>
    16cb:	48 8b 35 0e 19 00 00 	mov    0x190e(%rip),%rsi        # 2fe0 <$ss5Int64Vs23CustomStringConvertiblesWP>
    16d2:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    16d7:	e8 24 f7 ff ff       	call   e00 <$ss23CustomStringConvertibleP11descriptionSSvgTj@plt>
    16dc:	49 89 d4             	mov    %rdx,%r12
    16df:	49 89 e5             	mov    %rsp,%r13
    16e2:	48 89 c7             	mov    %rax,%rdi
    16e5:	48 89 d6             	mov    %rdx,%rsi
    16e8:	e8 23 f7 ff ff       	call   e10 <$sSS6appendyySSF@plt>
    16ed:	4c 89 e7             	mov    %r12,%rdi
    16f0:	e8 fb f6 ff ff       	call   df0 <swift_bridgeObjectRelease@plt>
    16f5:	0f 10 04 24          	movups (%rsp),%xmm0
    16f9:	49 89 6f 38          	mov    %rbp,0x38(%r15)
    16fd:	41 0f 11 47 20       	movups %xmm0,0x20(%r15)
    1702:	be 20 00 00 00       	mov    $0x20,%esi
    1707:	b9 0a 00 00 00       	mov    $0xa,%ecx
    170c:	4c 89 ff             	mov    %r15,%rdi
    170f:	48 89 da             	mov    %rbx,%rdx
    1712:	49 89 d8             	mov    %rbx,%r8
    1715:	e8 b6 f6 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    171a:	4c 89 ff             	mov    %r15,%rdi
    171d:	e8 8e f6 ff ff       	call   db0 <swift_release@plt>
    1722:	be 40 00 00 00       	mov    $0x40,%esi
    1727:	ba 07 00 00 00       	mov    $0x7,%edx
    172c:	4c 89 f7             	mov    %r14,%rdi
    172f:	e8 8c f6 ff ff       	call   dc0 <swift_allocObject@plt>
    1734:	49 89 c6             	mov    %rax,%r14
    1737:	48 c7 40 10 01 00 00 	movq   $0x1,0x10(%rax)
    173e:	00 
    173f:	48 c7 40 18 02 00 00 	movq   $0x2,0x18(%rax)
    1746:	00 
    1747:	48 b8 54 69 6d 65 3a 	movabs $0x203a656d6954,%rax
    174e:	20 00 00 
    1751:	48 89 04 24          	mov    %rax,(%rsp)
    1755:	48 b8 00 00 00 00 00 	movabs $0xe600000000000000,%rax
    175c:	00 00 e6 
    175f:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    1764:	f2 48 0f 2c 05 4b 1a 	cvttsd2si 0x1a4b(%rip),%rax        # 31b8 <$s4main8durationSdvp>
    176b:	00 00 
    176d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    1772:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    1777:	48 8b 3d 4a 18 00 00 	mov    0x184a(%rip),%rdi        # 2fc8 <$sSiN>
    177e:	48 8b 35 4b 18 00 00 	mov    0x184b(%rip),%rsi        # 2fd0 <$sSis23CustomStringConvertiblesWP>
    1785:	e8 76 f6 ff ff       	call   e00 <$ss23CustomStringConvertibleP11descriptionSSvgTj@plt>
    178a:	49 89 d7             	mov    %rdx,%r15
    178d:	49 89 e5             	mov    %rsp,%r13
    1790:	48 89 c7             	mov    %rax,%rdi
    1793:	48 89 d6             	mov    %rdx,%rsi
    1796:	e8 75 f6 ff ff       	call   e10 <$sSS6appendyySSF@plt>
    179b:	4c 89 ff             	mov    %r15,%rdi
    179e:	e8 4d f6 ff ff       	call   df0 <swift_bridgeObjectRelease@plt>
    17a3:	48 be 00 00 00 00 00 	movabs $0xe300000000000000,%rsi
    17aa:	00 00 e3 
    17ad:	bf 20 6d 73 00       	mov    $0x736d20,%edi
    17b2:	e8 59 f6 ff ff       	call   e10 <$sSS6appendyySSF@plt>
    17b7:	0f 10 04 24          	movups (%rsp),%xmm0
    17bb:	49 89 6e 38          	mov    %rbp,0x38(%r14)
    17bf:	41 0f 11 46 20       	movups %xmm0,0x20(%r14)
    17c4:	be 20 00 00 00       	mov    $0x20,%esi
    17c9:	b9 0a 00 00 00       	mov    $0xa,%ecx
    17ce:	4c 89 f7             	mov    %r14,%rdi
    17d1:	48 89 da             	mov    %rbx,%rdx
    17d4:	49 89 d8             	mov    %rbx,%r8
    17d7:	e8 f4 f5 ff ff       	call   dd0 <$ss5print_9separator10terminatoryypd_S2StF@plt>
    17dc:	4c 89 f7             	mov    %r14,%rdi
    17df:	e8 cc f5 ff ff       	call   db0 <swift_release@plt>
    17e4:	31 c0                	xor    %eax,%eax
    17e6:	48 83 c4 18          	add    $0x18,%rsp
    17ea:	5b                   	pop    %rbx
    17eb:	41 5c                	pop    %r12
    17ed:	41 5d                	pop    %r13
    17ef:	41 5e                	pop    %r14
    17f1:	41 5f                	pop    %r15
    17f3:	5d                   	pop    %rbp
    17f4:	c3                   	ret

Disassembly of section .fini:

00000000000017f8 <_fini>:
    17f8:	f3 0f 1e fa          	endbr64
    17fc:	48 83 ec 08          	sub    $0x8,%rsp
    1800:	48 83 c4 08          	add    $0x8,%rsp
    1804:	c3                   	ret
