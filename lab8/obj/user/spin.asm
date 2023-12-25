
obj/__user_spin.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <open>:
  800020:	1582                	slli	a1,a1,0x20
  800022:	9181                	srli	a1,a1,0x20
  800024:	1740006f          	j	800198 <sys_open>

0000000000800028 <close>:
  800028:	17c0006f          	j	8001a4 <sys_close>

000000000080002c <dup2>:
  80002c:	1820006f          	j	8001ae <sys_dup>

0000000000800030 <_start>:
  800030:	1f4000ef          	jal	ra,800224 <umain>
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
  800048:	76c50513          	addi	a0,a0,1900 # 8007b0 <main+0xcc>
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
  800068:	7c450513          	addi	a0,a0,1988 # 800828 <main+0x144>
  80006c:	08c000ef          	jal	ra,8000f8 <cprintf>
  800070:	5559                	li	a0,-10
  800072:	148000ef          	jal	ra,8001ba <exit>

0000000000800076 <__warn>:
  800076:	715d                	addi	sp,sp,-80
  800078:	e822                	sd	s0,16(sp)
  80007a:	fc3e                	sd	a5,56(sp)
  80007c:	8432                	mv	s0,a2
  80007e:	103c                	addi	a5,sp,40
  800080:	862e                	mv	a2,a1
  800082:	85aa                	mv	a1,a0
  800084:	00000517          	auipc	a0,0x0
  800088:	74c50513          	addi	a0,a0,1868 # 8007d0 <main+0xec>
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
  8000a8:	78450513          	addi	a0,a0,1924 # 800828 <main+0x144>
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
  8000c0:	0d0000ef          	jal	ra,800190 <sys_putc>
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
  8000e4:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6111>
  8000e8:	ec06                	sd	ra,24(sp)
  8000ea:	c602                	sw	zero,12(sp)
  8000ec:	226000ef          	jal	ra,800312 <vprintfmt>
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
  800116:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <error_string+0xffffffffff7f6111>
  80011a:	ec06                	sd	ra,24(sp)
  80011c:	e4be                	sd	a5,72(sp)
  80011e:	e8c2                	sd	a6,80(sp)
  800120:	ecc6                	sd	a7,88(sp)
  800122:	e41a                	sd	t1,8(sp)
  800124:	c202                	sw	zero,4(sp)
  800126:	1ec000ef          	jal	ra,800312 <vprintfmt>
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

0000000000800182 <sys_yield>:
  800182:	4529                	li	a0,10
  800184:	fafff06f          	j	800132 <syscall>

0000000000800188 <sys_kill>:
  800188:	85aa                	mv	a1,a0
  80018a:	4531                	li	a0,12
  80018c:	fa7ff06f          	j	800132 <syscall>

0000000000800190 <sys_putc>:
  800190:	85aa                	mv	a1,a0
  800192:	4579                	li	a0,30
  800194:	f9fff06f          	j	800132 <syscall>

0000000000800198 <sys_open>:
  800198:	862e                	mv	a2,a1
  80019a:	85aa                	mv	a1,a0
  80019c:	06400513          	li	a0,100
  8001a0:	f93ff06f          	j	800132 <syscall>

00000000008001a4 <sys_close>:
  8001a4:	85aa                	mv	a1,a0
  8001a6:	06500513          	li	a0,101
  8001aa:	f89ff06f          	j	800132 <syscall>

00000000008001ae <sys_dup>:
  8001ae:	862e                	mv	a2,a1
  8001b0:	85aa                	mv	a1,a0
  8001b2:	08200513          	li	a0,130
  8001b6:	f7dff06f          	j	800132 <syscall>

00000000008001ba <exit>:
  8001ba:	1141                	addi	sp,sp,-16
  8001bc:	e406                	sd	ra,8(sp)
  8001be:	fadff0ef          	jal	ra,80016a <sys_exit>
  8001c2:	00000517          	auipc	a0,0x0
  8001c6:	62e50513          	addi	a0,a0,1582 # 8007f0 <main+0x10c>
  8001ca:	f2fff0ef          	jal	ra,8000f8 <cprintf>
  8001ce:	a001                	j	8001ce <exit+0x14>

00000000008001d0 <fork>:
  8001d0:	fa3ff06f          	j	800172 <sys_fork>

00000000008001d4 <waitpid>:
  8001d4:	fa5ff06f          	j	800178 <sys_wait>

00000000008001d8 <yield>:
  8001d8:	fabff06f          	j	800182 <sys_yield>

00000000008001dc <kill>:
  8001dc:	fadff06f          	j	800188 <sys_kill>

00000000008001e0 <initfd>:
  8001e0:	1101                	addi	sp,sp,-32
  8001e2:	87ae                	mv	a5,a1
  8001e4:	e426                	sd	s1,8(sp)
  8001e6:	85b2                	mv	a1,a2
  8001e8:	84aa                	mv	s1,a0
  8001ea:	853e                	mv	a0,a5
  8001ec:	e822                	sd	s0,16(sp)
  8001ee:	ec06                	sd	ra,24(sp)
  8001f0:	e31ff0ef          	jal	ra,800020 <open>
  8001f4:	842a                	mv	s0,a0
  8001f6:	00054463          	bltz	a0,8001fe <initfd+0x1e>
  8001fa:	00951863          	bne	a0,s1,80020a <initfd+0x2a>
  8001fe:	8522                	mv	a0,s0
  800200:	60e2                	ld	ra,24(sp)
  800202:	6442                	ld	s0,16(sp)
  800204:	64a2                	ld	s1,8(sp)
  800206:	6105                	addi	sp,sp,32
  800208:	8082                	ret
  80020a:	8526                	mv	a0,s1
  80020c:	e1dff0ef          	jal	ra,800028 <close>
  800210:	85a6                	mv	a1,s1
  800212:	8522                	mv	a0,s0
  800214:	e19ff0ef          	jal	ra,80002c <dup2>
  800218:	84aa                	mv	s1,a0
  80021a:	8522                	mv	a0,s0
  80021c:	e0dff0ef          	jal	ra,800028 <close>
  800220:	8426                	mv	s0,s1
  800222:	bff1                	j	8001fe <initfd+0x1e>

0000000000800224 <umain>:
  800224:	1101                	addi	sp,sp,-32
  800226:	e822                	sd	s0,16(sp)
  800228:	e426                	sd	s1,8(sp)
  80022a:	842a                	mv	s0,a0
  80022c:	84ae                	mv	s1,a1
  80022e:	4601                	li	a2,0
  800230:	00000597          	auipc	a1,0x0
  800234:	5d858593          	addi	a1,a1,1496 # 800808 <main+0x124>
  800238:	4501                	li	a0,0
  80023a:	ec06                	sd	ra,24(sp)
  80023c:	fa5ff0ef          	jal	ra,8001e0 <initfd>
  800240:	02054263          	bltz	a0,800264 <umain+0x40>
  800244:	4605                	li	a2,1
  800246:	00000597          	auipc	a1,0x0
  80024a:	60258593          	addi	a1,a1,1538 # 800848 <main+0x164>
  80024e:	4505                	li	a0,1
  800250:	f91ff0ef          	jal	ra,8001e0 <initfd>
  800254:	02054663          	bltz	a0,800280 <umain+0x5c>
  800258:	85a6                	mv	a1,s1
  80025a:	8522                	mv	a0,s0
  80025c:	488000ef          	jal	ra,8006e4 <main>
  800260:	f5bff0ef          	jal	ra,8001ba <exit>
  800264:	86aa                	mv	a3,a0
  800266:	00000617          	auipc	a2,0x0
  80026a:	5aa60613          	addi	a2,a2,1450 # 800810 <main+0x12c>
  80026e:	02000593          	li	a1,32
  800272:	00000517          	auipc	a0,0x0
  800276:	5be50513          	addi	a0,a0,1470 # 800830 <main+0x14c>
  80027a:	dfdff0ef          	jal	ra,800076 <__warn>
  80027e:	b7d9                	j	800244 <umain+0x20>
  800280:	86aa                	mv	a3,a0
  800282:	00000617          	auipc	a2,0x0
  800286:	5ce60613          	addi	a2,a2,1486 # 800850 <main+0x16c>
  80028a:	02500593          	li	a1,37
  80028e:	00000517          	auipc	a0,0x0
  800292:	5a250513          	addi	a0,a0,1442 # 800830 <main+0x14c>
  800296:	de1ff0ef          	jal	ra,800076 <__warn>
  80029a:	bf7d                	j	800258 <umain+0x34>

000000000080029c <printnum>:
  80029c:	02071893          	slli	a7,a4,0x20
  8002a0:	7139                	addi	sp,sp,-64
  8002a2:	0208d893          	srli	a7,a7,0x20
  8002a6:	e456                	sd	s5,8(sp)
  8002a8:	0316fab3          	remu	s5,a3,a7
  8002ac:	f822                	sd	s0,48(sp)
  8002ae:	f426                	sd	s1,40(sp)
  8002b0:	f04a                	sd	s2,32(sp)
  8002b2:	ec4e                	sd	s3,24(sp)
  8002b4:	fc06                	sd	ra,56(sp)
  8002b6:	e852                	sd	s4,16(sp)
  8002b8:	84aa                	mv	s1,a0
  8002ba:	89ae                	mv	s3,a1
  8002bc:	8932                	mv	s2,a2
  8002be:	fff7841b          	addiw	s0,a5,-1
  8002c2:	2a81                	sext.w	s5,s5
  8002c4:	0516f163          	bleu	a7,a3,800306 <printnum+0x6a>
  8002c8:	8a42                	mv	s4,a6
  8002ca:	00805863          	blez	s0,8002da <printnum+0x3e>
  8002ce:	347d                	addiw	s0,s0,-1
  8002d0:	864e                	mv	a2,s3
  8002d2:	85ca                	mv	a1,s2
  8002d4:	8552                	mv	a0,s4
  8002d6:	9482                	jalr	s1
  8002d8:	f87d                	bnez	s0,8002ce <printnum+0x32>
  8002da:	1a82                	slli	s5,s5,0x20
  8002dc:	020ada93          	srli	s5,s5,0x20
  8002e0:	00000797          	auipc	a5,0x0
  8002e4:	7b078793          	addi	a5,a5,1968 # 800a90 <error_string+0xc8>
  8002e8:	9abe                	add	s5,s5,a5
  8002ea:	7442                	ld	s0,48(sp)
  8002ec:	000ac503          	lbu	a0,0(s5)
  8002f0:	70e2                	ld	ra,56(sp)
  8002f2:	6a42                	ld	s4,16(sp)
  8002f4:	6aa2                	ld	s5,8(sp)
  8002f6:	864e                	mv	a2,s3
  8002f8:	85ca                	mv	a1,s2
  8002fa:	69e2                	ld	s3,24(sp)
  8002fc:	7902                	ld	s2,32(sp)
  8002fe:	8326                	mv	t1,s1
  800300:	74a2                	ld	s1,40(sp)
  800302:	6121                	addi	sp,sp,64
  800304:	8302                	jr	t1
  800306:	0316d6b3          	divu	a3,a3,a7
  80030a:	87a2                	mv	a5,s0
  80030c:	f91ff0ef          	jal	ra,80029c <printnum>
  800310:	b7e9                	j	8002da <printnum+0x3e>

0000000000800312 <vprintfmt>:
  800312:	7119                	addi	sp,sp,-128
  800314:	f4a6                	sd	s1,104(sp)
  800316:	f0ca                	sd	s2,96(sp)
  800318:	ecce                	sd	s3,88(sp)
  80031a:	e4d6                	sd	s5,72(sp)
  80031c:	e0da                	sd	s6,64(sp)
  80031e:	fc5e                	sd	s7,56(sp)
  800320:	f862                	sd	s8,48(sp)
  800322:	ec6e                	sd	s11,24(sp)
  800324:	fc86                	sd	ra,120(sp)
  800326:	f8a2                	sd	s0,112(sp)
  800328:	e8d2                	sd	s4,80(sp)
  80032a:	f466                	sd	s9,40(sp)
  80032c:	f06a                	sd	s10,32(sp)
  80032e:	89aa                	mv	s3,a0
  800330:	892e                	mv	s2,a1
  800332:	84b2                	mv	s1,a2
  800334:	8db6                	mv	s11,a3
  800336:	8b3a                	mv	s6,a4
  800338:	5bfd                	li	s7,-1
  80033a:	00000a97          	auipc	s5,0x0
  80033e:	532a8a93          	addi	s5,s5,1330 # 80086c <main+0x188>
  800342:	05e00c13          	li	s8,94
  800346:	000dc503          	lbu	a0,0(s11)
  80034a:	02500793          	li	a5,37
  80034e:	001d8413          	addi	s0,s11,1
  800352:	00f50f63          	beq	a0,a5,800370 <vprintfmt+0x5e>
  800356:	c529                	beqz	a0,8003a0 <vprintfmt+0x8e>
  800358:	02500a13          	li	s4,37
  80035c:	a011                	j	800360 <vprintfmt+0x4e>
  80035e:	c129                	beqz	a0,8003a0 <vprintfmt+0x8e>
  800360:	864a                	mv	a2,s2
  800362:	85a6                	mv	a1,s1
  800364:	0405                	addi	s0,s0,1
  800366:	9982                	jalr	s3
  800368:	fff44503          	lbu	a0,-1(s0)
  80036c:	ff4519e3          	bne	a0,s4,80035e <vprintfmt+0x4c>
  800370:	00044603          	lbu	a2,0(s0)
  800374:	02000813          	li	a6,32
  800378:	4a01                	li	s4,0
  80037a:	4881                	li	a7,0
  80037c:	5d7d                	li	s10,-1
  80037e:	5cfd                	li	s9,-1
  800380:	05500593          	li	a1,85
  800384:	4525                	li	a0,9
  800386:	fdd6071b          	addiw	a4,a2,-35
  80038a:	0ff77713          	andi	a4,a4,255
  80038e:	00140d93          	addi	s11,s0,1
  800392:	22e5e363          	bltu	a1,a4,8005b8 <vprintfmt+0x2a6>
  800396:	070a                	slli	a4,a4,0x2
  800398:	9756                	add	a4,a4,s5
  80039a:	4318                	lw	a4,0(a4)
  80039c:	9756                	add	a4,a4,s5
  80039e:	8702                	jr	a4
  8003a0:	70e6                	ld	ra,120(sp)
  8003a2:	7446                	ld	s0,112(sp)
  8003a4:	74a6                	ld	s1,104(sp)
  8003a6:	7906                	ld	s2,96(sp)
  8003a8:	69e6                	ld	s3,88(sp)
  8003aa:	6a46                	ld	s4,80(sp)
  8003ac:	6aa6                	ld	s5,72(sp)
  8003ae:	6b06                	ld	s6,64(sp)
  8003b0:	7be2                	ld	s7,56(sp)
  8003b2:	7c42                	ld	s8,48(sp)
  8003b4:	7ca2                	ld	s9,40(sp)
  8003b6:	7d02                	ld	s10,32(sp)
  8003b8:	6de2                	ld	s11,24(sp)
  8003ba:	6109                	addi	sp,sp,128
  8003bc:	8082                	ret
  8003be:	4705                	li	a4,1
  8003c0:	008b0613          	addi	a2,s6,8
  8003c4:	01174463          	blt	a4,a7,8003cc <vprintfmt+0xba>
  8003c8:	28088563          	beqz	a7,800652 <vprintfmt+0x340>
  8003cc:	000b3683          	ld	a3,0(s6)
  8003d0:	4741                	li	a4,16
  8003d2:	8b32                	mv	s6,a2
  8003d4:	a86d                	j	80048e <vprintfmt+0x17c>
  8003d6:	00144603          	lbu	a2,1(s0)
  8003da:	4a05                	li	s4,1
  8003dc:	846e                	mv	s0,s11
  8003de:	b765                	j	800386 <vprintfmt+0x74>
  8003e0:	000b2503          	lw	a0,0(s6)
  8003e4:	864a                	mv	a2,s2
  8003e6:	85a6                	mv	a1,s1
  8003e8:	0b21                	addi	s6,s6,8
  8003ea:	9982                	jalr	s3
  8003ec:	bfa9                	j	800346 <vprintfmt+0x34>
  8003ee:	4705                	li	a4,1
  8003f0:	008b0a13          	addi	s4,s6,8
  8003f4:	01174463          	blt	a4,a7,8003fc <vprintfmt+0xea>
  8003f8:	24088563          	beqz	a7,800642 <vprintfmt+0x330>
  8003fc:	000b3403          	ld	s0,0(s6)
  800400:	26044563          	bltz	s0,80066a <vprintfmt+0x358>
  800404:	86a2                	mv	a3,s0
  800406:	8b52                	mv	s6,s4
  800408:	4729                	li	a4,10
  80040a:	a051                	j	80048e <vprintfmt+0x17c>
  80040c:	000b2783          	lw	a5,0(s6)
  800410:	46e1                	li	a3,24
  800412:	0b21                	addi	s6,s6,8
  800414:	41f7d71b          	sraiw	a4,a5,0x1f
  800418:	8fb9                	xor	a5,a5,a4
  80041a:	40e7873b          	subw	a4,a5,a4
  80041e:	1ce6c163          	blt	a3,a4,8005e0 <vprintfmt+0x2ce>
  800422:	00371793          	slli	a5,a4,0x3
  800426:	00000697          	auipc	a3,0x0
  80042a:	5a268693          	addi	a3,a3,1442 # 8009c8 <error_string>
  80042e:	97b6                	add	a5,a5,a3
  800430:	639c                	ld	a5,0(a5)
  800432:	1a078763          	beqz	a5,8005e0 <vprintfmt+0x2ce>
  800436:	873e                	mv	a4,a5
  800438:	00001697          	auipc	a3,0x1
  80043c:	86068693          	addi	a3,a3,-1952 # 800c98 <error_string+0x2d0>
  800440:	8626                	mv	a2,s1
  800442:	85ca                	mv	a1,s2
  800444:	854e                	mv	a0,s3
  800446:	25a000ef          	jal	ra,8006a0 <printfmt>
  80044a:	bdf5                	j	800346 <vprintfmt+0x34>
  80044c:	00144603          	lbu	a2,1(s0)
  800450:	2885                	addiw	a7,a7,1
  800452:	846e                	mv	s0,s11
  800454:	bf0d                	j	800386 <vprintfmt+0x74>
  800456:	4705                	li	a4,1
  800458:	008b0613          	addi	a2,s6,8
  80045c:	01174463          	blt	a4,a7,800464 <vprintfmt+0x152>
  800460:	1e088e63          	beqz	a7,80065c <vprintfmt+0x34a>
  800464:	000b3683          	ld	a3,0(s6)
  800468:	4721                	li	a4,8
  80046a:	8b32                	mv	s6,a2
  80046c:	a00d                	j	80048e <vprintfmt+0x17c>
  80046e:	03000513          	li	a0,48
  800472:	864a                	mv	a2,s2
  800474:	85a6                	mv	a1,s1
  800476:	e042                	sd	a6,0(sp)
  800478:	9982                	jalr	s3
  80047a:	864a                	mv	a2,s2
  80047c:	85a6                	mv	a1,s1
  80047e:	07800513          	li	a0,120
  800482:	9982                	jalr	s3
  800484:	0b21                	addi	s6,s6,8
  800486:	ff8b3683          	ld	a3,-8(s6)
  80048a:	6802                	ld	a6,0(sp)
  80048c:	4741                	li	a4,16
  80048e:	87e6                	mv	a5,s9
  800490:	8626                	mv	a2,s1
  800492:	85ca                	mv	a1,s2
  800494:	854e                	mv	a0,s3
  800496:	e07ff0ef          	jal	ra,80029c <printnum>
  80049a:	b575                	j	800346 <vprintfmt+0x34>
  80049c:	000b3703          	ld	a4,0(s6)
  8004a0:	0b21                	addi	s6,s6,8
  8004a2:	1e070063          	beqz	a4,800682 <vprintfmt+0x370>
  8004a6:	00170413          	addi	s0,a4,1
  8004aa:	19905563          	blez	s9,800634 <vprintfmt+0x322>
  8004ae:	02d00613          	li	a2,45
  8004b2:	14c81963          	bne	a6,a2,800604 <vprintfmt+0x2f2>
  8004b6:	00074703          	lbu	a4,0(a4)
  8004ba:	0007051b          	sext.w	a0,a4
  8004be:	c90d                	beqz	a0,8004f0 <vprintfmt+0x1de>
  8004c0:	000d4563          	bltz	s10,8004ca <vprintfmt+0x1b8>
  8004c4:	3d7d                	addiw	s10,s10,-1
  8004c6:	037d0363          	beq	s10,s7,8004ec <vprintfmt+0x1da>
  8004ca:	864a                	mv	a2,s2
  8004cc:	85a6                	mv	a1,s1
  8004ce:	180a0c63          	beqz	s4,800666 <vprintfmt+0x354>
  8004d2:	3701                	addiw	a4,a4,-32
  8004d4:	18ec7963          	bleu	a4,s8,800666 <vprintfmt+0x354>
  8004d8:	03f00513          	li	a0,63
  8004dc:	9982                	jalr	s3
  8004de:	0405                	addi	s0,s0,1
  8004e0:	fff44703          	lbu	a4,-1(s0)
  8004e4:	3cfd                	addiw	s9,s9,-1
  8004e6:	0007051b          	sext.w	a0,a4
  8004ea:	f979                	bnez	a0,8004c0 <vprintfmt+0x1ae>
  8004ec:	e5905de3          	blez	s9,800346 <vprintfmt+0x34>
  8004f0:	3cfd                	addiw	s9,s9,-1
  8004f2:	864a                	mv	a2,s2
  8004f4:	85a6                	mv	a1,s1
  8004f6:	02000513          	li	a0,32
  8004fa:	9982                	jalr	s3
  8004fc:	e40c85e3          	beqz	s9,800346 <vprintfmt+0x34>
  800500:	3cfd                	addiw	s9,s9,-1
  800502:	864a                	mv	a2,s2
  800504:	85a6                	mv	a1,s1
  800506:	02000513          	li	a0,32
  80050a:	9982                	jalr	s3
  80050c:	fe0c92e3          	bnez	s9,8004f0 <vprintfmt+0x1de>
  800510:	bd1d                	j	800346 <vprintfmt+0x34>
  800512:	4705                	li	a4,1
  800514:	008b0613          	addi	a2,s6,8
  800518:	01174463          	blt	a4,a7,800520 <vprintfmt+0x20e>
  80051c:	12088663          	beqz	a7,800648 <vprintfmt+0x336>
  800520:	000b3683          	ld	a3,0(s6)
  800524:	4729                	li	a4,10
  800526:	8b32                	mv	s6,a2
  800528:	b79d                	j	80048e <vprintfmt+0x17c>
  80052a:	00144603          	lbu	a2,1(s0)
  80052e:	02d00813          	li	a6,45
  800532:	846e                	mv	s0,s11
  800534:	bd89                	j	800386 <vprintfmt+0x74>
  800536:	864a                	mv	a2,s2
  800538:	85a6                	mv	a1,s1
  80053a:	02500513          	li	a0,37
  80053e:	9982                	jalr	s3
  800540:	b519                	j	800346 <vprintfmt+0x34>
  800542:	000b2d03          	lw	s10,0(s6)
  800546:	00144603          	lbu	a2,1(s0)
  80054a:	0b21                	addi	s6,s6,8
  80054c:	846e                	mv	s0,s11
  80054e:	e20cdce3          	bgez	s9,800386 <vprintfmt+0x74>
  800552:	8cea                	mv	s9,s10
  800554:	5d7d                	li	s10,-1
  800556:	bd05                	j	800386 <vprintfmt+0x74>
  800558:	00144603          	lbu	a2,1(s0)
  80055c:	03000813          	li	a6,48
  800560:	846e                	mv	s0,s11
  800562:	b515                	j	800386 <vprintfmt+0x74>
  800564:	fd060d1b          	addiw	s10,a2,-48
  800568:	00144603          	lbu	a2,1(s0)
  80056c:	846e                	mv	s0,s11
  80056e:	fd06071b          	addiw	a4,a2,-48
  800572:	0006031b          	sext.w	t1,a2
  800576:	fce56ce3          	bltu	a0,a4,80054e <vprintfmt+0x23c>
  80057a:	0405                	addi	s0,s0,1
  80057c:	002d171b          	slliw	a4,s10,0x2
  800580:	00044603          	lbu	a2,0(s0)
  800584:	01a706bb          	addw	a3,a4,s10
  800588:	0016969b          	slliw	a3,a3,0x1
  80058c:	006686bb          	addw	a3,a3,t1
  800590:	fd06071b          	addiw	a4,a2,-48
  800594:	fd068d1b          	addiw	s10,a3,-48
  800598:	0006031b          	sext.w	t1,a2
  80059c:	fce57fe3          	bleu	a4,a0,80057a <vprintfmt+0x268>
  8005a0:	b77d                	j	80054e <vprintfmt+0x23c>
  8005a2:	fffcc713          	not	a4,s9
  8005a6:	977d                	srai	a4,a4,0x3f
  8005a8:	00ecf7b3          	and	a5,s9,a4
  8005ac:	00144603          	lbu	a2,1(s0)
  8005b0:	00078c9b          	sext.w	s9,a5
  8005b4:	846e                	mv	s0,s11
  8005b6:	bbc1                	j	800386 <vprintfmt+0x74>
  8005b8:	864a                	mv	a2,s2
  8005ba:	85a6                	mv	a1,s1
  8005bc:	02500513          	li	a0,37
  8005c0:	9982                	jalr	s3
  8005c2:	fff44703          	lbu	a4,-1(s0)
  8005c6:	02500793          	li	a5,37
  8005ca:	8da2                	mv	s11,s0
  8005cc:	d6f70de3          	beq	a4,a5,800346 <vprintfmt+0x34>
  8005d0:	02500713          	li	a4,37
  8005d4:	1dfd                	addi	s11,s11,-1
  8005d6:	fffdc783          	lbu	a5,-1(s11)
  8005da:	fee79de3          	bne	a5,a4,8005d4 <vprintfmt+0x2c2>
  8005de:	b3a5                	j	800346 <vprintfmt+0x34>
  8005e0:	00000697          	auipc	a3,0x0
  8005e4:	6a868693          	addi	a3,a3,1704 # 800c88 <error_string+0x2c0>
  8005e8:	8626                	mv	a2,s1
  8005ea:	85ca                	mv	a1,s2
  8005ec:	854e                	mv	a0,s3
  8005ee:	0b2000ef          	jal	ra,8006a0 <printfmt>
  8005f2:	bb91                	j	800346 <vprintfmt+0x34>
  8005f4:	00000717          	auipc	a4,0x0
  8005f8:	68c70713          	addi	a4,a4,1676 # 800c80 <error_string+0x2b8>
  8005fc:	00000417          	auipc	s0,0x0
  800600:	68540413          	addi	s0,s0,1669 # 800c81 <error_string+0x2b9>
  800604:	853a                	mv	a0,a4
  800606:	85ea                	mv	a1,s10
  800608:	e03a                	sd	a4,0(sp)
  80060a:	e442                	sd	a6,8(sp)
  80060c:	0b2000ef          	jal	ra,8006be <strnlen>
  800610:	40ac8cbb          	subw	s9,s9,a0
  800614:	6702                	ld	a4,0(sp)
  800616:	01905f63          	blez	s9,800634 <vprintfmt+0x322>
  80061a:	6822                	ld	a6,8(sp)
  80061c:	0008079b          	sext.w	a5,a6
  800620:	e43e                	sd	a5,8(sp)
  800622:	6522                	ld	a0,8(sp)
  800624:	864a                	mv	a2,s2
  800626:	85a6                	mv	a1,s1
  800628:	e03a                	sd	a4,0(sp)
  80062a:	3cfd                	addiw	s9,s9,-1
  80062c:	9982                	jalr	s3
  80062e:	6702                	ld	a4,0(sp)
  800630:	fe0c99e3          	bnez	s9,800622 <vprintfmt+0x310>
  800634:	00074703          	lbu	a4,0(a4)
  800638:	0007051b          	sext.w	a0,a4
  80063c:	e80512e3          	bnez	a0,8004c0 <vprintfmt+0x1ae>
  800640:	b319                	j	800346 <vprintfmt+0x34>
  800642:	000b2403          	lw	s0,0(s6)
  800646:	bb6d                	j	800400 <vprintfmt+0xee>
  800648:	000b6683          	lwu	a3,0(s6)
  80064c:	4729                	li	a4,10
  80064e:	8b32                	mv	s6,a2
  800650:	bd3d                	j	80048e <vprintfmt+0x17c>
  800652:	000b6683          	lwu	a3,0(s6)
  800656:	4741                	li	a4,16
  800658:	8b32                	mv	s6,a2
  80065a:	bd15                	j	80048e <vprintfmt+0x17c>
  80065c:	000b6683          	lwu	a3,0(s6)
  800660:	4721                	li	a4,8
  800662:	8b32                	mv	s6,a2
  800664:	b52d                	j	80048e <vprintfmt+0x17c>
  800666:	9982                	jalr	s3
  800668:	bd9d                	j	8004de <vprintfmt+0x1cc>
  80066a:	864a                	mv	a2,s2
  80066c:	85a6                	mv	a1,s1
  80066e:	02d00513          	li	a0,45
  800672:	e042                	sd	a6,0(sp)
  800674:	9982                	jalr	s3
  800676:	8b52                	mv	s6,s4
  800678:	408006b3          	neg	a3,s0
  80067c:	4729                	li	a4,10
  80067e:	6802                	ld	a6,0(sp)
  800680:	b539                	j	80048e <vprintfmt+0x17c>
  800682:	01905663          	blez	s9,80068e <vprintfmt+0x37c>
  800686:	02d00713          	li	a4,45
  80068a:	f6e815e3          	bne	a6,a4,8005f4 <vprintfmt+0x2e2>
  80068e:	00000417          	auipc	s0,0x0
  800692:	5f340413          	addi	s0,s0,1523 # 800c81 <error_string+0x2b9>
  800696:	02800513          	li	a0,40
  80069a:	02800713          	li	a4,40
  80069e:	b50d                	j	8004c0 <vprintfmt+0x1ae>

00000000008006a0 <printfmt>:
  8006a0:	7139                	addi	sp,sp,-64
  8006a2:	02010313          	addi	t1,sp,32
  8006a6:	f03a                	sd	a4,32(sp)
  8006a8:	871a                	mv	a4,t1
  8006aa:	ec06                	sd	ra,24(sp)
  8006ac:	f43e                	sd	a5,40(sp)
  8006ae:	f842                	sd	a6,48(sp)
  8006b0:	fc46                	sd	a7,56(sp)
  8006b2:	e41a                	sd	t1,8(sp)
  8006b4:	c5fff0ef          	jal	ra,800312 <vprintfmt>
  8006b8:	60e2                	ld	ra,24(sp)
  8006ba:	6121                	addi	sp,sp,64
  8006bc:	8082                	ret

00000000008006be <strnlen>:
  8006be:	c185                	beqz	a1,8006de <strnlen+0x20>
  8006c0:	00054783          	lbu	a5,0(a0)
  8006c4:	cf89                	beqz	a5,8006de <strnlen+0x20>
  8006c6:	4781                	li	a5,0
  8006c8:	a021                	j	8006d0 <strnlen+0x12>
  8006ca:	00074703          	lbu	a4,0(a4)
  8006ce:	c711                	beqz	a4,8006da <strnlen+0x1c>
  8006d0:	0785                	addi	a5,a5,1
  8006d2:	00f50733          	add	a4,a0,a5
  8006d6:	fef59ae3          	bne	a1,a5,8006ca <strnlen+0xc>
  8006da:	853e                	mv	a0,a5
  8006dc:	8082                	ret
  8006de:	4781                	li	a5,0
  8006e0:	853e                	mv	a0,a5
  8006e2:	8082                	ret

00000000008006e4 <main>:
  8006e4:	1141                	addi	sp,sp,-16
  8006e6:	00000517          	auipc	a0,0x0
  8006ea:	5ba50513          	addi	a0,a0,1466 # 800ca0 <error_string+0x2d8>
  8006ee:	e406                	sd	ra,8(sp)
  8006f0:	e022                	sd	s0,0(sp)
  8006f2:	a07ff0ef          	jal	ra,8000f8 <cprintf>
  8006f6:	adbff0ef          	jal	ra,8001d0 <fork>
  8006fa:	e901                	bnez	a0,80070a <main+0x26>
  8006fc:	00000517          	auipc	a0,0x0
  800700:	5cc50513          	addi	a0,a0,1484 # 800cc8 <error_string+0x300>
  800704:	9f5ff0ef          	jal	ra,8000f8 <cprintf>
  800708:	a001                	j	800708 <main+0x24>
  80070a:	842a                	mv	s0,a0
  80070c:	00000517          	auipc	a0,0x0
  800710:	5dc50513          	addi	a0,a0,1500 # 800ce8 <error_string+0x320>
  800714:	9e5ff0ef          	jal	ra,8000f8 <cprintf>
  800718:	ac1ff0ef          	jal	ra,8001d8 <yield>
  80071c:	abdff0ef          	jal	ra,8001d8 <yield>
  800720:	ab9ff0ef          	jal	ra,8001d8 <yield>
  800724:	00000517          	auipc	a0,0x0
  800728:	5ec50513          	addi	a0,a0,1516 # 800d10 <error_string+0x348>
  80072c:	9cdff0ef          	jal	ra,8000f8 <cprintf>
  800730:	8522                	mv	a0,s0
  800732:	aabff0ef          	jal	ra,8001dc <kill>
  800736:	ed31                	bnez	a0,800792 <main+0xae>
  800738:	4581                	li	a1,0
  80073a:	00000517          	auipc	a0,0x0
  80073e:	63e50513          	addi	a0,a0,1598 # 800d78 <error_string+0x3b0>
  800742:	9b7ff0ef          	jal	ra,8000f8 <cprintf>
  800746:	4581                	li	a1,0
  800748:	8522                	mv	a0,s0
  80074a:	a8bff0ef          	jal	ra,8001d4 <waitpid>
  80074e:	e11d                	bnez	a0,800774 <main+0x90>
  800750:	4581                	li	a1,0
  800752:	00000517          	auipc	a0,0x0
  800756:	65e50513          	addi	a0,a0,1630 # 800db0 <error_string+0x3e8>
  80075a:	99fff0ef          	jal	ra,8000f8 <cprintf>
  80075e:	00000517          	auipc	a0,0x0
  800762:	66a50513          	addi	a0,a0,1642 # 800dc8 <error_string+0x400>
  800766:	993ff0ef          	jal	ra,8000f8 <cprintf>
  80076a:	60a2                	ld	ra,8(sp)
  80076c:	6402                	ld	s0,0(sp)
  80076e:	4501                	li	a0,0
  800770:	0141                	addi	sp,sp,16
  800772:	8082                	ret
  800774:	00000697          	auipc	a3,0x0
  800778:	61c68693          	addi	a3,a3,1564 # 800d90 <error_string+0x3c8>
  80077c:	00000617          	auipc	a2,0x0
  800780:	5d460613          	addi	a2,a2,1492 # 800d50 <error_string+0x388>
  800784:	45dd                	li	a1,23
  800786:	00000517          	auipc	a0,0x0
  80078a:	5e250513          	addi	a0,a0,1506 # 800d68 <error_string+0x3a0>
  80078e:	8a9ff0ef          	jal	ra,800036 <__panic>
  800792:	00000697          	auipc	a3,0x0
  800796:	5a668693          	addi	a3,a3,1446 # 800d38 <error_string+0x370>
  80079a:	00000617          	auipc	a2,0x0
  80079e:	5b660613          	addi	a2,a2,1462 # 800d50 <error_string+0x388>
  8007a2:	45d1                	li	a1,20
  8007a4:	00000517          	auipc	a0,0x0
  8007a8:	5c450513          	addi	a0,a0,1476 # 800d68 <error_string+0x3a0>
  8007ac:	88bff0ef          	jal	ra,800036 <__panic>
