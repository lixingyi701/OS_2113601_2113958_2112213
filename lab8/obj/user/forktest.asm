
obj/__user_forktest.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1660006f          	j	80018a <sys_open>

0000000000800028 <close>:
  800028:	16e0006f          	j	800196 <sys_close>

000000000080002c <dup2>:
  80002c:	1740006f          	j	8001a0 <sys_dup>

0000000000800030 <_start>:
  800030:	1e2000ef          	jal	ra,800212 <umain>
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
  800048:	73c50513          	addi	a0,a0,1852 # 800780 <main+0xae>
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
  800068:	79450513          	addi	a0,a0,1940 # 8007f8 <main+0x126>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	13a000ef          	jal	ra,8001ac <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00000517          	auipc	a0,0x0
  800088:	71c50513          	addi	a0,a0,1820 # 8007a0 <main+0xce>
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
  8000a8:	75450513          	addi	a0,a0,1876 # 8007f8 <main+0x126>
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
  8000c0:	0c2000ef          	jal	ra,800182 <sys_putc>
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
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6141>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	214000ef          	jal	ra,800300 <vprintfmt>
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
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6141>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1da000ef          	jal	ra,800300 <vprintfmt>
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

0000000000800172 <sys_fork>:
  800172:	4509                	li	a0,2
  800174:	fbfff06f          	j	800132 <syscall>

0000000000800178 <sys_wait>:
  800178:	862e                	mv	a2,a1
  80017a:	85aa                	mv	a1,a0
  80017c:	450d                	li	a0,3
  80017e:	fb5ff06f          	j	800132 <syscall>

0000000000800182 <sys_putc>:
  800182:	85aa                	mv	a1,a0
  800184:	4579                	li	a0,30
  800186:	fadff06f          	j	800132 <syscall>

000000000080018a <sys_open>:
  80018a:	862e                	mv	a2,a1
  80018c:	85aa                	mv	a1,a0
  80018e:	06400513          	li	a0,100
  800192:	fa1ff06f          	j	800132 <syscall>

0000000000800196 <sys_close>:
  800196:	85aa                	mv	a1,a0
  800198:	06500513          	li	a0,101
  80019c:	f97ff06f          	j	800132 <syscall>

00000000008001a0 <sys_dup>:
  8001a0:	862e                	mv	a2,a1
  8001a2:	85aa                	mv	a1,a0
  8001a4:	08200513          	li	a0,130
  8001a8:	f8bff06f          	j	800132 <syscall>

00000000008001ac <exit>:
  8001ac:	1141                	addi	sp,sp,-16
  8001ae:	e406                	sd	ra,8(sp)
  8001b0:	fbbff0ef          	jal	ra,80016a <sys_exit>
  8001b4:	00000517          	auipc	a0,0x0
  8001b8:	60c50513          	addi	a0,a0,1548 # 8007c0 <main+0xee>
  8001bc:	f3dff0ef          	jal	ra,8000f8 <cprintf>
  8001c0:	a001                	j	8001c0 <exit+0x14>

00000000008001c2 <fork>:
  8001c2:	fb1ff06f          	j	800172 <sys_fork>

00000000008001c6 <wait>:
  8001c6:	4581                	li	a1,0
  8001c8:	4501                	li	a0,0
  8001ca:	fafff06f          	j	800178 <sys_wait>

00000000008001ce <initfd>:
  8001ce:	1101                	addi	sp,sp,-32
  8001d0:	87ae                	mv	a5,a1
  8001d2:	e426                	sd	s1,8(sp)
  8001d4:	85b2                	mv	a1,a2
  8001d6:	84aa                	mv	s1,a0
  8001d8:	853e                	mv	a0,a5
  8001da:	e822                	sd	s0,16(sp)
  8001dc:	ec06                	sd	ra,24(sp)
  8001de:	e43ff0ef          	jal	ra,800020 <open>
  8001e2:	842a                	mv	s0,a0
  8001e4:	00054463          	bltz	a0,8001ec <initfd+0x1e>
  8001e8:	00951863          	bne	a0,s1,8001f8 <initfd+0x2a>
  8001ec:	8522                	mv	a0,s0
  8001ee:	60e2                	ld	ra,24(sp)
  8001f0:	6442                	ld	s0,16(sp)
  8001f2:	64a2                	ld	s1,8(sp)
  8001f4:	6105                	addi	sp,sp,32
  8001f6:	8082                	ret
  8001f8:	8526                	mv	a0,s1
  8001fa:	e2fff0ef          	jal	ra,800028 <close>
  8001fe:	85a6                	mv	a1,s1
  800200:	8522                	mv	a0,s0
  800202:	e2bff0ef          	jal	ra,80002c <dup2>
  800206:	84aa                	mv	s1,a0
  800208:	8522                	mv	a0,s0
  80020a:	e1fff0ef          	jal	ra,800028 <close>
  80020e:	8426                	mv	s0,s1
  800210:	bff1                	j	8001ec <initfd+0x1e>

0000000000800212 <umain>:
  800212:	1101                	addi	sp,sp,-32
  800214:	e822                	sd	s0,16(sp)
  800216:	e426                	sd	s1,8(sp)
  800218:	842a                	mv	s0,a0
  80021a:	84ae                	mv	s1,a1
  80021c:	4601                	li	a2,0
  80021e:	00000597          	auipc	a1,0x0
  800222:	5ba58593          	addi	a1,a1,1466 # 8007d8 <main+0x106>
  800226:	4501                	li	a0,0
  800228:	ec06                	sd	ra,24(sp)
  80022a:	fa5ff0ef          	jal	ra,8001ce <initfd>
  80022e:	02054263          	bltz	a0,800252 <umain+0x40>
  800232:	4605                	li	a2,1
  800234:	00000597          	auipc	a1,0x0
  800238:	5e458593          	addi	a1,a1,1508 # 800818 <main+0x146>
  80023c:	4505                	li	a0,1
  80023e:	f91ff0ef          	jal	ra,8001ce <initfd>
  800242:	02054663          	bltz	a0,80026e <umain+0x5c>
  800246:	85a6                	mv	a1,s1
  800248:	8522                	mv	a0,s0
  80024a:	488000ef          	jal	ra,8006d2 <main>
  80024e:	f5fff0ef          	jal	ra,8001ac <exit>
  800252:	86aa                	mv	a3,a0
  800254:	00000617          	auipc	a2,0x0
  800258:	58c60613          	addi	a2,a2,1420 # 8007e0 <main+0x10e>
  80025c:	02000593          	li	a1,32
  800260:	00000517          	auipc	a0,0x0
  800264:	5a050513          	addi	a0,a0,1440 # 800800 <main+0x12e>
  800268:	e0fff0ef          	jal	ra,800076 <__warn>
  80026c:	b7d9                	j	800232 <umain+0x20>
  80026e:	86aa                	mv	a3,a0
  800270:	00000617          	auipc	a2,0x0
  800274:	5b060613          	addi	a2,a2,1456 # 800820 <main+0x14e>
  800278:	02500593          	li	a1,37
  80027c:	00000517          	auipc	a0,0x0
  800280:	58450513          	addi	a0,a0,1412 # 800800 <main+0x12e>
  800284:	df3ff0ef          	jal	ra,800076 <__warn>
  800288:	bf7d                	j	800246 <umain+0x34>

000000000080028a <printnum>:
  80028a:	02071893          	slli	a7,a4,0x20
  80028e:	7139                	addi	sp,sp,-64
  800290:	0208d893          	srli	a7,a7,0x20
  800294:	e456                	sd	s5,8(sp)
  800296:	0316fab3          	remu	s5,a3,a7
  80029a:	f822                	sd	s0,48(sp)
  80029c:	f426                	sd	s1,40(sp)
  80029e:	f04a                	sd	s2,32(sp)
  8002a0:	ec4e                	sd	s3,24(sp)
  8002a2:	fc06                	sd	ra,56(sp)
  8002a4:	e852                	sd	s4,16(sp)
  8002a6:	84aa                	mv	s1,a0
  8002a8:	89ae                	mv	s3,a1
  8002aa:	8932                	mv	s2,a2
  8002ac:	fff7841b          	addiw	s0,a5,-1
  8002b0:	2a81                	sext.w	s5,s5
  8002b2:	0516f163          	bleu	a7,a3,8002f4 <printnum+0x6a>
  8002b6:	8a42                	mv	s4,a6
  8002b8:	00805863          	blez	s0,8002c8 <printnum+0x3e>
  8002bc:	347d                	addiw	s0,s0,-1
  8002be:	864e                	mv	a2,s3
  8002c0:	85ca                	mv	a1,s2
  8002c2:	8552                	mv	a0,s4
  8002c4:	9482                	jalr	s1
  8002c6:	f87d                	bnez	s0,8002bc <printnum+0x32>
  8002c8:	1a82                	slli	s5,s5,0x20
  8002ca:	020ada93          	srli	s5,s5,0x20
  8002ce:	00000797          	auipc	a5,0x0
  8002d2:	79278793          	addi	a5,a5,1938 # 800a60 <error_string+0xc8>
  8002d6:	9abe                	add	s5,s5,a5
  8002d8:	7442                	ld	s0,48(sp)
  8002da:	000ac503          	lbu	a0,0(s5)
  8002de:	70e2                	ld	ra,56(sp)
  8002e0:	6a42                	ld	s4,16(sp)
  8002e2:	6aa2                	ld	s5,8(sp)
  8002e4:	864e                	mv	a2,s3
  8002e6:	85ca                	mv	a1,s2
  8002e8:	69e2                	ld	s3,24(sp)
  8002ea:	7902                	ld	s2,32(sp)
  8002ec:	8326                	mv	t1,s1
  8002ee:	74a2                	ld	s1,40(sp)
  8002f0:	6121                	addi	sp,sp,64
  8002f2:	8302                	jr	t1
  8002f4:	0316d6b3          	divu	a3,a3,a7
  8002f8:	87a2                	mv	a5,s0
  8002fa:	f91ff0ef          	jal	ra,80028a <printnum>
  8002fe:	b7e9                	j	8002c8 <printnum+0x3e>

0000000000800300 <vprintfmt>:
  800300:	7119                	addi	sp,sp,-128
  800302:	f4a6                	sd	s1,104(sp)
  800304:	f0ca                	sd	s2,96(sp)
  800306:	ecce                	sd	s3,88(sp)
  800308:	e4d6                	sd	s5,72(sp)
  80030a:	e0da                	sd	s6,64(sp)
  80030c:	fc5e                	sd	s7,56(sp)
  80030e:	f862                	sd	s8,48(sp)
  800310:	ec6e                	sd	s11,24(sp)
  800312:	fc86                	sd	ra,120(sp)
  800314:	f8a2                	sd	s0,112(sp)
  800316:	e8d2                	sd	s4,80(sp)
  800318:	f466                	sd	s9,40(sp)
  80031a:	f06a                	sd	s10,32(sp)
  80031c:	89aa                	mv	s3,a0
  80031e:	892e                	mv	s2,a1
  800320:	84b2                	mv	s1,a2
  800322:	8db6                	mv	s11,a3
  800324:	8b3a                	mv	s6,a4
  800326:	5bfd                	li	s7,-1
  800328:	00000a97          	auipc	s5,0x0
  80032c:	514a8a93          	addi	s5,s5,1300 # 80083c <main+0x16a>
  800330:	05e00c13          	li	s8,94
  800334:	000dc503          	lbu	a0,0(s11)
  800338:	02500793          	li	a5,37
  80033c:	001d8413          	addi	s0,s11,1
  800340:	00f50f63          	beq	a0,a5,80035e <vprintfmt+0x5e>
  800344:	c529                	beqz	a0,80038e <vprintfmt+0x8e>
  800346:	02500a13          	li	s4,37
  80034a:	a011                	j	80034e <vprintfmt+0x4e>
  80034c:	c129                	beqz	a0,80038e <vprintfmt+0x8e>
  80034e:	864a                	mv	a2,s2
  800350:	85a6                	mv	a1,s1
  800352:	0405                	addi	s0,s0,1
  800354:	9982                	jalr	s3
  800356:	fff44503          	lbu	a0,-1(s0)
  80035a:	ff4519e3          	bne	a0,s4,80034c <vprintfmt+0x4c>
  80035e:	00044603          	lbu	a2,0(s0)
  800362:	02000813          	li	a6,32
  800366:	4a01                	li	s4,0
  800368:	4881                	li	a7,0
  80036a:	5d7d                	li	s10,-1
  80036c:	5cfd                	li	s9,-1
  80036e:	05500593          	li	a1,85
  800372:	4525                	li	a0,9
  800374:	fdd6071b          	addiw	a4,a2,-35
  800378:	0ff77713          	andi	a4,a4,255
  80037c:	00140d93          	addi	s11,s0,1
  800380:	22e5e363          	bltu	a1,a4,8005a6 <vprintfmt+0x2a6>
  800384:	070a                	slli	a4,a4,0x2
  800386:	9756                	add	a4,a4,s5
  800388:	4318                	lw	a4,0(a4)
  80038a:	9756                	add	a4,a4,s5
  80038c:	8702                	jr	a4
  80038e:	70e6                	ld	ra,120(sp)
  800390:	7446                	ld	s0,112(sp)
  800392:	74a6                	ld	s1,104(sp)
  800394:	7906                	ld	s2,96(sp)
  800396:	69e6                	ld	s3,88(sp)
  800398:	6a46                	ld	s4,80(sp)
  80039a:	6aa6                	ld	s5,72(sp)
  80039c:	6b06                	ld	s6,64(sp)
  80039e:	7be2                	ld	s7,56(sp)
  8003a0:	7c42                	ld	s8,48(sp)
  8003a2:	7ca2                	ld	s9,40(sp)
  8003a4:	7d02                	ld	s10,32(sp)
  8003a6:	6de2                	ld	s11,24(sp)
  8003a8:	6109                	addi	sp,sp,128
  8003aa:	8082                	ret
  8003ac:	4705                	li	a4,1
  8003ae:	008b0613          	addi	a2,s6,8
  8003b2:	01174463          	blt	a4,a7,8003ba <vprintfmt+0xba>
  8003b6:	28088563          	beqz	a7,800640 <vprintfmt+0x340>
  8003ba:	000b3683          	ld	a3,0(s6)
  8003be:	4741                	li	a4,16
  8003c0:	8b32                	mv	s6,a2
  8003c2:	a86d                	j	80047c <vprintfmt+0x17c>
  8003c4:	00144603          	lbu	a2,1(s0)
  8003c8:	4a05                	li	s4,1
  8003ca:	846e                	mv	s0,s11
  8003cc:	b765                	j	800374 <vprintfmt+0x74>
  8003ce:	000b2503          	lw	a0,0(s6)
  8003d2:	864a                	mv	a2,s2
  8003d4:	85a6                	mv	a1,s1
  8003d6:	0b21                	addi	s6,s6,8
  8003d8:	9982                	jalr	s3
  8003da:	bfa9                	j	800334 <vprintfmt+0x34>
  8003dc:	4705                	li	a4,1
  8003de:	008b0a13          	addi	s4,s6,8
  8003e2:	01174463          	blt	a4,a7,8003ea <vprintfmt+0xea>
  8003e6:	24088563          	beqz	a7,800630 <vprintfmt+0x330>
  8003ea:	000b3403          	ld	s0,0(s6)
  8003ee:	26044563          	bltz	s0,800658 <vprintfmt+0x358>
  8003f2:	86a2                	mv	a3,s0
  8003f4:	8b52                	mv	s6,s4
  8003f6:	4729                	li	a4,10
  8003f8:	a051                	j	80047c <vprintfmt+0x17c>
  8003fa:	000b2783          	lw	a5,0(s6)
  8003fe:	46e1                	li	a3,24
  800400:	0b21                	addi	s6,s6,8
  800402:	41f7d71b          	sraiw	a4,a5,0x1f
  800406:	8fb9                	xor	a5,a5,a4
  800408:	40e7873b          	subw	a4,a5,a4
  80040c:	1ce6c163          	blt	a3,a4,8005ce <vprintfmt+0x2ce>
  800410:	00371793          	slli	a5,a4,0x3
  800414:	00000697          	auipc	a3,0x0
  800418:	58468693          	addi	a3,a3,1412 # 800998 <error_string>
  80041c:	97b6                	add	a5,a5,a3
  80041e:	639c                	ld	a5,0(a5)
  800420:	1a078763          	beqz	a5,8005ce <vprintfmt+0x2ce>
  800424:	873e                	mv	a4,a5
  800426:	00001697          	auipc	a3,0x1
  80042a:	84268693          	addi	a3,a3,-1982 # 800c68 <error_string+0x2d0>
  80042e:	8626                	mv	a2,s1
  800430:	85ca                	mv	a1,s2
  800432:	854e                	mv	a0,s3
  800434:	25a000ef          	jal	ra,80068e <printfmt>
  800438:	bdf5                	j	800334 <vprintfmt+0x34>
  80043a:	00144603          	lbu	a2,1(s0)
  80043e:	2885                	addiw	a7,a7,1
  800440:	846e                	mv	s0,s11
  800442:	bf0d                	j	800374 <vprintfmt+0x74>
  800444:	4705                	li	a4,1
  800446:	008b0613          	addi	a2,s6,8
  80044a:	01174463          	blt	a4,a7,800452 <vprintfmt+0x152>
  80044e:	1e088e63          	beqz	a7,80064a <vprintfmt+0x34a>
  800452:	000b3683          	ld	a3,0(s6)
  800456:	4721                	li	a4,8
  800458:	8b32                	mv	s6,a2
  80045a:	a00d                	j	80047c <vprintfmt+0x17c>
  80045c:	03000513          	li	a0,48
  800460:	864a                	mv	a2,s2
  800462:	85a6                	mv	a1,s1
  800464:	e042                	sd	a6,0(sp)
  800466:	9982                	jalr	s3
  800468:	864a                	mv	a2,s2
  80046a:	85a6                	mv	a1,s1
  80046c:	07800513          	li	a0,120
  800470:	9982                	jalr	s3
  800472:	0b21                	addi	s6,s6,8
  800474:	ff8b3683          	ld	a3,-8(s6)
  800478:	6802                	ld	a6,0(sp)
  80047a:	4741                	li	a4,16
  80047c:	87e6                	mv	a5,s9
  80047e:	8626                	mv	a2,s1
  800480:	85ca                	mv	a1,s2
  800482:	854e                	mv	a0,s3
  800484:	e07ff0ef          	jal	ra,80028a <printnum>
  800488:	b575                	j	800334 <vprintfmt+0x34>
  80048a:	000b3703          	ld	a4,0(s6)
  80048e:	0b21                	addi	s6,s6,8
  800490:	1e070063          	beqz	a4,800670 <vprintfmt+0x370>
  800494:	00170413          	addi	s0,a4,1
  800498:	19905563          	blez	s9,800622 <vprintfmt+0x322>
  80049c:	02d00613          	li	a2,45
  8004a0:	14c81963          	bne	a6,a2,8005f2 <vprintfmt+0x2f2>
  8004a4:	00074703          	lbu	a4,0(a4)
  8004a8:	0007051b          	sext.w	a0,a4
  8004ac:	c90d                	beqz	a0,8004de <vprintfmt+0x1de>
  8004ae:	000d4563          	bltz	s10,8004b8 <vprintfmt+0x1b8>
  8004b2:	3d7d                	addiw	s10,s10,-1
  8004b4:	037d0363          	beq	s10,s7,8004da <vprintfmt+0x1da>
  8004b8:	864a                	mv	a2,s2
  8004ba:	85a6                	mv	a1,s1
  8004bc:	180a0c63          	beqz	s4,800654 <vprintfmt+0x354>
  8004c0:	3701                	addiw	a4,a4,-32
  8004c2:	18ec7963          	bleu	a4,s8,800654 <vprintfmt+0x354>
  8004c6:	03f00513          	li	a0,63
  8004ca:	9982                	jalr	s3
  8004cc:	0405                	addi	s0,s0,1
  8004ce:	fff44703          	lbu	a4,-1(s0)
  8004d2:	3cfd                	addiw	s9,s9,-1
  8004d4:	0007051b          	sext.w	a0,a4
  8004d8:	f979                	bnez	a0,8004ae <vprintfmt+0x1ae>
  8004da:	e5905de3          	blez	s9,800334 <vprintfmt+0x34>
  8004de:	3cfd                	addiw	s9,s9,-1
  8004e0:	864a                	mv	a2,s2
  8004e2:	85a6                	mv	a1,s1
  8004e4:	02000513          	li	a0,32
  8004e8:	9982                	jalr	s3
  8004ea:	e40c85e3          	beqz	s9,800334 <vprintfmt+0x34>
  8004ee:	3cfd                	addiw	s9,s9,-1
  8004f0:	864a                	mv	a2,s2
  8004f2:	85a6                	mv	a1,s1
  8004f4:	02000513          	li	a0,32
  8004f8:	9982                	jalr	s3
  8004fa:	fe0c92e3          	bnez	s9,8004de <vprintfmt+0x1de>
  8004fe:	bd1d                	j	800334 <vprintfmt+0x34>
  800500:	4705                	li	a4,1
  800502:	008b0613          	addi	a2,s6,8
  800506:	01174463          	blt	a4,a7,80050e <vprintfmt+0x20e>
  80050a:	12088663          	beqz	a7,800636 <vprintfmt+0x336>
  80050e:	000b3683          	ld	a3,0(s6)
  800512:	4729                	li	a4,10
  800514:	8b32                	mv	s6,a2
  800516:	b79d                	j	80047c <vprintfmt+0x17c>
  800518:	00144603          	lbu	a2,1(s0)
  80051c:	02d00813          	li	a6,45
  800520:	846e                	mv	s0,s11
  800522:	bd89                	j	800374 <vprintfmt+0x74>
  800524:	864a                	mv	a2,s2
  800526:	85a6                	mv	a1,s1
  800528:	02500513          	li	a0,37
  80052c:	9982                	jalr	s3
  80052e:	b519                	j	800334 <vprintfmt+0x34>
  800530:	000b2d03          	lw	s10,0(s6)
  800534:	00144603          	lbu	a2,1(s0)
  800538:	0b21                	addi	s6,s6,8
  80053a:	846e                	mv	s0,s11
  80053c:	e20cdce3          	bgez	s9,800374 <vprintfmt+0x74>
  800540:	8cea                	mv	s9,s10
  800542:	5d7d                	li	s10,-1
  800544:	bd05                	j	800374 <vprintfmt+0x74>
  800546:	00144603          	lbu	a2,1(s0)
  80054a:	03000813          	li	a6,48
  80054e:	846e                	mv	s0,s11
  800550:	b515                	j	800374 <vprintfmt+0x74>
  800552:	fd060d1b          	addiw	s10,a2,-48
  800556:	00144603          	lbu	a2,1(s0)
  80055a:	846e                	mv	s0,s11
  80055c:	fd06071b          	addiw	a4,a2,-48
  800560:	0006031b          	sext.w	t1,a2
  800564:	fce56ce3          	bltu	a0,a4,80053c <vprintfmt+0x23c>
  800568:	0405                	addi	s0,s0,1
  80056a:	002d171b          	slliw	a4,s10,0x2
  80056e:	00044603          	lbu	a2,0(s0)
  800572:	01a706bb          	addw	a3,a4,s10
  800576:	0016969b          	slliw	a3,a3,0x1
  80057a:	006686bb          	addw	a3,a3,t1
  80057e:	fd06071b          	addiw	a4,a2,-48
  800582:	fd068d1b          	addiw	s10,a3,-48
  800586:	0006031b          	sext.w	t1,a2
  80058a:	fce57fe3          	bleu	a4,a0,800568 <vprintfmt+0x268>
  80058e:	b77d                	j	80053c <vprintfmt+0x23c>
  800590:	fffcc713          	not	a4,s9
  800594:	977d                	srai	a4,a4,0x3f
  800596:	00ecf7b3          	and	a5,s9,a4
  80059a:	00144603          	lbu	a2,1(s0)
  80059e:	00078c9b          	sext.w	s9,a5
  8005a2:	846e                	mv	s0,s11
  8005a4:	bbc1                	j	800374 <vprintfmt+0x74>
  8005a6:	864a                	mv	a2,s2
  8005a8:	85a6                	mv	a1,s1
  8005aa:	02500513          	li	a0,37
  8005ae:	9982                	jalr	s3
  8005b0:	fff44703          	lbu	a4,-1(s0)
  8005b4:	02500793          	li	a5,37
  8005b8:	8da2                	mv	s11,s0
  8005ba:	d6f70de3          	beq	a4,a5,800334 <vprintfmt+0x34>
  8005be:	02500713          	li	a4,37
  8005c2:	1dfd                	addi	s11,s11,-1
  8005c4:	fffdc783          	lbu	a5,-1(s11)
  8005c8:	fee79de3          	bne	a5,a4,8005c2 <vprintfmt+0x2c2>
  8005cc:	b3a5                	j	800334 <vprintfmt+0x34>
  8005ce:	00000697          	auipc	a3,0x0
  8005d2:	68a68693          	addi	a3,a3,1674 # 800c58 <error_string+0x2c0>
  8005d6:	8626                	mv	a2,s1
  8005d8:	85ca                	mv	a1,s2
  8005da:	854e                	mv	a0,s3
  8005dc:	0b2000ef          	jal	ra,80068e <printfmt>
  8005e0:	bb91                	j	800334 <vprintfmt+0x34>
  8005e2:	00000717          	auipc	a4,0x0
  8005e6:	66e70713          	addi	a4,a4,1646 # 800c50 <error_string+0x2b8>
  8005ea:	00000417          	auipc	s0,0x0
  8005ee:	66740413          	addi	s0,s0,1639 # 800c51 <error_string+0x2b9>
  8005f2:	853a                	mv	a0,a4
  8005f4:	85ea                	mv	a1,s10
  8005f6:	e03a                	sd	a4,0(sp)
  8005f8:	e442                	sd	a6,8(sp)
  8005fa:	0b2000ef          	jal	ra,8006ac <strnlen>
  8005fe:	40ac8cbb          	subw	s9,s9,a0
  800602:	6702                	ld	a4,0(sp)
  800604:	01905f63          	blez	s9,800622 <vprintfmt+0x322>
  800608:	6822                	ld	a6,8(sp)
  80060a:	0008079b          	sext.w	a5,a6
  80060e:	e43e                	sd	a5,8(sp)
  800610:	6522                	ld	a0,8(sp)
  800612:	864a                	mv	a2,s2
  800614:	85a6                	mv	a1,s1
  800616:	e03a                	sd	a4,0(sp)
  800618:	3cfd                	addiw	s9,s9,-1
  80061a:	9982                	jalr	s3
  80061c:	6702                	ld	a4,0(sp)
  80061e:	fe0c99e3          	bnez	s9,800610 <vprintfmt+0x310>
  800622:	00074703          	lbu	a4,0(a4)
  800626:	0007051b          	sext.w	a0,a4
  80062a:	e80512e3          	bnez	a0,8004ae <vprintfmt+0x1ae>
  80062e:	b319                	j	800334 <vprintfmt+0x34>
  800630:	000b2403          	lw	s0,0(s6)
  800634:	bb6d                	j	8003ee <vprintfmt+0xee>
  800636:	000b6683          	lwu	a3,0(s6)
  80063a:	4729                	li	a4,10
  80063c:	8b32                	mv	s6,a2
  80063e:	bd3d                	j	80047c <vprintfmt+0x17c>
  800640:	000b6683          	lwu	a3,0(s6)
  800644:	4741                	li	a4,16
  800646:	8b32                	mv	s6,a2
  800648:	bd15                	j	80047c <vprintfmt+0x17c>
  80064a:	000b6683          	lwu	a3,0(s6)
  80064e:	4721                	li	a4,8
  800650:	8b32                	mv	s6,a2
  800652:	b52d                	j	80047c <vprintfmt+0x17c>
  800654:	9982                	jalr	s3
  800656:	bd9d                	j	8004cc <vprintfmt+0x1cc>
  800658:	864a                	mv	a2,s2
  80065a:	85a6                	mv	a1,s1
  80065c:	02d00513          	li	a0,45
  800660:	e042                	sd	a6,0(sp)
  800662:	9982                	jalr	s3
  800664:	8b52                	mv	s6,s4
  800666:	408006b3          	neg	a3,s0
  80066a:	4729                	li	a4,10
  80066c:	6802                	ld	a6,0(sp)
  80066e:	b539                	j	80047c <vprintfmt+0x17c>
  800670:	01905663          	blez	s9,80067c <vprintfmt+0x37c>
  800674:	02d00713          	li	a4,45
  800678:	f6e815e3          	bne	a6,a4,8005e2 <vprintfmt+0x2e2>
  80067c:	00000417          	auipc	s0,0x0
  800680:	5d540413          	addi	s0,s0,1493 # 800c51 <error_string+0x2b9>
  800684:	02800513          	li	a0,40
  800688:	02800713          	li	a4,40
  80068c:	b50d                	j	8004ae <vprintfmt+0x1ae>

000000000080068e <printfmt>:
  80068e:	7139                	addi	sp,sp,-64
  800690:	02010313          	addi	t1,sp,32
  800694:	f03a                	sd	a4,32(sp)
  800696:	871a                	mv	a4,t1
  800698:	ec06                	sd	ra,24(sp)
  80069a:	f43e                	sd	a5,40(sp)
  80069c:	f842                	sd	a6,48(sp)
  80069e:	fc46                	sd	a7,56(sp)
  8006a0:	e41a                	sd	t1,8(sp)
  8006a2:	c5fff0ef          	jal	ra,800300 <vprintfmt>
  8006a6:	60e2                	ld	ra,24(sp)
  8006a8:	6121                	addi	sp,sp,64
  8006aa:	8082                	ret

00000000008006ac <strnlen>:
  8006ac:	c185                	beqz	a1,8006cc <strnlen+0x20>
  8006ae:	00054783          	lbu	a5,0(a0)
  8006b2:	cf89                	beqz	a5,8006cc <strnlen+0x20>
  8006b4:	4781                	li	a5,0
  8006b6:	a021                	j	8006be <strnlen+0x12>
  8006b8:	00074703          	lbu	a4,0(a4)
  8006bc:	c711                	beqz	a4,8006c8 <strnlen+0x1c>
  8006be:	0785                	addi	a5,a5,1
  8006c0:	00f50733          	add	a4,a0,a5
  8006c4:	fef59ae3          	bne	a1,a5,8006b8 <strnlen+0xc>
  8006c8:	853e                	mv	a0,a5
  8006ca:	8082                	ret
  8006cc:	4781                	li	a5,0
  8006ce:	853e                	mv	a0,a5
  8006d0:	8082                	ret

00000000008006d2 <main>:
  8006d2:	1101                	addi	sp,sp,-32
  8006d4:	e822                	sd	s0,16(sp)
  8006d6:	e426                	sd	s1,8(sp)
  8006d8:	ec06                	sd	ra,24(sp)
  8006da:	4401                	li	s0,0
  8006dc:	02000493          	li	s1,32
  8006e0:	ae3ff0ef          	jal	ra,8001c2 <fork>
  8006e4:	cd05                	beqz	a0,80071c <main+0x4a>
  8006e6:	06a05063          	blez	a0,800746 <main+0x74>
  8006ea:	2405                	addiw	s0,s0,1
  8006ec:	fe941ae3          	bne	s0,s1,8006e0 <main+0xe>
  8006f0:	02000413          	li	s0,32
  8006f4:	ad3ff0ef          	jal	ra,8001c6 <wait>
  8006f8:	ed05                	bnez	a0,800730 <main+0x5e>
  8006fa:	347d                	addiw	s0,s0,-1
  8006fc:	fc65                	bnez	s0,8006f4 <main+0x22>
  8006fe:	ac9ff0ef          	jal	ra,8001c6 <wait>
  800702:	c12d                	beqz	a0,800764 <main+0x92>
  800704:	00000517          	auipc	a0,0x0
  800708:	5dc50513          	addi	a0,a0,1500 # 800ce0 <error_string+0x348>
  80070c:	9edff0ef          	jal	ra,8000f8 <cprintf>
  800710:	60e2                	ld	ra,24(sp)
  800712:	6442                	ld	s0,16(sp)
  800714:	64a2                	ld	s1,8(sp)
  800716:	4501                	li	a0,0
  800718:	6105                	addi	sp,sp,32
  80071a:	8082                	ret
  80071c:	85a2                	mv	a1,s0
  80071e:	00000517          	auipc	a0,0x0
  800722:	55250513          	addi	a0,a0,1362 # 800c70 <error_string+0x2d8>
  800726:	9d3ff0ef          	jal	ra,8000f8 <cprintf>
  80072a:	4501                	li	a0,0
  80072c:	a81ff0ef          	jal	ra,8001ac <exit>
  800730:	00000617          	auipc	a2,0x0
  800734:	58060613          	addi	a2,a2,1408 # 800cb0 <error_string+0x318>
  800738:	45dd                	li	a1,23
  80073a:	00000517          	auipc	a0,0x0
  80073e:	56650513          	addi	a0,a0,1382 # 800ca0 <error_string+0x308>
  800742:	8f5ff0ef          	jal	ra,800036 <__panic>
  800746:	00000697          	auipc	a3,0x0
  80074a:	53a68693          	addi	a3,a3,1338 # 800c80 <error_string+0x2e8>
  80074e:	00000617          	auipc	a2,0x0
  800752:	53a60613          	addi	a2,a2,1338 # 800c88 <error_string+0x2f0>
  800756:	45b9                	li	a1,14
  800758:	00000517          	auipc	a0,0x0
  80075c:	54850513          	addi	a0,a0,1352 # 800ca0 <error_string+0x308>
  800760:	8d7ff0ef          	jal	ra,800036 <__panic>
  800764:	00000617          	auipc	a2,0x0
  800768:	56460613          	addi	a2,a2,1380 # 800cc8 <error_string+0x330>
  80076c:	45f1                	li	a1,28
  80076e:	00000517          	auipc	a0,0x0
  800772:	53250513          	addi	a0,a0,1330 # 800ca0 <error_string+0x308>
  800776:	8c1ff0ef          	jal	ra,800036 <__panic>
