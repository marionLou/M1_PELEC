/**************************************************************
 * HTTPPrint.h
 * Provides callback headers and resolution for user's custom
 * HTTP Application.
 * 
 * This file is automatically generated by the MPFS Utility
 * ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS GENERATOR
 **************************************************************/

#ifndef __HTTPPRINT_H
#define __HTTPPRINT_H

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_HTTP2_SERVER)

extern HTTP_STUB httpStubs[MAX_HTTP_CONNECTIONS];
extern BYTE curHTTPID;

void HTTPPrint(DWORD callbackID);
void HTTPPrint_hellomsg(void);
void HTTPPrint_cookiename(void);
void HTTPPrint_(void);
void HTTPPrint_builddate(void);
void HTTPPrint_led(WORD);
void HTTPPrint_lcdtext(void);
void HTTPPrint_ledSelected(WORD,WORD);
void HTTPPrint_version(void);
void HTTPPrint_btn(WORD);
void HTTPPrint_pot(void);
void HTTPPrint_uploadedmd5(void);
void HTTPPrint_status_ok(void);
void HTTPPrint_ddns_status(void);
void HTTPPrint_ddns_status_msg(void);
void HTTPPrint_ddns_user(void);
void HTTPPrint_ddns_pass(void);
void HTTPPrint_ddns_host(void);
void HTTPPrint_status_fail(void);
void HTTPPrint_config_mac(void);
void HTTPPrint_config_hostname(void);
void HTTPPrint_config_dhcpchecked(void);
void HTTPPrint_config_ip(void);
void HTTPPrint_config_gw(void);
void HTTPPrint_config_subnet(void);
void HTTPPrint_config_dns1(void);
void HTTPPrint_config_dns2(void);
void HTTPPrint_reboot(void);
void HTTPPrint_rebootaddr(void);
void HTTPPrint_ddns_service(WORD);
void HTTPPrint_read_comm(WORD);
void HTTPPrint_write_comm(WORD);
void HTTPPrint_smtps_en(void);
void HTTPPrint_snmp_en(void);
void HTTPPrint_MyLevel(void);
void HTTPPrint_level(WORD);

void HTTPPrint(DWORD callbackID)
{
	switch(callbackID)
	{
        case 0x00000001:
			HTTPPrint_hellomsg();
			break;
        case 0x00000002:
			HTTPIncFile((ROM BYTE*)"footer.inc");
			break;
        case 0x00000003:
			HTTPPrint_cookiename();
			break;
        case 0x00000004:
			HTTPPrint_();
			break;
        case 0x00000005:
			HTTPPrint_builddate();
			break;
        case 0x00000006:
			HTTPPrint_led(7);
			break;
        case 0x00000007:
			HTTPPrint_led(6);
			break;
        case 0x00000008:
			HTTPPrint_led(5);
			break;
        case 0x00000009:
			HTTPPrint_led(4);
			break;
        case 0x0000000a:
			HTTPPrint_led(3);
			break;
        case 0x0000000b:
			HTTPPrint_led(2);
			break;
        case 0x0000000c:
			HTTPPrint_led(1);
			break;
        case 0x0000000d:
			HTTPPrint_lcdtext();
			break;
        case 0x0000000e:
			HTTPPrint_ledSelected(4,TRUE);
			break;
        case 0x0000000f:
			HTTPPrint_ledSelected(4,FALSE);
			break;
        case 0x00000010:
			HTTPPrint_ledSelected(3,TRUE);
			break;
        case 0x00000011:
			HTTPPrint_ledSelected(3,FALSE);
			break;
        case 0x00000012:
			HTTPPrint_ledSelected(2,TRUE);
			break;
        case 0x00000013:
			HTTPPrint_ledSelected(2,FALSE);
			break;
        case 0x00000014:
			HTTPPrint_ledSelected(1,TRUE);
			break;
        case 0x00000015:
			HTTPPrint_ledSelected(1,FALSE);
			break;
        case 0x00000016:
			HTTPPrint_version();
			break;
        case 0x00000017:
			HTTPPrint_led(0);
			break;
        case 0x00000018:
			HTTPPrint_btn(0);
			break;
        case 0x00000019:
			HTTPPrint_btn(1);
			break;
        case 0x0000001a:
			HTTPPrint_btn(2);
			break;
        case 0x0000001b:
			HTTPPrint_btn(3);
			break;
        case 0x0000001c:
			HTTPPrint_pot();
			break;
        case 0x0000001d:
			HTTPPrint_uploadedmd5();
			break;
        case 0x0000001e:
			HTTPPrint_status_ok();
			break;
        case 0x0000001f:
			HTTPPrint_ddns_status();
			break;
        case 0x00000020:
			HTTPPrint_ddns_status_msg();
			break;
        case 0x00000021:
			HTTPPrint_ddns_user();
			break;
        case 0x00000022:
			HTTPPrint_ddns_pass();
			break;
        case 0x00000023:
			HTTPPrint_ddns_host();
			break;
        case 0x00000024:
			HTTPPrint_status_fail();
			break;
        case 0x00000025:
			HTTPPrint_config_mac();
			break;
        case 0x00000026:
			HTTPPrint_config_hostname();
			break;
        case 0x00000027:
			HTTPPrint_config_dhcpchecked();
			break;
        case 0x00000028:
			HTTPPrint_config_ip();
			break;
        case 0x00000029:
			HTTPPrint_config_gw();
			break;
        case 0x0000002a:
			HTTPPrint_config_subnet();
			break;
        case 0x0000002b:
			HTTPPrint_config_dns1();
			break;
        case 0x0000002c:
			HTTPPrint_config_dns2();
			break;
        case 0x0000002d:
			HTTPPrint_reboot();
			break;
        case 0x0000002e:
			HTTPPrint_rebootaddr();
			break;
        case 0x0000002f:
			HTTPPrint_ddns_service(0);
			break;
        case 0x00000030:
			HTTPPrint_ddns_service(1);
			break;
        case 0x00000031:
			HTTPPrint_ddns_service(2);
			break;
        case 0x00000033:
			HTTPIncFile((ROM BYTE*)"header.inc");
			break;
        case 0x00000042:
			HTTPPrint_read_comm(0);
			break;
        case 0x00000043:
			HTTPPrint_read_comm(1);
			break;
        case 0x00000044:
			HTTPPrint_read_comm(2);
			break;
        case 0x00000045:
			HTTPPrint_write_comm(0);
			break;
        case 0x00000046:
			HTTPPrint_write_comm(1);
			break;
        case 0x00000047:
			HTTPPrint_write_comm(2);
			break;
        case 0x00000048:
			HTTPPrint_smtps_en();
			break;
        case 0x00000049:
			HTTPPrint_snmp_en();
			break;
        case 0x0000004a:
			HTTPPrint_MyLevel();
			break;
        case 0x0000004b:
			HTTPPrint_level(1);
			break;
        case 0x0000004c:
			HTTPPrint_level(2);
			break;
        case 0x0000004d:
			HTTPPrint_level(3);
			break;
		default:
			// Output notification for undefined values
			TCPPutROMArray(sktHTTP, (ROM BYTE*)"!DEF", 4);
	}

	return;
}

void HTTPPrint_(void)
{
	TCPPut(sktHTTP, '~');
	return;
}

#endif

#endif
