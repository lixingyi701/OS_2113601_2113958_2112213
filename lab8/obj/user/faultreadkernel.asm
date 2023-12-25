
obj/__user_faultreadkernel.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1560006f          	j	80017a <sys_open>

0000000000800028 <close>:
  800028:	15e0006f          	j	800186 <sys_close>

000000000080002c <dup2>:
  80002c:	1640006f          	j	800190 <sys_dup>

0000000000800030 <_start>:
  800030:	1c6000ef          	jal	ra,8001f6 <umain>
  800034:	a001                	j	800034 <_start+0x4>

0000000000800036 <__panic>:
  800036:	715d                	addi	sp,sp,-80
  800038:	e822                	sd	s0,16(sp)
  80003a:	fc3e                	sd	a5,56(sp)
  80003c:	8432                	mv	s0,a2
  80003e:	103c                	addi	a5,sp,40
  800040:	862e                	mv	a2,a1
  800042:	85aa                	mv	a1,a0
  800044:	00000517          	auipc	a0,0x0
  800048:	6a450513          	addi	a0,a0,1700 # 8006e8 <main+0x32>
  80004c:	ec06                	sd	ra,24(sp)
  80004e:	f436                	sd	a3,40(sp)
  800050:	f83a                	sd	a4,48(sp)
  800052:	e0c2                	sd	a6,64(sp)
  800054:	e4c6                	sd	a7,72(sp)
  800056:	e43e                	sd	a5,8(sp)
  800058:	0a0000ef          	jal	ra,8000f8 <cprintf>
  80005c:	65a2                	ld	a1,8(sp)
  80005e:	8522                	mv	a0,s0
  800060:	072000ef          	jal	ra,8000d2 <vcprintf>
  800064:	00000517          	auipc	a0,0x0
  800068:	6fc50513          	addi	a0,a0,1788 # 800760 <main+0xaa>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	12a000ef          	jal	ra,80019c <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00000517          	auipc	a0,0x0
  800088:	68450513          	addi	a0,a0,1668 # 800708 <main+0x52>
  80008c:	ec06                	sd	ra,24(sp)
  80008e:	f436                	sd	a3,40(sp)
  800090:	f83a                	sd	a4,48(sp)
  800092:	e0c2                	sd	a6,64(sp)
  800094:	e4c6                	sd	a7,72(sp)
  800096:	e43e                	sd	a5,8(sp)
  800098:	060000ef          	jal	ra,8000f8 <cprintf>
  80009c:	65a2                	ld	a1,8(sp)
  80009e:	8522                	mv	a0,s0
  8000a0:	032000ef          	jal	ra,8000d2 <vcprintf>
  8000a4:	00000517          	auipc	a0,0x0
  8000a8:	6bc50513          	addi	a0,a0,1724 # 800760 <main+0xaa>
  8000ac:	04c000ef          	jal	ra,8000f8 <cprintf>
  8000b0:	60e2                	ld	ra,24(sp)
  8000b2:	6442                	ld	s0,16(sp)
  8000b4:	6161                	addi	sp,sp,80
  8000b6:	8082                	ret

00000000008000b8 <cputch>:
  8000b8:	1141                	addi	sp,sp,-16
  8000ba:	e022                	sd	s0,0(sp)
  8000bc:	e406                	sd	ra,8(sp)
  8000be:	842e                	mv	s0,a1
  8000c0:	0b2000ef          	jal	ra,800172 <sys_putc>
  8000c4:	401c                	lw	a5,0(s0)
  8000c6:	60a2                	ld	ra,8(sp)
  8000c8:	2785                	addiw	a5,a5,1
  8000ca:	c01c                	sw	a5,0(s0)
  8000cc:	6402                	ld	s0,0(sp)
  8000ce:	0141                	addi	sp,sp,16
  8000d0:	8082                	ret

00000000008000d2 <vcprintf>:
  8000d2:	1101                	addi	sp,sp,-32
  8000d4:	872e                	mv	a4,a1
  8000d6:	75dd                	lui	a1,0xffff7
  8000d8:	86aa                	mv	a3,a0
  8000da:	0070                	addi	a2,sp,12
  8000dc:	00000517          	auipc	a0,0x0
  8000e0:	fdc50513          	addi	a0,a0,-36 # 8000b8 <cputch>
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f61d9>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	1f8000ef          	jal	ra,8002e4 <vprintfmt>
  8000f0:	60e2                	ld	ra,24(sp)
  8000f2:	4532                	lw	a0,12(sp)
  8000f4:	6105                	addi	sp,sp,32
  8000f6:	8082                	ret

00000000008000f8 <cprintf>:
  8000f8:	711d                	addi	sp,sp,-96
  8000fa:	02810313          	addi	t1,sp,40
  8000fe:	f42e                	sd	a1,40(sp)
  800100:	75dd                	lui	a1,0xffff7
  800102:	f832                	sd	a2,48(sp)
  800104:	fc36                	sd	a3,56(sp)
  800106:	e0ba                	sd	a4,64(sp)
  800108:	86aa                	mv	a3,a0
  80010a:	0050                	addi	a2,sp,4
  80010c:	00000517          	auipc	a0,0x0
  800110:	fac50513          	addi	a0,a0,-84 # 8000b8 <cputch>
  800114:	871a                	mv	a4,t1
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f61d9>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1be000ef          	jal	ra,8002e4 <vprintfmt>
  80012a:	60e2                	ld	ra,24(sp)
  80012c:	4512                	lw	a0,4(sp)
  80012e:	6125                	addi	sp,sp,96
  800130:	8082                	ret

0000000000800132 <syscall>:
  800132:	7175                	addi	sp,sp,-144
  800134:	f8ba                	sd	a4,112(sp)
  800136:	e0ba                	sd	a4,64(sp)
  800138:	0118                	addi	a4,sp,128
  80013a:	e42a                	sd	a0,8(sp)
  80013c:	ecae                	sd	a1,88(sp)
  80013e:	f0b2                	sd	a2,96(sp)
  800140:	f4b6                	sd	a3,104(sp)
  800142:	fcbe                	sd	a5,120(sp)
  800144:	e142                	sd	a6,128(sp)
  800146:	e546                	sd	a7,136(sp)
  800148:	f42e                	sd	a1,40(sp)
  80014a:	f832                	sd	a2,48(sp)
  80014c:	fc36                	sd	a3,56(sp)
  80014e:	f03a                	sd	a4,32(sp)
  800150:	e4be                	sd	a5,72(sp)
  800152:	4522                	lw	a0,8(sp)
  800154:	55a2                	lw	a1,40(sp)
  800156:	5642                	lw	a2,48(sp)
  800158:	56e2                	lw	a3,56(sp)
  80015a:	4706                	lw	a4,64(sp)
  80015c:	47a6                	lw	a5,72(sp)
  80015e:	00000073          	ecall
  800162:	ce2a                	sw	a0,28(sp)
  800164:	4572                	lw	a0,28(sp)
  800166:	6149                	addi	sp,sp,144
  800168:	8082                	ret

000000000080016a <sys_exit>:
  80016a:	85aa                	mv	a1,a0
  80016c:	4505                	li	a0,1
  80016e:	fc5ff06f          	j	800132 <syscall>

0000000000800172 <sys_putc>:
  800172:	85aa                	mv	a1,a0
  800174:	4579                	li	a0,30
  800176:	fbdff06f          	j	800132 <syscall>

000000000080017a <sys_open>:
  80017a:	862e                	mv	a2,a1
  80017c:	85aa                	mv	a1,a0
  80017e:	06400513          	li	a0,100
  800182:	fb1ff06f          	j	800132 <syscall>

0000000000800186 <sys_close>:
  800186:	85aa                	mv	a1,a0
  800188:	06500513          	li	a0,101
  80018c:	fa7ff06f          	j	800132 <syscall>

0000000000800190 <sys_dup>:
  800190:	862e                	mv	a2,a1
  800192:	85aa                	mv	a1,a0
  800194:	08200513          	li	a0,130
  800198:	f9bff06f          	j	800132 <syscall>

000000000080019c <exit>:
  80019c:	1141                	addi	sp,sp,-16
  80019e:	e406                	sd	ra,8(sp)
  8001a0:	fcbff0ef          	jal	ra,80016a <sys_exit>
  8001a4:	00000517          	auipc	a0,0x0
  8001a8:	58450513          	addi	a0,a0,1412 # 800728 <main+0x72>
  8001ac:	f4dff0ef          	jal	ra,8000f8 <cprintf>
  8001b0:	a001                	j	8001b0 <exit+0x14>

00000000008001b2 <initfd>:
  8001b2:	1101                	addi	sp,sp,-32
  8001b4:	87ae                	mv	a5,a1
  8001b6:	e426                	sd	s1,8(sp)
  8001b8:	85b2                	mv	a1,a2
  8001ba:	84aa                	mv	s1,a0
  8001bc:	853e                	mv	a0,a5
  8001be:	e822                	sd	s0,16(sp)
  8001c0:	ec06                	sd	ra,24(sp)
  8001c2:	e5fff0ef          	jal	ra,800020 <open>
  8001c6:	842a                	mv	s0,a0
  8001c8:	00054463          	bltz	a0,8001d0 <initfd+0x1e>
  8001cc:	00951863          	bne	a0,s1,8001dc <initfd+0x2a>
  8001d0:	8522                	mv	a0,s0
  8001d2:	60e2                	ld	ra,24(sp)
  8001d4:	6442                	ld	s0,16(sp)
  8001d6:	64a2                	ld	s1,8(sp)
  8001d8:	6105                	addi	sp,sp,32
  8001da:	8082                	ret
  8001dc:	8526                	mv	a0,s1
  8001de:	e4bff0ef          	jal	ra,800028 <close>
  8001e2:	85a6                	mv	a1,s1
  8001e4:	8522                	mv	a0,s0
  8001e6:	e47ff0ef          	jal	ra,80002c <dup2>
  8001ea:	84aa                	mv	s1,a0
  8001ec:	8522                	mv	a0,s0
  8001ee:	e3bff0ef          	jal	ra,800028 <close>
  8001f2:	8426                	mv	s0,s1
  8001f4:	bff1                	j	8001d0 <initfd+0x1e>

00000000008001f6 <umain>:
  8001f6:	1101                	addi	sp,sp,-32
  8001f8:	e822                	sd	s0,16(sp)
  8001fa:	e426                	sd	s1,8(sp)
  8001fc:	842a                	mv	s0,a0
  8001fe:	84ae                	mv	s1,a1
  800200:	4601                	li	a2,0
  800202:	00000597          	auipc	a1,0x0
  800206:	53e58593          	addi	a1,a1,1342 # 800740 <main+0x8a>
  80020a:	4501                	li	a0,0
  80020c:	ec06                	sd	ra,24(sp)
  80020e:	fa5ff0ef          	jal	ra,8001b2 <initfd>
  800212:	02054263          	bltz	a0,800236 <umain+0x40>
  800216:	4605                	li	a2,1
  800218:	00000597          	auipc	a1,0x0
  80021c:	56858593          	addi	a1,a1,1384 # 800780 <main+0xca>
  800220:	4505                	li	a0,1
  800222:	f91ff0ef          	jal	ra,8001b2 <initfd>
  800226:	02054663          	bltz	a0,800252 <umain+0x5c>
  80022a:	85a6                	mv	a1,s1
  80022c:	8522                	mv	a0,s0
  80022e:	488000ef          	jal	ra,8006b6 <main>
  800232:	f6bff0ef          	jal	ra,80019c <exit>
  800236:	86aa                	mv	a3,a0
  800238:	00000617          	auipc	a2,0x0
  80023c:	51060613          	addi	a2,a2,1296 # 800748 <main+0x92>
  800240:	02000593          	li	a1,32
  800244:	00000517          	auipc	a0,0x0
  800248:	52450513          	addi	a0,a0,1316 # 800768 <main+0xb2>
  80024c:	e2bff0ef          	jal	ra,800076 <__warn>
  800250:	b7d9                	j	800216 <umain+0x20>
  800252:	86aa                	mv	a3,a0
  800254:	00000617          	auipc	a2,0x0
  800258:	53460613          	addi	a2,a2,1332 # 800788 <main+0xd2>
  80025c:	02500593          	li	a1,37
  800260:	00000517          	auipc	a0,0x0
  800264:	50850513          	addi	a0,a0,1288 # 800768 <main+0xb2>
  800268:	e0fff0ef          	jal	ra,800076 <__warn>
  80026c:	bf7d                	j	80022a <umain+0x34>

000000000080026e <printnum>:
  80026e:	02071893          	slli	a7,a4,0x20
  800272:	7139                	addi	sp,sp,-64
  800274:	0208d893          	srli	a7,a7,0x20
  800278:	e456                	sd	s5,8(sp)
  80027a:	0316fab3          	remu	s5,a3,a7
  80027e:	f822                	sd	s0,48(sp)
  800280:	f426                	sd	s1,40(sp)
  800282:	f04a                	sd	s2,32(sp)
  800284:	ec4e                	sd	s3,24(sp)
  800286:	fc06                	sd	ra,56(sp)
  800288:	e852                	sd	s4,16(sp)
  80028a:	84aa                	mv	s1,a0
  80028c:	89ae                	mv	s3,a1
  80028e:	8932                	mv	s2,a2
  800290:	fff7841b          	addiw	s0,a5,-1
  800294:	2a81                	sext.w	s5,s5
  800296:	0516f163          	bleu	a7,a3,8002d8 <printnum+0x6a>
  80029a:	8a42                	mv	s4,a6
  80029c:	00805863          	blez	s0,8002ac <printnum+0x3e>
  8002a0:	347d                	addiw	s0,s0,-1
  8002a2:	864e                	mv	a2,s3
  8002a4:	85ca                	mv	a1,s2
  8002a6:	8552                	mv	a0,s4
  8002a8:	9482                	jalr	s1
  8002aa:	f87d                	bnez	s0,8002a0 <printnum+0x32>
  8002ac:	1a82                	slli	s5,s5,0x20
  8002ae:	020ada93          	srli	s5,s5,0x20
  8002b2:	00000797          	auipc	a5,0x0
  8002b6:	71678793          	addi	a5,a5,1814 # 8009c8 <error_string+0xc8>
  8002ba:	9abe                	add	s5,s5,a5
  8002bc:	7442                	ld	s0,48(sp)
  8002be:	000ac503          	lbu	a0,0(s5)
  8002c2:	70e2                	ld	ra,56(sp)
  8002c4:	6a42                	ld	s4,16(sp)
  8002c6:	6aa2                	ld	s5,8(sp)
  8002c8:	864e                	mv	a2,s3
  8002ca:	85ca                	mv	a1,s2
  8002cc:	69e2                	ld	s3,24(sp)
  8002ce:	7902                	ld	s2,32(sp)
  8002d0:	8326                	mv	t1,s1
  8002d2:	74a2                	ld	s1,40(sp)
  8002d4:	6121                	addi	sp,sp,64
  8002d6:	8302                	jr	t1
  8002d8:	0316d6b3          	divu	a3,a3,a7
  8002dc:	87a2                	mv	a5,s0
  8002de:	f91ff0ef          	jal	ra,80026e <printnum>
  8002e2:	b7e9                	j	8002ac <printnum+0x3e>

00000000008002e4 <vprintfmt>:
  8002e4:	7119                	addi	sp,sp,-128
  8002e6:	f4a6                	sd	s1,104(sp)
  8002e8:	f0ca                	sd	s2,96(sp)
  8002ea:	ecce                	sd	s3,88(sp)
  8002ec:	e4d6                	sd	s5,72(sp)
  8002ee:	e0da                	sd	s6,64(sp)
  8002f0:	fc5e                	sd	s7,56(sp)
  8002f2:	f862                	sd	s8,48(sp)
  8002f4:	ec6e                	sd	s11,24(sp)
  8002f6:	fc86                	sd	ra,120(sp)
  8002f8:	f8a2                	sd	s0,112(sp)
  8002fa:	e8d2                	sd	s4,80(sp)
  8002fc:	f466                	sd	s9,40(sp)
  8002fe:	f06a                	sd	s10,32(sp)
  800300:	89aa                	mv	s3,a0
  800302:	892e                	mv	s2,a1
  800304:	84b2                	mv	s1,a2
  800306:	8db6                	mv	s11,a3
  800308:	8b3a                	mv	s6,a4
  80030a:	5bfd                	li	s7,-1
  80030c:	00000a97          	auipc	s5,0x0
  800310:	498a8a93          	addi	s5,s5,1176 # 8007a4 <main+0xee>
  800314:	05e00c13          	li	s8,94
  800318:	000dc503          	lbu	a0,0(s11)
  80031c:	02500793          	li	a5,37
  800320:	001d8413          	addi	s0,s11,1
  800324:	00f50f63          	beq	a0,a5,800342 <vprintfmt+0x5e>
  800328:	c529                	beqz	a0,800372 <vprintfmt+0x8e>
  80032a:	02500a13          	li	s4,37
  80032e:	a011                	j	800332 <vprintfmt+0x4e>
  800330:	c129                	beqz	a0,800372 <vprintfmt+0x8e>
  800332:	864a                	mv	a2,s2
  800334:	85a6                	mv	a1,s1
  800336:	0405                	addi	s0,s0,1
  800338:	9982                	jalr	s3
  80033a:	fff44503          	lbu	a0,-1(s0)
  80033e:	ff4519e3          	bne	a0,s4,800330 <vprintfmt+0x4c>
  800342:	00044603          	lbu	a2,0(s0)
  800346:	02000813          	li	a6,32
  80034a:	4a01                	li	s4,0
  80034c:	4881                	li	a7,0
  80034e:	5d7d                	li	s10,-1
  800350:	5cfd                	li	s9,-1
  800352:	05500593          	li	a1,85
  800356:	4525                	li	a0,9
  800358:	fdd6071b          	addiw	a4,a2,-35
  80035c:	0ff77713          	andi	a4,a4,255
  800360:	00140d93          	addi	s11,s0,1
  800364:	22e5e363          	bltu	a1,a4,80058a <vprintfmt+0x2a6>
  800368:	070a                	slli	a4,a4,0x2
  80036a:	9756                	add	a4,a4,s5
  80036c:	4318                	lw	a4,0(a4)
  80036e:	9756                	add	a4,a4,s5
  800370:	8702                	jr	a4
  800372:	70e6                	ld	ra,120(sp)
  800374:	7446                	ld	s0,112(sp)
  800376:	74a6                	ld	s1,104(sp)
  800378:	7906                	ld	s2,96(sp)
  80037a:	69e6                	ld	s3,88(sp)
  80037c:	6a46                	ld	s4,80(sp)
  80037e:	6aa6                	ld	s5,72(sp)
  800380:	6b06                	ld	s6,64(sp)
  800382:	7be2                	ld	s7,56(sp)
  800384:	7c42                	ld	s8,48(sp)
  800386:	7ca2                	ld	s9,40(sp)
  800388:	7d02                	ld	s10,32(sp)
  80038a:	6de2                	ld	s11,24(sp)
  80038c:	6109                	addi	sp,sp,128
  80038e:	8082                	ret
  800390:	4705                	li	a4,1
  800392:	008b0613          	addi	a2,s6,8
  800396:	01174463          	blt	a4,a7,80039e <vprintfmt+0xba>
  80039a:	28088563          	beqz	a7,800624 <vprintfmt+0x340>
  80039e:	000b3683          	ld	a3,0(s6)
  8003a2:	4741                	li	a4,16
  8003a4:	8b32                	mv	s6,a2
  8003a6:	a86d                	j	800460 <vprintfmt+0x17c>
  8003a8:	00144603          	lbu	a2,1(s0)
  8003ac:	4a05                	li	s4,1
  8003ae:	846e                	mv	s0,s11
  8003b0:	b765                	j	800358 <vprintfmt+0x74>
  8003b2:	000b2503          	lw	a0,0(s6)
  8003b6:	864a                	mv	a2,s2
  8003b8:	85a6                	mv	a1,s1
  8003ba:	0b21                	addi	s6,s6,8
  8003bc:	9982                	jalr	s3
  8003be:	bfa9                	j	800318 <vprintfmt+0x34>
  8003c0:	4705                	li	a4,1
  8003c2:	008b0a13          	addi	s4,s6,8
  8003c6:	01174463          	blt	a4,a7,8003ce <vprintfmt+0xea>
  8003ca:	24088563          	beqz	a7,800614 <vprintfmt+0x330>
  8003ce:	000b3403          	ld	s0,0(s6)
  8003d2:	26044563          	bltz	s0,80063c <vprintfmt+0x358>
  8003d6:	86a2                	mv	a3,s0
  8003d8:	8b52                	mv	s6,s4
  8003da:	4729                	li	a4,10
  8003dc:	a051                	j	800460 <vprintfmt+0x17c>
  8003de:	000b2783          	lw	a5,0(s6)
  8003e2:	46e1                	li	a3,24
  8003e4:	0b21                	addi	s6,s6,8
  8003e6:	41f7d71b          	sraiw	a4,a5,0x1f
  8003ea:	8fb9                	xor	a5,a5,a4
  8003ec:	40e7873b          	subw	a4,a5,a4
  8003f0:	1ce6c163          	blt	a3,a4,8005b2 <vprintfmt+0x2ce>
  8003f4:	00371793          	slli	a5,a4,0x3
  8003f8:	00000697          	auipc	a3,0x0
  8003fc:	50868693          	addi	a3,a3,1288 # 800900 <error_string>
  800400:	97b6                	add	a5,a5,a3
  800402:	639c                	ld	a5,0(a5)
  800404:	1a078763          	beqz	a5,8005b2 <vprintfmt+0x2ce>
  800408:	873e                	mv	a4,a5
  80040a:	00000697          	auipc	a3,0x0
  80040e:	7c668693          	addi	a3,a3,1990 # 800bd0 <error_string+0x2d0>
  800412:	8626                	mv	a2,s1
  800414:	85ca                	mv	a1,s2
  800416:	854e                	mv	a0,s3
  800418:	25a000ef          	jal	ra,800672 <printfmt>
  80041c:	bdf5                	j	800318 <vprintfmt+0x34>
  80041e:	00144603          	lbu	a2,1(s0)
  800422:	2885                	addiw	a7,a7,1
  800424:	846e                	mv	s0,s11
  800426:	bf0d                	j	800358 <vprintfmt+0x74>
  800428:	4705                	li	a4,1
  80042a:	008b0613          	addi	a2,s6,8
  80042e:	01174463          	blt	a4,a7,800436 <vprintfmt+0x152>
  800432:	1e088e63          	beqz	a7,80062e <vprintfmt+0x34a>
  800436:	000b3683          	ld	a3,0(s6)
  80043a:	4721                	li	a4,8
  80043c:	8b32                	mv	s6,a2
  80043e:	a00d                	j	800460 <vprintfmt+0x17c>
  800440:	03000513          	li	a0,48
  800444:	864a                	mv	a2,s2
  800446:	85a6                	mv	a1,s1
  800448:	e042                	sd	a6,0(sp)
  80044a:	9982                	jalr	s3
  80044c:	864a                	mv	a2,s2
  80044e:	85a6                	mv	a1,s1
  800450:	07800513          	li	a0,120
  800454:	9982                	jalr	s3
  800456:	0b21                	addi	s6,s6,8
  800458:	ff8b3683          	ld	a3,-8(s6)
  80045c:	6802                	ld	a6,0(sp)
  80045e:	4741                	li	a4,16
  800460:	87e6                	mv	a5,s9
  800462:	8626                	mv	a2,s1
  800464:	85ca                	mv	a1,s2
  800466:	854e                	mv	a0,s3
  800468:	e07ff0ef          	jal	ra,80026e <printnum>
  80046c:	b575                	j	800318 <vprintfmt+0x34>
  80046e:	000b3703          	ld	a4,0(s6)
  800472:	0b21                	addi	s6,s6,8
  800474:	1e070063          	beqz	a4,800654 <vprintfmt+0x370>
  800478:	00170413          	addi	s0,a4,1
  80047c:	19905563          	blez	s9,800606 <vprintfmt+0x322>
  800480:	02d00613          	li	a2,45
  800484:	14c81963          	bne	a6,a2,8005d6 <vprintfmt+0x2f2>
  800488:	00074703          	lbu	a4,0(a4)
  80048c:	0007051b          	sext.w	a0,a4
  800490:	c90d                	beqz	a0,8004c2 <vprintfmt+0x1de>
  800492:	000d4563          	bltz	s10,80049c <vprintfmt+0x1b8>
  800496:	3d7d                	addiw	s10,s10,-1
  800498:	037d0363          	beq	s10,s7,8004be <vprintfmt+0x1da>
  80049c:	864a                	mv	a2,s2
  80049e:	85a6                	mv	a1,s1
  8004a0:	180a0c63          	beqz	s4,800638 <vprintfmt+0x354>
  8004a4:	3701                	addiw	a4,a4,-32
  8004a6:	18ec7963          	bleu	a4,s8,800638 <vprintfmt+0x354>
  8004aa:	03f00513          	li	a0,63
  8004ae:	9982                	jalr	s3
  8004b0:	0405                	addi	s0,s0,1
  8004b2:	fff44703          	lbu	a4,-1(s0)
  8004b6:	3cfd                	addiw	s9,s9,-1
  8004b8:	0007051b          	sext.w	a0,a4
  8004bc:	f979                	bnez	a0,800492 <vprintfmt+0x1ae>
  8004be:	e5905de3          	blez	s9,800318 <vprintfmt+0x34>
  8004c2:	3cfd                	addiw	s9,s9,-1
  8004c4:	864a                	mv	a2,s2
  8004c6:	85a6                	mv	a1,s1
  8004c8:	02000513          	li	a0,32
  8004cc:	9982                	jalr	s3
  8004ce:	e40c85e3          	beqz	s9,800318 <vprintfmt+0x34>
  8004d2:	3cfd                	addiw	s9,s9,-1
  8004d4:	864a                	mv	a2,s2
  8004d6:	85a6                	mv	a1,s1
  8004d8:	02000513          	li	a0,32
  8004dc:	9982                	jalr	s3
  8004de:	fe0c92e3          	bnez	s9,8004c2 <vprintfmt+0x1de>
  8004e2:	bd1d                	j	800318 <vprintfmt+0x34>
  8004e4:	4705                	li	a4,1
  8004e6:	008b0613          	addi	a2,s6,8
  8004ea:	01174463          	blt	a4,a7,8004f2 <vprintfmt+0x20e>
  8004ee:	12088663          	beqz	a7,80061a <vprintfmt+0x336>
  8004f2:	000b3683          	ld	a3,0(s6)
  8004f6:	4729                	li	a4,10
  8004f8:	8b32                	mv	s6,a2
  8004fa:	b79d                	j	800460 <vprintfmt+0x17c>
  8004fc:	00144603          	lbu	a2,1(s0)
  800500:	02d00813          	li	a6,45
  800504:	846e                	mv	s0,s11
  800506:	bd89                	j	800358 <vprintfmt+0x74>
  800508:	864a                	mv	a2,s2
  80050a:	85a6                	mv	a1,s1
  80050c:	02500513          	li	a0,37
  800510:	9982                	jalr	s3
  800512:	b519                	j	800318 <vprintfmt+0x34>
  800514:	000b2d03          	lw	s10,0(s6)
  800518:	00144603          	lbu	a2,1(s0)
  80051c:	0b21                	addi	s6,s6,8
  80051e:	846e                	mv	s0,s11
  800520:	e20cdce3          	bgez	s9,800358 <vprintfmt+0x74>
  800524:	8cea                	mv	s9,s10
  800526:	5d7d                	li	s10,-1
  800528:	bd05                	j	800358 <vprintfmt+0x74>
  80052a:	00144603          	lbu	a2,1(s0)
  80052e:	03000813          	li	a6,48
  800532:	846e                	mv	s0,s11
  800534:	b515                	j	800358 <vprintfmt+0x74>
  800536:	fd060d1b          	addiw	s10,a2,-48
  80053a:	00144603          	lbu	a2,1(s0)
  80053e:	846e                	mv	s0,s11
  800540:	fd06071b          	addiw	a4,a2,-48
  800544:	0006031b          	sext.w	t1,a2
  800548:	fce56ce3          	bltu	a0,a4,800520 <vprintfmt+0x23c>
  80054c:	0405                	addi	s0,s0,1
  80054e:	002d171b          	slliw	a4,s10,0x2
  800552:	00044603          	lbu	a2,0(s0)
  800556:	01a706bb          	addw	a3,a4,s10
  80055a:	0016969b          	slliw	a3,a3,0x1
  80055e:	006686bb          	addw	a3,a3,t1
  800562:	fd06071b          	addiw	a4,a2,-48
  800566:	fd068d1b          	addiw	s10,a3,-48
  80056a:	0006031b          	sext.w	t1,a2
  80056e:	fce57fe3          	bleu	a4,a0,80054c <vprintfmt+0x268>
  800572:	b77d                	j	800520 <vprintfmt+0x23c>
  800574:	fffcc713          	not	a4,s9
  800578:	977d                	srai	a4,a4,0x3f
  80057a:	00ecf7b3          	and	a5,s9,a4
  80057e:	00144603          	lbu	a2,1(s0)
  800582:	00078c9b          	sext.w	s9,a5
  800586:	846e                	mv	s0,s11
  800588:	bbc1                	j	800358 <vprintfmt+0x74>
  80058a:	864a                	mv	a2,s2
  80058c:	85a6                	mv	a1,s1
  80058e:	02500513          	li	a0,37
  800592:	9982                	jalr	s3
  800594:	fff44703          	lbu	a4,-1(s0)
  800598:	02500793          	li	a5,37
  80059c:	8da2                	mv	s11,s0
  80059e:	d6f70de3          	beq	a4,a5,800318 <vprintfmt+0x34>
  8005a2:	02500713          	li	a4,37
  8005a6:	1dfd                	addi	s11,s11,-1
  8005a8:	fffdc783          	lbu	a5,-1(s11)
  8005ac:	fee79de3          	bne	a5,a4,8005a6 <vprintfmt+0x2c2>
  8005b0:	b3a5                	j	800318 <vprintfmt+0x34>
  8005b2:	00000697          	auipc	a3,0x0
  8005b6:	60e68693          	addi	a3,a3,1550 # 800bc0 <error_string+0x2c0>
  8005ba:	8626                	mv	a2,s1
  8005bc:	85ca                	mv	a1,s2
  8005be:	854e                	mv	a0,s3
  8005c0:	0b2000ef          	jal	ra,800672 <printfmt>
  8005c4:	bb91                	j	800318 <vprintfmt+0x34>
  8005c6:	00000717          	auipc	a4,0x0
  8005ca:	5f270713          	addi	a4,a4,1522 # 800bb8 <error_string+0x2b8>
  8005ce:	00000417          	auipc	s0,0x0
  8005d2:	5eb40413          	addi	s0,s0,1515 # 800bb9 <error_string+0x2b9>
  8005d6:	853a                	mv	a0,a4
  8005d8:	85ea                	mv	a1,s10
  8005da:	e03a                	sd	a4,0(sp)
  8005dc:	e442                	sd	a6,8(sp)
  8005de:	0b2000ef          	jal	ra,800690 <strnlen>
  8005e2:	40ac8cbb          	subw	s9,s9,a0
  8005e6:	6702                	ld	a4,0(sp)
  8005e8:	01905f63          	blez	s9,800606 <vprintfmt+0x322>
  8005ec:	6822                	ld	a6,8(sp)
  8005ee:	0008079b          	sext.w	a5,a6
  8005f2:	e43e                	sd	a5,8(sp)
  8005f4:	6522                	ld	a0,8(sp)
  8005f6:	864a                	mv	a2,s2
  8005f8:	85a6                	mv	a1,s1
  8005fa:	e03a                	sd	a4,0(sp)
  8005fc:	3cfd                	addiw	s9,s9,-1
  8005fe:	9982                	jalr	s3
  800600:	6702                	ld	a4,0(sp)
  800602:	fe0c99e3          	bnez	s9,8005f4 <vprintfmt+0x310>
  800606:	00074703          	lbu	a4,0(a4)
  80060a:	0007051b          	sext.w	a0,a4
  80060e:	e80512e3          	bnez	a0,800492 <vprintfmt+0x1ae>
  800612:	b319                	j	800318 <vprintfmt+0x34>
  800614:	000b2403          	lw	s0,0(s6)
  800618:	bb6d                	j	8003d2 <vprintfmt+0xee>
  80061a:	000b6683          	lwu	a3,0(s6)
  80061e:	4729                	li	a4,10
  800620:	8b32                	mv	s6,a2
  800622:	bd3d                	j	800460 <vprintfmt+0x17c>
  800624:	000b6683          	lwu	a3,0(s6)
  800628:	4741                	li	a4,16
  80062a:	8b32                	mv	s6,a2
  80062c:	bd15                	j	800460 <vprintfmt+0x17c>
  80062e:	000b6683          	lwu	a3,0(s6)
  800632:	4721                	li	a4,8
  800634:	8b32                	mv	s6,a2
  800636:	b52d                	j	800460 <vprintfmt+0x17c>
  800638:	9982                	jalr	s3
  80063a:	bd9d                	j	8004b0 <vprintfmt+0x1cc>
  80063c:	864a                	mv	a2,s2
  80063e:	85a6                	mv	a1,s1
  800640:	02d00513          	li	a0,45
  800644:	e042                	sd	a6,0(sp)
  800646:	9982                	jalr	s3
  800648:	8b52                	mv	s6,s4
  80064a:	408006b3          	neg	a3,s0
  80064e:	4729                	li	a4,10
  800650:	6802                	ld	a6,0(sp)
  800652:	b539                	j	800460 <vprintfmt+0x17c>
  800654:	01905663          	blez	s9,800660 <vprintfmt+0x37c>
  800658:	02d00713          	li	a4,45
  80065c:	f6e815e3          	bne	a6,a4,8005c6 <vprintfmt+0x2e2>
  800660:	00000417          	auipc	s0,0x0
  800664:	55940413          	addi	s0,s0,1369 # 800bb9 <error_string+0x2b9>
  800668:	02800513          	li	a0,40
  80066c:	02800713          	li	a4,40
  800670:	b50d                	j	800492 <vprintfmt+0x1ae>

0000000000800672 <printfmt>:
  800672:	7139                	addi	sp,sp,-64
  800674:	02010313          	addi	t1,sp,32
  800678:	f03a                	sd	a4,32(sp)
  80067a:	871a                	mv	a4,t1
  80067c:	ec06                	sd	ra,24(sp)
  80067e:	f43e                	sd	a5,40(sp)
  800680:	f842                	sd	a6,48(sp)
  800682:	fc46                	sd	a7,56(sp)
  800684:	e41a                	sd	t1,8(sp)
  800686:	c5fff0ef          	jal	ra,8002e4 <vprintfmt>
  80068a:	60e2                	ld	ra,24(sp)
  80068c:	6121                	addi	sp,sp,64
  80068e:	8082                	ret

0000000000800690 <strnlen>:
  800690:	c185                	beqz	a1,8006b0 <strnlen+0x20>
  800692:	00054783          	lbu	a5,0(a0)
  800696:	cf89                	beqz	a5,8006b0 <strnlen+0x20>
  800698:	4781                	li	a5,0
  80069a:	a021                	j	8006a2 <strnlen+0x12>
  80069c:	00074703          	lbu	a4,0(a4)
  8006a0:	c711                	beqz	a4,8006ac <strnlen+0x1c>
  8006a2:	0785                	addi	a5,a5,1
  8006a4:	00f50733          	add	a4,a0,a5
  8006a8:	fef59ae3          	bne	a1,a5,80069c <strnlen+0xc>
  8006ac:	853e                	mv	a0,a5
  8006ae:	8082                	ret
  8006b0:	4781                	li	a5,0
  8006b2:	853e                	mv	a0,a5
  8006b4:	8082                	ret

00000000008006b6 <main>:
  8006b6:	3eb00793          	li	a5,1003
  8006ba:	07da                	slli	a5,a5,0x16
  8006bc:	438c                	lw	a1,0(a5)
  8006be:	1141                	addi	sp,sp,-16
  8006c0:	00000517          	auipc	a0,0x0
  8006c4:	51850513          	addi	a0,a0,1304 # 800bd8 <error_string+0x2d8>
  8006c8:	e406                	sd	ra,8(sp)
  8006ca:	a2fff0ef          	jal	ra,8000f8 <cprintf>
  8006ce:	00000617          	auipc	a2,0x0
  8006d2:	52a60613          	addi	a2,a2,1322 # 800bf8 <error_string+0x2f8>
  8006d6:	459d                	li	a1,7
  8006d8:	00000517          	auipc	a0,0x0
  8006dc:	53050513          	addi	a0,a0,1328 # 800c08 <error_string+0x308>
  8006e0:	957ff0ef          	jal	ra,800036 <__panic>
