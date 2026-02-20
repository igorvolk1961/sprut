unit PayDox_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 04.06.2005 22:42:06 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\paydox\core\PayDox.dll (1)
// LIBID: {C5C63138-6737-4E87-8C78-3F8CC8017975}
// LCID: 0
// Helpfile: 
// HelpString: PayDox ActiveX components
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v2.7 ADODB, (C:\Program Files\Common Files\System\ado\msado27.tlb)
//   (3) v3.0 ASPTypeLibrary, (C:\WINDOWS\system32\inetsrv\asp.dll)
//   (4) v1.0 CDO, (C:\WINDOWS\system32\cdosys.dll)
// Errors:
//   Hint: TypeInfo 'Property' changed to 'Property_'
//   Hint: Parameter 'unit' of _Common.AmountByWords changed to 'unit_'
//   Hint: Enum Member 'OK' of 'E_DOWNLOAD_RETURNVALUE' changed to 'OK_'
//   Hint: Enum Member 'ERR_UNKNOW' of 'E_DOWNLOAD_RETURNVALUE' changed to 'ERR_UNKNOW_'
//   Error creating palette bitmap of (TCommon) : Server c:\paydox\core\PayDox.dll contains no icons
//   Error creating palette bitmap of (TUpload) : Server c:\paydox\core\PayDox.dll contains no icons
//   Error creating palette bitmap of (TConnect1C) : Server c:\paydox\core\PayDox.dll contains no icons
//   Error creating palette bitmap of (TVB5Power) : Server c:\paydox\core\PayDox.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, ADODB_TLB, ASPTypeLibrary_TLB, CDO_TLB, Classes, Graphics, OleServer, 
StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  PayDoxMajorVersion = 1;
  PayDoxMinorVersion = 0;

  LIBID_PayDox: TGUID = '{C5C63138-6737-4E87-8C78-3F8CC8017975}';

  IID__Common: TGUID = '{10C2B7B5-5BE2-48F7-B487-D0154AA85861}';
  CLASS_Common: TGUID = '{34AF9B5D-0636-4DC3-BF58-F14EF166A531}';
  IID__Form: TGUID = '{2B83E039-A180-4A59-8C3E-727651B8DC93}';
  CLASS_Form: TGUID = '{B34F7332-68A0-455F-B2E2-3E4CB329FF04}';
  IID__FormItem: TGUID = '{49E1C150-13AE-4C79-A343-370419B73C58}';
  CLASS_FormItem: TGUID = '{D0EA52A4-E669-45C3-AD5A-D4506F50D1AF}';
  IID__Properties: TGUID = '{B309B5CD-F0BB-41FD-8F61-81220D2025CE}';
  CLASS_Properties: TGUID = '{4DDC71ED-7A8D-4F4E-9168-072D27220698}';
  IID__Property: TGUID = '{5E0E3B73-558B-4777-9E96-1E140A49C5B6}';
  CLASS_Property_: TGUID = '{155F51C7-4FB2-42EF-9D22-D71F03DB7C69}';
  IID__Upload: TGUID = '{753A1788-E813-4BD6-819D-72C8EB9DAB71}';
  CLASS_Upload: TGUID = '{0A0F5AD2-7EAA-4DD7-B7FB-6254607CA504}';
  IID__Connect1C: TGUID = '{E297D2EB-323A-4D37-B3FF-2B7B53B27287}';
  CLASS_Connect1C: TGUID = '{2A9B48B8-081D-4C61-B12B-E4A43AE0E92F}';
  IID__VB5Power: TGUID = '{4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}';
  CLASS_VB5Power: TGUID = '{50A1721E-CF78-42AD-9E84-1DC096F089D8}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum E_SAVE_RETURNVALUE
type
  E_SAVE_RETURNVALUE = TOleEnum;
const
  OK = $00000000;
  ERR_FILEALREADYEXISTS = $00000001;
  ERR_FILECONTAINSNODATA = $00000002;
  ERR_THISNOFILEITEMS = $00000003;
  ERR_UNKNOW = $00000004;

// Constants for enum E_DOWNLOAD_RETURNVALUE
type
  E_DOWNLOAD_RETURNVALUE = TOleEnum;
const
  OK_ = $00000000;
  ERR_FILEDOESNOTEXISTS = $00000001;
  ERR_UNKNOW_ = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _Common = interface;
  _CommonDisp = dispinterface;
  _Form = interface;
  _FormDisp = dispinterface;
  _FormItem = interface;
  _FormItemDisp = dispinterface;
  _Properties = interface;
  _PropertiesDisp = dispinterface;
  _Property = interface;
  _PropertyDisp = dispinterface;
  _Upload = interface;
  _UploadDisp = dispinterface;
  _Connect1C = interface;
  _Connect1CDisp = dispinterface;
  _VB5Power = interface;
  _VB5PowerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Common = _Common;
  Form = _Form;
  FormItem = _FormItem;
  Properties = _Properties;
  Property_ = _Property;
  Upload = _Upload;
  Connect1C = _Connect1C;
  VB5Power = _VB5Power;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}


// *********************************************************************//
// Interface: _Common
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {10C2B7B5-5BE2-48F7-B487-D0154AA85861}
// *********************************************************************//
  _Common = interface(IDispatch)
    ['{10C2B7B5-5BE2-48F7-B487-D0154AA85861}']
    function Get_obj: OleVariant; safecall;
    procedure Set_obj(var obj: OleVariant); safecall;
    procedure _Set_obj(var obj: OleVariant); safecall;
    function Get_doc: OleVariant; safecall;
    procedure Set_doc(var doc: OleVariant); safecall;
    procedure _Set_doc(var doc: OleVariant); safecall;
    function Get_oXL: OleVariant; safecall;
    procedure Set_oXL(var oXL: OleVariant); safecall;
    procedure _Set_oXL(var oXL: OleVariant); safecall;
    function Get_oWB: OleVariant; safecall;
    procedure Set_oWB(var oWB: OleVariant); safecall;
    procedure _Set_oWB(var oWB: OleVariant); safecall;
    function Get_oSheet: OleVariant; safecall;
    procedure Set_oSheet(var oSheet: OleVariant); safecall;
    procedure _Set_oSheet(var oSheet: OleVariant); safecall;
    function Get_oRng: OleVariant; safecall;
    procedure Set_oRng(var oRng: OleVariant); safecall;
    procedure _Set_oRng(var oRng: OleVariant); safecall;
    function Get_Conn: _Connection; safecall;
    procedure GhostMethod__Common_104_1; safecall;
    procedure _Set_Conn(const Conn: _Connection); safecall;
    function Get_ds: OleVariant; safecall;
    procedure Set_ds(var ds: OleVariant); safecall;
    procedure _Set_ds(var ds: OleVariant); safecall;
    function Get_dsDoc: OleVariant; safecall;
    procedure Set_dsDoc(var dsDoc: OleVariant); safecall;
    procedure _Set_dsDoc(var dsDoc: OleVariant); safecall;
    function Get_dsDoc1: OleVariant; safecall;
    procedure Set_dsDoc1(var dsDoc1: OleVariant); safecall;
    procedure _Set_dsDoc1(var dsDoc1: OleVariant); safecall;
    function Get_dsDoc2: OleVariant; safecall;
    procedure Set_dsDoc2(var dsDoc2: OleVariant); safecall;
    procedure _Set_dsDoc2(var dsDoc2: OleVariant); safecall;
    function Get_dsDoc3: OleVariant; safecall;
    procedure Set_dsDoc3(var dsDoc3: OleVariant); safecall;
    procedure _Set_dsDoc3(var dsDoc3: OleVariant); safecall;
    function Get_dsDocTemp: _Recordset; safecall;
    procedure GhostMethod__Common_176_2; safecall;
    procedure _Set_dsDocTemp(const dsDocTemp: _Recordset); safecall;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant; safecall;
    function GetMDBName: OleVariant; safecall;
    function CheckNotForDemo: OleVariant; safecall;
    function Random(var lowerbound: OleVariant; var upperbound: OleVariant): OleVariant; safecall;
    function ReadBinFile(const bfilename: WideString): OleVariant; safecall;
    function TransText(const myString: WideString): WideString; safecall;
    function LicCheck: OleVariant; safecall;
    function GoProcess(const myString: WideString): WideString; safecall;
    function test(const myString: WideString): WideString; safecall;
    function OnEndPage: OleVariant; safecall;
    procedure ActiveX_Main; safecall;
    procedure DoGet; safecall;
    procedure DoPost; safecall;
    function ToALLuni(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant; safecall;
    function ToALLlocal(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant; safecall;
    function GetSessionID: OleVariant; safecall;
    procedure Login(var VAR_StatusActiveUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_LOGGEDIN: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                    var DOCS_STATUSHOLD: OleVariant; var USER_Role: OleVariant; 
                    var DOCS_WRONGLOGIN: OleVariant; var DOCS_SysUser: OleVariant; 
                    var DOCS_ActionLoggedIn: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                    var DOCS_NoUsersExceeded: OleVariant; var DOCS_NoPassword: OleVariant; 
                    var USER_StatusActiveEMail: OleVariant); safecall;
    procedure GetCurrentUsers(var sUsers: OleVariant; var sTimes: OleVariant; 
                              var sAddresses: OleVariant; var VAR_BeginOfTimes: OleVariant); safecall;
    procedure Logout(var DOCS_LOGGEDOUT: OleVariant; var DOCS_ActionLogOut: OleVariant; 
                     var DOCS_SysUser: OleVariant); safecall;
    function MyInt(var dVal: OleVariant): OleVariant; safecall;
    function MyCStr(var cPar: OleVariant): OleVariant; safecall;
    procedure Delay(var nTicks: OleVariant); safecall;
    procedure SendSMS(var cPhone: OleVariant; var cMessage: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOCS_NOPHONECELL: OleVariant; 
                      var DOCS_WRONGPHONECELL: OleVariant; var DOCS_SMSMessagingOFF: OleVariant; 
                      var DOCS_SMSMessagingERROR: OleVariant); safecall;
    procedure ShowTimes(var sMes: OleVariant; var bShowTimes: OleVariant); safecall;
    procedure SendSMSMessage(var bErr: OleVariant; var sMessage: OleVariant; 
                             sPhoneNumber: OleVariant; const msg: WideString; 
                             var nPort: OleVariant; var DOCS_SMSError: OleVariant; 
                             var DOCS_GSMModemBusy: OleVariant; 
                             var DOCS_WRONGPHONECELL: OleVariant; 
                             var DOCS_GSMModemError1: OleVariant; var nDelay: OleVariant; 
                             var nTimes: OleVariant; var nDelayTimes: OleVariant; 
                             var bShowTimes: OleVariant); safecall;
    function GetCompanyName(var sDept: OleVariant): OleVariant; safecall;
    function ShowStatusExtInt(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                              var DOCS_Int: OleVariant; var DOCS_Ext: OleVariant): OleVariant; safecall;
    function ShowStatusArchiv(var cPar: OleVariant; var VAR_StatusArchiv: OleVariant; 
                              var DOCS_Archiv: OleVariant; var DOCS_Current: OleVariant): OleVariant; safecall;
    function ShowStatusCompletion(var cPar: OleVariant; var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant): OleVariant; safecall;
    function ShowStatusPaymentDirection(var cPar: OleVariant; var DOCS_PaymentOutgoing: OleVariant; 
                                        var DOCS_PaymentIncoming: OleVariant; 
                                        var DOCS_NotPaymentDoc: OleVariant): OleVariant; safecall;
    function ShowStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                               var DOCS_StatusPaymentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentToPay: OleVariant; 
                               var DOCS_StatusPaymentPaid: OleVariant; 
                               var DOCS_StatusExistsButNotDefined: OleVariant; 
                               var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                               var DOCS_StatusPaymentPaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant; safecall;
    function GetStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                              var DOCS_StatusPaymentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentToPay: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant; 
                              var DOCS_StatusExistsButNotDefined: OleVariant; 
                              var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                              var DOCS_StatusPaymentPaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant; safecall;
    function ShowBPtype(var cPar: OleVariant; var DOCS_BPTypeDaily: OleVariant; 
                        var DOCS_BPTypeWeekly: OleVariant; var DOCS_BPTypeMonthly: OleVariant): OleVariant; safecall;
    function ShowStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                               var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant; safecall;
    function GetStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant): OleVariant; safecall;
    function ShowStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                   var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                   var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant; safecall;
    function GetStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                  var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant; safecall;
    function GetStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                               var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                               var DOCS_Returned: OleVariant; 
                               var DOCS_ReturnedFromFile: OleVariant; 
                               var DOCS_WaitingToBeSent: OleVariant): OleVariant; safecall;
    function GetStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                              var DOCS_IsExactly: OleVariant): OleVariant; safecall;
    function ShowStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                               var DOCS_IsExactly: OleVariant): OleVariant; safecall;
    function ShowStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                                var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_WaitingToBeSent: OleVariant): OleVariant; safecall;
    function ShowStatusActive(var cPar: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                              var VAR_StatusActiveUserEMail: OleVariant; var DOCS_Yes: OleVariant; 
                              var DOCS_No: OleVariant; var DOCS_Yes_EMail: OleVariant): OleVariant; safecall;
    function ShowStatusExtIntUser(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_Yes: OleVariant; var DOCS_No: OleVariant): OleVariant; safecall;
    function ShowStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                     var DOCS_SecurityLevel2: OleVariant; 
                                     var DOCS_SecurityLevel3: OleVariant; 
                                     var DOCS_SecurityLevel4: OleVariant; 
                                     var DOCS_SecurityLevelS: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function ShowSpecType(var cPar: OleVariant; var VAR_TypeVal_String: OleVariant; 
                          var VAR_TypeVal_DateTime: OleVariant; 
                          var VAR_TypeVal_NumericMoney: OleVariant; 
                          var DOCS_SpecFieldTypeString: OleVariant; 
                          var DOCS_SpecFieldTypeDate: OleVariant; 
                          var DOCS_SpecFieldTypeNumeric: OleVariant): OleVariant; safecall;
    function GetStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                    var DOCS_SecurityLevel2: OleVariant; 
                                    var DOCS_SecurityLevel3: OleVariant; 
                                    var DOCS_SecurityLevel4: OleVariant; 
                                    var DOCS_SecurityLevelS: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function MakeSQLSafe(var strInput: OleVariant): OleVariant; safecall;
    function FixLen(var cPar: OleVariant; var iLen: OleVariant; var sSymbol: OleVariant): OleVariant; safecall;
    function RightValue(var strInput: OleVariant): OleVariant; safecall;
    procedure PutMessage; safecall;
    procedure PutMessage1; safecall;
    function NoLastBr(cPar: OleVariant): OleVariant; safecall;
    function PutDirNRec(cPar: OleVariant): OleVariant; safecall;
    procedure RedirHome; safecall;
    procedure RedirMessage; safecall;
    procedure RedirMessage1(var cPar: OleVariant); safecall;
    procedure RedirMessage2; safecall;
    procedure RedirStopped; safecall;
    procedure RedirShowDoc(var cPar: OleVariant); safecall;
    procedure CheckReg; safecall;
    function CheckRegF: OleVariant; safecall;
    procedure CheckAdmin(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); safecall;
    procedure CheckIfDocIDIncomingExists(var sDocIDIncoming: OleVariant; var ds: OleVariant); safecall;
    procedure SetIndexSearch(var rs: OleVariant; var sCATALOG: OleVariant; 
                             var DOCS_IndexError: OleVariant; var VAR_DocsMaxRecords: OleVariant); safecall;
    function CheckAdminF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; safecall;
    procedure CheckAdminOrUser(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant); safecall;
    function CheckAdminOrUserF(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant): OleVariant; safecall;
    procedure CheckAdminOrUser1(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); safecall;
    function CheckAdminOrUser1F(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; safecall;
    procedure CheckAdminRead(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); safecall;
    function CheckAdminReadF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; safecall;
    function GetURL(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant): OleVariant; safecall;
    function GetUserNFromList(var clist: OleVariant; var cnumber: OleVariant): OleVariant; safecall;
    function GetUserID(var cPar: OleVariant): OleVariant; safecall;
    function GetUserEMail(var cparUserID: OleVariant): OleVariant; safecall;
    function GetURL2(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant): OleVariant; safecall;
    function GetURL3(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant): OleVariant; safecall;
    function GetURL4(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant): OleVariant; safecall;
    function GetURL5(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant; 
                     var cpar5: OleVariant; var cvalue5: OleVariant): OleVariant; safecall;
    procedure CheckReadAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant); safecall;
    function CheckReadAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    procedure CheckWriteAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    function CheckWriteAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function IsWriteAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function IsReadAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                          var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                          var VAR_ExtInt: OleVariant): OleVariant; safecall;
    function IsReadAccessDocID(var sDocID: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function IsReadAccessRS(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant): OleVariant; safecall;
    function IsReadAccessUser(var sUserID: OleVariant; var sMessage: OleVariant; 
                              var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; 
                              var VAR_StatusActiveUser: OleVariant): OleVariant; safecall;
    procedure NoAccessReport(var cPar: OleVariant); safecall;
    procedure AddLog(var sDocID: OleVariant; var sAction: OleVariant; var sDocName: OleVariant); safecall;
    function SafeSQL(var cPar: OleVariant): OleVariant; safecall;
    procedure AddLogAmountQuantity(var sAmountDocOld: OleVariant; var sAmountDocNew: OleVariant; 
                                   var sQuantityDocOld: OleVariant; 
                                   var sQuantityDocNew: OleVariant; var sDocID: OleVariant; 
                                   var sDocIDParent: OleVariant; var sName: OleVariant; 
                                   var DOCS_ActionChangeDocShort: OleVariant; 
                                   var DOCS_ActionChangeDoc: OleVariant; 
                                   var DOCS_ActionChangeDependantDoc: OleVariant); safecall;
    procedure AddLogD(var cPar: OleVariant); safecall;
    procedure AddLogPostcard(var cPar: OleVariant); safecall;
    procedure AddLogDocAndParent(var sDocID: OleVariant; var sDocIDParent: OleVariant; 
                                 var sName: OleVariant; var sAmount: OleVariant; 
                                 var sQuantity: OleVariant; var sAction: OleVariant; 
                                 var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant); safecall;
    function CheckPermit(var sSource: OleVariant; var cPar: OleVariant): OleVariant; safecall;
    procedure GetPermit(var sSource: OleVariant; var cPar: OleVariant); safecall;
    procedure DeletePermit(var sSource: OleVariant; var cPar: OleVariant); safecall;
    function GetMiddleUniqueIdentifier(var UI1: OleVariant; var UI2: OleVariant): OleVariant; safecall;
    function CorrectUniqueIdentifier(var UI: OleVariant): OleVariant; safecall;
    function MyFormatCurrency(var rVal: OleVariant): OleVariant; safecall;
    function MyFormatRate(var rVal: OleVariant): OleVariant; safecall;
    function FormatCommon(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function FormatNumberShort(var rVal: OleVariant): OleVariant; safecall;
    function MyTableVal(var xVal: OleVariant): OleVariant; safecall;
    function IsTime(var dVal: OleVariant): OleVariant; safecall;
    function MyDateLong(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                        var DOCS_PERIOD_JAN1: OleVariant; var DOCS_PERIOD_FEB1: OleVariant; 
                        var DOCS_PERIOD_MAR1: OleVariant; var DOCS_PERIOD_APR1: OleVariant; 
                        var DOCS_PERIOD_MAY1: OleVariant; var DOCS_PERIOD_JUN1: OleVariant; 
                        var DOCS_PERIOD_JUL1: OleVariant; var DOCS_PERIOD_AUG1: OleVariant; 
                        var DOCS_PERIOD_SEP1: OleVariant; var DOCS_PERIOD_OCT1: OleVariant; 
                        var DOCS_PERIOD_NOV1: OleVariant; var DOCS_PERIOD_DEC1: OleVariant): OleVariant; safecall;
    function MyDate(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function MyDateTime(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function MyDateShort(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function MyChar(var dVal: OleVariant): OleVariant; safecall;
    function MyDateBr(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function NoNull(var cPar: OleVariant): OleVariant; safecall;
    function NoZeroFormat(var cPar: OleVariant): OleVariant; safecall;
    function DocsDate(var cPar: OleVariant): OleVariant; safecall;
    function EuroDateTime(var cPar: OleVariant): OleVariant; safecall;
    function DateName(var dDate: OleVariant): OleVariant; safecall;
    function UniDate(var dDate: OleVariant): OleVariant; safecall;
    function LeadZero(var cPar: OleVariant): OleVariant; safecall;
    function ConvertToDateOLD(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                              var DOCS_WrongDate: OleVariant): OleVariant; safecall;
    function ConvertToDate(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant): OleVariant; safecall;
    function IsFormula(var dsDoc: OleVariant): OleVariant; safecall;
    function IsAprovalRequired(dsDoc: OleVariant; var sUserID: OleVariant; 
                               var Var_ApprovalPermitted: OleVariant; 
                               var VAR_InActiveTask: OleVariant; var VAR_StatusCancelled: OleVariant): OleVariant; safecall;
    procedure GetCalendarDocs(nDocs: OleVariant; var sDocs: OleVariant; nYear: OleVariant; 
                              nMonth: OleVariant; sUserID: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_PERIOD_Date: OleVariant; var DOCS_DocID: OleVariant; 
                              var DOCS_DocIDAdd: OleVariant; var DOCS_DocIDParent: OleVariant; 
                              var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                              var DOCS_PartnerName: OleVariant; 
                              var DOCS_NameResponsible: OleVariant; 
                              var DOCS_NameControl: OleVariant; var DOCS_NameAproval: OleVariant; 
                              var DOCS_ListToView: OleVariant; var DOCS_ListToEdit: OleVariant; 
                              var DOCS_ListToReconcile: OleVariant; var DOCS_Author: OleVariant; 
                              var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                              var DOCS_History: OleVariant; var DOCS_NameCreation: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                              var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant; 
                              var DOCS_ListReconciled: OleVariant; 
                              var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                              var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                              var DOCS_DocIDIncoming: OleVariant; 
                              var DOCS_DateCompletion: OleVariant; 
                              var DOCS_DateActivation: OleVariant; var StyleCalendar: OleVariant; 
                              var VAR_StatusCancelled: OleVariant; 
                              var VAR_StatusCompletion: OleVariant; var DOCS_EXPIRED2: OleVariant; 
                              var DOCS_Completed: OleVariant; var DOCS_Cancelled2: OleVariant; 
                              var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                              var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                              var DOCS_ClassDoc: OleVariant; var Var_ApprovalPermitted: OleVariant; 
                              var DOCS_APROVALREQUIRED: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant); safecall;
    procedure GetCalendarEvents(var sDocs: OleVariant; nYear: OleVariant; nMonth: OleVariant; 
                                sUserID: OleVariant; var BGColorLight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_DateTime: OleVariant; 
                                var DOCS_DateTimeEnd: OleVariant; var StyleCalendar: OleVariant; 
                                sWidth: OleVariant); safecall;
    function PutEvent(iCase: OleVariant; cInfo: OleVariant; sLink: OleVariant; 
                      BGColorLight: OleVariant; StyleCalendar: OleVariant; sWidth: OleVariant): OleVariant; safecall;
    function PutInfoPicture(var cInfo: OleVariant; var cPic: OleVariant): OleVariant; safecall;
    function GetName(var cPar: OleVariant): OleVariant; safecall;
    function GetFullName(var cParName: OleVariant; var cParID: OleVariant): OleVariant; safecall;
    function GetPosition(var cPar: OleVariant): OleVariant; safecall;
    procedure GetUserDetails(var cPar: OleVariant; var sName: OleVariant; var sPhone: OleVariant; 
                             var sEMail: OleVariant; var sICQ: OleVariant; 
                             var sDepartment: OleVariant; var sPartnerName: OleVariant; 
                             var sPosition: OleVariant; var sIDentification: OleVariant; 
                             var sIDNo: OleVariant; var sIDIssuedBy: OleVariant; 
                             var dIDIssueDate: OleVariant; var dIDExpDate: OleVariant; 
                             var dBirthDate: OleVariant; var sCorporateIDNo: OleVariant; 
                             var sAddInfo: OleVariant; var sComment: OleVariant); safecall;
    function GetPositionsNames(var cPar: OleVariant; var cDel1: OleVariant; var cDel2: OleVariant): OleVariant; safecall;
    function GetSuffix(var cPar: OleVariant): OleVariant; safecall;
    function RightName(cPar: OleVariant): OleVariant; safecall;
    function ToEng(var cPar: OleVariant): OleVariant; safecall;
    function ToEngSMS(var cPar: OleVariant): OleVariant; safecall;
    function ToTheseSymbolsOnly(var sSymbols: OleVariant; var cPar: OleVariant): OleVariant; safecall;
    function PutInString(var cPar: OleVariant; var nPar: OleVariant): OleVariant; safecall;
    function GetNameAsLink(var cPar: OleVariant): OleVariant; safecall;
    function GetNameAsLinkGN(var cPar: OleVariant): OleVariant; safecall;
    function GetLogin(var cPar: OleVariant): OleVariant; safecall;
    function NamesIn2ndForm(var cPar: OleVariant): OleVariant; safecall;
    function NamesIn3rdForm(var cPar: OleVariant): OleVariant; safecall;
    function NamesIn3ndForm(var cPar: OleVariant): OleVariant; safecall;
    procedure CreateAutoCommentGUID(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant; var sGUID: OleVariant); safecall;
    procedure CreateAutoComment(var sDocID: OleVariant; var sComment: OleVariant); safecall;
    procedure CreateAutoCommentType(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant); safecall;
    procedure ConfirmNotification; safecall;
    function GetCompatibleSpec(var sSpecIDs: OleVariant; var sItemNameP: OleVariant): OleVariant; safecall;
    function ShowSpecName(var cPar: OleVariant): OleVariant; safecall;
    function GetBusinessProcessSteps(var cPar: OleVariant): OleVariant; safecall;
    function GenNewDocID(var cParDocIDOld: OleVariant): OleVariant; safecall;
    function GenNewDocIDIncrement(var iD: OleVariant; var Var_MaxLong: OleVariant): OleVariant; safecall;
    function NoVbCrLf(var cPar: OleVariant): OleVariant; safecall;
    function GetDocDetails(var cPar: OleVariant; var bIsShowLinks: OleVariant; var cRS: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DocIDAdd: OleVariant; 
                           var DOCS_DocIDParent: OleVariant; var DOCS_AmountDoc: OleVariant; 
                           var DOCS_QuantityDoc: OleVariant; var DOCS_PartnerName: OleVariant; 
                           var DOCS_NameResponsible: OleVariant; var DOCS_NameControl: OleVariant; 
                           var DOCS_NameAproval: OleVariant; var DOCS_ListToView: OleVariant; 
                           var DOCS_ListToEdit: OleVariant; var DOCS_ListToReconcile: OleVariant; 
                           var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                           var DOCS_NameCreation: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                           var DOCS_Internal: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_ListReconciled: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                           var DOCS_DocIDIncoming: OleVariant; var DOCS_DateCompletion: OleVariant; 
                           var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                           var DOCS_ClassDoc: OleVariant): OleVariant; safecall;
    function GetDocAmount(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                          var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant; safecall;
    function GetDocDateActivation(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    function GetDocName(var cPar: OleVariant): OleVariant; safecall;
    function GetUserDepartment(var cPar: OleVariant): OleVariant; safecall;
    function IsNamesCompatible(sName1: OleVariant; sName2: OleVariant): OleVariant; safecall;
    function IsWorkingDay(var nDay: OleVariant; var nStaffTableMonth: OleVariant; 
                          var nStaffTableYear: OleVariant; var CMonths: OleVariant; 
                          var CDays: OleVariant): OleVariant; safecall;
    function ShowWeekday(var sItemName: OleVariant; var nStaffTableMonth: OleVariant; 
                         var nStaffTableYear: OleVariant; var IsHTML: OleVariant; 
                         var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                         var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                         var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                         var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                         var CMonths: OleVariant; var CDays: OleVariant): OleVariant; safecall;
    procedure Out(var cPar: OleVariant); safecall;
    procedure Out1(var cPar: OleVariant); safecall;
    procedure SendNotification(var cParRS: OleVariant; var cParDocID: OleVariant; 
                               var cRecipient: OleVariant; var cSubject: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                               var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                               var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure SendNotification1(var cParRS: OleVariant; var cParDocID: OleVariant; 
                                var cRecipient: OleVariant; var cSubject: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant); safecall;
    procedure SendNotification2(var sMessageBody: OleVariant; var cParRS: OleVariant; 
                                var cParDocID: OleVariant; var cRecipient: OleVariant; 
                                var cSubject: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant); safecall;
    function SurnameGN(var cPar: OleVariant): OleVariant; safecall;
    function IsOutNotif(var bPrint: OleVariant): OleVariant; safecall;
    procedure QueueDirectoryFiles(var sQueueDirectory: OleVariant; var Files: OleVariant); safecall;
    procedure EMailPatch1(var objMail: OleVariant); safecall;
    procedure SendNotificationCore(var sMessageBody: OleVariant; var dsTemp: OleVariant; 
                                   var sS_Description: OleVariant; var S_UserList: OleVariant; 
                                   var S_MessageSubject: OleVariant; var S_MessageBody: OleVariant; 
                                   var S_DocID: OleVariant; var S_SecurityLevel: OleVariant; 
                                   var sSend: OleVariant; var USER_Department: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var bPrint: OleVariant; 
                                   var MailTexts: OleVariant); safecall;
    function GetAuthenticode(var sDocID: OleVariant; var sDateCreation: OleVariant; 
                             var sUserID: OleVariant; var sAction: OleVariant): OleVariant; safecall;
    function CheckAuthenticode(const sAuthenticode: WideString): OleVariant; safecall;
    function ClickEMailOld(var cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; safecall;
    function ClickEMail(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                        var cSendAction: OleVariant; var sWarning: OleVariant; 
                        var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; safecall;
    function ClickEMailNot(var cTitle: OleVariant; var cButton: OleVariant): OleVariant; safecall;
    function ClickEMailComment(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                               var cSendAction: OleVariant; var sWarning: OleVariant; 
                               var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; safecall;
    function ClickEMailFile(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                            var cSendAction: OleVariant; var sWarning: OleVariant; 
                            var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; safecall;
    function ClickEMailNoPic(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; safecall;
    function ClickEMailBig1(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; safecall;
    function ClickEMailBig(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                           var cSendAction: OleVariant; var sWarning: OleVariant; 
                           var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; safecall;
    function Status(var cName: OleVariant; var cTitle: OleVariant): OleVariant; safecall;
    function Sep(var cName: OleVariant; var cTitle: OleVariant): OleVariant; safecall;
    procedure AddLogA(var sLog: OleVariant); safecall;
    function DOUT(var sLog: OleVariant): OleVariant; safecall;
    function ExtractMessage(const iBp: IBodyPart): IMessage; safecall;
    procedure ProcessEMail(var sFile: OleVariant; var sDocID: OleVariant; 
                           var strSubject: OleVariant; var strFrom: OleVariant; 
                           var bErr: OleVariant; var sMessage: OleVariant; var Texts: OleVariant; 
                           var MailTexts: OleVariant); safecall;
    procedure ProcessEMailClient(var Texts: OleVariant; var MailTexts: OleVariant); safecall;
    procedure ProcessEMailClientCommand(var bDeleteFile: OleVariant; var sFile: OleVariant; 
                                        var iMsg: OleVariant; var sContent1: OleVariant; 
                                        var sAuthenticode: OleVariant; var sMessage: OleVariant; 
                                        var sUserEMail: OleVariant; var Texts: OleVariant; 
                                        var MailTexts: OleVariant; 
                                        var Var_nDaysToReconcile: OleVariant); safecall;
    function ClickEMailDocID(var sDocID: OleVariant; var cSendAction: OleVariant; 
                             var sWarning: OleVariant; var cCommand: OleVariant; 
                             var cAuthenticode: OleVariant; var StyleDetailValues: OleVariant): OleVariant; safecall;
    function NoEmpty(var cPar: OleVariant): OleVariant; safecall;
    function NotSkipThisRecord(var sAction: OleVariant; var dsDoc: OleVariant; 
                               var VAR_StatusCompletion: OleVariant; 
                               var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                               var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                               var VAR_InActiveTask: OleVariant): OleVariant; safecall;
    function GetEMailPar(var sContent: OleVariant; sCommand: OleVariant): OleVariant; safecall;
    function GetEMailParDelimiter(var sContent: OleVariant; sPar: OleVariant; sDelimiter: OleVariant): OleVariant; safecall;
    function GetEMailParComment(var sCont: OleVariant): OleVariant; safecall;
    function Koi2Win(var StrKOI: OleVariant): OleVariant; safecall;
    function ShowDocRow(var cTitle: OleVariant; var cValue: OleVariant): OleVariant; safecall;
    function IsValidEMail(var cPar: OleVariant): OleVariant; safecall;
    procedure SendPostcard(var sFile: OleVariant; var sFileMuz: OleVariant; 
                           var DOCS_PostcardSent: OleVariant; var DOCS_EMailOff: OleVariant; 
                           var DOCS_TITLEFooter: OleVariant; var DOCS_Postcard: OleVariant; 
                           var DOCS_NOEMailSender: OleVariant; var DOCS_BADEMailSender: OleVariant); safecall;
    procedure RunGetDocSend(var cTo: OleVariant; var cFrom: OleVariant; var cBody: OleVariant; 
                            var cSubject: OleVariant; var cBodyFormat: OleVariant; 
                            var cFile: OleVariant; var DOCS_TITLEFooter: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant); safecall;
    function GetFileName(var cPar: OleVariant): OleVariant; safecall;
    function HTMLEncode(var cPar: OleVariant): OleVariant; safecall;
    function HTMLEncodeNBSP(var cPar: OleVariant): OleVariant; safecall;
    function CRtoBR(var cPar: OleVariant): OleVariant; safecall;
    function CRtoBRHTMLEncode(var cPar: OleVariant): OleVariant; safecall;
    function CRtoSeparatorHTMLEncode(var cPar: OleVariant; var cSeparator: OleVariant): OleVariant; safecall;
    function SeparatorToBR(var cPar: OleVariant; var cSep: OleVariant): OleVariant; safecall;
    function SeparatorToSymbols(var cPar: OleVariant; var cSep: OleVariant; var cSymbols: OleVariant): OleVariant; safecall;
    function BoldContext(var cPar: OleVariant; var cCon: OleVariant): OleVariant; safecall;
    function ShowBoldCurrentUserName(var cPar: OleVariant): OleVariant; safecall;
    function CR: OleVariant; safecall;
    procedure ShowContextMarks(var cPar: OleVariant; var cOnlyMarks: OleVariant); safecall;
    function MyNumericStr(var cPar: OleVariant): OleVariant; safecall;
    function IsVisaNow(var sUserID: OleVariant; var sListToReconcile: OleVariant; 
                       var sListReconciled: OleVariant; var sNameApproved: OleVariant): OleVariant; safecall;
    function IsVisaLast(var sUserID: OleVariant; var sListReconciled: OleVariant): OleVariant; safecall;
    function MyTrim(var cPar: OleVariant): OleVariant; safecall;
    function MyDayName(var cPar: OleVariant; var DOCS_PERIOD_SAN: OleVariant; 
                       var DOCS_PERIOD_MON: OleVariant; var DOCS_PERIOD_TUS: OleVariant; 
                       var DOCS_PERIOD_WED: OleVariant; var DOCS_PERIOD_THU: OleVariant; 
                       var DOCS_PERIOD_FRI: OleVariant; var DOCS_PERIOD_SAT: OleVariant): OleVariant; safecall;
    function QuarterName(var dPar: OleVariant; var DOCS_PERIOD_Quarter: OleVariant): OleVariant; safecall;
    procedure SCORE_GetDate(var dDATEFROM: OleVariant; var dDATETO: OleVariant; 
                            var S_FirstPeriod: OleVariant; var S_PeriodType: OleVariant; 
                            var iPeriod: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant); safecall;
    function MyMonthName(var cPar: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                         var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                         var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                         var DOCS_PERIOD_JUN: OleVariant; var DOCS_PERIOD_JUL: OleVariant; 
                         var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                         var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                         var DOCS_PERIOD_DEC: OleVariant): OleVariant; safecall;
    function MonthNameEng(var cPar: OleVariant): OleVariant; safecall;
    function IsReconciliationComplete(var S_ListToReconcile: OleVariant; 
                                      var S_ListReconciled: OleVariant): OleVariant; safecall;
    function MarkReconciledNames(var cPar: OleVariant; var cParReconciled: OleVariant; 
                                 var DOCS_NextStepToReconcile: OleVariant; 
                                 var DOCS_Reconciled: OleVariant; var DOCS_Refused: OleVariant): OleVariant; safecall;
    function PutInfo(var cPar: OleVariant): OleVariant; safecall;
    function ShowCustomerName: OleVariant; safecall;
    function InsertCommentTypeImageAsLink(var sDocID: OleVariant; var sKeyField: OleVariant; 
                                          var sSubject: OleVariant; var sComment: OleVariant; 
                                          var cParCommentType: OleVariant; 
                                          var cParSpecialInfo: OleVariant; 
                                          var cParAddress: OleVariant; 
                                          var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                          var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                          var DOCS_Comment: OleVariant; 
                                          var DOCS_RespComment: OleVariant; 
                                          var DOCS_LocationPaper: OleVariant; 
                                          var DOCS_VersionFile: OleVariant; 
                                          var DOCS_SystemMessage: OleVariant; 
                                          var DOCS_Viewed: OleVariant; var DOCS_News: OleVariant; 
                                          var DOCS_CreateRespComment: OleVariant): OleVariant; safecall;
    function InsertCommentTypeImage(var cParCommentType: OleVariant; 
                                    var cParSpecialInfo: OleVariant; var cParAddress: OleVariant; 
                                    var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                    var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                    var DOCS_Comment: OleVariant; var DOCS_RespComment: OleVariant; 
                                    var DOCS_LocationPaper: OleVariant; 
                                    var DOCS_VersionFile: OleVariant; 
                                    var DOCS_SystemMessage: OleVariant; 
                                    var DOCS_Viewed: OleVariant; var DOCS_PushToGet: OleVariant; 
                                    var DOCS_MSWordExcelOnServer: OleVariant): OleVariant; safecall;
    function GetNewUserIDsInList(var sNotificationListForListToReconcileBefore: OleVariant; 
                                 var sNotificationListForListToReconcileAfter: OleVariant; 
                                 var IsRefused: OleVariant): OleVariant; safecall;
    function GetNextUserIDInList(var sList: OleVariant; var iPos: OleVariant): OleVariant; safecall;
    function GetNotificationListForListToReconcile1(var S_ListToReconcile: OleVariant; 
                                                    var S_ListReconciled: OleVariant; 
                                                    var S_NameApproved: OleVariant; 
                                                    var S_NameAproval: OleVariant; 
                                                    var bRefused: OleVariant): OleVariant; safecall;
    function GetNotificationListForListToReconcile(var S_ListToReconcile: OleVariant; 
                                                   var S_ListReconciled: OleVariant; 
                                                   var S_NameApproved: OleVariant; 
                                                   var bRefused: OleVariant): OleVariant; safecall;
    function GetNotificationListForDocActivation(var dsDoc: OleVariant): OleVariant; safecall;
    procedure MakeDocActiveOrInactiveInList(var bActiveTask: OleVariant; var dsDoc1: OleVariant; 
                                            var bPutMes: OleVariant; 
                                            var VAR_ActiveTask: OleVariant; 
                                            var VAR_InActiveTask: OleVariant; 
                                            var VAR_BeginOfTimes: OleVariant; 
                                            var DOCS_NOTFOUND: OleVariant; 
                                            var DOCS_DocID: OleVariant; 
                                            var DOCS_DateActivation: OleVariant; 
                                            var DOCS_DateCompletion: OleVariant; 
                                            var DOCS_Name: OleVariant; 
                                            var DOCS_PartnerName: OleVariant; 
                                            var DOCS_ACT: OleVariant; 
                                            var DOCS_Description: OleVariant; 
                                            var DOCS_Author: OleVariant; 
                                            var DOCS_Correspondent: OleVariant; 
                                            var DOCS_Resolution: OleVariant; 
                                            var DOCS_NotificationSentTo: OleVariant; 
                                            var DOCS_SendNotification: OleVariant; 
                                            var DOCS_UsersNotFound: OleVariant; 
                                            var DOCS_NotificationDoc: OleVariant; 
                                            var USER_NOEMail: OleVariant; 
                                            var DOCS_NoAccess: OleVariant; 
                                            var DOCS_EXPIREDSEC: OleVariant; 
                                            var DOCS_STATUSHOLD: OleVariant; 
                                            var VAR_StatusActiveUser: OleVariant; 
                                            var DOCS_ErrorSMTP: OleVariant; 
                                            var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                            var DOCS_NoReadAccess: OleVariant; 
                                            var USER_Department: OleVariant; 
                                            var VAR_ExtInt: OleVariant; 
                                            var VAR_AdminSecLevel: OleVariant; 
                                            var DOCS_FROM1: OleVariant; 
                                            var DOCS_Reconciliation: OleVariant; 
                                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                            var MailTexts: OleVariant; 
                                            var Var_nDaysToReconcile: OleVariant); safecall;
    function GetUserNotificationList(var sNotificationList: OleVariant; var dsDoc: OleVariant): OleVariant; safecall;
    procedure MakeDocActiveOrInactive(var sNotificationList: OleVariant; var DOCS_All: OleVariant; 
                                      var DOCS_NoWriteAccess: OleVariant; 
                                      var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; 
                                      var VAR_InActiveTask: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_UnderDevelopment: OleVariant; 
                                      var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                      var VAR_StatusCompletion: OleVariant; 
                                      var VAR_StatusCancelled: OleVariant; 
                                      var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                      var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                      var DOCS_Approving: OleVariant; 
                                      var DOCS_Approved: OleVariant; 
                                      var DOCS_RefusedApp: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant; 
                                      var Var_nDaysToReconcile: OleVariant); safecall;
    procedure CreateReconciliationComment(var dsDoc: OleVariant; var nDaysToReconcile: OleVariant; 
                                          var DOCS_Reconciliation: OleVariant); safecall;
    procedure DeleteReconciliationComments(var sDocID: OleVariant); safecall;
    procedure DeleteReconciliationCommentsCanceled(var dsDoc: OleVariant); safecall;
    procedure UpdateReconciliationComments(var sDocID: OleVariant; var sMessage: OleVariant; 
                                           var sStatus: OleVariant; 
                                           var VAR_BeginOfTimes: OleVariant; 
                                           var DOCS_DateDiff1: OleVariant); safecall;
    procedure ModifyPaymentStatus(var sNotificationList: OleVariant; 
                                  var DOCS_StatusPaymentNotPaid: OleVariant; 
                                  var DOCS_StatusPaymentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentToPay: OleVariant; 
                                  var DOCS_StatusPaymentPaid: OleVariant; 
                                  var DOCS_StatusExistsButNotDefined: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var VAR_ActiveTask: OleVariant; var VAR_InActiveTask: OleVariant; 
                                  var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                  var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                  var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                                  var DOCS_RefusedApp: OleVariant; 
                                  var VAR_StatusActiveUser: OleVariant; var DOCS_DocID: OleVariant; 
                                  var DOCS_DateActivation: OleVariant; 
                                  var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                  var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                  var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                  var DOCS_Correspondent: OleVariant; 
                                  var DOCS_Resolution: OleVariant; 
                                  var DOCS_NotificationSentTo: OleVariant; 
                                  var DOCS_SendNotification: OleVariant; 
                                  var DOCS_UsersNotFound: OleVariant; 
                                  var DOCS_NotificationDoc: OleVariant; 
                                  var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                  var DOCS_STATUSHOLD: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                  var DOCS_Sender: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_StatusAlreadyChanged: OleVariant; 
                                  var DOCS_StatusCancel: OleVariant; var DOCS_FROM1: OleVariant; 
                                  var DOCS_Reconciliation: OleVariant; 
                                  var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                  var DOCS_StatusPaymentCancel: OleVariant; 
                                  var MailTexts: OleVariant); safecall;
    procedure CreateAutoCommentPayment(var sDocID: OleVariant; var sComment: OleVariant; 
                                       var sStatus: OleVariant; var sAmountPart: OleVariant; 
                                       var sAmountPart2: OleVariant; var rAmountPart: OleVariant; 
                                       var sAccount: OleVariant; var sAccount2: OleVariant; 
                                       var bIncoming: OleVariant); safecall;
    procedure ModifyAccountBalance(sAccount: OleVariant; rAmount: OleVariant; var bErr: OleVariant); safecall;
    procedure MakeCanceled(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                           var VAR_StatusCancelled: OleVariant; var DOCS_Cancelled: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                           var bUpdated: OleVariant); safecall;
    procedure MakeCompleted(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                            var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var USER_NOEMail: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                            var bUpdated: OleVariant); safecall;
    procedure MakeRefuseCompletion(var sNotificationList: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_WrongDate: OleVariant; 
                                   var VAR_StatusCompletion: OleVariant; 
                                   var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant; var But_RefuseCompletion: OleVariant); safecall;
    procedure MakeSigned(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                         var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var VAR_StatusCompletion: OleVariant; var DOCS_Signed: OleVariant; 
                         var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                         var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                         var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_SendNotification: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                         var DOCS_DateActivation: OleVariant; var DOCS_DateSigned: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                         var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                         var DOCS_Author: OleVariant; var DOCS_FROM1: OleVariant; 
                         var DOCS_Reconciliation: OleVariant; 
                         var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant); safecall;
    procedure AutoFill(var DOCS_NORight: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                       var Var_StandardWorkHours: OleVariant; var DOCS_All: OleVariant; 
                       var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                       var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                       var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                       var CMonths: OleVariant; var CDays: OleVariant); safecall;
    procedure ModifyPercent(var DOCS_PercentCompletion: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_WrongAmount: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_PercentValueWarning: OleVariant); safecall;
    function IsResponsibleOnly(var S_NameAproval: OleVariant; var S_NameCreation: OleVariant; 
                               var S_ListToEdit: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var S_NameResponsible: OleVariant): OleVariant; safecall;
    procedure CreateAutoCommentListToEdit(var dsDocListToEdit: OleVariant; 
                                          var RequestListToEdit: OleVariant; 
                                          var sDocID: OleVariant; var DOCS_Changed: OleVariant; 
                                          var DOCS_ListToEdit: OleVariant; 
                                          var DOCS_Added: OleVariant; var DOCS_Deleted: OleVariant); safecall;
    function IsDocIDExist(var sDocID: OleVariant): OleVariant; safecall;
    procedure ChangeDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_StatusCompletion: OleVariant; 
                             var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant); safecall;
    procedure ChangeOneDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; 
                                var VAR_StatusCompletion: OleVariant; 
                                var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant); safecall;
    procedure AddListCorrespondentRet(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                      var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_InfoAlreadyExists: OleVariant; 
                                      var DOCS_InformationNotUpdated: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant); safecall;
    procedure MakeArchival(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_Archival: OleVariant; 
                           var DOCS_Operative: OleVariant; var VAR_StatusArchiv: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                           var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant); safecall;
    procedure MakeDelivery(var DOCS_StatusDelivery: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_Records: OleVariant; var DOCS_Sent: OleVariant; 
                           var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                           var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                           var DOCS_WaitingToBeSent: OleVariant; var DOCS_ReturnedToFile: OleVariant); safecall;
    procedure ChangeHardCopyLocation(var bIsRedirect: OleVariant; 
                                     var sNewHardCopyLocation: OleVariant; var sDocID: OleVariant; 
                                     var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                     var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                     var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                     var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant); safecall;
    procedure ChangePaperFileName(var bIsRedirect: OleVariant; var sPaperFileName: OleVariant; 
                                  var sDocID: OleVariant; var DOCS_PaperFile: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant); safecall;
    function GetCurrentUserFullName: OleVariant; safecall;
    procedure MakeRegisteredRet(var DOCS_DeliveryMethod: OleVariant; 
                                var DOCS_PaperFile: OleVariant; var DOCS_TypeDoc: OleVariant; 
                                var DOCS_RegLog: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_DocIDIncoming: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Description: OleVariant; 
                                var DOCS_NameResponsible: OleVariant; 
                                var DOCS_Resolution: OleVariant; var DOCS_Registered: OleVariant; 
                                var DOCS_InformationUpdated: OleVariant; 
                                var DOCS_InformationNotUpdated: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                                var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                                var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_Comment: OleVariant; var DOCS_PostType: OleVariant; 
                                var DOCS_PostID: OleVariant; var DOCS_Recipient: OleVariant; 
                                var DOCS_PostAddress: OleVariant; var DOCS_DateSent: OleVariant; 
                                var DOCS_StatusDelivery: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                var DOCS_DateArrive: OleVariant; var DOCS_NameAproval: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateTime: OleVariant; var AddFieldName1: OleVariant; 
                                var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                                var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                                var AddFieldName6: OleVariant); safecall;
    procedure CopyDoc(var DOCS_Copied: OleVariant); safecall;
    procedure ClearDocBuffer(var DOCS_BufferCleared: OleVariant); safecall;
    procedure ItemMove; safecall;
    function ShortID(var cPar: OleVariant): OleVariant; safecall;
    function SBigger(var cPar1: OleVariant; var cPar2: OleVariant): OleVariant; safecall;
    procedure Shift(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_NORight: OleVariant; 
                    var DOCS_NOTFOUND: OleVariant; var DOCS_LOGIN: OleVariant; 
                    var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var Var_StandardWorkHours: OleVariant; var CMonths: OleVariant; 
                    var CDays: OleVariant); safecall;
    procedure DeleteDoc(var DOCS_NOTFOUND: OleVariant; var DOCS_All: OleVariant; 
                        var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                        var VAR_ExtInt: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                        var DOCS_NORight: OleVariant; var DOCS_HASDEPENDANT: OleVariant; 
                        var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                        var DOCS_ActionDeleteDependantDoc: OleVariant; 
                        var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                        var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant); safecall;
    procedure GetSelectRecordset(var S_ClassDoc: OleVariant; var sDataSourceName: OleVariant; 
                                 var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                 var sFieldNames: OleVariant); safecall;
    procedure GetRecordsetDetailsClassDoc(S_ClassDoc: OleVariant; var nDataSources: OleVariant; 
                                          var sDataSourceName: OleVariant; 
                                          var sDataSource: OleVariant; 
                                          var sSelectRecordset: OleVariant; 
                                          var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                          var sStatementInsert: OleVariant; 
                                          var sStatementUpdate: OleVariant; 
                                          var sStatementDelete: OleVariant; var sGUID: OleVariant); safecall;
    procedure GetRecordsetDetails(var S_GUID: OleVariant; var sDataSourceName: OleVariant; 
                                  var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                  var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                  var sStatementInsert: OleVariant; 
                                  var sStatementUpdate: OleVariant; 
                                  var sStatementDelete: OleVariant; var sComments: OleVariant; 
                                  var sGUID: OleVariant); safecall;
    procedure DeleteExtData(var nRec: OleVariant; var sStatementDelete: OleVariant; 
                            var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                            var sSelectRecordset: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; var DOCS_DeletedExt: OleVariant; 
                            var DOCS_DeletedExt1: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var DOCS_NORight: OleVariant; 
                            var DOCS_HASDEPENDANT: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_ActionDeleteDependantDoc: OleVariant; 
                            var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant); safecall;
    procedure GetExtRecordsetOld(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                 var sMessage: OleVariant; var sDataSource: OleVariant; 
                                 sSelectRecordset: OleVariant; 
                                 var DOCS_ErrorDataSource: OleVariant; 
                                 var DOCS_ErrorSelectRecordset: OleVariant; 
                                 var DOCS_ErrorInsertPars: OleVariant; 
                                 var DOCS_ErrorSelectNotDefined: OleVariant); safecall;
    procedure GetExtRecordsetArch(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                  var sMessage: OleVariant; var sDataSource: OleVariant; 
                                  var sSelectRecordset: OleVariant; 
                                  var DOCS_ErrorDataSource: OleVariant; 
                                  var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                                  var DOCS_ErrorInsertPars: OleVariant; 
                                  var DOCS_ErrorSelectNotDefined: OleVariant); safecall;
    procedure GetExtRecordset(bArch: OleVariant; var ds: OleVariant; var bErr: OleVariant; 
                              var sMessage: OleVariant; sDataSource: OleVariant; 
                              sSelectRecordset: OleVariant; sGUID: OleVariant; 
                              var DOCS_ErrorDataSource: OleVariant; 
                              var DOCS_ErrorSelectRecordset: OleVariant; 
                              var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                              var DOCS_ErrorInsertPars: OleVariant; 
                              var DOCS_ErrorSelectNotDefined: OleVariant); safecall;
    procedure ChangeExtData(var nRec: OleVariant; var sDataSourceName: OleVariant; 
                            var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                            var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                            var sStatement: OleVariant; var bCheckOK: OleVariant; 
                            var bErr: OleVariant; var ds: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                            var DOCS_ErrorDataEdit: OleVariant; var DOCS_Error: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Changed1: OleVariant; 
                            var DOCS_Created: OleVariant; var DOCS_Created1: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_Field: OleVariant; var DOCS_WrongField: OleVariant; 
                            var DOCS_NoUpdate: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_Records: OleVariant); safecall;
    function InsertPars(sSelect: OleVariant; var dsDoc: OleVariant; var sErr: OleVariant): OleVariant; safecall;
    function InsertParsEval(sSelect: OleVariant; dsDoc: OleVariant; var bErr: OleVariant): OleVariant; safecall;
    function GetNextFieldName(var sSelect: OleVariant): OleVariant; safecall;
    function NotViewedList(var sUserList: OleVariant): OleVariant; safecall;
    function NotAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant; safecall;
    function NotYetAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant; safecall;
    function GetFullUserFromList(var sList: OleVariant; var sUserID: OleVariant): OleVariant; safecall;
    function GetUserIDFromList(var sList: OleVariant; var i1: OleVariant): OleVariant; safecall;
    procedure Visa(var bRedirect: OleVariant; var sNotificationList: OleVariant; 
                   var sDocID: OleVariant; var sRefuse: OleVariant; var sapp: OleVariant; 
                   var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                   var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                   var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                   var DOCS_Refused: OleVariant; var DOCS_RefusedApp: OleVariant; 
                   var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                   var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                   var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                   var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                   var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                   var DOCS_NotificationSentTo: OleVariant; var DOCS_SendNotification: OleVariant; 
                   var DOCS_UsersNotFound: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                   var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                   var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                   var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                   var DOCS_Sender: OleVariant; var DOCS_APROVAL: OleVariant; 
                   var DOCS_Visa: OleVariant; var DOCS_View: OleVariant; 
                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                   var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant; 
                   var Var_nDaysToReconcile: OleVariant; var DOCS_DateDiff1: OleVariant); safecall;
    procedure VisaCancel(var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                         var DOCS_Cancelled: OleVariant; var DOCS_Refused: OleVariant; 
                         var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                         var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                         var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; 
                         var DOCS_SendNotification: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                         var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                         var DOCS_APROVAL: OleVariant; var DOCS_Visa: OleVariant; 
                         var DOCS_View: OleVariant); safecall;
    procedure ReconciliationCancel(var Var_nDaysToReconcile: OleVariant; 
                                   var DOCS_AGREECancelled: OleVariant; var DOCS_Visa: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                   var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant); safecall;
    procedure ShowDoc(var dsDoc: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    function FSpec(var SxSy: OleVariant): OleVariant; safecall;
    procedure CopySpec(var Name1: OleVariant; var Name2: OleVariant; var Conn: OleVariant; 
                       var DOC_ComplexUnits: OleVariant; var DOCS_Copied: OleVariant); safecall;
    procedure CopySpecComponents(var Name1: OleVariant; var Name2: OleVariant; 
                                 var Conn: OleVariant; var DOCS_Copied: OleVariant; 
                                 var DOC_ComplexUnits: OleVariant); safecall;
    procedure CreateNotice(var DOCS_Notices: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                           var DOCS_SecurityLevel2: OleVariant; 
                           var DOCS_SecurityLevel3: OleVariant; 
                           var DOCS_SecurityLevel4: OleVariant; 
                           var DOCS_SecurityLevelS: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_WrongAmount: OleVariant; var DOCS_WrongQuantity: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_Created: OleVariant); safecall;
    procedure DeleteAct(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant); safecall;
    procedure DeleteFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeleteUserPhoto(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeletePartnerFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeleteDepartmentFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                   var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeleteTypeDocFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeletePrintFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); safecall;
    procedure DeleteMailListFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); safecall;
    function IsClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant; safecall;
    function DocIDParentFromClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant; safecall;
    function NoPars(var cPar: OleVariant): OleVariant; safecall;
    procedure FormingSQL(var dsDoc: OleVariant; var sClassDocParent: OleVariant; 
                         var sPartnerNameParent: OleVariant; 
                         var sNameResponsibleParent: OleVariant; var Specs: OleVariant; 
                         var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                         var bSpec: OleVariant; var bDateActivation: OleVariant; 
                         var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                         var sDetailes: OleVariant; var S_OrderBy1: OleVariant; 
                         var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                         var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                         var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                         var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant; 
                         var sDateOrder: OleVariant; var sDateOrder2: OleVariant; 
                         var sDateOrder3: OleVariant; var VAR_StatusArchiv: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                         var DOCS_ListToReconcile: OleVariant; 
                         var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                         var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var Consts: OleVariant; 
                         var Periods: OleVariant; var Statuses: OleVariant; 
                         var VAR_StatusExpired: OleVariant; var DOCS_IsExactly: OleVariant; 
                         var DOCS_BeginsWith: OleVariant; var DOCS_Sent: OleVariant; 
                         var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                         var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                         var DOCS_WaitingToBeSent: OleVariant; var DOCS_ClassDocParent: OleVariant); safecall;
    procedure GetSQLDate(var sSQLDate: OleVariant; var sDetailesDate: OleVariant; 
                         var sYear: OleVariant; var sDate: OleVariant; var sField: OleVariant; 
                         var sFieldName: OleVariant; var Periods: OleVariant); safecall;
    procedure RequestCompleted(var dsDoc: OleVariant; var sDocIDpar: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_StatusRequestCompletion: OleVariant; 
                               var DOCS_RequestedCompleted: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var VAR_ExtInt: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                               var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant); safecall;
    function IsDateInMonitorRange(var dPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    procedure CheckLicense(var sCompany: OleVariant; var bOK: OleVariant; 
                           var DOCS_DEMO_MODE: OleVariant; var DOCS_CopyrightWarning: OleVariant; 
                           var DOCS_Error: OleVariant); safecall;
    procedure ListRegLogDocs(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                             var DOCS_PERIOD_THISM: OleVariant; var DOCS_PERIOD_PREVM: OleVariant; 
                             var DOCS_PERIOD_1QUARTER: OleVariant; 
                             var DOCS_PERIOD_2QUARTER: OleVariant; 
                             var DOCS_PERIOD_3QUARTER: OleVariant; 
                             var DOCS_PERIOD_4QUARTER: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                             var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                             var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                             var DOCS_PERIOD_JUN: OleVariant; var OCS_PERIOD_JUL: OleVariant; 
                             var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                             var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                             var DOCS_PERIOD_DEC: OleVariant; var DOCS_PERIOD_THISY: OleVariant; 
                             var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                             var DOCS_PERIOD_YEAR: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                             var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                             var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                             var VAR_DocsMaxRecords: OleVariant); safecall;
    procedure ListPaperFileRegistry(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                                    var DOCS_PERIOD_THISM: OleVariant; 
                                    var DOCS_PERIOD_PREVM: OleVariant; 
                                    var DOCS_PERIOD_1QUARTER: OleVariant; 
                                    var DOCS_PERIOD_2QUARTER: OleVariant; 
                                    var DOCS_PERIOD_3QUARTER: OleVariant; 
                                    var DOCS_PERIOD_4QUARTER: OleVariant; 
                                    var DOCS_PERIOD_JAN: OleVariant; 
                                    var DOCS_PERIOD_FEB: OleVariant; 
                                    var DOCS_PERIOD_MAR: OleVariant; 
                                    var DOCS_PERIOD_APR: OleVariant; 
                                    var DOCS_PERIOD_MAY: OleVariant; 
                                    var DOCS_PERIOD_JUN: OleVariant; 
                                    var OCS_PERIOD_JUL: OleVariant; 
                                    var DOCS_PERIOD_AUG: OleVariant; 
                                    var DOCS_PERIOD_SEP: OleVariant; 
                                    var DOCS_PERIOD_OCT: OleVariant; 
                                    var DOCS_PERIOD_NOV: OleVariant; 
                                    var DOCS_PERIOD_DEC: OleVariant; 
                                    var DOCS_PERIOD_THISY: OleVariant; 
                                    var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                                    var DOCS_PERIOD_YEAR: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                                    var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                                    var VAR_DocsMaxRecords: OleVariant); safecall;
    procedure ClearSearch; safecall;
    procedure ListDoc(var sCommand: OleVariant; var S_Title: OleVariant; var sSQL: OleVariant; 
                      var S_TitleSearchCriteria: OleVariant; var DOCS_Contacts: OleVariant; 
                      var DOCS_Comments: OleVariant; var DOCS_ContextContaining: OleVariant; 
                      var DOCS_DOCUMENTRECORDS: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var DOCS_WrongDate: OleVariant; var Periods: OleVariant; 
                      var DOCS_CATEGORY: OleVariant; var DOCS_EXPIRED1: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; var DOCS_OUTSTANDING: OleVariant; 
                      var DOCS_Status: OleVariant; var DOCS_Incoming: OleVariant; 
                      var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                      var DOCS_Department: OleVariant; var DOCS_USER: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_MYDOCS: OleVariant; var DOCS_News: OleVariant; 
                      var DOCS_FromDocs: OleVariant; var VAR_DateNewDocs: OleVariant; 
                      var DOCS_DateFormat: OleVariant; var DOCS_UNAPPROVED: OleVariant; 
                      var DOCS_EXPIRED: OleVariant; var DOCS_UnderControl: OleVariant; 
                      var DOCS_Cancelled1: OleVariant; var VAR_StatusCancelled: OleVariant; 
                      var DOCS_Completed1: OleVariant; var USER_Department: OleVariant; 
                      var DOCS_Inactives1: OleVariant; var VAR_InActiveTask: OleVariant; 
                      var DOCS_Approved1: OleVariant; var DOCS_ApprovedNot1: OleVariant; 
                      var DOCS_Refused1: OleVariant; var DOCS_NOTCOMPLETED: OleVariant; 
                      var DOCS_YouAreResponsible: OleVariant; var DOCS_YouAreCreator: OleVariant; 
                      var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                      var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                      var DOCS_ReturnedFromFile: OleVariant; var DOCS_WaitingToBeSent: OleVariant; 
                      var DOCS_PaymentOutgoingIncompleted: OleVariant; 
                      var DOCS_PaymentIncomingIncompleted: OleVariant; 
                      var DOCS_StatusRequireToBePaid: OleVariant; 
                      var DOCS_GoToPaperFileDocList: OleVariant; 
                      var DOCS_NoUsersExceeded: OleVariant; var DOCS_LOGGEDOUT: OleVariant; 
                      var DOCS_ActionLogOut: OleVariant; var DOCS_SysUser: OleVariant; 
                      var DOCS_ViewedStatusDocs: OleVariant; var Texts: OleVariant); safecall;
    procedure InOutOfOffice(var VAR_BeginOfTimes: OleVariant); safecall;
    function AmountByWords(var summa: OleVariant; var unit_: OleVariant): OleVariant; safecall;
    procedure GetDoc(var sFileOut: OleVariant; var sError: OleVariant; 
                     var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                     var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                     var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                     var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                     var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                     var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                     var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                     var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                     var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                     var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                     var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                     var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                     var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                     var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                     var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                     var VAR_NamesListDelimiter1: OleVariant; 
                     var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                     var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                     var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure SetDoc(obj: OleVariant; var doc: OleVariant; sFileOut: OleVariant); safecall;
    procedure GetDoc1(var sFileOut: OleVariant; var sError: OleVariant; 
                      var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                      var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                      var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                      var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                      var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                      var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                      var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                      var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                      var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                      var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                      var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                      var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                      var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                      var VAR_NamesListDelimiter1: OleVariant; 
                      var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                      var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                      var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                      var DOCS_Internal: OleVariant); safecall;
    procedure InsertBookmarkTable(var cField: OleVariant; var cBookmark: OleVariant); safecall;
    procedure InsertRangeTable(var rVal: OleVariant; var mRange: OleVariant); safecall;
    procedure InsertRangeText(var rVal: OleVariant; var mRange: OleVariant); safecall;
    procedure InsertRangeCurrency(var cPar: OleVariant); safecall;
    procedure InsertRange(var cPar: OleVariant); safecall;
    procedure InsertRangeDate(var cPar: OleVariant); safecall;
    procedure InsertRowXLS; safecall;
    procedure InsertRow; safecall;
    procedure InsertRowExt(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                           var doc: OleVariant; var obj: OleVariant); safecall;
    procedure InsertRowExt1(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                            var doc: OleVariant; var obj: OleVariant); safecall;
    procedure InsertRowExt2(var iTable: OleVariant; var doc: OleVariant; var obj: OleVariant; 
                            var bErr: OleVariant); safecall;
    procedure AddBookmarksToTable(var Bookmarks: OleVariant; var iTable: OleVariant; 
                                  var iRow: OleVariant; var iColStart: OleVariant; 
                                  var doc: OleVariant; var obj: OleVariant; var bError: OleVariant); safecall;
    procedure MoveBookmarks(var Bookmarks: OleVariant; var iTable: OleVariant; var doc: OleVariant; 
                            var obj: OleVariant); safecall;
    function NoIDs(var cPar: OleVariant): OleVariant; safecall;
    procedure InsertBookmark(var cPar: OleVariant); safecall;
    procedure InsertBookmarkComments(var cPar: OleVariant); safecall;
    procedure InsertBookmarkComments1(var sCommentType: OleVariant; var sBookmark: OleVariant; 
                                      var bError: OleVariant); safecall;
    procedure InsertBookmarkCurrency(var cPar: OleVariant); safecall;
    procedure InsertBookmarkDate(var cPar: OleVariant); safecall;
    procedure InsertBookmarkSum(var rVal: OleVariant; var mBookmark: OleVariant); safecall;
    procedure InsertBookmarkText(var rVal: OleVariant; var mBookmark: OleVariant); safecall;
    procedure InsertBookmarkTextDoc(var doc: OleVariant; var rVal: OleVariant; 
                                    var mBookmark: OleVariant); safecall;
    procedure InsertBookmarkHyperlink(var cField: OleVariant; var cBookmark: OleVariant); safecall;
    procedure ShowSpecSummary(var VAR_QNewSpec: OleVariant); safecall;
    procedure ShowSpecSummaryXLS(var VAR_QNewSpec: OleVariant); safecall;
    procedure SpecMove; safecall;
    procedure SpecIDChange(var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_SPECIDWrong: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NoChangeSpecID: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant); safecall;
    procedure RestoreDoc(var DOCS_ActionRestoredDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_AmountDoc: OleVariant; 
                         var DOCS_QuantityDoc: OleVariant; var DOCS_ErrorDataSource: OleVariant; 
                         var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                         var DOCS_ErrorSelectRecordset: OleVariant; 
                         var DOCS_ErrorInsertPars: OleVariant; 
                         var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant); safecall;
    procedure ReCalcSpec(var DOCS_ReCalculated: OleVariant; var DOCS_Records: OleVariant; 
                         var DOCS_Values: OleVariant; var DOCS_WrongNumber: OleVariant; 
                         var DOCS_WrongDate: OleVariant; var DOC_Calculator: OleVariant; 
                         var DOCS_Error: OleVariant; var VAR_QNewSpec: OleVariant; 
                         var VAR_TypeVal_String: OleVariant; var VAR_TypeVal_DateTime: OleVariant; 
                         var VAR_TypeVal_NumericMoney: OleVariant; 
                         var DOCS_SpecFieldName: OleVariant; var DOCS_SpecFieldFormula: OleVariant); safecall;
    function Percent(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; safecall;
    function PercentAdd(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; safecall;
    function PercentAddRev(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; safecall;
    function Y1(var Number: OleVariant): OleVariant; safecall;
    function FQ: OleVariant; safecall;
    function FS: OleVariant; safecall;
    function FS1: OleVariant; safecall;
    function FS2: OleVariant; safecall;
    function F1: OleVariant; safecall;
    function F2: OleVariant; safecall;
    function F3: OleVariant; safecall;
    function F4: OleVariant; safecall;
    function F5: OleVariant; safecall;
    function F6: OleVariant; safecall;
    function F7: OleVariant; safecall;
    function F8: OleVariant; safecall;
    function F9: OleVariant; safecall;
    function F10: OleVariant; safecall;
    function F11: OleVariant; safecall;
    function F12: OleVariant; safecall;
    function F13: OleVariant; safecall;
    function F14: OleVariant; safecall;
    function F15: OleVariant; safecall;
    function F16: OleVariant; safecall;
    function F17: OleVariant; safecall;
    function F18: OleVariant; safecall;
    function F19: OleVariant; safecall;
    function F20: OleVariant; safecall;
    function F21: OleVariant; safecall;
    function F22: OleVariant; safecall;
    function F23: OleVariant; safecall;
    function F24: OleVariant; safecall;
    function F25: OleVariant; safecall;
    function F26: OleVariant; safecall;
    function F27: OleVariant; safecall;
    function F28: OleVariant; safecall;
    function F29: OleVariant; safecall;
    function F30: OleVariant; safecall;
    function F31: OleVariant; safecall;
    function F32: OleVariant; safecall;
    function F33: OleVariant; safecall;
    function F34: OleVariant; safecall;
    function F35: OleVariant; safecall;
    function F36: OleVariant; safecall;
    function F37: OleVariant; safecall;
    function F38: OleVariant; safecall;
    function F39: OleVariant; safecall;
    function F40: OleVariant; safecall;
    procedure CheckError; safecall;
    function CheckErrorF: OleVariant; safecall;
    procedure GoError(var Description: OleVariant); safecall;
    procedure PasteSpec(var DOCS_SpecNotPermitted: OleVariant; var DOCS_Inserted: OleVariant; 
                        var DOCS_InsertedCompatibleSpec: OleVariant); safecall;
    procedure PasteComponentsSpec(var DOC_ComplexUnits: OleVariant; 
                                  var DOCS_QuantityDoc: OleVariant; var DOCS_Inserted: OleVariant; 
                                  var DOCS_Total: OleVariant; var DOCS_ComplexItems: OleVariant); safecall;
    procedure DeleteType(var DOCS_NoDeleteType: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteSpecItem(var DOCS_SPECElement: OleVariant; var DOCS_Deleted: OleVariant); safecall;
    function GetDataNameAll(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; safecall;
    function GetDataName(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; safecall;
    function GetDataWidth(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; safecall;
    function IsFieldEditArea(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; safecall;
    function IsNoDir(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; safecall;
    function IsRUS(var cPar: OleVariant): OleVariant; safecall;
    procedure Archive(var DOC_ArchiveExit: OleVariant; var DOC_ArchiveEnter: OleVariant; 
                      var VAR_AdminSecLevel: OleVariant; var VAR_StatusArchiv: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; 
                      var Var_ArchiveMoveAllCompletedDocsYears: OleVariant; 
                      var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                      var DOC_Moved: OleVariant; var DOC_Total: OleVariant; 
                      var DOCS_DateActivation: OleVariant; var DOCS_Completed: OleVariant; 
                      var DOCS_Archiv: OleVariant; var DOC_Move: OleVariant; 
                      var DOCS_MakeChoice: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var Var_ArchiveMoveAllOldDocsYears: OleVariant; 
                      var DOCS_ErrorDataSource: OleVariant; 
                      var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                      var DOCS_ErrorSelectRecordset: OleVariant; 
                      var DOCS_ErrorInsertPars: OleVariant; 
                      var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant); safecall;
    procedure DeleteAuditing(var DOCS_ActionDeleteLog: OleVariant; var DOCS_NORight: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_DateOldAuditing: OleVariant; var DOCS_SysLog: OleVariant; 
                             var DOCS_Records: OleVariant); safecall;
    procedure DeleteComment(var DOCS_ActionDeleteComment: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_ActionDeleteFile: OleVariant; var DOCS_Version: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant); safecall;
    procedure DeleteDepartment(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var DOCS_Deleted: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteInventory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteMeasure(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeletePartner(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeletePosition(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteUserDirectory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_NoDeleteDir: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var USER_Department: OleVariant; var sDepartment: OleVariant); safecall;
    procedure DeleteUserDirectoryValues(var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant); safecall;
    procedure DeleteDirectoryValues(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteRegLog(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteRequest(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteScorecard(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORightToDelete: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var USER_Department: OleVariant); safecall;
    procedure DeleteSpec(var DOCS_SysUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Spec: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                         var DOCS_NoDeleteSpec: OleVariant); safecall;
    procedure DeleteTransaction(var DOCS_Deleted: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure DeleteUser(var DOCS_NOTFOUND: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant); safecall;
    function GetMonitorURL(var sPar: OleVariant; var sval: OleVariant; var cbm: OleVariant; 
                           var DOCS_News: OleVariant): OleVariant; safecall;
    procedure SetMonitorSound; safecall;
    function GetMonitorSound(var DOCS_MonitorSoundN: OleVariant; var DOCS_MonitorNoSound: OleVariant): OleVariant; safecall;
    procedure ChangeMonitorSound(var Var_nMonitorSoundFiles: OleVariant); safecall;
    procedure ShowListMonitorUsers(var S_PartnerID: OleVariant; var S_PartnerName: OleVariant; 
                                   var DOCS_News: OleVariant; 
                                   var DOCS_SendPersonalMessage: OleVariant; 
                                   var DOCS_SendPersonalMessageYourself: OleVariant; 
                                   var Var_nMonitorRefreshSeconds: OleVariant); safecall;
    procedure AddUserToMonitor(var DOCS_Created: OleVariant); safecall;
    procedure ClearMonitorList; safecall;
    procedure DeleteUserFromMonitor(var DOCS_Deleted: OleVariant); safecall;
    function UserInMonitor(var sUserID: OleVariant): OleVariant; safecall;
    procedure ChangeMeasure(var S_Measure: OleVariant; var S_Code: OleVariant; 
                            var S_UnitName: OleVariant; var S_Name: OleVariant; 
                            var S_USLNAT: OleVariant; var S_USLINTER: OleVariant; 
                            var S_ALFNAT: OleVariant; var S_ALFINTER: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant); safecall;
    procedure ChangePartner(var S_Companies: OleVariant; var S_Partner: OleVariant; 
                            var S_ShortName: OleVariant; var S_Address: OleVariant; 
                            var S_Address1: OleVariant; var S_Address2: OleVariant; 
                            var S_Phone: OleVariant; var S_Fax: OleVariant; 
                            var S_ContactName: OleVariant; var S_EMail: OleVariant; 
                            var S_WebLink: OleVariant; var S_BankDetails: OleVariant; 
                            var S_TaxID: OleVariant; var S_RegCode: OleVariant; 
                            var S_RegCode1: OleVariant; var S_Country: OleVariant; 
                            var S_Area: OleVariant; var S_City: OleVariant; 
                            var S_Industry: OleVariant; var S_ManagerName: OleVariant; 
                            var S_ManagerPosition: OleVariant; var S_ManagerPhoneNo: OleVariant; 
                            var S_AccountingManagerName: OleVariant; 
                            var S_AccountingManagerPhoneNo: OleVariant; 
                            var S_SalesManagerName: OleVariant; 
                            var S_SalesManagerPosition: OleVariant; 
                            var S_SalesManagerPhoneNo: OleVariant; var S_AddInfo: OleVariant; 
                            var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                            var S_NameLastModification: OleVariant; 
                            var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant); safecall;
    procedure ChangePosition(var S_Position: OleVariant; var S_NameCreation: OleVariant; 
                             var S_DateCreation: OleVariant; 
                             var S_NameLastModification: OleVariant; 
                             var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                             var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant); safecall;
    function CanModifyDirectory(var WriteSecurityLevel: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                var NameCreation: OleVariant; var USER_Department: OleVariant; 
                                var sDepartment: OleVariant): OleVariant; safecall;
    function CanModifyDirectoryGUID(var sDirGUID: OleVariant; var sGUID: OleVariant; 
                                    var WriteSecurityLevel: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                    var USER_Department: OleVariant; var sDepartment: OleVariant): OleVariant; safecall;
    procedure ChangeUserDirectory(var S_Name: OleVariant; var S_DocField: OleVariant; 
                                  var S_FieldName1: OleVariant; var S_FieldName2: OleVariant; 
                                  var S_FieldName3: OleVariant; var S_FieldName4: OleVariant; 
                                  var S_FieldName5: OleVariant; var S_FieldName6: OleVariant; 
                                  var S_CompanyDoc: OleVariant; var S_NameCreation: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                                  var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_All: OleVariant; var USER_Department: OleVariant; 
                                  var sDepartment: OleVariant); safecall;
    function GetGUID: WideString; safecall;
    function GetGUID1: WideString; safecall;
    function GetGUIDFromKeyField(var cPar: OleVariant): OleVariant; safecall;
    function GUID2ByteArray(const strGUID: WideString): PSafeArray; safecall;
    procedure ChangeUserDirectoryValues(var S_GUID: OleVariant; var S_KeyField: OleVariant; 
                                        var S_Field1: OleVariant; var S_Field2: OleVariant; 
                                        var S_Field3: OleVariant; var S_Field4: OleVariant; 
                                        var S_Field5: OleVariant; var S_Field6: OleVariant; 
                                        var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_ALREADYEXISTS: OleVariant; 
                                        var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var DOCS_NORight: OleVariant; 
                                        var VAR_BeginOfTimes: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant); safecall;
    procedure ChangeDirectoryValues(var dsDoc: OleVariant; var S_Name: OleVariant; 
                                    var S_Code: OleVariant; var S_Code2: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; 
                                    var DOCS_ALREADYEXISTS: OleVariant; 
                                    var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_ErrorGUID: OleVariant); safecall;
    procedure ChangeRegLog(var S_Name: OleVariant; var S_Users: OleVariant; 
                           var S_Owners: OleVariant; var S_ClassDocs: OleVariant; 
                           var S_RegLogID: OleVariant; var S_VisibleFields: OleVariant; 
                           var S_DocType: OleVariant; var S_NameCreation: OleVariant; 
                           var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                           var S_DateLastModification: OleVariant; var AddFieldName1: OleVariant; 
                           var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                           var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                           var AddFieldName6: OleVariant; var AddFieldFormula1: OleVariant; 
                           var AddFieldFormula2: OleVariant; var AddFieldFormula3: OleVariant; 
                           var AddFieldFormula4: OleVariant; var AddFieldFormula5: OleVariant; 
                           var AddFieldFormula6: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_All: OleVariant); safecall;
    procedure GetOrderPars(var dsDoc: OleVariant; var S_OrderBy1: OleVariant; 
                           var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                           var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                           var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                           var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant); safecall;
    procedure ChangeRequest(var RequestPars: OleVariant; var dsDoc: OleVariant; 
                            var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                            var bSpec: OleVariant; var bDateActivation: OleVariant; 
                            var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                            var sDetailes: OleVariant; var VAR_StatusArchiv: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                            var DOCS_ListToReconcile: OleVariant; 
                            var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                            var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                            var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_InventoryUnit: OleVariant; 
                            var DOCS_PaymentMethod: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_StatusCompletion: OleVariant; 
                            var DOCS_OUTSTANDING: OleVariant; var DOCS_Completed1: OleVariant; 
                            var VAR_StatusCompletion: OleVariant; 
                            var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                            var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                            var DOCS_Cancelled1: OleVariant; var DOCS_Incoming: OleVariant; 
                            var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                            var DOCS_TypeDoc: OleVariant; var DOCS_ClassDoc: OleVariant; 
                            var DOCS_StatusDevelopment: OleVariant; 
                            var DOCS_NameUserFieldDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                            var DOCS_TO_Date: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; 
                            var DOCS_RequestAddSQL: OleVariant; var Statuses: OleVariant; 
                            var Periods: OleVariant; var TextConsts: OleVariant; 
                            var Consts: OleVariant; var sRequestSQL: OleVariant; 
                            var DOCS_All: OleVariant); safecall;
    procedure ChangeTransaction(var S_Transaction: OleVariant; var S_Account: OleVariant; 
                                var S_SubAccount1: OleVariant; var S_SubAccount2: OleVariant; 
                                var S_SubAccount3: OleVariant; var S_NameCreation: OleVariant; 
                                var S_DateCreation: OleVariant; 
                                var S_NameLastModification: OleVariant; 
                                var S_DateLastModification: OleVariant; 
                                var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant); safecall;
    procedure ChangeType(var S_Type: OleVariant; var S_Template: OleVariant; 
                         var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                         var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var UserInstructions: OleVariant; 
                         var BusinessProcessSteps: OleVariant; var BusinessProcessType: OleVariant; 
                         var StandardNameTexts: OleVariant; var NameUserFieldText1: OleVariant; 
                         var NameUserFieldText2: OleVariant; var NameUserFieldText3: OleVariant; 
                         var NameUserFieldText4: OleVariant; var NameUserFieldText5: OleVariant; 
                         var NameUserFieldText6: OleVariant; var NameUserFieldText7: OleVariant; 
                         var NameUserFieldText8: OleVariant; var NameUserFieldMoney1: OleVariant; 
                         var NameUserFieldMoney2: OleVariant; var NameUserFieldDate1: OleVariant; 
                         var NameUserFieldDate2: OleVariant; var NameSpecIDs: OleVariant; 
                         var bVar: OleVariant; var S_FormulaQuantity: OleVariant; 
                         var S_FormulaAmount: OleVariant; var TextConsts: OleVariant; 
                         var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                         var sSelectRecordset: OleVariant; var sFieldNames: OleVariant); safecall;
    function CanAccessRecord(var SecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Users: OleVariant): OleVariant; safecall;
    function CanViewRecord(var ReadSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var UserID: OleVariant; var sDepartment: OleVariant; 
                           var USER_Department: OleVariant; var Viewers: OleVariant): OleVariant; safecall;
    function CanModifyRecord(var WriteSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Editors: OleVariant): OleVariant; safecall;
    procedure ChangeScorecard(var S_GUID: OleVariant; var S_KeyWords: OleVariant; 
                              var S_Name: OleVariant; var S_Description: OleVariant; 
                              var S_PeriodType: OleVariant; var S_FirstPeriod: OleVariant; 
                              var N_PeriodsPerScreen: OleVariant; var N_ScreenWidth: OleVariant; 
                              var N_MinScorecardValue: OleVariant; 
                              var N_MaxScorecardValue: OleVariant; var S_DataSource: OleVariant; 
                              var S_DataSourcePars: OleVariant; var S_SelectRecordset: OleVariant; 
                              var S_SelectRecordsetPars: OleVariant; var S_ColorNormal: OleVariant; 
                              var S_ColorWarning: OleVariant; var S_ColorCritical: OleVariant; 
                              var S_ConditionWarning: OleVariant; 
                              var S_ConditionCritical: OleVariant; var S_SignWarning: OleVariant; 
                              var S_SignCritical: OleVariant; var S_NameFormula: OleVariant; 
                              var S_NameFormulaPars: OleVariant; var S_ValueFormula: OleVariant; 
                              var S_ValueFormat: OleVariant; 
                              var S_ScorecardDownLevelGUID: OleVariant; 
                              var S_ScorecardDownLevelFormulaLink: OleVariant; 
                              var S_Editors: OleVariant; var S_Viewers: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; var DOCS_NORight: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant); safecall;
    procedure ChangeUser(var S_UserID: OleVariant; var S_Password: OleVariant; 
                         var S_Name: OleVariant; var S_Phone: OleVariant; 
                         var S_PhoneCell: OleVariant; var S_IDentification: OleVariant; 
                         var S_IDNo: OleVariant; var S_IDIssuedBy: OleVariant; 
                         var S_IDIssueDate: OleVariant; var S_IDExpDate: OleVariant; 
                         var S_BirthDate: OleVariant; var S_CorporateIDNo: OleVariant; 
                         var S_AddInfo: OleVariant; var S_Comment: OleVariant; 
                         var S_EMail: OleVariant; var S_PostAddress: OleVariant; 
                         var S_ICQ: OleVariant; var S_Department: OleVariant; 
                         var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                         var S_ClassDoc: OleVariant; var S_Reporttype: OleVariant; 
                         var S_CompanyDoc: OleVariant; var S_Position: OleVariant; 
                         var S_Role: OleVariant; var S_PossibleRoles: OleVariant; 
                         var S_ReadSecurityLevel: OleVariant; var S_WriteSecurityLevel: OleVariant; 
                         var S_ExtIntSecurityLevel: OleVariant; 
                         var S_DateExpirationSecurity: OleVariant; var S_StatusActive: OleVariant; 
                         var S_Permitions: OleVariant; var S_NameCreation: OleVariant; 
                         var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var sNewRole: OleVariant; 
                         var VARS: OleVariant); safecall;
    function GenNewMSAccessReplicationID: OleVariant; safecall;
    procedure ChangeSpecItem(var dsDoc: OleVariant; var S_ItemID: OleVariant; 
                             var S_NameSpec: OleVariant; var DOCS_Error: OleVariant; 
                             var UPC_NotFound: OleVariant; var VAR_TypeVal_String: OleVariant; 
                             var VAR_TypeVal_NumericMoney: OleVariant; 
                             var VAR_TypeVal_DateTime: OleVariant; 
                             var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                             var DOCS_WrongNumber: OleVariant; var DOCS_Created: OleVariant; 
                             var DOCS_Changed: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var S_InventoryUnitField: OleVariant; var Var_InventoryCode: OleVariant); safecall;
    procedure ChangeSpec(var dsDoc: OleVariant; var S_NameSpec: OleVariant; 
                         var VAR_QNewSpec: OleVariant; var DOCS_ErrSpecEmptyName: OleVariant; 
                         var DOCS_Created: OleVariant; var DOCS_Changed: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant); safecall;
    procedure ChangeReporttype(var S_Reporttype: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); safecall;
    procedure ChangeInventory(var S_Inventory: OleVariant; var S_Code: OleVariant; 
                              var S_UnitName: OleVariant; var S_CodeInternal: OleVariant; 
                              var S_CodeInternal2: OleVariant; var S_Quantity: OleVariant; 
                              var S_PriceIn: OleVariant; var S_PriceOut: OleVariant; 
                              var S_Comment: OleVariant; var S_Comment2: OleVariant; 
                              var S_PictureURL: OleVariant; var S_Category: OleVariant; 
                              var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                              var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant); safecall;
    procedure ChangeDepartment(var S_Department: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); safecall;
    procedure ChangeDocIdInDepandants(var sDocIDold: OleVariant; var sDocIDnew: OleVariant); safecall;
    procedure GetExtDataRecordsets(var dsDoc: OleVariant; var nDataSources: OleVariant; 
                                   var bErr: OleVariant; var sMessage: OleVariant; 
                                   var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                   var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                   var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                   var sStatementUpdate: OleVariant; 
                                   var sStatementDelete: OleVariant; var sGUID: OleVariant); safecall;
    procedure GetExtDataDescriptions(var sClassDoc: OleVariant; var nDataSources: OleVariant; 
                                     var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                     var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                     var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                     var sStatementUpdate: OleVariant; 
                                     var sStatementDelete: OleVariant; var sGUID: OleVariant); safecall;
    procedure ChangeDocIDInExtData(var sDocIDold: OleVariant; var sDocIDnew: OleVariant; 
                                   var dsDoc: OleVariant; var S_ClassDoc: OleVariant); safecall;
    procedure PutsChanges(var cDoc: OleVariant; var cRequest: OleVariant); safecall;
    procedure PutsChangesNewUsers(var sNewUsers: OleVariant; var cDoc: OleVariant; 
                                  var cRequest: OleVariant); safecall;
    procedure PutsChanges1(var cDoc: OleVariant; var cRequest: OleVariant); safecall;
    function IsRightCurrency(var cPar: OleVariant; var Var_MainSystemCurrency: OleVariant): OleVariant; safecall;
    procedure ChangeDoc(var S_DocID: OleVariant; var S_DocIDAdd: OleVariant; 
                        var S_DocIDParent: OleVariant; var S_DocIDPrevious: OleVariant; 
                        var S_DocIDIncoming: OleVariant; var S_Department: OleVariant; 
                        var S_Author: OleVariant; var S_Correspondent: OleVariant; 
                        var S_Resolution: OleVariant; var S_History: OleVariant; 
                        var S_Result: OleVariant; var S_ExtPassword: OleVariant; 
                        var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                        var S_Name: OleVariant; var S_Description: OleVariant; 
                        var S_Content: OleVariant; var S_LocationPaper: OleVariant; 
                        var S_Currency: OleVariant; var S_CurrencyRate: OleVariant; 
                        var S_Rank: OleVariant; var S_LocationPath: OleVariant; 
                        var S_ExtInt: OleVariant; var S_PartnerName: OleVariant; 
                        var S_StatusDevelopment: OleVariant; var S_StatusArchiv: OleVariant; 
                        var S_StatusCompletion: OleVariant; var S_PaymentMethod: OleVariant; 
                        var S_StatusPayment: OleVariant; var S_InventoryUnit: OleVariant; 
                        var S_AmountDoc: OleVariant; var S_AmountDocPart: OleVariant; 
                        var S_QuantityDoc: OleVariant; var S_SecurityLevel: OleVariant; 
                        var S_DateCreation: OleVariant; var S_DateCompletion: OleVariant; 
                        var S_DateExpiration: OleVariant; var S_DateActivation: OleVariant; 
                        var S_DateSigned: OleVariant; var S_NameCreation: OleVariant; 
                        var S_NameAproval: OleVariant; var S_NameControl: OleVariant; 
                        var S_NameApproved: OleVariant; var S_ListToView: OleVariant; 
                        var S_ListToEdit: OleVariant; var S_ListToReconcile: OleVariant; 
                        var S_ListReconciled: OleVariant; var S_NameResponsible: OleVariant; 
                        var S_NameLastModification: OleVariant; 
                        var S_DateLastModification: OleVariant; var S_TypeDoc: OleVariant; 
                        var S_StandardNameTexts: OleVariant; var S_ClassDoc: OleVariant; 
                        var S_BusinessProcessStep: OleVariant; var S_IsActive: OleVariant; 
                        var HasNoSub: OleVariant; var S_UserFields: OleVariant; 
                        var TextConsts: OleVariant; var MailTexts: OleVariant); safecall;
    function Mult(var cPar: OleVariant): OleVariant; safecall;
    procedure ChangeAct(var S_Type: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Changed: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); safecall;
    procedure CopyCompany(var DOCS_Copied1: OleVariant; var DOCS_ALREADYEXISTS: OleVariant); safecall;
    function LeadSymbolN(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant; safecall;
    function LeadSymbolN1(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant; safecall;
    procedure BusinessProcessInit(sBusinessProcessSteps: OleVariant); safecall;
    procedure BPSetResultFinal(var sResultText: OleVariant); safecall;
    function BPResultFinal: OleVariant; safecall;
    function BPStepName(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPStepNumber(sBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIsInactive(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIsActive(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIsActiveCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIsCompleted(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIsCanceled(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPSetSeparator(nBPStep: OleVariant; var sTitle: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPSetComment(nBPStep: OleVariant; var sComment: OleVariant; var sError: OleVariant; 
                          var sPict: OleVariant): OleVariant; safecall;
    function BPSeparator(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPComment(nBPStep: OleVariant; var sError: OleVariant; var sPict: OleVariant): OleVariant; safecall;
    function BPResult(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPResultNumber(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPSetResults(nBPStep: OleVariant; var sResultSet: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPResultSet(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPSetResult(nBPStep: OleVariant; var nResult: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPSetResultString(nBPStep: OleVariant; var sResult: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPCancel(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPComplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPIncomplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPDeactivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPActivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function BPActivateCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant; safecall;
    function IsWrongNBPStep(var nBPStep: OleVariant): OleVariant; safecall;
    function BoardOrderValue(var dDate: OleVariant; var sKey: OleVariant; var dDateEvent: OleVariant): OleVariant; safecall;
    function BoardOrderValueSQL: OleVariant; safecall;
    procedure CheckOut(var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                       var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                       var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var DOCS_CheckedOut: OleVariant; 
                       var DOCS_Version: OleVariant; var DOCS_CheckedOutAlready: OleVariant); safecall;
    procedure CreateComment(var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_CommentDescription: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_News: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var DOCS_DateFormat: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                            var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                            var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant); safecall;
    procedure CreateCommentEMailClient(var sUserID: OleVariant; var sUserName: OleVariant; 
                                       var sDocID: OleVariant; var sCommentType: OleVariant; 
                                       var sSubject: OleVariant; var sComment: OleVariant; 
                                       var sMessage: OleVariant; var DOCS_CommentCreated: OleVariant); safecall;
    procedure CreateViewed(var ds: OleVariant; var sDocIDpar: OleVariant; 
                           var DOCS_Viewed: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant); safecall;
    procedure UploadDescriptionXMLRet(var sMessage: OleVariant; var DocFields: OleVariant; 
                                      var nFields: OleVariant; var ReportFields: OleVariant; 
                                      var nReportFields: OleVariant; 
                                      var DOCS_ALREADYEXISTS: OleVariant; 
                                      var DOCS_FileUploaded: OleVariant; 
                                      var DOCS_DocID: OleVariant; var DOCS_Name: OleVariant); safecall;
    function IsFieldExist(var rs: OleVariant; var sFieldName: OleVariant): OleVariant; safecall;
    procedure UploadPartnerRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); safecall;
    procedure UploadDepartmentRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_FileNotUploaded: OleVariant; 
                                  var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                  var DOCS_FileName: OleVariant; 
                                  var DOCS_VersionFileChanged: OleVariant; 
                                  var DOCS_NoModiFile1: OleVariant; 
                                  var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant); safecall;
    procedure UploadTypeDocRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); safecall;
    procedure UploadUserPhotoRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                 var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                 var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_FileNotUploaded: OleVariant; 
                                 var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                 var DOCS_FileName: OleVariant; 
                                 var DOCS_VersionFileChanged: OleVariant; 
                                 var DOCS_NoModiFile1: OleVariant; 
                                 var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant); safecall;
    function PostcardFilePrefix: OleVariant; safecall;
    function PostcardFile(var sExt: OleVariant): OleVariant; safecall;
    function PostcardFileNoPath(var sExt: OleVariant): OleVariant; safecall;
    function PostcardFileURL(var sExt: OleVariant): OleVariant; safecall;
    function IsPostcardFile(sFile: OleVariant): OleVariant; safecall;
    procedure UploadPostcardPicRet(var sMessage: OleVariant; var sFile: OleVariant; 
                                   var sFileURL: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                   var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_FileNotUploaded: OleVariant; 
                                   var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                   var DOCS_FileName: OleVariant; 
                                   var DOCS_VersionFileChanged: OleVariant; 
                                   var DOCS_NoModiFile1: OleVariant; 
                                   var DOCS_NoModiFile2: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_MaxFileSizeExceeded1: OleVariant); safecall;
    procedure LoadDBCheck(var bMain: OleVariant; var DOCS_Table: OleVariant; 
                          var DOCS_TableContainsData: OleVariant; 
                          var DOCS_TableContainsDataNot: OleVariant; var bOKAny: OleVariant); safecall;
    procedure LoadDB(var DOCS_TableContainsData: OleVariant; 
                     var DOCS_TableSourceNoData: OleVariant; var DOCS_Records: OleVariant; 
                     var VAR_AdminSecLevel: OleVariant; var DOCS_LoadDB1: OleVariant; 
                     var DOCS_Error: OleVariant; var DOCS_Table: OleVariant; 
                     var DOCS_Field: OleVariant; var DOCS_FieldValue: OleVariant; 
                     var DOCS_FieldTypeFrom: OleVariant; var DOCS_FieldTypeTo: OleVariant; 
                     var DOCS_LoadDBEnd: OleVariant; var DOCS_TableSourceRecordCount: OleVariant; 
                     var DOCS_TableTargetRecordCount: OleVariant); safecall;
    procedure UploadRetNew(sNotificationList: OleVariant; var sMessage: OleVariant; 
                           var sKeyField: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                           var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                           var DOCS_FileName: OleVariant; var DOCS_VersionFileChanged: OleVariant; 
                           var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_NORight: OleVariant; 
                           var DOCS_CheckInUsePictogram: OleVariant; 
                           var DOCS_VersionFileUploaded: OleVariant; 
                           var DOCS_CheckedIn: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_RecListUsersUpload: OleVariant; 
                           var DOCS_AccessDenied: OleVariant; var DOCS_DocID: OleVariant; 
                           var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant); safecall;
    function GetRandomSeq(var nSeq: OleVariant): OleVariant; safecall;
    procedure ListPartners(var dsDoc: OleVariant; var sSQL: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                           var VAR_DocsMaxRecords: OleVariant; var par_searchsearch: OleVariant; 
                           var par_C_Search: OleVariant; var par_SearchComments: OleVariant; 
                           var par_Companies: OleVariant); safecall;
    procedure ListUserDirectories(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                                  var VAR_DocsMaxRecords: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant); safecall;
    procedure ListReportRequests(var sSQL: OleVariant; var USER_Department: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant); safecall;
    procedure ListUserDirectoryValues(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                      var KeyField: OleVariant); safecall;
    procedure ListDirectoryValues(var sSQL: OleVariant); safecall;
    procedure ListUsers(var dsDoc: OleVariant; var sSQL: OleVariant; 
                        var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                        var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant; 
                        var par_Companies: OleVariant; var par_searchPartner: OleVariant; 
                        var par_searchDepartment: OleVariant; var par_searchsearch: OleVariant; 
                        var par_C_Search: OleVariant; var par_searchPosition: OleVariant); safecall;
    procedure ListDirectories(var dsDoc: OleVariant; var sCurDir: OleVariant; 
                              var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant); safecall;
    procedure ListInventory(var dsDoc: OleVariant; var sSQL: OleVariant; 
                            var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_FOUND: OleVariant); safecall;
    procedure ListMeasure(var dsDoc: OleVariant; var sSQL: OleVariant; 
                          var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                          var DOCS_FOUND: OleVariant); safecall;
    procedure ShowListNotices(var S_DocID: OleVariant; var dsDoc1: OleVariant; 
                              var sBusinessProcessSteps: OleVariant; var DOCS_Notices: OleVariant); safecall;
    function CommentsOrder: OleVariant; safecall;
    procedure ShowListComments(var S_DocID: OleVariant; var dsDoc1: OleVariant); safecall;
    procedure ShowListCommentsTransactions(var S_GUID: OleVariant; var dsDoc1: OleVariant); safecall;
    procedure ShowListCommentsPartner(var S_PartnerID: OleVariant; var S_Partner: OleVariant; 
                                      var dsDoc1: OleVariant); safecall;
    procedure ShowListCommentsUser(var S_UserID: OleVariant; var dsDoc1: OleVariant); safecall;
    procedure ShowListSpecUnits(var S_DocID: OleVariant; var ds: OleVariant; 
                                var sSpecIDs: OleVariant); safecall;
    procedure ShowDocSpecItems(var S_DocID: OleVariant; var dsDoc1: OleVariant); safecall;
    function ShowContext(var cPar: OleVariant): OleVariant; safecall;
    function ShowContextHTMLEncode(var cPar: OleVariant): OleVariant; safecall;
    function GetExt(var fName: OleVariant): OleVariant; safecall;
    function GetWithoutExt(var fName: OleVariant): OleVariant; safecall;
    function AddLogM(var sLog: OleVariant): OleVariant; safecall;
    function MailListOLD(var DOCS_MailListNotFound: OleVariant; var DOCS_MailList: OleVariant; 
                         var DOCS_MailsSent: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; safecall;
    procedure GetMailListFilesAndMessages(var Files: OleVariant; var iMsgs: OleVariant); safecall;
    procedure GetPrintFiles(var Files: OleVariant); safecall;
    procedure MailList(var rs: OleVariant; var sDataName: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var USER_NOEMail: OleVariant; 
                       var USER_BADEMail: OleVariant; var DOCS_MailListMarkFile: OleVariant; 
                       var DOCS_MessageSent: OleVariant; var DOCS_MailListMarkExtData: OleVariant; 
                       var DOCS_DBEOF: OleVariant; var DOCS_MailList: OleVariant; 
                       var VAR_BeginOfTimes: OleVariant; var DOCS_MailsSent: OleVariant; 
                       var DOCS_DataSourceRecords: OleVariant; var DOCS_LISTUSERS: OleVariant; 
                       var DOCS_LISTCONTACTNAMES: OleVariant; var DOCS_Source: OleVariant; 
                       var DOCS_FileName: OleVariant; var DOCS_MailListERROR1: OleVariant; 
                       var DOCS_ErrorDataSource: OleVariant; 
                       var DOCS_ErrorSelectRecordset: OleVariant; 
                       var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                       var DOCS_ErrorInsertPars: OleVariant; 
                       var DOCS_ErrorSelectNotDefined: OleVariant; 
                       var DOCS_MailListERRORTO: OleVariant; 
                       var DOCS_MailListERRORFIELD: OleVariant; 
                       var DOCS_MailListRunning: OleVariant; var DOCS_MailListERROR2: OleVariant; 
                       var DOCS_DemoMaximumMails: OleVariant; var DOCS_MailListERROR3: OleVariant; 
                       var nDelay: OleVariant); safecall;
    function CheckRSField(var rs: OleVariant; var sToField: OleVariant): OleVariant; safecall;
    procedure GetKeyFromString(var sPar: OleVariant; var sLeft: OleVariant; var sRight: OleVariant; 
                               var iStart: OleVariant; var sKey: OleVariant; var nPoz: OleVariant; 
                               var nLen: OleVariant); safecall;
    procedure InsertEMailListPars(var sText: OleVariant; sType: OleVariant; sData: OleVariant; 
                                  var rs: OleVariant); safecall;
    function InsertParsFromRS(var bErr: OleVariant; var rs: OleVariant; sSourceText: OleVariant; 
                              sFieldArray: OleVariant; nPozArray: OleVariant; 
                              nLenArray: OleVariant; nSize: OleVariant; 
                              VAR_BeginOfTimes: OleVariant; var DOCS_MailListERROR3: OleVariant): OleVariant; safecall;
    function IsLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant): OleVariant; safecall;
    function PutLogFieldInUseNumber: OleVariant; safecall;
    procedure PutLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant); safecall;
    function MoneyFormat(var Amount: Currency): WideString; safecall;
    function MakeHTMLSafe(var sText: WideString): WideString; safecall;
    function Unescape(var s: WideString): OleVariant; safecall;
    function FindExtraHeader(var key: WideString): WideString; safecall;
    function Get_myProperty: WideString; safecall;
    procedure Set_myProperty(const Param1: WideString); safecall;
    procedure Set_SetSelector(const Param1: WideString); safecall;
    function myMethod(const myString: WideString): WideString; safecall;
    function RoundMoney(pAmount: Currency): Currency; safecall;
    function RightAmount(const pAmount: WideString): Currency; safecall;
    function myPowerMethod: OleVariant; safecall;
    function Get_myPowerProperty: WideString; safecall;
    procedure SendContent(var s: WideString); safecall;
    function RUS: OleVariant; safecall;
    function RUZone: OleVariant; safecall;
    function LPar: OleVariant; safecall;
    function LPar1: OleVariant; safecall;
    procedure MainCommon; safecall;
    procedure doSetKey(var txtKey: WideString); safecall;
    property Conn: _Connection read Get_Conn write _Set_Conn;
    property dsDocTemp: _Recordset read Get_dsDocTemp write _Set_dsDocTemp;
    property myProperty: WideString read Get_myProperty write Set_myProperty;
    property SetSelector: WideString write Set_SetSelector;
    property myPowerProperty: WideString read Get_myPowerProperty;
  end;

// *********************************************************************//
// DispIntf:  _CommonDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {10C2B7B5-5BE2-48F7-B487-D0154AA85861}
// *********************************************************************//
  _CommonDisp = dispinterface
    ['{10C2B7B5-5BE2-48F7-B487-D0154AA85861}']
    function obj: OleVariant; dispid 1073938462;
    function doc: OleVariant; dispid 1073938463;
    function oXL: OleVariant; dispid 1073938464;
    function oWB: OleVariant; dispid 1073938465;
    function oSheet: OleVariant; dispid 1073938466;
    function oRng: OleVariant; dispid 1073938467;
    property Conn: _Connection dispid 1073938498;
    procedure GhostMethod__Common_104_1; dispid 1610743827;
    function ds: OleVariant; dispid 1073938499;
    function dsDoc: OleVariant; dispid 1073938500;
    function dsDoc1: OleVariant; dispid 1073938501;
    function dsDoc2: OleVariant; dispid 1073938502;
    function dsDoc3: OleVariant; dispid 1073938503;
    property dsDocTemp: _Recordset dispid 1073938504;
    procedure GhostMethod__Common_176_2; dispid 1610743845;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant; dispid 1610809347;
    function GetMDBName: OleVariant; dispid 1610809348;
    function CheckNotForDemo: OleVariant; dispid 1610809349;
    function Random(var lowerbound: OleVariant; var upperbound: OleVariant): OleVariant; dispid 1610809351;
    function ReadBinFile(const bfilename: WideString): OleVariant; dispid 1610809352;
    function TransText(const myString: WideString): WideString; dispid 1610809356;
    function LicCheck: OleVariant; dispid 1610809357;
    function GoProcess(const myString: WideString): WideString; dispid 1610809358;
    function test(const myString: WideString): WideString; dispid 1610809359;
    function OnEndPage: OleVariant; dispid 1610809360;
    procedure ActiveX_Main; dispid 1610809361;
    procedure DoGet; dispid 1610809362;
    procedure DoPost; dispid 1610809363;
    function ToALLuni(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant; dispid 1610809364;
    function ToALLlocal(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant; dispid 1610809365;
    function GetSessionID: OleVariant; dispid 1610809366;
    procedure Login(var VAR_StatusActiveUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_LOGGEDIN: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                    var DOCS_STATUSHOLD: OleVariant; var USER_Role: OleVariant; 
                    var DOCS_WRONGLOGIN: OleVariant; var DOCS_SysUser: OleVariant; 
                    var DOCS_ActionLoggedIn: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                    var DOCS_NoUsersExceeded: OleVariant; var DOCS_NoPassword: OleVariant; 
                    var USER_StatusActiveEMail: OleVariant); dispid 1610809367;
    procedure GetCurrentUsers(var sUsers: OleVariant; var sTimes: OleVariant; 
                              var sAddresses: OleVariant; var VAR_BeginOfTimes: OleVariant); dispid 1610809368;
    procedure Logout(var DOCS_LOGGEDOUT: OleVariant; var DOCS_ActionLogOut: OleVariant; 
                     var DOCS_SysUser: OleVariant); dispid 1610809369;
    function MyInt(var dVal: OleVariant): OleVariant; dispid 1610809370;
    function MyCStr(var cPar: OleVariant): OleVariant; dispid 1610809371;
    procedure Delay(var nTicks: OleVariant); dispid 1610809372;
    procedure SendSMS(var cPhone: OleVariant; var cMessage: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOCS_NOPHONECELL: OleVariant; 
                      var DOCS_WRONGPHONECELL: OleVariant; var DOCS_SMSMessagingOFF: OleVariant; 
                      var DOCS_SMSMessagingERROR: OleVariant); dispid 1610809373;
    procedure ShowTimes(var sMes: OleVariant; var bShowTimes: OleVariant); dispid 1610809374;
    procedure SendSMSMessage(var bErr: OleVariant; var sMessage: OleVariant; 
                             sPhoneNumber: OleVariant; const msg: WideString; 
                             var nPort: OleVariant; var DOCS_SMSError: OleVariant; 
                             var DOCS_GSMModemBusy: OleVariant; 
                             var DOCS_WRONGPHONECELL: OleVariant; 
                             var DOCS_GSMModemError1: OleVariant; var nDelay: OleVariant; 
                             var nTimes: OleVariant; var nDelayTimes: OleVariant; 
                             var bShowTimes: OleVariant); dispid 1610809375;
    function GetCompanyName(var sDept: OleVariant): OleVariant; dispid 1610809376;
    function ShowStatusExtInt(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                              var DOCS_Int: OleVariant; var DOCS_Ext: OleVariant): OleVariant; dispid 1610809377;
    function ShowStatusArchiv(var cPar: OleVariant; var VAR_StatusArchiv: OleVariant; 
                              var DOCS_Archiv: OleVariant; var DOCS_Current: OleVariant): OleVariant; dispid 1610809378;
    function ShowStatusCompletion(var cPar: OleVariant; var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant): OleVariant; dispid 1610809379;
    function ShowStatusPaymentDirection(var cPar: OleVariant; var DOCS_PaymentOutgoing: OleVariant; 
                                        var DOCS_PaymentIncoming: OleVariant; 
                                        var DOCS_NotPaymentDoc: OleVariant): OleVariant; dispid 1610809380;
    function ShowStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                               var DOCS_StatusPaymentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentToPay: OleVariant; 
                               var DOCS_StatusPaymentPaid: OleVariant; 
                               var DOCS_StatusExistsButNotDefined: OleVariant; 
                               var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                               var DOCS_StatusPaymentPaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant; dispid 1610809381;
    function GetStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                              var DOCS_StatusPaymentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentToPay: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant; 
                              var DOCS_StatusExistsButNotDefined: OleVariant; 
                              var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                              var DOCS_StatusPaymentPaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant; dispid 1610809382;
    function ShowBPtype(var cPar: OleVariant; var DOCS_BPTypeDaily: OleVariant; 
                        var DOCS_BPTypeWeekly: OleVariant; var DOCS_BPTypeMonthly: OleVariant): OleVariant; dispid 1610809383;
    function ShowStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                               var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant; dispid 1610809384;
    function GetStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant): OleVariant; dispid 1610809385;
    function ShowStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                   var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                   var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant; dispid 1610809386;
    function GetStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                  var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant; dispid 1610809387;
    function GetStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                               var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                               var DOCS_Returned: OleVariant; 
                               var DOCS_ReturnedFromFile: OleVariant; 
                               var DOCS_WaitingToBeSent: OleVariant): OleVariant; dispid 1610809388;
    function GetStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                              var DOCS_IsExactly: OleVariant): OleVariant; dispid 1610809389;
    function ShowStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                               var DOCS_IsExactly: OleVariant): OleVariant; dispid 1610809390;
    function ShowStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                                var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_WaitingToBeSent: OleVariant): OleVariant; dispid 1610809391;
    function ShowStatusActive(var cPar: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                              var VAR_StatusActiveUserEMail: OleVariant; var DOCS_Yes: OleVariant; 
                              var DOCS_No: OleVariant; var DOCS_Yes_EMail: OleVariant): OleVariant; dispid 1610809392;
    function ShowStatusExtIntUser(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_Yes: OleVariant; var DOCS_No: OleVariant): OleVariant; dispid 1610809393;
    function ShowStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                     var DOCS_SecurityLevel2: OleVariant; 
                                     var DOCS_SecurityLevel3: OleVariant; 
                                     var DOCS_SecurityLevel4: OleVariant; 
                                     var DOCS_SecurityLevelS: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809394;
    function ShowSpecType(var cPar: OleVariant; var VAR_TypeVal_String: OleVariant; 
                          var VAR_TypeVal_DateTime: OleVariant; 
                          var VAR_TypeVal_NumericMoney: OleVariant; 
                          var DOCS_SpecFieldTypeString: OleVariant; 
                          var DOCS_SpecFieldTypeDate: OleVariant; 
                          var DOCS_SpecFieldTypeNumeric: OleVariant): OleVariant; dispid 1610809395;
    function GetStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                    var DOCS_SecurityLevel2: OleVariant; 
                                    var DOCS_SecurityLevel3: OleVariant; 
                                    var DOCS_SecurityLevel4: OleVariant; 
                                    var DOCS_SecurityLevelS: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809396;
    function MakeSQLSafe(var strInput: OleVariant): OleVariant; dispid 1610809397;
    function FixLen(var cPar: OleVariant; var iLen: OleVariant; var sSymbol: OleVariant): OleVariant; dispid 1610809398;
    function RightValue(var strInput: OleVariant): OleVariant; dispid 1610809399;
    procedure PutMessage; dispid 1610809400;
    procedure PutMessage1; dispid 1610809401;
    function NoLastBr(cPar: OleVariant): OleVariant; dispid 1610809402;
    function PutDirNRec(cPar: OleVariant): OleVariant; dispid 1610809403;
    procedure RedirHome; dispid 1610809404;
    procedure RedirMessage; dispid 1610809405;
    procedure RedirMessage1(var cPar: OleVariant); dispid 1610809406;
    procedure RedirMessage2; dispid 1610809407;
    procedure RedirStopped; dispid 1610809408;
    procedure RedirShowDoc(var cPar: OleVariant); dispid 1610809409;
    procedure CheckReg; dispid 1610809410;
    function CheckRegF: OleVariant; dispid 1610809411;
    procedure CheckAdmin(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); dispid 1610809412;
    procedure CheckIfDocIDIncomingExists(var sDocIDIncoming: OleVariant; var ds: OleVariant); dispid 1610809413;
    procedure SetIndexSearch(var rs: OleVariant; var sCATALOG: OleVariant; 
                             var DOCS_IndexError: OleVariant; var VAR_DocsMaxRecords: OleVariant); dispid 1610809414;
    function CheckAdminF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; dispid 1610809415;
    procedure CheckAdminOrUser(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant); dispid 1610809416;
    function CheckAdminOrUserF(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant): OleVariant; dispid 1610809417;
    procedure CheckAdminOrUser1(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); dispid 1610809418;
    function CheckAdminOrUser1F(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; dispid 1610809419;
    procedure CheckAdminRead(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); dispid 1610809420;
    function CheckAdminReadF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant; dispid 1610809421;
    function GetURL(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant): OleVariant; dispid 1610809422;
    function GetUserNFromList(var clist: OleVariant; var cnumber: OleVariant): OleVariant; dispid 1610809423;
    function GetUserID(var cPar: OleVariant): OleVariant; dispid 1610809424;
    function GetUserEMail(var cparUserID: OleVariant): OleVariant; dispid 1610809425;
    function GetURL2(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant): OleVariant; dispid 1610809426;
    function GetURL3(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant): OleVariant; dispid 1610809427;
    function GetURL4(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant): OleVariant; dispid 1610809428;
    function GetURL5(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant; 
                     var cpar5: OleVariant; var cvalue5: OleVariant): OleVariant; dispid 1610809429;
    procedure CheckReadAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant); dispid 1610809430;
    function CheckReadAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809431;
    procedure CheckWriteAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809432;
    function CheckWriteAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809433;
    function IsWriteAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809434;
    function IsReadAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                          var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                          var VAR_ExtInt: OleVariant): OleVariant; dispid 1610809435;
    function IsReadAccessDocID(var sDocID: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809436;
    function IsReadAccessRS(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant): OleVariant; dispid 1610809437;
    function IsReadAccessUser(var sUserID: OleVariant; var sMessage: OleVariant; 
                              var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; 
                              var VAR_StatusActiveUser: OleVariant): OleVariant; dispid 1610809438;
    procedure NoAccessReport(var cPar: OleVariant); dispid 1610809439;
    procedure AddLog(var sDocID: OleVariant; var sAction: OleVariant; var sDocName: OleVariant); dispid 1610809440;
    function SafeSQL(var cPar: OleVariant): OleVariant; dispid 1610809441;
    procedure AddLogAmountQuantity(var sAmountDocOld: OleVariant; var sAmountDocNew: OleVariant; 
                                   var sQuantityDocOld: OleVariant; 
                                   var sQuantityDocNew: OleVariant; var sDocID: OleVariant; 
                                   var sDocIDParent: OleVariant; var sName: OleVariant; 
                                   var DOCS_ActionChangeDocShort: OleVariant; 
                                   var DOCS_ActionChangeDoc: OleVariant; 
                                   var DOCS_ActionChangeDependantDoc: OleVariant); dispid 1610809442;
    procedure AddLogD(var cPar: OleVariant); dispid 1610809443;
    procedure AddLogPostcard(var cPar: OleVariant); dispid 1610809444;
    procedure AddLogDocAndParent(var sDocID: OleVariant; var sDocIDParent: OleVariant; 
                                 var sName: OleVariant; var sAmount: OleVariant; 
                                 var sQuantity: OleVariant; var sAction: OleVariant; 
                                 var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant); dispid 1610809445;
    function CheckPermit(var sSource: OleVariant; var cPar: OleVariant): OleVariant; dispid 1610809446;
    procedure GetPermit(var sSource: OleVariant; var cPar: OleVariant); dispid 1610809447;
    procedure DeletePermit(var sSource: OleVariant; var cPar: OleVariant); dispid 1610809448;
    function GetMiddleUniqueIdentifier(var UI1: OleVariant; var UI2: OleVariant): OleVariant; dispid 1610809449;
    function CorrectUniqueIdentifier(var UI: OleVariant): OleVariant; dispid 1610809450;
    function MyFormatCurrency(var rVal: OleVariant): OleVariant; dispid 1610809451;
    function MyFormatRate(var rVal: OleVariant): OleVariant; dispid 1610809452;
    function FormatCommon(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809453;
    function FormatNumberShort(var rVal: OleVariant): OleVariant; dispid 1610809454;
    function MyTableVal(var xVal: OleVariant): OleVariant; dispid 1610809455;
    function IsTime(var dVal: OleVariant): OleVariant; dispid 1610809456;
    function MyDateLong(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                        var DOCS_PERIOD_JAN1: OleVariant; var DOCS_PERIOD_FEB1: OleVariant; 
                        var DOCS_PERIOD_MAR1: OleVariant; var DOCS_PERIOD_APR1: OleVariant; 
                        var DOCS_PERIOD_MAY1: OleVariant; var DOCS_PERIOD_JUN1: OleVariant; 
                        var DOCS_PERIOD_JUL1: OleVariant; var DOCS_PERIOD_AUG1: OleVariant; 
                        var DOCS_PERIOD_SEP1: OleVariant; var DOCS_PERIOD_OCT1: OleVariant; 
                        var DOCS_PERIOD_NOV1: OleVariant; var DOCS_PERIOD_DEC1: OleVariant): OleVariant; dispid 1610809457;
    function MyDate(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809458;
    function MyDateTime(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809459;
    function MyDateShort(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809460;
    function MyChar(var dVal: OleVariant): OleVariant; dispid 1610809461;
    function MyDateBr(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809462;
    function NoNull(var cPar: OleVariant): OleVariant; dispid 1610809463;
    function NoZeroFormat(var cPar: OleVariant): OleVariant; dispid 1610809464;
    function DocsDate(var cPar: OleVariant): OleVariant; dispid 1610809465;
    function EuroDateTime(var cPar: OleVariant): OleVariant; dispid 1610809466;
    function DateName(var dDate: OleVariant): OleVariant; dispid 1610809467;
    function UniDate(var dDate: OleVariant): OleVariant; dispid 1610809468;
    function LeadZero(var cPar: OleVariant): OleVariant; dispid 1610809470;
    function ConvertToDateOLD(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                              var DOCS_WrongDate: OleVariant): OleVariant; dispid 1610809471;
    function ConvertToDate(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant): OleVariant; dispid 1610809472;
    function IsFormula(var dsDoc: OleVariant): OleVariant; dispid 1610809473;
    function IsAprovalRequired(dsDoc: OleVariant; var sUserID: OleVariant; 
                               var Var_ApprovalPermitted: OleVariant; 
                               var VAR_InActiveTask: OleVariant; var VAR_StatusCancelled: OleVariant): OleVariant; dispid 1610809474;
    procedure GetCalendarDocs(nDocs: OleVariant; var sDocs: OleVariant; nYear: OleVariant; 
                              nMonth: OleVariant; sUserID: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_PERIOD_Date: OleVariant; var DOCS_DocID: OleVariant; 
                              var DOCS_DocIDAdd: OleVariant; var DOCS_DocIDParent: OleVariant; 
                              var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                              var DOCS_PartnerName: OleVariant; 
                              var DOCS_NameResponsible: OleVariant; 
                              var DOCS_NameControl: OleVariant; var DOCS_NameAproval: OleVariant; 
                              var DOCS_ListToView: OleVariant; var DOCS_ListToEdit: OleVariant; 
                              var DOCS_ListToReconcile: OleVariant; var DOCS_Author: OleVariant; 
                              var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                              var DOCS_History: OleVariant; var DOCS_NameCreation: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                              var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant; 
                              var DOCS_ListReconciled: OleVariant; 
                              var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                              var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                              var DOCS_DocIDIncoming: OleVariant; 
                              var DOCS_DateCompletion: OleVariant; 
                              var DOCS_DateActivation: OleVariant; var StyleCalendar: OleVariant; 
                              var VAR_StatusCancelled: OleVariant; 
                              var VAR_StatusCompletion: OleVariant; var DOCS_EXPIRED2: OleVariant; 
                              var DOCS_Completed: OleVariant; var DOCS_Cancelled2: OleVariant; 
                              var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                              var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                              var DOCS_ClassDoc: OleVariant; var Var_ApprovalPermitted: OleVariant; 
                              var DOCS_APROVALREQUIRED: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant); dispid 1610809475;
    procedure GetCalendarEvents(var sDocs: OleVariant; nYear: OleVariant; nMonth: OleVariant; 
                                sUserID: OleVariant; var BGColorLight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_DateTime: OleVariant; 
                                var DOCS_DateTimeEnd: OleVariant; var StyleCalendar: OleVariant; 
                                sWidth: OleVariant); dispid 1610809476;
    function PutEvent(iCase: OleVariant; cInfo: OleVariant; sLink: OleVariant; 
                      BGColorLight: OleVariant; StyleCalendar: OleVariant; sWidth: OleVariant): OleVariant; dispid 1610809477;
    function PutInfoPicture(var cInfo: OleVariant; var cPic: OleVariant): OleVariant; dispid 1610809478;
    function GetName(var cPar: OleVariant): OleVariant; dispid 1610809479;
    function GetFullName(var cParName: OleVariant; var cParID: OleVariant): OleVariant; dispid 1610809480;
    function GetPosition(var cPar: OleVariant): OleVariant; dispid 1610809481;
    procedure GetUserDetails(var cPar: OleVariant; var sName: OleVariant; var sPhone: OleVariant; 
                             var sEMail: OleVariant; var sICQ: OleVariant; 
                             var sDepartment: OleVariant; var sPartnerName: OleVariant; 
                             var sPosition: OleVariant; var sIDentification: OleVariant; 
                             var sIDNo: OleVariant; var sIDIssuedBy: OleVariant; 
                             var dIDIssueDate: OleVariant; var dIDExpDate: OleVariant; 
                             var dBirthDate: OleVariant; var sCorporateIDNo: OleVariant; 
                             var sAddInfo: OleVariant; var sComment: OleVariant); dispid 1610809482;
    function GetPositionsNames(var cPar: OleVariant; var cDel1: OleVariant; var cDel2: OleVariant): OleVariant; dispid 1610809483;
    function GetSuffix(var cPar: OleVariant): OleVariant; dispid 1610809484;
    function RightName(cPar: OleVariant): OleVariant; dispid 1610809485;
    function ToEng(var cPar: OleVariant): OleVariant; dispid 1610809486;
    function ToEngSMS(var cPar: OleVariant): OleVariant; dispid 1610809487;
    function ToTheseSymbolsOnly(var sSymbols: OleVariant; var cPar: OleVariant): OleVariant; dispid 1610809488;
    function PutInString(var cPar: OleVariant; var nPar: OleVariant): OleVariant; dispid 1610809489;
    function GetNameAsLink(var cPar: OleVariant): OleVariant; dispid 1610809490;
    function GetNameAsLinkGN(var cPar: OleVariant): OleVariant; dispid 1610809491;
    function GetLogin(var cPar: OleVariant): OleVariant; dispid 1610809492;
    function NamesIn2ndForm(var cPar: OleVariant): OleVariant; dispid 1610809493;
    function NamesIn3rdForm(var cPar: OleVariant): OleVariant; dispid 1610809494;
    function NamesIn3ndForm(var cPar: OleVariant): OleVariant; dispid 1610809495;
    procedure CreateAutoCommentGUID(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant; var sGUID: OleVariant); dispid 1610809496;
    procedure CreateAutoComment(var sDocID: OleVariant; var sComment: OleVariant); dispid 1610809497;
    procedure CreateAutoCommentType(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant); dispid 1610809498;
    procedure ConfirmNotification; dispid 1610809499;
    function GetCompatibleSpec(var sSpecIDs: OleVariant; var sItemNameP: OleVariant): OleVariant; dispid 1610809500;
    function ShowSpecName(var cPar: OleVariant): OleVariant; dispid 1610809501;
    function GetBusinessProcessSteps(var cPar: OleVariant): OleVariant; dispid 1610809502;
    function GenNewDocID(var cParDocIDOld: OleVariant): OleVariant; dispid 1610809503;
    function GenNewDocIDIncrement(var iD: OleVariant; var Var_MaxLong: OleVariant): OleVariant; dispid 1610809504;
    function NoVbCrLf(var cPar: OleVariant): OleVariant; dispid 1610809505;
    function GetDocDetails(var cPar: OleVariant; var bIsShowLinks: OleVariant; var cRS: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DocIDAdd: OleVariant; 
                           var DOCS_DocIDParent: OleVariant; var DOCS_AmountDoc: OleVariant; 
                           var DOCS_QuantityDoc: OleVariant; var DOCS_PartnerName: OleVariant; 
                           var DOCS_NameResponsible: OleVariant; var DOCS_NameControl: OleVariant; 
                           var DOCS_NameAproval: OleVariant; var DOCS_ListToView: OleVariant; 
                           var DOCS_ListToEdit: OleVariant; var DOCS_ListToReconcile: OleVariant; 
                           var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                           var DOCS_NameCreation: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                           var DOCS_Internal: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_ListReconciled: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                           var DOCS_DocIDIncoming: OleVariant; var DOCS_DateCompletion: OleVariant; 
                           var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                           var DOCS_ClassDoc: OleVariant): OleVariant; dispid 1610809506;
    function GetDocAmount(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                          var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant; dispid 1610809507;
    function GetDocDateActivation(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809508;
    function GetDocName(var cPar: OleVariant): OleVariant; dispid 1610809509;
    function GetUserDepartment(var cPar: OleVariant): OleVariant; dispid 1610809510;
    function IsNamesCompatible(sName1: OleVariant; sName2: OleVariant): OleVariant; dispid 1610809511;
    function IsWorkingDay(var nDay: OleVariant; var nStaffTableMonth: OleVariant; 
                          var nStaffTableYear: OleVariant; var CMonths: OleVariant; 
                          var CDays: OleVariant): OleVariant; dispid 1610809512;
    function ShowWeekday(var sItemName: OleVariant; var nStaffTableMonth: OleVariant; 
                         var nStaffTableYear: OleVariant; var IsHTML: OleVariant; 
                         var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                         var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                         var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                         var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                         var CMonths: OleVariant; var CDays: OleVariant): OleVariant; dispid 1610809513;
    procedure Out(var cPar: OleVariant); dispid 1610809514;
    procedure Out1(var cPar: OleVariant); dispid 1610809515;
    procedure SendNotification(var cParRS: OleVariant; var cParDocID: OleVariant; 
                               var cRecipient: OleVariant; var cSubject: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                               var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                               var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809516;
    procedure SendNotification1(var cParRS: OleVariant; var cParDocID: OleVariant; 
                                var cRecipient: OleVariant; var cSubject: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant); dispid 1610809517;
    procedure SendNotification2(var sMessageBody: OleVariant; var cParRS: OleVariant; 
                                var cParDocID: OleVariant; var cRecipient: OleVariant; 
                                var cSubject: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant); dispid 1610809518;
    function SurnameGN(var cPar: OleVariant): OleVariant; dispid 1610809519;
    function IsOutNotif(var bPrint: OleVariant): OleVariant; dispid 1610809520;
    procedure QueueDirectoryFiles(var sQueueDirectory: OleVariant; var Files: OleVariant); dispid 1610809521;
    procedure EMailPatch1(var objMail: OleVariant); dispid 1610809522;
    procedure SendNotificationCore(var sMessageBody: OleVariant; var dsTemp: OleVariant; 
                                   var sS_Description: OleVariant; var S_UserList: OleVariant; 
                                   var S_MessageSubject: OleVariant; var S_MessageBody: OleVariant; 
                                   var S_DocID: OleVariant; var S_SecurityLevel: OleVariant; 
                                   var sSend: OleVariant; var USER_Department: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var bPrint: OleVariant; 
                                   var MailTexts: OleVariant); dispid 1610809523;
    function GetAuthenticode(var sDocID: OleVariant; var sDateCreation: OleVariant; 
                             var sUserID: OleVariant; var sAction: OleVariant): OleVariant; dispid 1610809524;
    function CheckAuthenticode(const sAuthenticode: WideString): OleVariant; dispid 1610809525;
    function ClickEMailOld(var cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; dispid 1610809526;
    function ClickEMail(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                        var cSendAction: OleVariant; var sWarning: OleVariant; 
                        var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; dispid 1610809527;
    function ClickEMailNot(var cTitle: OleVariant; var cButton: OleVariant): OleVariant; dispid 1610809528;
    function ClickEMailComment(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                               var cSendAction: OleVariant; var sWarning: OleVariant; 
                               var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; dispid 1610809529;
    function ClickEMailFile(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                            var cSendAction: OleVariant; var sWarning: OleVariant; 
                            var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; dispid 1610809530;
    function ClickEMailNoPic(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; dispid 1610809531;
    function ClickEMailBig1(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant; dispid 1610809532;
    function ClickEMailBig(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                           var cSendAction: OleVariant; var sWarning: OleVariant; 
                           var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant; dispid 1610809533;
    function Status(var cName: OleVariant; var cTitle: OleVariant): OleVariant; dispid 1610809534;
    function Sep(var cName: OleVariant; var cTitle: OleVariant): OleVariant; dispid 1610809535;
    procedure AddLogA(var sLog: OleVariant); dispid 1610809536;
    function DOUT(var sLog: OleVariant): OleVariant; dispid 1610809537;
    function ExtractMessage(const iBp: IBodyPart): IMessage; dispid 1610809538;
    procedure ProcessEMail(var sFile: OleVariant; var sDocID: OleVariant; 
                           var strSubject: OleVariant; var strFrom: OleVariant; 
                           var bErr: OleVariant; var sMessage: OleVariant; var Texts: OleVariant; 
                           var MailTexts: OleVariant); dispid 1610809539;
    procedure ProcessEMailClient(var Texts: OleVariant; var MailTexts: OleVariant); dispid 1610809540;
    procedure ProcessEMailClientCommand(var bDeleteFile: OleVariant; var sFile: OleVariant; 
                                        var iMsg: OleVariant; var sContent1: OleVariant; 
                                        var sAuthenticode: OleVariant; var sMessage: OleVariant; 
                                        var sUserEMail: OleVariant; var Texts: OleVariant; 
                                        var MailTexts: OleVariant; 
                                        var Var_nDaysToReconcile: OleVariant); dispid 1610809541;
    function ClickEMailDocID(var sDocID: OleVariant; var cSendAction: OleVariant; 
                             var sWarning: OleVariant; var cCommand: OleVariant; 
                             var cAuthenticode: OleVariant; var StyleDetailValues: OleVariant): OleVariant; dispid 1610809542;
    function NoEmpty(var cPar: OleVariant): OleVariant; dispid 1610809543;
    function NotSkipThisRecord(var sAction: OleVariant; var dsDoc: OleVariant; 
                               var VAR_StatusCompletion: OleVariant; 
                               var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                               var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                               var VAR_InActiveTask: OleVariant): OleVariant; dispid 1610809544;
    function GetEMailPar(var sContent: OleVariant; sCommand: OleVariant): OleVariant; dispid 1610809545;
    function GetEMailParDelimiter(var sContent: OleVariant; sPar: OleVariant; sDelimiter: OleVariant): OleVariant; dispid 1610809546;
    function GetEMailParComment(var sCont: OleVariant): OleVariant; dispid 1610809547;
    function Koi2Win(var StrKOI: OleVariant): OleVariant; dispid 1610809548;
    function ShowDocRow(var cTitle: OleVariant; var cValue: OleVariant): OleVariant; dispid 1610809549;
    function IsValidEMail(var cPar: OleVariant): OleVariant; dispid 1610809550;
    procedure SendPostcard(var sFile: OleVariant; var sFileMuz: OleVariant; 
                           var DOCS_PostcardSent: OleVariant; var DOCS_EMailOff: OleVariant; 
                           var DOCS_TITLEFooter: OleVariant; var DOCS_Postcard: OleVariant; 
                           var DOCS_NOEMailSender: OleVariant; var DOCS_BADEMailSender: OleVariant); dispid 1610809551;
    procedure RunGetDocSend(var cTo: OleVariant; var cFrom: OleVariant; var cBody: OleVariant; 
                            var cSubject: OleVariant; var cBodyFormat: OleVariant; 
                            var cFile: OleVariant; var DOCS_TITLEFooter: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant); dispid 1610809552;
    function GetFileName(var cPar: OleVariant): OleVariant; dispid 1610809553;
    function HTMLEncode(var cPar: OleVariant): OleVariant; dispid 1610809554;
    function HTMLEncodeNBSP(var cPar: OleVariant): OleVariant; dispid 1610809555;
    function CRtoBR(var cPar: OleVariant): OleVariant; dispid 1610809556;
    function CRtoBRHTMLEncode(var cPar: OleVariant): OleVariant; dispid 1610809557;
    function CRtoSeparatorHTMLEncode(var cPar: OleVariant; var cSeparator: OleVariant): OleVariant; dispid 1610809558;
    function SeparatorToBR(var cPar: OleVariant; var cSep: OleVariant): OleVariant; dispid 1610809559;
    function SeparatorToSymbols(var cPar: OleVariant; var cSep: OleVariant; var cSymbols: OleVariant): OleVariant; dispid 1610809560;
    function BoldContext(var cPar: OleVariant; var cCon: OleVariant): OleVariant; dispid 1610809561;
    function ShowBoldCurrentUserName(var cPar: OleVariant): OleVariant; dispid 1610809562;
    function CR: OleVariant; dispid 1610809563;
    procedure ShowContextMarks(var cPar: OleVariant; var cOnlyMarks: OleVariant); dispid 1610809564;
    function MyNumericStr(var cPar: OleVariant): OleVariant; dispid 1610809565;
    function IsVisaNow(var sUserID: OleVariant; var sListToReconcile: OleVariant; 
                       var sListReconciled: OleVariant; var sNameApproved: OleVariant): OleVariant; dispid 1610809566;
    function IsVisaLast(var sUserID: OleVariant; var sListReconciled: OleVariant): OleVariant; dispid 1610809567;
    function MyTrim(var cPar: OleVariant): OleVariant; dispid 1610809568;
    function MyDayName(var cPar: OleVariant; var DOCS_PERIOD_SAN: OleVariant; 
                       var DOCS_PERIOD_MON: OleVariant; var DOCS_PERIOD_TUS: OleVariant; 
                       var DOCS_PERIOD_WED: OleVariant; var DOCS_PERIOD_THU: OleVariant; 
                       var DOCS_PERIOD_FRI: OleVariant; var DOCS_PERIOD_SAT: OleVariant): OleVariant; dispid 1610809569;
    function QuarterName(var dPar: OleVariant; var DOCS_PERIOD_Quarter: OleVariant): OleVariant; dispid 1610809570;
    procedure SCORE_GetDate(var dDATEFROM: OleVariant; var dDATETO: OleVariant; 
                            var S_FirstPeriod: OleVariant; var S_PeriodType: OleVariant; 
                            var iPeriod: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant); dispid 1610809571;
    function MyMonthName(var cPar: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                         var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                         var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                         var DOCS_PERIOD_JUN: OleVariant; var DOCS_PERIOD_JUL: OleVariant; 
                         var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                         var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                         var DOCS_PERIOD_DEC: OleVariant): OleVariant; dispid 1610809572;
    function MonthNameEng(var cPar: OleVariant): OleVariant; dispid 1610809573;
    function IsReconciliationComplete(var S_ListToReconcile: OleVariant; 
                                      var S_ListReconciled: OleVariant): OleVariant; dispid 1610809574;
    function MarkReconciledNames(var cPar: OleVariant; var cParReconciled: OleVariant; 
                                 var DOCS_NextStepToReconcile: OleVariant; 
                                 var DOCS_Reconciled: OleVariant; var DOCS_Refused: OleVariant): OleVariant; dispid 1610809575;
    function PutInfo(var cPar: OleVariant): OleVariant; dispid 1610809576;
    function ShowCustomerName: OleVariant; dispid 1610809577;
    function InsertCommentTypeImageAsLink(var sDocID: OleVariant; var sKeyField: OleVariant; 
                                          var sSubject: OleVariant; var sComment: OleVariant; 
                                          var cParCommentType: OleVariant; 
                                          var cParSpecialInfo: OleVariant; 
                                          var cParAddress: OleVariant; 
                                          var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                          var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                          var DOCS_Comment: OleVariant; 
                                          var DOCS_RespComment: OleVariant; 
                                          var DOCS_LocationPaper: OleVariant; 
                                          var DOCS_VersionFile: OleVariant; 
                                          var DOCS_SystemMessage: OleVariant; 
                                          var DOCS_Viewed: OleVariant; var DOCS_News: OleVariant; 
                                          var DOCS_CreateRespComment: OleVariant): OleVariant; dispid 1610809578;
    function InsertCommentTypeImage(var cParCommentType: OleVariant; 
                                    var cParSpecialInfo: OleVariant; var cParAddress: OleVariant; 
                                    var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                    var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                    var DOCS_Comment: OleVariant; var DOCS_RespComment: OleVariant; 
                                    var DOCS_LocationPaper: OleVariant; 
                                    var DOCS_VersionFile: OleVariant; 
                                    var DOCS_SystemMessage: OleVariant; 
                                    var DOCS_Viewed: OleVariant; var DOCS_PushToGet: OleVariant; 
                                    var DOCS_MSWordExcelOnServer: OleVariant): OleVariant; dispid 1610809579;
    function GetNewUserIDsInList(var sNotificationListForListToReconcileBefore: OleVariant; 
                                 var sNotificationListForListToReconcileAfter: OleVariant; 
                                 var IsRefused: OleVariant): OleVariant; dispid 1610809580;
    function GetNextUserIDInList(var sList: OleVariant; var iPos: OleVariant): OleVariant; dispid 1610809581;
    function GetNotificationListForListToReconcile1(var S_ListToReconcile: OleVariant; 
                                                    var S_ListReconciled: OleVariant; 
                                                    var S_NameApproved: OleVariant; 
                                                    var S_NameAproval: OleVariant; 
                                                    var bRefused: OleVariant): OleVariant; dispid 1610809582;
    function GetNotificationListForListToReconcile(var S_ListToReconcile: OleVariant; 
                                                   var S_ListReconciled: OleVariant; 
                                                   var S_NameApproved: OleVariant; 
                                                   var bRefused: OleVariant): OleVariant; dispid 1610809583;
    function GetNotificationListForDocActivation(var dsDoc: OleVariant): OleVariant; dispid 1610809584;
    procedure MakeDocActiveOrInactiveInList(var bActiveTask: OleVariant; var dsDoc1: OleVariant; 
                                            var bPutMes: OleVariant; 
                                            var VAR_ActiveTask: OleVariant; 
                                            var VAR_InActiveTask: OleVariant; 
                                            var VAR_BeginOfTimes: OleVariant; 
                                            var DOCS_NOTFOUND: OleVariant; 
                                            var DOCS_DocID: OleVariant; 
                                            var DOCS_DateActivation: OleVariant; 
                                            var DOCS_DateCompletion: OleVariant; 
                                            var DOCS_Name: OleVariant; 
                                            var DOCS_PartnerName: OleVariant; 
                                            var DOCS_ACT: OleVariant; 
                                            var DOCS_Description: OleVariant; 
                                            var DOCS_Author: OleVariant; 
                                            var DOCS_Correspondent: OleVariant; 
                                            var DOCS_Resolution: OleVariant; 
                                            var DOCS_NotificationSentTo: OleVariant; 
                                            var DOCS_SendNotification: OleVariant; 
                                            var DOCS_UsersNotFound: OleVariant; 
                                            var DOCS_NotificationDoc: OleVariant; 
                                            var USER_NOEMail: OleVariant; 
                                            var DOCS_NoAccess: OleVariant; 
                                            var DOCS_EXPIREDSEC: OleVariant; 
                                            var DOCS_STATUSHOLD: OleVariant; 
                                            var VAR_StatusActiveUser: OleVariant; 
                                            var DOCS_ErrorSMTP: OleVariant; 
                                            var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                            var DOCS_NoReadAccess: OleVariant; 
                                            var USER_Department: OleVariant; 
                                            var VAR_ExtInt: OleVariant; 
                                            var VAR_AdminSecLevel: OleVariant; 
                                            var DOCS_FROM1: OleVariant; 
                                            var DOCS_Reconciliation: OleVariant; 
                                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                            var MailTexts: OleVariant; 
                                            var Var_nDaysToReconcile: OleVariant); dispid 1610809585;
    function GetUserNotificationList(var sNotificationList: OleVariant; var dsDoc: OleVariant): OleVariant; dispid 1610809586;
    procedure MakeDocActiveOrInactive(var sNotificationList: OleVariant; var DOCS_All: OleVariant; 
                                      var DOCS_NoWriteAccess: OleVariant; 
                                      var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; 
                                      var VAR_InActiveTask: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_UnderDevelopment: OleVariant; 
                                      var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                      var VAR_StatusCompletion: OleVariant; 
                                      var VAR_StatusCancelled: OleVariant; 
                                      var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                      var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                      var DOCS_Approving: OleVariant; 
                                      var DOCS_Approved: OleVariant; 
                                      var DOCS_RefusedApp: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant; 
                                      var Var_nDaysToReconcile: OleVariant); dispid 1610809587;
    procedure CreateReconciliationComment(var dsDoc: OleVariant; var nDaysToReconcile: OleVariant; 
                                          var DOCS_Reconciliation: OleVariant); dispid 1610809588;
    procedure DeleteReconciliationComments(var sDocID: OleVariant); dispid 1610809589;
    procedure DeleteReconciliationCommentsCanceled(var dsDoc: OleVariant); dispid 1610809590;
    procedure UpdateReconciliationComments(var sDocID: OleVariant; var sMessage: OleVariant; 
                                           var sStatus: OleVariant; 
                                           var VAR_BeginOfTimes: OleVariant; 
                                           var DOCS_DateDiff1: OleVariant); dispid 1610809591;
    procedure ModifyPaymentStatus(var sNotificationList: OleVariant; 
                                  var DOCS_StatusPaymentNotPaid: OleVariant; 
                                  var DOCS_StatusPaymentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentToPay: OleVariant; 
                                  var DOCS_StatusPaymentPaid: OleVariant; 
                                  var DOCS_StatusExistsButNotDefined: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var VAR_ActiveTask: OleVariant; var VAR_InActiveTask: OleVariant; 
                                  var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                  var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                  var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                                  var DOCS_RefusedApp: OleVariant; 
                                  var VAR_StatusActiveUser: OleVariant; var DOCS_DocID: OleVariant; 
                                  var DOCS_DateActivation: OleVariant; 
                                  var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                  var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                  var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                  var DOCS_Correspondent: OleVariant; 
                                  var DOCS_Resolution: OleVariant; 
                                  var DOCS_NotificationSentTo: OleVariant; 
                                  var DOCS_SendNotification: OleVariant; 
                                  var DOCS_UsersNotFound: OleVariant; 
                                  var DOCS_NotificationDoc: OleVariant; 
                                  var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                  var DOCS_STATUSHOLD: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                  var DOCS_Sender: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_StatusAlreadyChanged: OleVariant; 
                                  var DOCS_StatusCancel: OleVariant; var DOCS_FROM1: OleVariant; 
                                  var DOCS_Reconciliation: OleVariant; 
                                  var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                  var DOCS_StatusPaymentCancel: OleVariant; 
                                  var MailTexts: OleVariant); dispid 1610809592;
    procedure CreateAutoCommentPayment(var sDocID: OleVariant; var sComment: OleVariant; 
                                       var sStatus: OleVariant; var sAmountPart: OleVariant; 
                                       var sAmountPart2: OleVariant; var rAmountPart: OleVariant; 
                                       var sAccount: OleVariant; var sAccount2: OleVariant; 
                                       var bIncoming: OleVariant); dispid 1610809593;
    procedure ModifyAccountBalance(sAccount: OleVariant; rAmount: OleVariant; var bErr: OleVariant); dispid 1610809594;
    procedure MakeCanceled(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                           var VAR_StatusCancelled: OleVariant; var DOCS_Cancelled: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                           var bUpdated: OleVariant); dispid 1610809595;
    procedure MakeCompleted(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                            var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var USER_NOEMail: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                            var bUpdated: OleVariant); dispid 1610809596;
    procedure MakeRefuseCompletion(var sNotificationList: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_WrongDate: OleVariant; 
                                   var VAR_StatusCompletion: OleVariant; 
                                   var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant; var But_RefuseCompletion: OleVariant); dispid 1610809597;
    procedure MakeSigned(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                         var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var VAR_StatusCompletion: OleVariant; var DOCS_Signed: OleVariant; 
                         var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                         var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                         var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_SendNotification: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                         var DOCS_DateActivation: OleVariant; var DOCS_DateSigned: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                         var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                         var DOCS_Author: OleVariant; var DOCS_FROM1: OleVariant; 
                         var DOCS_Reconciliation: OleVariant; 
                         var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant); dispid 1610809598;
    procedure AutoFill(var DOCS_NORight: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                       var Var_StandardWorkHours: OleVariant; var DOCS_All: OleVariant; 
                       var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                       var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                       var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                       var CMonths: OleVariant; var CDays: OleVariant); dispid 1610809599;
    procedure ModifyPercent(var DOCS_PercentCompletion: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_WrongAmount: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_PercentValueWarning: OleVariant); dispid 1610809600;
    function IsResponsibleOnly(var S_NameAproval: OleVariant; var S_NameCreation: OleVariant; 
                               var S_ListToEdit: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var S_NameResponsible: OleVariant): OleVariant; dispid 1610809601;
    procedure CreateAutoCommentListToEdit(var dsDocListToEdit: OleVariant; 
                                          var RequestListToEdit: OleVariant; 
                                          var sDocID: OleVariant; var DOCS_Changed: OleVariant; 
                                          var DOCS_ListToEdit: OleVariant; 
                                          var DOCS_Added: OleVariant; var DOCS_Deleted: OleVariant); dispid 1610809602;
    function IsDocIDExist(var sDocID: OleVariant): OleVariant; dispid 1610809603;
    procedure ChangeDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_StatusCompletion: OleVariant; 
                             var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant); dispid 1610809604;
    procedure ChangeOneDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; 
                                var VAR_StatusCompletion: OleVariant; 
                                var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant); dispid 1610809605;
    procedure AddListCorrespondentRet(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                      var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_InfoAlreadyExists: OleVariant; 
                                      var DOCS_InformationNotUpdated: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant); dispid 1610809606;
    procedure MakeArchival(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_Archival: OleVariant; 
                           var DOCS_Operative: OleVariant; var VAR_StatusArchiv: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                           var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant); dispid 1610809607;
    procedure MakeDelivery(var DOCS_StatusDelivery: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_Records: OleVariant; var DOCS_Sent: OleVariant; 
                           var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                           var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                           var DOCS_WaitingToBeSent: OleVariant; var DOCS_ReturnedToFile: OleVariant); dispid 1610809608;
    procedure ChangeHardCopyLocation(var bIsRedirect: OleVariant; 
                                     var sNewHardCopyLocation: OleVariant; var sDocID: OleVariant; 
                                     var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                     var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                     var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                     var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant); dispid 1610809609;
    procedure ChangePaperFileName(var bIsRedirect: OleVariant; var sPaperFileName: OleVariant; 
                                  var sDocID: OleVariant; var DOCS_PaperFile: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant); dispid 1610809610;
    function GetCurrentUserFullName: OleVariant; dispid 1610809611;
    procedure MakeRegisteredRet(var DOCS_DeliveryMethod: OleVariant; 
                                var DOCS_PaperFile: OleVariant; var DOCS_TypeDoc: OleVariant; 
                                var DOCS_RegLog: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_DocIDIncoming: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Description: OleVariant; 
                                var DOCS_NameResponsible: OleVariant; 
                                var DOCS_Resolution: OleVariant; var DOCS_Registered: OleVariant; 
                                var DOCS_InformationUpdated: OleVariant; 
                                var DOCS_InformationNotUpdated: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                                var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                                var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_Comment: OleVariant; var DOCS_PostType: OleVariant; 
                                var DOCS_PostID: OleVariant; var DOCS_Recipient: OleVariant; 
                                var DOCS_PostAddress: OleVariant; var DOCS_DateSent: OleVariant; 
                                var DOCS_StatusDelivery: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                var DOCS_DateArrive: OleVariant; var DOCS_NameAproval: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateTime: OleVariant; var AddFieldName1: OleVariant; 
                                var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                                var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                                var AddFieldName6: OleVariant); dispid 1610809612;
    procedure CopyDoc(var DOCS_Copied: OleVariant); dispid 1610809613;
    procedure ClearDocBuffer(var DOCS_BufferCleared: OleVariant); dispid 1610809614;
    procedure ItemMove; dispid 1610809615;
    function ShortID(var cPar: OleVariant): OleVariant; dispid 1610809616;
    function SBigger(var cPar1: OleVariant; var cPar2: OleVariant): OleVariant; dispid 1610809617;
    procedure Shift(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_NORight: OleVariant; 
                    var DOCS_NOTFOUND: OleVariant; var DOCS_LOGIN: OleVariant; 
                    var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var Var_StandardWorkHours: OleVariant; var CMonths: OleVariant; 
                    var CDays: OleVariant); dispid 1610809618;
    procedure DeleteDoc(var DOCS_NOTFOUND: OleVariant; var DOCS_All: OleVariant; 
                        var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                        var VAR_ExtInt: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                        var DOCS_NORight: OleVariant; var DOCS_HASDEPENDANT: OleVariant; 
                        var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                        var DOCS_ActionDeleteDependantDoc: OleVariant; 
                        var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                        var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant); dispid 1610809619;
    procedure GetSelectRecordset(var S_ClassDoc: OleVariant; var sDataSourceName: OleVariant; 
                                 var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                 var sFieldNames: OleVariant); dispid 1610809620;
    procedure GetRecordsetDetailsClassDoc(S_ClassDoc: OleVariant; var nDataSources: OleVariant; 
                                          var sDataSourceName: OleVariant; 
                                          var sDataSource: OleVariant; 
                                          var sSelectRecordset: OleVariant; 
                                          var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                          var sStatementInsert: OleVariant; 
                                          var sStatementUpdate: OleVariant; 
                                          var sStatementDelete: OleVariant; var sGUID: OleVariant); dispid 1610809621;
    procedure GetRecordsetDetails(var S_GUID: OleVariant; var sDataSourceName: OleVariant; 
                                  var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                  var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                  var sStatementInsert: OleVariant; 
                                  var sStatementUpdate: OleVariant; 
                                  var sStatementDelete: OleVariant; var sComments: OleVariant; 
                                  var sGUID: OleVariant); dispid 1610809622;
    procedure DeleteExtData(var nRec: OleVariant; var sStatementDelete: OleVariant; 
                            var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                            var sSelectRecordset: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; var DOCS_DeletedExt: OleVariant; 
                            var DOCS_DeletedExt1: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var DOCS_NORight: OleVariant; 
                            var DOCS_HASDEPENDANT: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_ActionDeleteDependantDoc: OleVariant; 
                            var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant); dispid 1610809623;
    procedure GetExtRecordsetOld(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                 var sMessage: OleVariant; var sDataSource: OleVariant; 
                                 sSelectRecordset: OleVariant; 
                                 var DOCS_ErrorDataSource: OleVariant; 
                                 var DOCS_ErrorSelectRecordset: OleVariant; 
                                 var DOCS_ErrorInsertPars: OleVariant; 
                                 var DOCS_ErrorSelectNotDefined: OleVariant); dispid 1610809624;
    procedure GetExtRecordsetArch(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                  var sMessage: OleVariant; var sDataSource: OleVariant; 
                                  var sSelectRecordset: OleVariant; 
                                  var DOCS_ErrorDataSource: OleVariant; 
                                  var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                                  var DOCS_ErrorInsertPars: OleVariant; 
                                  var DOCS_ErrorSelectNotDefined: OleVariant); dispid 1610809625;
    procedure GetExtRecordset(bArch: OleVariant; var ds: OleVariant; var bErr: OleVariant; 
                              var sMessage: OleVariant; sDataSource: OleVariant; 
                              sSelectRecordset: OleVariant; sGUID: OleVariant; 
                              var DOCS_ErrorDataSource: OleVariant; 
                              var DOCS_ErrorSelectRecordset: OleVariant; 
                              var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                              var DOCS_ErrorInsertPars: OleVariant; 
                              var DOCS_ErrorSelectNotDefined: OleVariant); dispid 1610809626;
    procedure ChangeExtData(var nRec: OleVariant; var sDataSourceName: OleVariant; 
                            var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                            var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                            var sStatement: OleVariant; var bCheckOK: OleVariant; 
                            var bErr: OleVariant; var ds: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                            var DOCS_ErrorDataEdit: OleVariant; var DOCS_Error: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Changed1: OleVariant; 
                            var DOCS_Created: OleVariant; var DOCS_Created1: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_Field: OleVariant; var DOCS_WrongField: OleVariant; 
                            var DOCS_NoUpdate: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_Records: OleVariant); dispid 1610809627;
    function InsertPars(sSelect: OleVariant; var dsDoc: OleVariant; var sErr: OleVariant): OleVariant; dispid 1610809628;
    function InsertParsEval(sSelect: OleVariant; dsDoc: OleVariant; var bErr: OleVariant): OleVariant; dispid 1610809629;
    function GetNextFieldName(var sSelect: OleVariant): OleVariant; dispid 1610809630;
    function NotViewedList(var sUserList: OleVariant): OleVariant; dispid 1610809631;
    function NotAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant; dispid 1610809632;
    function NotYetAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant; dispid 1610809633;
    function GetFullUserFromList(var sList: OleVariant; var sUserID: OleVariant): OleVariant; dispid 1610809634;
    function GetUserIDFromList(var sList: OleVariant; var i1: OleVariant): OleVariant; dispid 1610809635;
    procedure Visa(var bRedirect: OleVariant; var sNotificationList: OleVariant; 
                   var sDocID: OleVariant; var sRefuse: OleVariant; var sapp: OleVariant; 
                   var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                   var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                   var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                   var DOCS_Refused: OleVariant; var DOCS_RefusedApp: OleVariant; 
                   var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                   var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                   var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                   var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                   var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                   var DOCS_NotificationSentTo: OleVariant; var DOCS_SendNotification: OleVariant; 
                   var DOCS_UsersNotFound: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                   var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                   var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                   var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                   var DOCS_Sender: OleVariant; var DOCS_APROVAL: OleVariant; 
                   var DOCS_Visa: OleVariant; var DOCS_View: OleVariant; 
                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                   var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant; 
                   var Var_nDaysToReconcile: OleVariant; var DOCS_DateDiff1: OleVariant); dispid 1610809636;
    procedure VisaCancel(var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                         var DOCS_Cancelled: OleVariant; var DOCS_Refused: OleVariant; 
                         var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                         var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                         var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; 
                         var DOCS_SendNotification: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                         var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                         var DOCS_APROVAL: OleVariant; var DOCS_Visa: OleVariant; 
                         var DOCS_View: OleVariant); dispid 1610809637;
    procedure ReconciliationCancel(var Var_nDaysToReconcile: OleVariant; 
                                   var DOCS_AGREECancelled: OleVariant; var DOCS_Visa: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                   var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant); dispid 1610809638;
    procedure ShowDoc(var dsDoc: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809639;
    function FSpec(var SxSy: OleVariant): OleVariant; dispid 1610809640;
    procedure CopySpec(var Name1: OleVariant; var Name2: OleVariant; var Conn: OleVariant; 
                       var DOC_ComplexUnits: OleVariant; var DOCS_Copied: OleVariant); dispid 1610809641;
    procedure CopySpecComponents(var Name1: OleVariant; var Name2: OleVariant; 
                                 var Conn: OleVariant; var DOCS_Copied: OleVariant; 
                                 var DOC_ComplexUnits: OleVariant); dispid 1610809642;
    procedure CreateNotice(var DOCS_Notices: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                           var DOCS_SecurityLevel2: OleVariant; 
                           var DOCS_SecurityLevel3: OleVariant; 
                           var DOCS_SecurityLevel4: OleVariant; 
                           var DOCS_SecurityLevelS: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_WrongAmount: OleVariant; var DOCS_WrongQuantity: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_Created: OleVariant); dispid 1610809643;
    procedure DeleteAct(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant); dispid 1610809644;
    procedure DeleteFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); dispid 1610809645;
    procedure DeleteUserPhoto(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_ActionDeleteFile: OleVariant); dispid 1610809646;
    procedure DeletePartnerFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant); dispid 1610809647;
    procedure DeleteDepartmentFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                   var DOCS_ActionDeleteFile: OleVariant); dispid 1610809648;
    procedure DeleteTypeDocFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant); dispid 1610809649;
    procedure DeletePrintFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); dispid 1610809650;
    procedure DeleteMailListFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant); dispid 1610809651;
    function IsClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant; dispid 1610809652;
    function DocIDParentFromClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant; dispid 1610809653;
    function NoPars(var cPar: OleVariant): OleVariant; dispid 1610809654;
    procedure FormingSQL(var dsDoc: OleVariant; var sClassDocParent: OleVariant; 
                         var sPartnerNameParent: OleVariant; 
                         var sNameResponsibleParent: OleVariant; var Specs: OleVariant; 
                         var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                         var bSpec: OleVariant; var bDateActivation: OleVariant; 
                         var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                         var sDetailes: OleVariant; var S_OrderBy1: OleVariant; 
                         var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                         var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                         var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                         var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant; 
                         var sDateOrder: OleVariant; var sDateOrder2: OleVariant; 
                         var sDateOrder3: OleVariant; var VAR_StatusArchiv: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                         var DOCS_ListToReconcile: OleVariant; 
                         var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                         var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var Consts: OleVariant; 
                         var Periods: OleVariant; var Statuses: OleVariant; 
                         var VAR_StatusExpired: OleVariant; var DOCS_IsExactly: OleVariant; 
                         var DOCS_BeginsWith: OleVariant; var DOCS_Sent: OleVariant; 
                         var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                         var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                         var DOCS_WaitingToBeSent: OleVariant; var DOCS_ClassDocParent: OleVariant); dispid 1610809655;
    procedure GetSQLDate(var sSQLDate: OleVariant; var sDetailesDate: OleVariant; 
                         var sYear: OleVariant; var sDate: OleVariant; var sField: OleVariant; 
                         var sFieldName: OleVariant; var Periods: OleVariant); dispid 1610809656;
    procedure RequestCompleted(var dsDoc: OleVariant; var sDocIDpar: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_StatusRequestCompletion: OleVariant; 
                               var DOCS_RequestedCompleted: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var VAR_ExtInt: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                               var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant); dispid 1610809657;
    function IsDateInMonitorRange(var dPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809658;
    procedure CheckLicense(var sCompany: OleVariant; var bOK: OleVariant; 
                           var DOCS_DEMO_MODE: OleVariant; var DOCS_CopyrightWarning: OleVariant; 
                           var DOCS_Error: OleVariant); dispid 1610809659;
    procedure ListRegLogDocs(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                             var DOCS_PERIOD_THISM: OleVariant; var DOCS_PERIOD_PREVM: OleVariant; 
                             var DOCS_PERIOD_1QUARTER: OleVariant; 
                             var DOCS_PERIOD_2QUARTER: OleVariant; 
                             var DOCS_PERIOD_3QUARTER: OleVariant; 
                             var DOCS_PERIOD_4QUARTER: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                             var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                             var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                             var DOCS_PERIOD_JUN: OleVariant; var OCS_PERIOD_JUL: OleVariant; 
                             var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                             var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                             var DOCS_PERIOD_DEC: OleVariant; var DOCS_PERIOD_THISY: OleVariant; 
                             var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                             var DOCS_PERIOD_YEAR: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                             var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                             var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                             var VAR_DocsMaxRecords: OleVariant); dispid 1610809660;
    procedure ListPaperFileRegistry(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                                    var DOCS_PERIOD_THISM: OleVariant; 
                                    var DOCS_PERIOD_PREVM: OleVariant; 
                                    var DOCS_PERIOD_1QUARTER: OleVariant; 
                                    var DOCS_PERIOD_2QUARTER: OleVariant; 
                                    var DOCS_PERIOD_3QUARTER: OleVariant; 
                                    var DOCS_PERIOD_4QUARTER: OleVariant; 
                                    var DOCS_PERIOD_JAN: OleVariant; 
                                    var DOCS_PERIOD_FEB: OleVariant; 
                                    var DOCS_PERIOD_MAR: OleVariant; 
                                    var DOCS_PERIOD_APR: OleVariant; 
                                    var DOCS_PERIOD_MAY: OleVariant; 
                                    var DOCS_PERIOD_JUN: OleVariant; 
                                    var OCS_PERIOD_JUL: OleVariant; 
                                    var DOCS_PERIOD_AUG: OleVariant; 
                                    var DOCS_PERIOD_SEP: OleVariant; 
                                    var DOCS_PERIOD_OCT: OleVariant; 
                                    var DOCS_PERIOD_NOV: OleVariant; 
                                    var DOCS_PERIOD_DEC: OleVariant; 
                                    var DOCS_PERIOD_THISY: OleVariant; 
                                    var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                                    var DOCS_PERIOD_YEAR: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                                    var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                                    var VAR_DocsMaxRecords: OleVariant); dispid 1610809661;
    procedure ClearSearch; dispid 1610809662;
    procedure ListDoc(var sCommand: OleVariant; var S_Title: OleVariant; var sSQL: OleVariant; 
                      var S_TitleSearchCriteria: OleVariant; var DOCS_Contacts: OleVariant; 
                      var DOCS_Comments: OleVariant; var DOCS_ContextContaining: OleVariant; 
                      var DOCS_DOCUMENTRECORDS: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var DOCS_WrongDate: OleVariant; var Periods: OleVariant; 
                      var DOCS_CATEGORY: OleVariant; var DOCS_EXPIRED1: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; var DOCS_OUTSTANDING: OleVariant; 
                      var DOCS_Status: OleVariant; var DOCS_Incoming: OleVariant; 
                      var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                      var DOCS_Department: OleVariant; var DOCS_USER: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_MYDOCS: OleVariant; var DOCS_News: OleVariant; 
                      var DOCS_FromDocs: OleVariant; var VAR_DateNewDocs: OleVariant; 
                      var DOCS_DateFormat: OleVariant; var DOCS_UNAPPROVED: OleVariant; 
                      var DOCS_EXPIRED: OleVariant; var DOCS_UnderControl: OleVariant; 
                      var DOCS_Cancelled1: OleVariant; var VAR_StatusCancelled: OleVariant; 
                      var DOCS_Completed1: OleVariant; var USER_Department: OleVariant; 
                      var DOCS_Inactives1: OleVariant; var VAR_InActiveTask: OleVariant; 
                      var DOCS_Approved1: OleVariant; var DOCS_ApprovedNot1: OleVariant; 
                      var DOCS_Refused1: OleVariant; var DOCS_NOTCOMPLETED: OleVariant; 
                      var DOCS_YouAreResponsible: OleVariant; var DOCS_YouAreCreator: OleVariant; 
                      var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                      var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                      var DOCS_ReturnedFromFile: OleVariant; var DOCS_WaitingToBeSent: OleVariant; 
                      var DOCS_PaymentOutgoingIncompleted: OleVariant; 
                      var DOCS_PaymentIncomingIncompleted: OleVariant; 
                      var DOCS_StatusRequireToBePaid: OleVariant; 
                      var DOCS_GoToPaperFileDocList: OleVariant; 
                      var DOCS_NoUsersExceeded: OleVariant; var DOCS_LOGGEDOUT: OleVariant; 
                      var DOCS_ActionLogOut: OleVariant; var DOCS_SysUser: OleVariant; 
                      var DOCS_ViewedStatusDocs: OleVariant; var Texts: OleVariant); dispid 1610809663;
    procedure InOutOfOffice(var VAR_BeginOfTimes: OleVariant); dispid 1610809664;
    function AmountByWords(var summa: OleVariant; var unit_: OleVariant): OleVariant; dispid 1610809665;
    procedure GetDoc(var sFileOut: OleVariant; var sError: OleVariant; 
                     var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                     var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                     var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                     var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                     var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                     var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                     var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                     var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                     var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                     var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                     var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                     var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                     var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                     var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                     var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                     var VAR_NamesListDelimiter1: OleVariant; 
                     var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                     var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                     var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809666;
    procedure SetDoc(obj: OleVariant; var doc: OleVariant; sFileOut: OleVariant); dispid 1610809667;
    procedure GetDoc1(var sFileOut: OleVariant; var sError: OleVariant; 
                      var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                      var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                      var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                      var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                      var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                      var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                      var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                      var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                      var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                      var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                      var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                      var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                      var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                      var VAR_NamesListDelimiter1: OleVariant; 
                      var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                      var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                      var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                      var DOCS_Internal: OleVariant); dispid 1610809668;
    procedure InsertBookmarkTable(var cField: OleVariant; var cBookmark: OleVariant); dispid 1610809669;
    procedure InsertRangeTable(var rVal: OleVariant; var mRange: OleVariant); dispid 1610809670;
    procedure InsertRangeText(var rVal: OleVariant; var mRange: OleVariant); dispid 1610809671;
    procedure InsertRangeCurrency(var cPar: OleVariant); dispid 1610809672;
    procedure InsertRange(var cPar: OleVariant); dispid 1610809673;
    procedure InsertRangeDate(var cPar: OleVariant); dispid 1610809674;
    procedure InsertRowXLS; dispid 1610809675;
    procedure InsertRow; dispid 1610809676;
    procedure InsertRowExt(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                           var doc: OleVariant; var obj: OleVariant); dispid 1610809677;
    procedure InsertRowExt1(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                            var doc: OleVariant; var obj: OleVariant); dispid 1610809678;
    procedure InsertRowExt2(var iTable: OleVariant; var doc: OleVariant; var obj: OleVariant; 
                            var bErr: OleVariant); dispid 1610809679;
    procedure AddBookmarksToTable(var Bookmarks: OleVariant; var iTable: OleVariant; 
                                  var iRow: OleVariant; var iColStart: OleVariant; 
                                  var doc: OleVariant; var obj: OleVariant; var bError: OleVariant); dispid 1610809680;
    procedure MoveBookmarks(var Bookmarks: OleVariant; var iTable: OleVariant; var doc: OleVariant; 
                            var obj: OleVariant); dispid 1610809681;
    function NoIDs(var cPar: OleVariant): OleVariant; dispid 1610809682;
    procedure InsertBookmark(var cPar: OleVariant); dispid 1610809683;
    procedure InsertBookmarkComments(var cPar: OleVariant); dispid 1610809684;
    procedure InsertBookmarkComments1(var sCommentType: OleVariant; var sBookmark: OleVariant; 
                                      var bError: OleVariant); dispid 1610809685;
    procedure InsertBookmarkCurrency(var cPar: OleVariant); dispid 1610809686;
    procedure InsertBookmarkDate(var cPar: OleVariant); dispid 1610809687;
    procedure InsertBookmarkSum(var rVal: OleVariant; var mBookmark: OleVariant); dispid 1610809688;
    procedure InsertBookmarkText(var rVal: OleVariant; var mBookmark: OleVariant); dispid 1610809689;
    procedure InsertBookmarkTextDoc(var doc: OleVariant; var rVal: OleVariant; 
                                    var mBookmark: OleVariant); dispid 1610809690;
    procedure InsertBookmarkHyperlink(var cField: OleVariant; var cBookmark: OleVariant); dispid 1610809691;
    procedure ShowSpecSummary(var VAR_QNewSpec: OleVariant); dispid 1610809692;
    procedure ShowSpecSummaryXLS(var VAR_QNewSpec: OleVariant); dispid 1610809693;
    procedure SpecMove; dispid 1610809694;
    procedure SpecIDChange(var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_SPECIDWrong: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NoChangeSpecID: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant); dispid 1610809695;
    procedure RestoreDoc(var DOCS_ActionRestoredDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_AmountDoc: OleVariant; 
                         var DOCS_QuantityDoc: OleVariant; var DOCS_ErrorDataSource: OleVariant; 
                         var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                         var DOCS_ErrorSelectRecordset: OleVariant; 
                         var DOCS_ErrorInsertPars: OleVariant; 
                         var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant); dispid 1610809696;
    procedure ReCalcSpec(var DOCS_ReCalculated: OleVariant; var DOCS_Records: OleVariant; 
                         var DOCS_Values: OleVariant; var DOCS_WrongNumber: OleVariant; 
                         var DOCS_WrongDate: OleVariant; var DOC_Calculator: OleVariant; 
                         var DOCS_Error: OleVariant; var VAR_QNewSpec: OleVariant; 
                         var VAR_TypeVal_String: OleVariant; var VAR_TypeVal_DateTime: OleVariant; 
                         var VAR_TypeVal_NumericMoney: OleVariant; 
                         var DOCS_SpecFieldName: OleVariant; var DOCS_SpecFieldFormula: OleVariant); dispid 1610809697;
    function Percent(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; dispid 1610809698;
    function PercentAdd(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; dispid 1610809699;
    function PercentAddRev(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant; dispid 1610809700;
    function Y1(var Number: OleVariant): OleVariant; dispid 1610809701;
    function FQ: OleVariant; dispid 1610809702;
    function FS: OleVariant; dispid 1610809703;
    function FS1: OleVariant; dispid 1610809704;
    function FS2: OleVariant; dispid 1610809705;
    function F1: OleVariant; dispid 1610809706;
    function F2: OleVariant; dispid 1610809707;
    function F3: OleVariant; dispid 1610809708;
    function F4: OleVariant; dispid 1610809709;
    function F5: OleVariant; dispid 1610809710;
    function F6: OleVariant; dispid 1610809711;
    function F7: OleVariant; dispid 1610809712;
    function F8: OleVariant; dispid 1610809713;
    function F9: OleVariant; dispid 1610809714;
    function F10: OleVariant; dispid 1610809715;
    function F11: OleVariant; dispid 1610809716;
    function F12: OleVariant; dispid 1610809717;
    function F13: OleVariant; dispid 1610809718;
    function F14: OleVariant; dispid 1610809719;
    function F15: OleVariant; dispid 1610809720;
    function F16: OleVariant; dispid 1610809721;
    function F17: OleVariant; dispid 1610809722;
    function F18: OleVariant; dispid 1610809723;
    function F19: OleVariant; dispid 1610809724;
    function F20: OleVariant; dispid 1610809725;
    function F21: OleVariant; dispid 1610809726;
    function F22: OleVariant; dispid 1610809727;
    function F23: OleVariant; dispid 1610809728;
    function F24: OleVariant; dispid 1610809729;
    function F25: OleVariant; dispid 1610809730;
    function F26: OleVariant; dispid 1610809731;
    function F27: OleVariant; dispid 1610809732;
    function F28: OleVariant; dispid 1610809733;
    function F29: OleVariant; dispid 1610809734;
    function F30: OleVariant; dispid 1610809735;
    function F31: OleVariant; dispid 1610809736;
    function F32: OleVariant; dispid 1610809737;
    function F33: OleVariant; dispid 1610809738;
    function F34: OleVariant; dispid 1610809739;
    function F35: OleVariant; dispid 1610809740;
    function F36: OleVariant; dispid 1610809741;
    function F37: OleVariant; dispid 1610809742;
    function F38: OleVariant; dispid 1610809743;
    function F39: OleVariant; dispid 1610809744;
    function F40: OleVariant; dispid 1610809745;
    procedure CheckError; dispid 1610809746;
    function CheckErrorF: OleVariant; dispid 1610809747;
    procedure GoError(var Description: OleVariant); dispid 1610809748;
    procedure PasteSpec(var DOCS_SpecNotPermitted: OleVariant; var DOCS_Inserted: OleVariant; 
                        var DOCS_InsertedCompatibleSpec: OleVariant); dispid 1610809749;
    procedure PasteComponentsSpec(var DOC_ComplexUnits: OleVariant; 
                                  var DOCS_QuantityDoc: OleVariant; var DOCS_Inserted: OleVariant; 
                                  var DOCS_Total: OleVariant; var DOCS_ComplexItems: OleVariant); dispid 1610809750;
    procedure DeleteType(var DOCS_NoDeleteType: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant); dispid 1610809751;
    procedure DeleteSpecItem(var DOCS_SPECElement: OleVariant; var DOCS_Deleted: OleVariant); dispid 1610809752;
    function GetDataNameAll(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; dispid 1610809753;
    function GetDataName(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; dispid 1610809754;
    function GetDataWidth(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; dispid 1610809755;
    function IsFieldEditArea(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; dispid 1610809756;
    function IsNoDir(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant; dispid 1610809757;
    function IsRUS(var cPar: OleVariant): OleVariant; dispid 1610809758;
    procedure Archive(var DOC_ArchiveExit: OleVariant; var DOC_ArchiveEnter: OleVariant; 
                      var VAR_AdminSecLevel: OleVariant; var VAR_StatusArchiv: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; 
                      var Var_ArchiveMoveAllCompletedDocsYears: OleVariant; 
                      var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                      var DOC_Moved: OleVariant; var DOC_Total: OleVariant; 
                      var DOCS_DateActivation: OleVariant; var DOCS_Completed: OleVariant; 
                      var DOCS_Archiv: OleVariant; var DOC_Move: OleVariant; 
                      var DOCS_MakeChoice: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var Var_ArchiveMoveAllOldDocsYears: OleVariant; 
                      var DOCS_ErrorDataSource: OleVariant; 
                      var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                      var DOCS_ErrorSelectRecordset: OleVariant; 
                      var DOCS_ErrorInsertPars: OleVariant; 
                      var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant); dispid 1610809759;
    procedure DeleteAuditing(var DOCS_ActionDeleteLog: OleVariant; var DOCS_NORight: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_DateOldAuditing: OleVariant; var DOCS_SysLog: OleVariant; 
                             var DOCS_Records: OleVariant); dispid 1610809760;
    procedure DeleteComment(var DOCS_ActionDeleteComment: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_ActionDeleteFile: OleVariant; var DOCS_Version: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant); dispid 1610809761;
    procedure DeleteDepartment(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var DOCS_Deleted: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809762;
    procedure DeleteInventory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809763;
    procedure DeleteMeasure(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809764;
    procedure DeletePartner(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809765;
    procedure DeletePosition(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809766;
    procedure DeleteUserDirectory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_NoDeleteDir: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var USER_Department: OleVariant; var sDepartment: OleVariant); dispid 1610809767;
    procedure DeleteUserDirectoryValues(var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant); dispid 1610809768;
    procedure DeleteDirectoryValues(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809769;
    procedure DeleteRegLog(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809770;
    procedure DeleteRequest(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809771;
    procedure DeleteScorecard(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORightToDelete: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var USER_Department: OleVariant); dispid 1610809772;
    procedure DeleteSpec(var DOCS_SysUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Spec: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                         var DOCS_NoDeleteSpec: OleVariant); dispid 1610809773;
    procedure DeleteTransaction(var DOCS_Deleted: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809774;
    procedure DeleteUser(var DOCS_NOTFOUND: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant); dispid 1610809775;
    function GetMonitorURL(var sPar: OleVariant; var sval: OleVariant; var cbm: OleVariant; 
                           var DOCS_News: OleVariant): OleVariant; dispid 1610809776;
    procedure SetMonitorSound; dispid 1610809777;
    function GetMonitorSound(var DOCS_MonitorSoundN: OleVariant; var DOCS_MonitorNoSound: OleVariant): OleVariant; dispid 1610809778;
    procedure ChangeMonitorSound(var Var_nMonitorSoundFiles: OleVariant); dispid 1610809779;
    procedure ShowListMonitorUsers(var S_PartnerID: OleVariant; var S_PartnerName: OleVariant; 
                                   var DOCS_News: OleVariant; 
                                   var DOCS_SendPersonalMessage: OleVariant; 
                                   var DOCS_SendPersonalMessageYourself: OleVariant; 
                                   var Var_nMonitorRefreshSeconds: OleVariant); dispid 1610809780;
    procedure AddUserToMonitor(var DOCS_Created: OleVariant); dispid 1610809781;
    procedure ClearMonitorList; dispid 1610809782;
    procedure DeleteUserFromMonitor(var DOCS_Deleted: OleVariant); dispid 1610809783;
    function UserInMonitor(var sUserID: OleVariant): OleVariant; dispid 1610809784;
    procedure ChangeMeasure(var S_Measure: OleVariant; var S_Code: OleVariant; 
                            var S_UnitName: OleVariant; var S_Name: OleVariant; 
                            var S_USLNAT: OleVariant; var S_USLINTER: OleVariant; 
                            var S_ALFNAT: OleVariant; var S_ALFINTER: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant); dispid 1610809785;
    procedure ChangePartner(var S_Companies: OleVariant; var S_Partner: OleVariant; 
                            var S_ShortName: OleVariant; var S_Address: OleVariant; 
                            var S_Address1: OleVariant; var S_Address2: OleVariant; 
                            var S_Phone: OleVariant; var S_Fax: OleVariant; 
                            var S_ContactName: OleVariant; var S_EMail: OleVariant; 
                            var S_WebLink: OleVariant; var S_BankDetails: OleVariant; 
                            var S_TaxID: OleVariant; var S_RegCode: OleVariant; 
                            var S_RegCode1: OleVariant; var S_Country: OleVariant; 
                            var S_Area: OleVariant; var S_City: OleVariant; 
                            var S_Industry: OleVariant; var S_ManagerName: OleVariant; 
                            var S_ManagerPosition: OleVariant; var S_ManagerPhoneNo: OleVariant; 
                            var S_AccountingManagerName: OleVariant; 
                            var S_AccountingManagerPhoneNo: OleVariant; 
                            var S_SalesManagerName: OleVariant; 
                            var S_SalesManagerPosition: OleVariant; 
                            var S_SalesManagerPhoneNo: OleVariant; var S_AddInfo: OleVariant; 
                            var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                            var S_NameLastModification: OleVariant; 
                            var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant); dispid 1610809786;
    procedure ChangePosition(var S_Position: OleVariant; var S_NameCreation: OleVariant; 
                             var S_DateCreation: OleVariant; 
                             var S_NameLastModification: OleVariant; 
                             var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                             var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant); dispid 1610809787;
    function CanModifyDirectory(var WriteSecurityLevel: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                var NameCreation: OleVariant; var USER_Department: OleVariant; 
                                var sDepartment: OleVariant): OleVariant; dispid 1610809788;
    function CanModifyDirectoryGUID(var sDirGUID: OleVariant; var sGUID: OleVariant; 
                                    var WriteSecurityLevel: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                    var USER_Department: OleVariant; var sDepartment: OleVariant): OleVariant; dispid 1610809789;
    procedure ChangeUserDirectory(var S_Name: OleVariant; var S_DocField: OleVariant; 
                                  var S_FieldName1: OleVariant; var S_FieldName2: OleVariant; 
                                  var S_FieldName3: OleVariant; var S_FieldName4: OleVariant; 
                                  var S_FieldName5: OleVariant; var S_FieldName6: OleVariant; 
                                  var S_CompanyDoc: OleVariant; var S_NameCreation: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                                  var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_All: OleVariant; var USER_Department: OleVariant; 
                                  var sDepartment: OleVariant); dispid 1610809790;
    function GetGUID: WideString; dispid 1610809791;
    function GetGUID1: WideString; dispid 1610809792;
    function GetGUIDFromKeyField(var cPar: OleVariant): OleVariant; dispid 1610809793;
    function GUID2ByteArray(const strGUID: WideString): {??PSafeArray}OleVariant; dispid 1610809794;
    procedure ChangeUserDirectoryValues(var S_GUID: OleVariant; var S_KeyField: OleVariant; 
                                        var S_Field1: OleVariant; var S_Field2: OleVariant; 
                                        var S_Field3: OleVariant; var S_Field4: OleVariant; 
                                        var S_Field5: OleVariant; var S_Field6: OleVariant; 
                                        var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_ALREADYEXISTS: OleVariant; 
                                        var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var DOCS_NORight: OleVariant; 
                                        var VAR_BeginOfTimes: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant); dispid 1610809795;
    procedure ChangeDirectoryValues(var dsDoc: OleVariant; var S_Name: OleVariant; 
                                    var S_Code: OleVariant; var S_Code2: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; 
                                    var DOCS_ALREADYEXISTS: OleVariant; 
                                    var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_ErrorGUID: OleVariant); dispid 1610809796;
    procedure ChangeRegLog(var S_Name: OleVariant; var S_Users: OleVariant; 
                           var S_Owners: OleVariant; var S_ClassDocs: OleVariant; 
                           var S_RegLogID: OleVariant; var S_VisibleFields: OleVariant; 
                           var S_DocType: OleVariant; var S_NameCreation: OleVariant; 
                           var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                           var S_DateLastModification: OleVariant; var AddFieldName1: OleVariant; 
                           var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                           var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                           var AddFieldName6: OleVariant; var AddFieldFormula1: OleVariant; 
                           var AddFieldFormula2: OleVariant; var AddFieldFormula3: OleVariant; 
                           var AddFieldFormula4: OleVariant; var AddFieldFormula5: OleVariant; 
                           var AddFieldFormula6: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_All: OleVariant); dispid 1610809797;
    procedure GetOrderPars(var dsDoc: OleVariant; var S_OrderBy1: OleVariant; 
                           var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                           var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                           var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                           var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant); dispid 1610809798;
    procedure ChangeRequest(var RequestPars: OleVariant; var dsDoc: OleVariant; 
                            var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                            var bSpec: OleVariant; var bDateActivation: OleVariant; 
                            var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                            var sDetailes: OleVariant; var VAR_StatusArchiv: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                            var DOCS_ListToReconcile: OleVariant; 
                            var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                            var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                            var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_InventoryUnit: OleVariant; 
                            var DOCS_PaymentMethod: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_StatusCompletion: OleVariant; 
                            var DOCS_OUTSTANDING: OleVariant; var DOCS_Completed1: OleVariant; 
                            var VAR_StatusCompletion: OleVariant; 
                            var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                            var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                            var DOCS_Cancelled1: OleVariant; var DOCS_Incoming: OleVariant; 
                            var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                            var DOCS_TypeDoc: OleVariant; var DOCS_ClassDoc: OleVariant; 
                            var DOCS_StatusDevelopment: OleVariant; 
                            var DOCS_NameUserFieldDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                            var DOCS_TO_Date: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; 
                            var DOCS_RequestAddSQL: OleVariant; var Statuses: OleVariant; 
                            var Periods: OleVariant; var TextConsts: OleVariant; 
                            var Consts: OleVariant; var sRequestSQL: OleVariant; 
                            var DOCS_All: OleVariant); dispid 1610809799;
    procedure ChangeTransaction(var S_Transaction: OleVariant; var S_Account: OleVariant; 
                                var S_SubAccount1: OleVariant; var S_SubAccount2: OleVariant; 
                                var S_SubAccount3: OleVariant; var S_NameCreation: OleVariant; 
                                var S_DateCreation: OleVariant; 
                                var S_NameLastModification: OleVariant; 
                                var S_DateLastModification: OleVariant; 
                                var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant); dispid 1610809800;
    procedure ChangeType(var S_Type: OleVariant; var S_Template: OleVariant; 
                         var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                         var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var UserInstructions: OleVariant; 
                         var BusinessProcessSteps: OleVariant; var BusinessProcessType: OleVariant; 
                         var StandardNameTexts: OleVariant; var NameUserFieldText1: OleVariant; 
                         var NameUserFieldText2: OleVariant; var NameUserFieldText3: OleVariant; 
                         var NameUserFieldText4: OleVariant; var NameUserFieldText5: OleVariant; 
                         var NameUserFieldText6: OleVariant; var NameUserFieldText7: OleVariant; 
                         var NameUserFieldText8: OleVariant; var NameUserFieldMoney1: OleVariant; 
                         var NameUserFieldMoney2: OleVariant; var NameUserFieldDate1: OleVariant; 
                         var NameUserFieldDate2: OleVariant; var NameSpecIDs: OleVariant; 
                         var bVar: OleVariant; var S_FormulaQuantity: OleVariant; 
                         var S_FormulaAmount: OleVariant; var TextConsts: OleVariant; 
                         var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                         var sSelectRecordset: OleVariant; var sFieldNames: OleVariant); dispid 1610809801;
    function CanAccessRecord(var SecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Users: OleVariant): OleVariant; dispid 1610809802;
    function CanViewRecord(var ReadSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var UserID: OleVariant; var sDepartment: OleVariant; 
                           var USER_Department: OleVariant; var Viewers: OleVariant): OleVariant; dispid 1610809803;
    function CanModifyRecord(var WriteSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Editors: OleVariant): OleVariant; dispid 1610809804;
    procedure ChangeScorecard(var S_GUID: OleVariant; var S_KeyWords: OleVariant; 
                              var S_Name: OleVariant; var S_Description: OleVariant; 
                              var S_PeriodType: OleVariant; var S_FirstPeriod: OleVariant; 
                              var N_PeriodsPerScreen: OleVariant; var N_ScreenWidth: OleVariant; 
                              var N_MinScorecardValue: OleVariant; 
                              var N_MaxScorecardValue: OleVariant; var S_DataSource: OleVariant; 
                              var S_DataSourcePars: OleVariant; var S_SelectRecordset: OleVariant; 
                              var S_SelectRecordsetPars: OleVariant; var S_ColorNormal: OleVariant; 
                              var S_ColorWarning: OleVariant; var S_ColorCritical: OleVariant; 
                              var S_ConditionWarning: OleVariant; 
                              var S_ConditionCritical: OleVariant; var S_SignWarning: OleVariant; 
                              var S_SignCritical: OleVariant; var S_NameFormula: OleVariant; 
                              var S_NameFormulaPars: OleVariant; var S_ValueFormula: OleVariant; 
                              var S_ValueFormat: OleVariant; 
                              var S_ScorecardDownLevelGUID: OleVariant; 
                              var S_ScorecardDownLevelFormulaLink: OleVariant; 
                              var S_Editors: OleVariant; var S_Viewers: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; var DOCS_NORight: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant); dispid 1610809805;
    procedure ChangeUser(var S_UserID: OleVariant; var S_Password: OleVariant; 
                         var S_Name: OleVariant; var S_Phone: OleVariant; 
                         var S_PhoneCell: OleVariant; var S_IDentification: OleVariant; 
                         var S_IDNo: OleVariant; var S_IDIssuedBy: OleVariant; 
                         var S_IDIssueDate: OleVariant; var S_IDExpDate: OleVariant; 
                         var S_BirthDate: OleVariant; var S_CorporateIDNo: OleVariant; 
                         var S_AddInfo: OleVariant; var S_Comment: OleVariant; 
                         var S_EMail: OleVariant; var S_PostAddress: OleVariant; 
                         var S_ICQ: OleVariant; var S_Department: OleVariant; 
                         var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                         var S_ClassDoc: OleVariant; var S_Reporttype: OleVariant; 
                         var S_CompanyDoc: OleVariant; var S_Position: OleVariant; 
                         var S_Role: OleVariant; var S_PossibleRoles: OleVariant; 
                         var S_ReadSecurityLevel: OleVariant; var S_WriteSecurityLevel: OleVariant; 
                         var S_ExtIntSecurityLevel: OleVariant; 
                         var S_DateExpirationSecurity: OleVariant; var S_StatusActive: OleVariant; 
                         var S_Permitions: OleVariant; var S_NameCreation: OleVariant; 
                         var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var sNewRole: OleVariant; 
                         var VARS: OleVariant); dispid 1610809806;
    function GenNewMSAccessReplicationID: OleVariant; dispid 1610809807;
    procedure ChangeSpecItem(var dsDoc: OleVariant; var S_ItemID: OleVariant; 
                             var S_NameSpec: OleVariant; var DOCS_Error: OleVariant; 
                             var UPC_NotFound: OleVariant; var VAR_TypeVal_String: OleVariant; 
                             var VAR_TypeVal_NumericMoney: OleVariant; 
                             var VAR_TypeVal_DateTime: OleVariant; 
                             var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                             var DOCS_WrongNumber: OleVariant; var DOCS_Created: OleVariant; 
                             var DOCS_Changed: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var S_InventoryUnitField: OleVariant; var Var_InventoryCode: OleVariant); dispid 1610809808;
    procedure ChangeSpec(var dsDoc: OleVariant; var S_NameSpec: OleVariant; 
                         var VAR_QNewSpec: OleVariant; var DOCS_ErrSpecEmptyName: OleVariant; 
                         var DOCS_Created: OleVariant; var DOCS_Changed: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant); dispid 1610809809;
    procedure ChangeReporttype(var S_Reporttype: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); dispid 1610809810;
    procedure ChangeInventory(var S_Inventory: OleVariant; var S_Code: OleVariant; 
                              var S_UnitName: OleVariant; var S_CodeInternal: OleVariant; 
                              var S_CodeInternal2: OleVariant; var S_Quantity: OleVariant; 
                              var S_PriceIn: OleVariant; var S_PriceOut: OleVariant; 
                              var S_Comment: OleVariant; var S_Comment2: OleVariant; 
                              var S_PictureURL: OleVariant; var S_Category: OleVariant; 
                              var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                              var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant); dispid 1610809811;
    procedure ChangeDepartment(var S_Department: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); dispid 1610809812;
    procedure ChangeDocIdInDepandants(var sDocIDold: OleVariant; var sDocIDnew: OleVariant); dispid 1610809813;
    procedure GetExtDataRecordsets(var dsDoc: OleVariant; var nDataSources: OleVariant; 
                                   var bErr: OleVariant; var sMessage: OleVariant; 
                                   var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                   var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                   var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                   var sStatementUpdate: OleVariant; 
                                   var sStatementDelete: OleVariant; var sGUID: OleVariant); dispid 1610809814;
    procedure GetExtDataDescriptions(var sClassDoc: OleVariant; var nDataSources: OleVariant; 
                                     var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                     var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                     var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                     var sStatementUpdate: OleVariant; 
                                     var sStatementDelete: OleVariant; var sGUID: OleVariant); dispid 1610809815;
    procedure ChangeDocIDInExtData(var sDocIDold: OleVariant; var sDocIDnew: OleVariant; 
                                   var dsDoc: OleVariant; var S_ClassDoc: OleVariant); dispid 1610809816;
    procedure PutsChanges(var cDoc: OleVariant; var cRequest: OleVariant); dispid 1610809817;
    procedure PutsChangesNewUsers(var sNewUsers: OleVariant; var cDoc: OleVariant; 
                                  var cRequest: OleVariant); dispid 1610809818;
    procedure PutsChanges1(var cDoc: OleVariant; var cRequest: OleVariant); dispid 1610809819;
    function IsRightCurrency(var cPar: OleVariant; var Var_MainSystemCurrency: OleVariant): OleVariant; dispid 1610809820;
    procedure ChangeDoc(var S_DocID: OleVariant; var S_DocIDAdd: OleVariant; 
                        var S_DocIDParent: OleVariant; var S_DocIDPrevious: OleVariant; 
                        var S_DocIDIncoming: OleVariant; var S_Department: OleVariant; 
                        var S_Author: OleVariant; var S_Correspondent: OleVariant; 
                        var S_Resolution: OleVariant; var S_History: OleVariant; 
                        var S_Result: OleVariant; var S_ExtPassword: OleVariant; 
                        var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                        var S_Name: OleVariant; var S_Description: OleVariant; 
                        var S_Content: OleVariant; var S_LocationPaper: OleVariant; 
                        var S_Currency: OleVariant; var S_CurrencyRate: OleVariant; 
                        var S_Rank: OleVariant; var S_LocationPath: OleVariant; 
                        var S_ExtInt: OleVariant; var S_PartnerName: OleVariant; 
                        var S_StatusDevelopment: OleVariant; var S_StatusArchiv: OleVariant; 
                        var S_StatusCompletion: OleVariant; var S_PaymentMethod: OleVariant; 
                        var S_StatusPayment: OleVariant; var S_InventoryUnit: OleVariant; 
                        var S_AmountDoc: OleVariant; var S_AmountDocPart: OleVariant; 
                        var S_QuantityDoc: OleVariant; var S_SecurityLevel: OleVariant; 
                        var S_DateCreation: OleVariant; var S_DateCompletion: OleVariant; 
                        var S_DateExpiration: OleVariant; var S_DateActivation: OleVariant; 
                        var S_DateSigned: OleVariant; var S_NameCreation: OleVariant; 
                        var S_NameAproval: OleVariant; var S_NameControl: OleVariant; 
                        var S_NameApproved: OleVariant; var S_ListToView: OleVariant; 
                        var S_ListToEdit: OleVariant; var S_ListToReconcile: OleVariant; 
                        var S_ListReconciled: OleVariant; var S_NameResponsible: OleVariant; 
                        var S_NameLastModification: OleVariant; 
                        var S_DateLastModification: OleVariant; var S_TypeDoc: OleVariant; 
                        var S_StandardNameTexts: OleVariant; var S_ClassDoc: OleVariant; 
                        var S_BusinessProcessStep: OleVariant; var S_IsActive: OleVariant; 
                        var HasNoSub: OleVariant; var S_UserFields: OleVariant; 
                        var TextConsts: OleVariant; var MailTexts: OleVariant); dispid 1610809821;
    function Mult(var cPar: OleVariant): OleVariant; dispid 1610809822;
    procedure ChangeAct(var S_Type: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Changed: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant); dispid 1610809823;
    procedure CopyCompany(var DOCS_Copied1: OleVariant; var DOCS_ALREADYEXISTS: OleVariant); dispid 1610809824;
    function LeadSymbolN(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant; dispid 1610809825;
    function LeadSymbolN1(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant; dispid 1610809826;
    procedure BusinessProcessInit(sBusinessProcessSteps: OleVariant); dispid 1610809827;
    procedure BPSetResultFinal(var sResultText: OleVariant); dispid 1610809828;
    function BPResultFinal: OleVariant; dispid 1610809829;
    function BPStepName(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809830;
    function BPStepNumber(sBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809831;
    function BPIsInactive(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809832;
    function BPIsActive(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809833;
    function BPIsActiveCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809834;
    function BPIsCompleted(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809835;
    function BPIsCanceled(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809836;
    function BPSetSeparator(nBPStep: OleVariant; var sTitle: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809837;
    function BPSetComment(nBPStep: OleVariant; var sComment: OleVariant; var sError: OleVariant; 
                          var sPict: OleVariant): OleVariant; dispid 1610809838;
    function BPSeparator(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809839;
    function BPComment(nBPStep: OleVariant; var sError: OleVariant; var sPict: OleVariant): OleVariant; dispid 1610809840;
    function BPResult(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809841;
    function BPResultNumber(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809842;
    function BPSetResults(nBPStep: OleVariant; var sResultSet: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809843;
    function BPResultSet(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809844;
    function BPSetResult(nBPStep: OleVariant; var nResult: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809845;
    function BPSetResultString(nBPStep: OleVariant; var sResult: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809846;
    function BPCancel(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809847;
    function BPComplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809848;
    function BPIncomplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809849;
    function BPDeactivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809850;
    function BPActivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809851;
    function BPActivateCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant; dispid 1610809852;
    function IsWrongNBPStep(var nBPStep: OleVariant): OleVariant; dispid 1610809853;
    function BoardOrderValue(var dDate: OleVariant; var sKey: OleVariant; var dDateEvent: OleVariant): OleVariant; dispid 1610809854;
    function BoardOrderValueSQL: OleVariant; dispid 1610809855;
    procedure CheckOut(var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                       var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                       var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var DOCS_CheckedOut: OleVariant; 
                       var DOCS_Version: OleVariant; var DOCS_CheckedOutAlready: OleVariant); dispid 1610809856;
    procedure CreateComment(var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_CommentDescription: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_News: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var DOCS_DateFormat: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                            var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                            var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant); dispid 1610809857;
    procedure CreateCommentEMailClient(var sUserID: OleVariant; var sUserName: OleVariant; 
                                       var sDocID: OleVariant; var sCommentType: OleVariant; 
                                       var sSubject: OleVariant; var sComment: OleVariant; 
                                       var sMessage: OleVariant; var DOCS_CommentCreated: OleVariant); dispid 1610809858;
    procedure CreateViewed(var ds: OleVariant; var sDocIDpar: OleVariant; 
                           var DOCS_Viewed: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant); dispid 1610809859;
    procedure UploadDescriptionXMLRet(var sMessage: OleVariant; var DocFields: OleVariant; 
                                      var nFields: OleVariant; var ReportFields: OleVariant; 
                                      var nReportFields: OleVariant; 
                                      var DOCS_ALREADYEXISTS: OleVariant; 
                                      var DOCS_FileUploaded: OleVariant; 
                                      var DOCS_DocID: OleVariant; var DOCS_Name: OleVariant); dispid 1610809860;
    function IsFieldExist(var rs: OleVariant; var sFieldName: OleVariant): OleVariant; dispid 1610809861;
    procedure UploadPartnerRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); dispid 1610809862;
    procedure UploadDepartmentRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_FileNotUploaded: OleVariant; 
                                  var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                  var DOCS_FileName: OleVariant; 
                                  var DOCS_VersionFileChanged: OleVariant; 
                                  var DOCS_NoModiFile1: OleVariant; 
                                  var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant); dispid 1610809863;
    procedure UploadTypeDocRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant); dispid 1610809864;
    procedure UploadUserPhotoRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                 var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                 var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_FileNotUploaded: OleVariant; 
                                 var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                 var DOCS_FileName: OleVariant; 
                                 var DOCS_VersionFileChanged: OleVariant; 
                                 var DOCS_NoModiFile1: OleVariant; 
                                 var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant); dispid 1610809865;
    function PostcardFilePrefix: OleVariant; dispid 1610809866;
    function PostcardFile(var sExt: OleVariant): OleVariant; dispid 1610809867;
    function PostcardFileNoPath(var sExt: OleVariant): OleVariant; dispid 1610809868;
    function PostcardFileURL(var sExt: OleVariant): OleVariant; dispid 1610809869;
    function IsPostcardFile(sFile: OleVariant): OleVariant; dispid 1610809870;
    procedure UploadPostcardPicRet(var sMessage: OleVariant; var sFile: OleVariant; 
                                   var sFileURL: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                   var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_FileNotUploaded: OleVariant; 
                                   var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                   var DOCS_FileName: OleVariant; 
                                   var DOCS_VersionFileChanged: OleVariant; 
                                   var DOCS_NoModiFile1: OleVariant; 
                                   var DOCS_NoModiFile2: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_MaxFileSizeExceeded1: OleVariant); dispid 1610809871;
    procedure LoadDBCheck(var bMain: OleVariant; var DOCS_Table: OleVariant; 
                          var DOCS_TableContainsData: OleVariant; 
                          var DOCS_TableContainsDataNot: OleVariant; var bOKAny: OleVariant); dispid 1610809872;
    procedure LoadDB(var DOCS_TableContainsData: OleVariant; 
                     var DOCS_TableSourceNoData: OleVariant; var DOCS_Records: OleVariant; 
                     var VAR_AdminSecLevel: OleVariant; var DOCS_LoadDB1: OleVariant; 
                     var DOCS_Error: OleVariant; var DOCS_Table: OleVariant; 
                     var DOCS_Field: OleVariant; var DOCS_FieldValue: OleVariant; 
                     var DOCS_FieldTypeFrom: OleVariant; var DOCS_FieldTypeTo: OleVariant; 
                     var DOCS_LoadDBEnd: OleVariant; var DOCS_TableSourceRecordCount: OleVariant; 
                     var DOCS_TableTargetRecordCount: OleVariant); dispid 1610809873;
    procedure UploadRetNew(sNotificationList: OleVariant; var sMessage: OleVariant; 
                           var sKeyField: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                           var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                           var DOCS_FileName: OleVariant; var DOCS_VersionFileChanged: OleVariant; 
                           var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_NORight: OleVariant; 
                           var DOCS_CheckInUsePictogram: OleVariant; 
                           var DOCS_VersionFileUploaded: OleVariant; 
                           var DOCS_CheckedIn: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_RecListUsersUpload: OleVariant; 
                           var DOCS_AccessDenied: OleVariant; var DOCS_DocID: OleVariant; 
                           var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant); dispid 1610809874;
    function GetRandomSeq(var nSeq: OleVariant): OleVariant; dispid 1610809875;
    procedure ListPartners(var dsDoc: OleVariant; var sSQL: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                           var VAR_DocsMaxRecords: OleVariant; var par_searchsearch: OleVariant; 
                           var par_C_Search: OleVariant; var par_SearchComments: OleVariant; 
                           var par_Companies: OleVariant); dispid 1610809876;
    procedure ListUserDirectories(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                                  var VAR_DocsMaxRecords: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant); dispid 1610809877;
    procedure ListReportRequests(var sSQL: OleVariant; var USER_Department: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant); dispid 1610809878;
    procedure ListUserDirectoryValues(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                      var KeyField: OleVariant); dispid 1610809879;
    procedure ListDirectoryValues(var sSQL: OleVariant); dispid 1610809880;
    procedure ListUsers(var dsDoc: OleVariant; var sSQL: OleVariant; 
                        var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                        var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant; 
                        var par_Companies: OleVariant; var par_searchPartner: OleVariant; 
                        var par_searchDepartment: OleVariant; var par_searchsearch: OleVariant; 
                        var par_C_Search: OleVariant; var par_searchPosition: OleVariant); dispid 1610809881;
    procedure ListDirectories(var dsDoc: OleVariant; var sCurDir: OleVariant; 
                              var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant); dispid 1610809882;
    procedure ListInventory(var dsDoc: OleVariant; var sSQL: OleVariant; 
                            var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_FOUND: OleVariant); dispid 1610809883;
    procedure ListMeasure(var dsDoc: OleVariant; var sSQL: OleVariant; 
                          var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                          var DOCS_FOUND: OleVariant); dispid 1610809884;
    procedure ShowListNotices(var S_DocID: OleVariant; var dsDoc1: OleVariant; 
                              var sBusinessProcessSteps: OleVariant; var DOCS_Notices: OleVariant); dispid 1610809885;
    function CommentsOrder: OleVariant; dispid 1610809886;
    procedure ShowListComments(var S_DocID: OleVariant; var dsDoc1: OleVariant); dispid 1610809887;
    procedure ShowListCommentsTransactions(var S_GUID: OleVariant; var dsDoc1: OleVariant); dispid 1610809888;
    procedure ShowListCommentsPartner(var S_PartnerID: OleVariant; var S_Partner: OleVariant; 
                                      var dsDoc1: OleVariant); dispid 1610809889;
    procedure ShowListCommentsUser(var S_UserID: OleVariant; var dsDoc1: OleVariant); dispid 1610809890;
    procedure ShowListSpecUnits(var S_DocID: OleVariant; var ds: OleVariant; 
                                var sSpecIDs: OleVariant); dispid 1610809891;
    procedure ShowDocSpecItems(var S_DocID: OleVariant; var dsDoc1: OleVariant); dispid 1610809892;
    function ShowContext(var cPar: OleVariant): OleVariant; dispid 1610809893;
    function ShowContextHTMLEncode(var cPar: OleVariant): OleVariant; dispid 1610809894;
    function GetExt(var fName: OleVariant): OleVariant; dispid 1610809895;
    function GetWithoutExt(var fName: OleVariant): OleVariant; dispid 1610809896;
    function AddLogM(var sLog: OleVariant): OleVariant; dispid 1610809897;
    function MailListOLD(var DOCS_MailListNotFound: OleVariant; var DOCS_MailList: OleVariant; 
                         var DOCS_MailsSent: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant; dispid 1610809898;
    procedure GetMailListFilesAndMessages(var Files: OleVariant; var iMsgs: OleVariant); dispid 1610809899;
    procedure GetPrintFiles(var Files: OleVariant); dispid 1610809900;
    procedure MailList(var rs: OleVariant; var sDataName: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var USER_NOEMail: OleVariant; 
                       var USER_BADEMail: OleVariant; var DOCS_MailListMarkFile: OleVariant; 
                       var DOCS_MessageSent: OleVariant; var DOCS_MailListMarkExtData: OleVariant; 
                       var DOCS_DBEOF: OleVariant; var DOCS_MailList: OleVariant; 
                       var VAR_BeginOfTimes: OleVariant; var DOCS_MailsSent: OleVariant; 
                       var DOCS_DataSourceRecords: OleVariant; var DOCS_LISTUSERS: OleVariant; 
                       var DOCS_LISTCONTACTNAMES: OleVariant; var DOCS_Source: OleVariant; 
                       var DOCS_FileName: OleVariant; var DOCS_MailListERROR1: OleVariant; 
                       var DOCS_ErrorDataSource: OleVariant; 
                       var DOCS_ErrorSelectRecordset: OleVariant; 
                       var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                       var DOCS_ErrorInsertPars: OleVariant; 
                       var DOCS_ErrorSelectNotDefined: OleVariant; 
                       var DOCS_MailListERRORTO: OleVariant; 
                       var DOCS_MailListERRORFIELD: OleVariant; 
                       var DOCS_MailListRunning: OleVariant; var DOCS_MailListERROR2: OleVariant; 
                       var DOCS_DemoMaximumMails: OleVariant; var DOCS_MailListERROR3: OleVariant; 
                       var nDelay: OleVariant); dispid 1610809901;
    function CheckRSField(var rs: OleVariant; var sToField: OleVariant): OleVariant; dispid 1610809902;
    procedure GetKeyFromString(var sPar: OleVariant; var sLeft: OleVariant; var sRight: OleVariant; 
                               var iStart: OleVariant; var sKey: OleVariant; var nPoz: OleVariant; 
                               var nLen: OleVariant); dispid 1610809903;
    procedure InsertEMailListPars(var sText: OleVariant; sType: OleVariant; sData: OleVariant; 
                                  var rs: OleVariant); dispid 1610809904;
    function InsertParsFromRS(var bErr: OleVariant; var rs: OleVariant; sSourceText: OleVariant; 
                              sFieldArray: OleVariant; nPozArray: OleVariant; 
                              nLenArray: OleVariant; nSize: OleVariant; 
                              VAR_BeginOfTimes: OleVariant; var DOCS_MailListERROR3: OleVariant): OleVariant; dispid 1610809905;
    function IsLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant): OleVariant; dispid 1610809906;
    function PutLogFieldInUseNumber: OleVariant; dispid 1610809907;
    procedure PutLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant); dispid 1610809908;
    function MoneyFormat(var Amount: Currency): WideString; dispid 1610809909;
    function MakeHTMLSafe(var sText: WideString): WideString; dispid 1610809910;
    function Unescape(var s: WideString): OleVariant; dispid 1610809911;
    function FindExtraHeader(var key: WideString): WideString; dispid 1610809914;
    property myProperty: WideString dispid 1745027074;
    property SetSelector: WideString writeonly dispid 1745027073;
    function myMethod(const myString: WideString): WideString; dispid 1610809915;
    function RoundMoney(pAmount: Currency): Currency; dispid 1610809916;
    function RightAmount(const pAmount: WideString): Currency; dispid 1610809917;
    function myPowerMethod: OleVariant; dispid 1610809918;
    property myPowerProperty: WideString readonly dispid 1745027072;
    procedure SendContent(var s: WideString); dispid 1610809920;
    function RUS: OleVariant; dispid 1610809921;
    function RUZone: OleVariant; dispid 1610809922;
    function LPar: OleVariant; dispid 1610809923;
    function LPar1: OleVariant; dispid 1610809924;
    procedure MainCommon; dispid 1610809925;
    procedure doSetKey(var txtKey: WideString); dispid 1610809973;
  end;

// *********************************************************************//
// Interface: _Form
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2B83E039-A180-4A59-8C3E-727651B8DC93}
// *********************************************************************//
  _Form = interface(IDispatch)
    ['{2B83E039-A180-4A59-8C3E-727651B8DC93}']
    function Item(var Index: OleVariant): _FormItem; safecall;
    function Get_Count: Integer; safecall;
    function NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _FormDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2B83E039-A180-4A59-8C3E-727651B8DC93}
// *********************************************************************//
  _FormDisp = dispinterface
    ['{2B83E039-A180-4A59-8C3E-727651B8DC93}']
    function Item(var Index: OleVariant): _FormItem; dispid 0;
    property Count: Integer readonly dispid 1745027072;
    function NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _FormItem
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {49E1C150-13AE-4C79-A343-370419B73C58}
// *********************************************************************//
  _FormItem = interface(IDispatch)
    ['{49E1C150-13AE-4C79-A343-370419B73C58}']
    function Get_Data: WideString; safecall;
    function Get_Properties: _Properties; safecall;
    function Save(const Path: WideString; const FileName: WideString; IsOverWrite: WordBool): E_SAVE_RETURNVALUE; safecall;
    function Save1: OleVariant; safecall;
    property Data: WideString read Get_Data;
    property Properties: _Properties read Get_Properties;
  end;

// *********************************************************************//
// DispIntf:  _FormItemDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {49E1C150-13AE-4C79-A343-370419B73C58}
// *********************************************************************//
  _FormItemDisp = dispinterface
    ['{49E1C150-13AE-4C79-A343-370419B73C58}']
    property Data: WideString readonly dispid 0;
    property Properties: _Properties readonly dispid 1745027072;
    function Save(const Path: WideString; const FileName: WideString; IsOverWrite: WordBool): E_SAVE_RETURNVALUE; dispid 1610809345;
    function Save1: OleVariant; dispid 1610809346;
  end;

// *********************************************************************//
// Interface: _Properties
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B309B5CD-F0BB-41FD-8F61-81220D2025CE}
// *********************************************************************//
  _Properties = interface(IDispatch)
    ['{B309B5CD-F0BB-41FD-8F61-81220D2025CE}']
    function Item(var Index: OleVariant): _Property; safecall;
    function Get_Count: Integer; safecall;
    function NewEnum: IUnknown; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  _PropertiesDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {B309B5CD-F0BB-41FD-8F61-81220D2025CE}
// *********************************************************************//
  _PropertiesDisp = dispinterface
    ['{B309B5CD-F0BB-41FD-8F61-81220D2025CE}']
    function Item(var Index: OleVariant): _Property; dispid 0;
    property Count: Integer readonly dispid 1745027072;
    function NewEnum: IUnknown; dispid -4;
  end;

// *********************************************************************//
// Interface: _Property
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5E0E3B73-558B-4777-9E96-1E140A49C5B6}
// *********************************************************************//
  _Property = interface(IDispatch)
    ['{5E0E3B73-558B-4777-9E96-1E140A49C5B6}']
    function Get_Name: WideString; safecall;
    function Get_Value: WideString; safecall;
    property Name: WideString read Get_Name;
    property Value: WideString read Get_Value;
  end;

// *********************************************************************//
// DispIntf:  _PropertyDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {5E0E3B73-558B-4777-9E96-1E140A49C5B6}
// *********************************************************************//
  _PropertyDisp = dispinterface
    ['{5E0E3B73-558B-4777-9E96-1E140A49C5B6}']
    property Name: WideString readonly dispid 1745027072;
    property Value: WideString readonly dispid 0;
  end;

// *********************************************************************//
// Interface: _Upload
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {753A1788-E813-4BD6-819D-72C8EB9DAB71}
// *********************************************************************//
  _Upload = interface(IDispatch)
    ['{753A1788-E813-4BD6-819D-72C8EB9DAB71}']
    function Get_Form: _Form; safecall;
    procedure AddLogD(var cPar: OleVariant); safecall;
    function doUploadOLD: Integer; safecall;
    function doUpload: Integer; safecall;
    function Download(const Path: WideString; const FileName: WideString): E_DOWNLOAD_RETURNVALUE; safecall;
    property Form: _Form read Get_Form;
  end;

// *********************************************************************//
// DispIntf:  _UploadDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {753A1788-E813-4BD6-819D-72C8EB9DAB71}
// *********************************************************************//
  _UploadDisp = dispinterface
    ['{753A1788-E813-4BD6-819D-72C8EB9DAB71}']
    property Form: _Form readonly dispid 1745027072;
    procedure AddLogD(var cPar: OleVariant); dispid 1610809347;
    function doUploadOLD: Integer; dispid 1610809348;
    function doUpload: Integer; dispid 1610809349;
    function Download(const Path: WideString; const FileName: WideString): E_DOWNLOAD_RETURNVALUE; dispid 1610809350;
  end;

// *********************************************************************//
// Interface: _Connect1C
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E297D2EB-323A-4D37-B3FF-2B7B53B27287}
// *********************************************************************//
  _Connect1C = interface(IDispatch)
    ['{E297D2EB-323A-4D37-B3FF-2B7B53B27287}']
    procedure SFIn(const ComputerName: WideString; const BasePath: WideString; 
                   const AppType: WideString; const UserID: WideString; const Pass: WideString); safecall;
    procedure SFOut(const ComputerName: WideString; const BasePath: WideString; 
                    const AppType: WideString; const UserID: WideString; const Pass: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  _Connect1CDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E297D2EB-323A-4D37-B3FF-2B7B53B27287}
// *********************************************************************//
  _Connect1CDisp = dispinterface
    ['{E297D2EB-323A-4D37-B3FF-2B7B53B27287}']
    procedure SFIn(const ComputerName: WideString; const BasePath: WideString; 
                   const AppType: WideString; const UserID: WideString; const Pass: WideString); dispid 1610809348;
    procedure SFOut(const ComputerName: WideString; const BasePath: WideString; 
                    const AppType: WideString; const UserID: WideString; const Pass: WideString); dispid 1610809349;
  end;

// *********************************************************************//
// Interface: _VB5Power
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}
// *********************************************************************//
  _VB5Power = interface(IDispatch)
    ['{4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}']
    function Get_myProperty: WideString; safecall;
    procedure Set_myProperty(const Param1: WideString); safecall;
    function myMethod(const myString: WideString): WideString; safecall;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant; safecall;
    function OnEndPage: OleVariant; safecall;
    function myPowerMethod: OleVariant; safecall;
    function Get_myPowerProperty: WideString; safecall;
    property myProperty: WideString read Get_myProperty write Set_myProperty;
    property myPowerProperty: WideString read Get_myPowerProperty;
  end;

// *********************************************************************//
// DispIntf:  _VB5PowerDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}
// *********************************************************************//
  _VB5PowerDisp = dispinterface
    ['{4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}']
    property myProperty: WideString dispid 1745027073;
    function myMethod(const myString: WideString): WideString; dispid 1610809347;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant; dispid 1610809348;
    function OnEndPage: OleVariant; dispid 1610809349;
    function myPowerMethod: OleVariant; dispid 1610809350;
    property myPowerProperty: WideString readonly dispid 1745027072;
  end;

// *********************************************************************//
// The Class CoCommon provides a Create and CreateRemote method to          
// create instances of the default interface _Common exposed by              
// the CoClass Common. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCommon = class
    class function Create: _Common;
    class function CreateRemote(const MachineName: string): _Common;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCommon
// Help String      : 
// Default Interface: _Common
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCommonProperties= class;
{$ENDIF}
  TCommon = class(TOleServer)
  private
    FIntf:        _Common;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TCommonProperties;
    function      GetServerProperties: TCommonProperties;
{$ENDIF}
    function      GetDefaultInterface: _Common;
  protected
    procedure InitServerData; override;
    function Get_obj: OleVariant;
    procedure Set_obj(var obj: OleVariant);
    procedure _Set_obj(var obj: OleVariant);
    function Get_doc: OleVariant;
    procedure Set_doc(var doc: OleVariant);
    procedure _Set_doc(var doc: OleVariant);
    function Get_oXL: OleVariant;
    procedure Set_oXL(var oXL: OleVariant);
    procedure _Set_oXL(var oXL: OleVariant);
    function Get_oWB: OleVariant;
    procedure Set_oWB(var oWB: OleVariant);
    procedure _Set_oWB(var oWB: OleVariant);
    function Get_oSheet: OleVariant;
    procedure Set_oSheet(var oSheet: OleVariant);
    procedure _Set_oSheet(var oSheet: OleVariant);
    function Get_oRng: OleVariant;
    procedure Set_oRng(var oRng: OleVariant);
    procedure _Set_oRng(var oRng: OleVariant);
    function Get_Conn: _Connection;
    procedure _Set_Conn(const Conn: _Connection);
    function Get_ds: OleVariant;
    procedure Set_ds(var ds: OleVariant);
    procedure _Set_ds(var ds: OleVariant);
    function Get_dsDoc: OleVariant;
    procedure Set_dsDoc(var dsDoc: OleVariant);
    procedure _Set_dsDoc(var dsDoc: OleVariant);
    function Get_dsDoc1: OleVariant;
    procedure Set_dsDoc1(var dsDoc1: OleVariant);
    procedure _Set_dsDoc1(var dsDoc1: OleVariant);
    function Get_dsDoc2: OleVariant;
    procedure Set_dsDoc2(var dsDoc2: OleVariant);
    procedure _Set_dsDoc2(var dsDoc2: OleVariant);
    function Get_dsDoc3: OleVariant;
    procedure Set_dsDoc3(var dsDoc3: OleVariant);
    procedure _Set_dsDoc3(var dsDoc3: OleVariant);
    function Get_dsDocTemp: _Recordset;
    procedure _Set_dsDocTemp(const dsDocTemp: _Recordset);
    function Get_myProperty: WideString;
    procedure Set_myProperty(const Param1: WideString);
    procedure Set_SetSelector(const Param1: WideString);
    function Get_myPowerProperty: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Common);
    procedure Disconnect; override;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant;
    function GetMDBName: OleVariant;
    function CheckNotForDemo: OleVariant;
    function Random(var lowerbound: OleVariant; var upperbound: OleVariant): OleVariant;
    function ReadBinFile(const bfilename: WideString): OleVariant;
    function TransText(const myString: WideString): WideString;
    function LicCheck: OleVariant;
    function GoProcess(const myString: WideString): WideString;
    function test(const myString: WideString): WideString;
    function OnEndPage: OleVariant;
    procedure ActiveX_Main;
    procedure DoGet;
    procedure DoPost;
    function ToALLuni(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant;
    function ToALLlocal(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant;
    function GetSessionID: OleVariant;
    procedure Login(var VAR_StatusActiveUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_LOGGEDIN: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                    var DOCS_STATUSHOLD: OleVariant; var USER_Role: OleVariant; 
                    var DOCS_WRONGLOGIN: OleVariant; var DOCS_SysUser: OleVariant; 
                    var DOCS_ActionLoggedIn: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                    var DOCS_NoUsersExceeded: OleVariant; var DOCS_NoPassword: OleVariant; 
                    var USER_StatusActiveEMail: OleVariant);
    procedure GetCurrentUsers(var sUsers: OleVariant; var sTimes: OleVariant; 
                              var sAddresses: OleVariant; var VAR_BeginOfTimes: OleVariant);
    procedure Logout(var DOCS_LOGGEDOUT: OleVariant; var DOCS_ActionLogOut: OleVariant; 
                     var DOCS_SysUser: OleVariant);
    function MyInt(var dVal: OleVariant): OleVariant;
    function MyCStr(var cPar: OleVariant): OleVariant;
    procedure Delay(var nTicks: OleVariant);
    procedure SendSMS(var cPhone: OleVariant; var cMessage: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOCS_NOPHONECELL: OleVariant; 
                      var DOCS_WRONGPHONECELL: OleVariant; var DOCS_SMSMessagingOFF: OleVariant; 
                      var DOCS_SMSMessagingERROR: OleVariant);
    procedure ShowTimes(var sMes: OleVariant; var bShowTimes: OleVariant);
    procedure SendSMSMessage(var bErr: OleVariant; var sMessage: OleVariant; 
                             sPhoneNumber: OleVariant; const msg: WideString; 
                             var nPort: OleVariant; var DOCS_SMSError: OleVariant; 
                             var DOCS_GSMModemBusy: OleVariant; 
                             var DOCS_WRONGPHONECELL: OleVariant; 
                             var DOCS_GSMModemError1: OleVariant; var nDelay: OleVariant; 
                             var nTimes: OleVariant; var nDelayTimes: OleVariant; 
                             var bShowTimes: OleVariant);
    function GetCompanyName(var sDept: OleVariant): OleVariant;
    function ShowStatusExtInt(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                              var DOCS_Int: OleVariant; var DOCS_Ext: OleVariant): OleVariant;
    function ShowStatusArchiv(var cPar: OleVariant; var VAR_StatusArchiv: OleVariant; 
                              var DOCS_Archiv: OleVariant; var DOCS_Current: OleVariant): OleVariant;
    function ShowStatusCompletion(var cPar: OleVariant; var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant): OleVariant;
    function ShowStatusPaymentDirection(var cPar: OleVariant; var DOCS_PaymentOutgoing: OleVariant; 
                                        var DOCS_PaymentIncoming: OleVariant; 
                                        var DOCS_NotPaymentDoc: OleVariant): OleVariant;
    function ShowStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                               var DOCS_StatusPaymentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                               var DOCS_StatusPaymentToPay: OleVariant; 
                               var DOCS_StatusPaymentPaid: OleVariant; 
                               var DOCS_StatusExistsButNotDefined: OleVariant; 
                               var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                               var DOCS_StatusPaymentPaidPart: OleVariant; 
                               var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant;
    function GetStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                              var DOCS_StatusPaymentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                              var DOCS_StatusPaymentToPay: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant; 
                              var DOCS_StatusExistsButNotDefined: OleVariant; 
                              var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                              var DOCS_StatusPaymentPaidPart: OleVariant; 
                              var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant;
    function ShowBPtype(var cPar: OleVariant; var DOCS_BPTypeDaily: OleVariant; 
                        var DOCS_BPTypeWeekly: OleVariant; var DOCS_BPTypeMonthly: OleVariant): OleVariant;
    function ShowStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                               var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant;
    function GetStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant): OleVariant;
    function ShowStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                   var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                   var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant;
    function GetStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                  var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant;
    function GetStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                               var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                               var DOCS_Returned: OleVariant; 
                               var DOCS_ReturnedFromFile: OleVariant; 
                               var DOCS_WaitingToBeSent: OleVariant): OleVariant;
    function GetStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                              var DOCS_IsExactly: OleVariant): OleVariant;
    function ShowStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                               var DOCS_IsExactly: OleVariant): OleVariant;
    function ShowStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                                var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_WaitingToBeSent: OleVariant): OleVariant;
    function ShowStatusActive(var cPar: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                              var VAR_StatusActiveUserEMail: OleVariant; var DOCS_Yes: OleVariant; 
                              var DOCS_No: OleVariant; var DOCS_Yes_EMail: OleVariant): OleVariant;
    function ShowStatusExtIntUser(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_Yes: OleVariant; var DOCS_No: OleVariant): OleVariant;
    function ShowStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                     var DOCS_SecurityLevel2: OleVariant; 
                                     var DOCS_SecurityLevel3: OleVariant; 
                                     var DOCS_SecurityLevel4: OleVariant; 
                                     var DOCS_SecurityLevelS: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant): OleVariant;
    function ShowSpecType(var cPar: OleVariant; var VAR_TypeVal_String: OleVariant; 
                          var VAR_TypeVal_DateTime: OleVariant; 
                          var VAR_TypeVal_NumericMoney: OleVariant; 
                          var DOCS_SpecFieldTypeString: OleVariant; 
                          var DOCS_SpecFieldTypeDate: OleVariant; 
                          var DOCS_SpecFieldTypeNumeric: OleVariant): OleVariant;
    function GetStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                    var DOCS_SecurityLevel2: OleVariant; 
                                    var DOCS_SecurityLevel3: OleVariant; 
                                    var DOCS_SecurityLevel4: OleVariant; 
                                    var DOCS_SecurityLevelS: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant): OleVariant;
    function MakeSQLSafe(var strInput: OleVariant): OleVariant;
    function FixLen(var cPar: OleVariant; var iLen: OleVariant; var sSymbol: OleVariant): OleVariant;
    function RightValue(var strInput: OleVariant): OleVariant;
    procedure PutMessage;
    procedure PutMessage1;
    function NoLastBr(cPar: OleVariant): OleVariant;
    function PutDirNRec(cPar: OleVariant): OleVariant;
    procedure RedirHome;
    procedure RedirMessage;
    procedure RedirMessage1(var cPar: OleVariant);
    procedure RedirMessage2;
    procedure RedirStopped;
    procedure RedirShowDoc(var cPar: OleVariant);
    procedure CheckReg;
    function CheckRegF: OleVariant;
    procedure CheckAdmin(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
    procedure CheckIfDocIDIncomingExists(var sDocIDIncoming: OleVariant; var ds: OleVariant);
    procedure SetIndexSearch(var rs: OleVariant; var sCATALOG: OleVariant; 
                             var DOCS_IndexError: OleVariant; var VAR_DocsMaxRecords: OleVariant);
    function CheckAdminF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
    procedure CheckAdminOrUser(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant);
    function CheckAdminOrUserF(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NORight: OleVariant): OleVariant;
    procedure CheckAdminOrUser1(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
    function CheckAdminOrUser1F(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
    procedure CheckAdminRead(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
    function CheckAdminReadF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
    function GetURL(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant): OleVariant;
    function GetUserNFromList(var clist: OleVariant; var cnumber: OleVariant): OleVariant;
    function GetUserID(var cPar: OleVariant): OleVariant;
    function GetUserEMail(var cparUserID: OleVariant): OleVariant;
    function GetURL2(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant): OleVariant;
    function GetURL3(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant): OleVariant;
    function GetURL4(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant): OleVariant;
    function GetURL5(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                     var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                     var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant; 
                     var cpar5: OleVariant; var cvalue5: OleVariant): OleVariant;
    procedure CheckReadAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant);
    function CheckReadAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                              var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant): OleVariant;
    procedure CheckWriteAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant);
    function CheckWriteAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant;
    function IsWriteAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant;
    function IsReadAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                          var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                          var VAR_ExtInt: OleVariant): OleVariant;
    function IsReadAccessDocID(var sDocID: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant): OleVariant;
    function IsReadAccessRS(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant): OleVariant;
    function IsReadAccessUser(var sUserID: OleVariant; var sMessage: OleVariant; 
                              var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; 
                              var VAR_StatusActiveUser: OleVariant): OleVariant;
    procedure NoAccessReport(var cPar: OleVariant);
    procedure AddLog(var sDocID: OleVariant; var sAction: OleVariant; var sDocName: OleVariant);
    function SafeSQL(var cPar: OleVariant): OleVariant;
    procedure AddLogAmountQuantity(var sAmountDocOld: OleVariant; var sAmountDocNew: OleVariant; 
                                   var sQuantityDocOld: OleVariant; 
                                   var sQuantityDocNew: OleVariant; var sDocID: OleVariant; 
                                   var sDocIDParent: OleVariant; var sName: OleVariant; 
                                   var DOCS_ActionChangeDocShort: OleVariant; 
                                   var DOCS_ActionChangeDoc: OleVariant; 
                                   var DOCS_ActionChangeDependantDoc: OleVariant);
    procedure AddLogD(var cPar: OleVariant);
    procedure AddLogPostcard(var cPar: OleVariant);
    procedure AddLogDocAndParent(var sDocID: OleVariant; var sDocIDParent: OleVariant; 
                                 var sName: OleVariant; var sAmount: OleVariant; 
                                 var sQuantity: OleVariant; var sAction: OleVariant; 
                                 var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant);
    function CheckPermit(var sSource: OleVariant; var cPar: OleVariant): OleVariant;
    procedure GetPermit(var sSource: OleVariant; var cPar: OleVariant);
    procedure DeletePermit(var sSource: OleVariant; var cPar: OleVariant);
    function GetMiddleUniqueIdentifier(var UI1: OleVariant; var UI2: OleVariant): OleVariant;
    function CorrectUniqueIdentifier(var UI: OleVariant): OleVariant;
    function MyFormatCurrency(var rVal: OleVariant): OleVariant;
    function MyFormatRate(var rVal: OleVariant): OleVariant;
    function FormatCommon(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function FormatNumberShort(var rVal: OleVariant): OleVariant;
    function MyTableVal(var xVal: OleVariant): OleVariant;
    function IsTime(var dVal: OleVariant): OleVariant;
    function MyDateLong(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                        var DOCS_PERIOD_JAN1: OleVariant; var DOCS_PERIOD_FEB1: OleVariant; 
                        var DOCS_PERIOD_MAR1: OleVariant; var DOCS_PERIOD_APR1: OleVariant; 
                        var DOCS_PERIOD_MAY1: OleVariant; var DOCS_PERIOD_JUN1: OleVariant; 
                        var DOCS_PERIOD_JUL1: OleVariant; var DOCS_PERIOD_AUG1: OleVariant; 
                        var DOCS_PERIOD_SEP1: OleVariant; var DOCS_PERIOD_OCT1: OleVariant; 
                        var DOCS_PERIOD_NOV1: OleVariant; var DOCS_PERIOD_DEC1: OleVariant): OleVariant;
    function MyDate(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function MyDateTime(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function MyDateShort(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function MyChar(var dVal: OleVariant): OleVariant;
    function MyDateBr(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function NoNull(var cPar: OleVariant): OleVariant;
    function NoZeroFormat(var cPar: OleVariant): OleVariant;
    function DocsDate(var cPar: OleVariant): OleVariant;
    function EuroDateTime(var cPar: OleVariant): OleVariant;
    function DateName(var dDate: OleVariant): OleVariant;
    function UniDate(var dDate: OleVariant): OleVariant;
    function LeadZero(var cPar: OleVariant): OleVariant;
    function ConvertToDateOLD(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                              var DOCS_WrongDate: OleVariant): OleVariant;
    function ConvertToDate(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant): OleVariant;
    function IsFormula(var dsDoc: OleVariant): OleVariant;
    function IsAprovalRequired(dsDoc: OleVariant; var sUserID: OleVariant; 
                               var Var_ApprovalPermitted: OleVariant; 
                               var VAR_InActiveTask: OleVariant; var VAR_StatusCancelled: OleVariant): OleVariant;
    procedure GetCalendarDocs(nDocs: OleVariant; var sDocs: OleVariant; nYear: OleVariant; 
                              nMonth: OleVariant; sUserID: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_PERIOD_Date: OleVariant; var DOCS_DocID: OleVariant; 
                              var DOCS_DocIDAdd: OleVariant; var DOCS_DocIDParent: OleVariant; 
                              var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                              var DOCS_PartnerName: OleVariant; 
                              var DOCS_NameResponsible: OleVariant; 
                              var DOCS_NameControl: OleVariant; var DOCS_NameAproval: OleVariant; 
                              var DOCS_ListToView: OleVariant; var DOCS_ListToEdit: OleVariant; 
                              var DOCS_ListToReconcile: OleVariant; var DOCS_Author: OleVariant; 
                              var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                              var DOCS_History: OleVariant; var DOCS_NameCreation: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                              var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant; 
                              var DOCS_ListReconciled: OleVariant; 
                              var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                              var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                              var DOCS_DocIDIncoming: OleVariant; 
                              var DOCS_DateCompletion: OleVariant; 
                              var DOCS_DateActivation: OleVariant; var StyleCalendar: OleVariant; 
                              var VAR_StatusCancelled: OleVariant; 
                              var VAR_StatusCompletion: OleVariant; var DOCS_EXPIRED2: OleVariant; 
                              var DOCS_Completed: OleVariant; var DOCS_Cancelled2: OleVariant; 
                              var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                              var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                              var DOCS_ClassDoc: OleVariant; var Var_ApprovalPermitted: OleVariant; 
                              var DOCS_APROVALREQUIRED: OleVariant; 
                              var DOCS_StatusPaymentPaid: OleVariant);
    procedure GetCalendarEvents(var sDocs: OleVariant; nYear: OleVariant; nMonth: OleVariant; 
                                sUserID: OleVariant; var BGColorLight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_DateTime: OleVariant; 
                                var DOCS_DateTimeEnd: OleVariant; var StyleCalendar: OleVariant; 
                                sWidth: OleVariant);
    function PutEvent(iCase: OleVariant; cInfo: OleVariant; sLink: OleVariant; 
                      BGColorLight: OleVariant; StyleCalendar: OleVariant; sWidth: OleVariant): OleVariant;
    function PutInfoPicture(var cInfo: OleVariant; var cPic: OleVariant): OleVariant;
    function GetName(var cPar: OleVariant): OleVariant;
    function GetFullName(var cParName: OleVariant; var cParID: OleVariant): OleVariant;
    function GetPosition(var cPar: OleVariant): OleVariant;
    procedure GetUserDetails(var cPar: OleVariant; var sName: OleVariant; var sPhone: OleVariant; 
                             var sEMail: OleVariant; var sICQ: OleVariant; 
                             var sDepartment: OleVariant; var sPartnerName: OleVariant; 
                             var sPosition: OleVariant; var sIDentification: OleVariant; 
                             var sIDNo: OleVariant; var sIDIssuedBy: OleVariant; 
                             var dIDIssueDate: OleVariant; var dIDExpDate: OleVariant; 
                             var dBirthDate: OleVariant; var sCorporateIDNo: OleVariant; 
                             var sAddInfo: OleVariant; var sComment: OleVariant);
    function GetPositionsNames(var cPar: OleVariant; var cDel1: OleVariant; var cDel2: OleVariant): OleVariant;
    function GetSuffix(var cPar: OleVariant): OleVariant;
    function RightName(cPar: OleVariant): OleVariant;
    function ToEng(var cPar: OleVariant): OleVariant;
    function ToEngSMS(var cPar: OleVariant): OleVariant;
    function ToTheseSymbolsOnly(var sSymbols: OleVariant; var cPar: OleVariant): OleVariant;
    function PutInString(var cPar: OleVariant; var nPar: OleVariant): OleVariant;
    function GetNameAsLink(var cPar: OleVariant): OleVariant;
    function GetNameAsLinkGN(var cPar: OleVariant): OleVariant;
    function GetLogin(var cPar: OleVariant): OleVariant;
    function NamesIn2ndForm(var cPar: OleVariant): OleVariant;
    function NamesIn3rdForm(var cPar: OleVariant): OleVariant;
    function NamesIn3ndForm(var cPar: OleVariant): OleVariant;
    procedure CreateAutoCommentGUID(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant; var sGUID: OleVariant);
    procedure CreateAutoComment(var sDocID: OleVariant; var sComment: OleVariant);
    procedure CreateAutoCommentType(var sDocID: OleVariant; var sComment: OleVariant; 
                                    var sCommentType: OleVariant);
    procedure ConfirmNotification;
    function GetCompatibleSpec(var sSpecIDs: OleVariant; var sItemNameP: OleVariant): OleVariant;
    function ShowSpecName(var cPar: OleVariant): OleVariant;
    function GetBusinessProcessSteps(var cPar: OleVariant): OleVariant;
    function GenNewDocID(var cParDocIDOld: OleVariant): OleVariant;
    function GenNewDocIDIncrement(var iD: OleVariant; var Var_MaxLong: OleVariant): OleVariant;
    function NoVbCrLf(var cPar: OleVariant): OleVariant;
    function GetDocDetails(var cPar: OleVariant; var bIsShowLinks: OleVariant; var cRS: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DocIDAdd: OleVariant; 
                           var DOCS_DocIDParent: OleVariant; var DOCS_AmountDoc: OleVariant; 
                           var DOCS_QuantityDoc: OleVariant; var DOCS_PartnerName: OleVariant; 
                           var DOCS_NameResponsible: OleVariant; var DOCS_NameControl: OleVariant; 
                           var DOCS_NameAproval: OleVariant; var DOCS_ListToView: OleVariant; 
                           var DOCS_ListToEdit: OleVariant; var DOCS_ListToReconcile: OleVariant; 
                           var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                           var DOCS_NameCreation: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                           var DOCS_Internal: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_ListReconciled: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                           var DOCS_DocIDIncoming: OleVariant; var DOCS_DateCompletion: OleVariant; 
                           var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                           var DOCS_ClassDoc: OleVariant): OleVariant;
    function GetDocAmount(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                          var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant;
    function GetDocDateActivation(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    function GetDocName(var cPar: OleVariant): OleVariant;
    function GetUserDepartment(var cPar: OleVariant): OleVariant;
    function IsNamesCompatible(sName1: OleVariant; sName2: OleVariant): OleVariant;
    function IsWorkingDay(var nDay: OleVariant; var nStaffTableMonth: OleVariant; 
                          var nStaffTableYear: OleVariant; var CMonths: OleVariant; 
                          var CDays: OleVariant): OleVariant;
    function ShowWeekday(var sItemName: OleVariant; var nStaffTableMonth: OleVariant; 
                         var nStaffTableYear: OleVariant; var IsHTML: OleVariant; 
                         var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                         var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                         var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                         var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                         var CMonths: OleVariant; var CDays: OleVariant): OleVariant;
    procedure Out(var cPar: OleVariant);
    procedure Out1(var cPar: OleVariant);
    procedure SendNotification(var cParRS: OleVariant; var cParDocID: OleVariant; 
                               var cRecipient: OleVariant; var cSubject: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                               var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                               var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure SendNotification1(var cParRS: OleVariant; var cParDocID: OleVariant; 
                                var cRecipient: OleVariant; var cSubject: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant);
    procedure SendNotification2(var sMessageBody: OleVariant; var cParRS: OleVariant; 
                                var cParDocID: OleVariant; var cRecipient: OleVariant; 
                                var cSubject: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant);
    function SurnameGN(var cPar: OleVariant): OleVariant;
    function IsOutNotif(var bPrint: OleVariant): OleVariant;
    procedure QueueDirectoryFiles(var sQueueDirectory: OleVariant; var Files: OleVariant);
    procedure EMailPatch1(var objMail: OleVariant);
    procedure SendNotificationCore(var sMessageBody: OleVariant; var dsTemp: OleVariant; 
                                   var sS_Description: OleVariant; var S_UserList: OleVariant; 
                                   var S_MessageSubject: OleVariant; var S_MessageBody: OleVariant; 
                                   var S_DocID: OleVariant; var S_SecurityLevel: OleVariant; 
                                   var sSend: OleVariant; var USER_Department: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var bPrint: OleVariant; 
                                   var MailTexts: OleVariant);
    function GetAuthenticode(var sDocID: OleVariant; var sDateCreation: OleVariant; 
                             var sUserID: OleVariant; var sAction: OleVariant): OleVariant;
    function CheckAuthenticode(const sAuthenticode: WideString): OleVariant;
    function ClickEMailOld(var cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
    function ClickEMail(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                        var cSendAction: OleVariant; var sWarning: OleVariant; 
                        var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
    function ClickEMailNot(var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
    function ClickEMailComment(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                               var cSendAction: OleVariant; var sWarning: OleVariant; 
                               var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
    function ClickEMailFile(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                            var cSendAction: OleVariant; var sWarning: OleVariant; 
                            var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
    function ClickEMailNoPic(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
    function ClickEMailBig1(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
    function ClickEMailBig(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                           var cSendAction: OleVariant; var sWarning: OleVariant; 
                           var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
    function Status(var cName: OleVariant; var cTitle: OleVariant): OleVariant;
    function Sep(var cName: OleVariant; var cTitle: OleVariant): OleVariant;
    procedure AddLogA(var sLog: OleVariant);
    function DOUT(var sLog: OleVariant): OleVariant;
    function ExtractMessage(const iBp: IBodyPart): IMessage;
    procedure ProcessEMail(var sFile: OleVariant; var sDocID: OleVariant; 
                           var strSubject: OleVariant; var strFrom: OleVariant; 
                           var bErr: OleVariant; var sMessage: OleVariant; var Texts: OleVariant; 
                           var MailTexts: OleVariant);
    procedure ProcessEMailClient(var Texts: OleVariant; var MailTexts: OleVariant);
    procedure ProcessEMailClientCommand(var bDeleteFile: OleVariant; var sFile: OleVariant; 
                                        var iMsg: OleVariant; var sContent1: OleVariant; 
                                        var sAuthenticode: OleVariant; var sMessage: OleVariant; 
                                        var sUserEMail: OleVariant; var Texts: OleVariant; 
                                        var MailTexts: OleVariant; 
                                        var Var_nDaysToReconcile: OleVariant);
    function ClickEMailDocID(var sDocID: OleVariant; var cSendAction: OleVariant; 
                             var sWarning: OleVariant; var cCommand: OleVariant; 
                             var cAuthenticode: OleVariant; var StyleDetailValues: OleVariant): OleVariant;
    function NoEmpty(var cPar: OleVariant): OleVariant;
    function NotSkipThisRecord(var sAction: OleVariant; var dsDoc: OleVariant; 
                               var VAR_StatusCompletion: OleVariant; 
                               var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                               var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                               var VAR_InActiveTask: OleVariant): OleVariant;
    function GetEMailPar(var sContent: OleVariant; sCommand: OleVariant): OleVariant;
    function GetEMailParDelimiter(var sContent: OleVariant; sPar: OleVariant; sDelimiter: OleVariant): OleVariant;
    function GetEMailParComment(var sCont: OleVariant): OleVariant;
    function Koi2Win(var StrKOI: OleVariant): OleVariant;
    function ShowDocRow(var cTitle: OleVariant; var cValue: OleVariant): OleVariant;
    function IsValidEMail(var cPar: OleVariant): OleVariant;
    procedure SendPostcard(var sFile: OleVariant; var sFileMuz: OleVariant; 
                           var DOCS_PostcardSent: OleVariant; var DOCS_EMailOff: OleVariant; 
                           var DOCS_TITLEFooter: OleVariant; var DOCS_Postcard: OleVariant; 
                           var DOCS_NOEMailSender: OleVariant; var DOCS_BADEMailSender: OleVariant);
    procedure RunGetDocSend(var cTo: OleVariant; var cFrom: OleVariant; var cBody: OleVariant; 
                            var cSubject: OleVariant; var cBodyFormat: OleVariant; 
                            var cFile: OleVariant; var DOCS_TITLEFooter: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant);
    function GetFileName(var cPar: OleVariant): OleVariant;
    function HTMLEncode(var cPar: OleVariant): OleVariant;
    function HTMLEncodeNBSP(var cPar: OleVariant): OleVariant;
    function CRtoBR(var cPar: OleVariant): OleVariant;
    function CRtoBRHTMLEncode(var cPar: OleVariant): OleVariant;
    function CRtoSeparatorHTMLEncode(var cPar: OleVariant; var cSeparator: OleVariant): OleVariant;
    function SeparatorToBR(var cPar: OleVariant; var cSep: OleVariant): OleVariant;
    function SeparatorToSymbols(var cPar: OleVariant; var cSep: OleVariant; var cSymbols: OleVariant): OleVariant;
    function BoldContext(var cPar: OleVariant; var cCon: OleVariant): OleVariant;
    function ShowBoldCurrentUserName(var cPar: OleVariant): OleVariant;
    function CR: OleVariant;
    procedure ShowContextMarks(var cPar: OleVariant; var cOnlyMarks: OleVariant);
    function MyNumericStr(var cPar: OleVariant): OleVariant;
    function IsVisaNow(var sUserID: OleVariant; var sListToReconcile: OleVariant; 
                       var sListReconciled: OleVariant; var sNameApproved: OleVariant): OleVariant;
    function IsVisaLast(var sUserID: OleVariant; var sListReconciled: OleVariant): OleVariant;
    function MyTrim(var cPar: OleVariant): OleVariant;
    function MyDayName(var cPar: OleVariant; var DOCS_PERIOD_SAN: OleVariant; 
                       var DOCS_PERIOD_MON: OleVariant; var DOCS_PERIOD_TUS: OleVariant; 
                       var DOCS_PERIOD_WED: OleVariant; var DOCS_PERIOD_THU: OleVariant; 
                       var DOCS_PERIOD_FRI: OleVariant; var DOCS_PERIOD_SAT: OleVariant): OleVariant;
    function QuarterName(var dPar: OleVariant; var DOCS_PERIOD_Quarter: OleVariant): OleVariant;
    procedure SCORE_GetDate(var dDATEFROM: OleVariant; var dDATETO: OleVariant; 
                            var S_FirstPeriod: OleVariant; var S_PeriodType: OleVariant; 
                            var iPeriod: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant);
    function MyMonthName(var cPar: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                         var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                         var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                         var DOCS_PERIOD_JUN: OleVariant; var DOCS_PERIOD_JUL: OleVariant; 
                         var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                         var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                         var DOCS_PERIOD_DEC: OleVariant): OleVariant;
    function MonthNameEng(var cPar: OleVariant): OleVariant;
    function IsReconciliationComplete(var S_ListToReconcile: OleVariant; 
                                      var S_ListReconciled: OleVariant): OleVariant;
    function MarkReconciledNames(var cPar: OleVariant; var cParReconciled: OleVariant; 
                                 var DOCS_NextStepToReconcile: OleVariant; 
                                 var DOCS_Reconciled: OleVariant; var DOCS_Refused: OleVariant): OleVariant;
    function PutInfo(var cPar: OleVariant): OleVariant;
    function ShowCustomerName: OleVariant;
    function InsertCommentTypeImageAsLink(var sDocID: OleVariant; var sKeyField: OleVariant; 
                                          var sSubject: OleVariant; var sComment: OleVariant; 
                                          var cParCommentType: OleVariant; 
                                          var cParSpecialInfo: OleVariant; 
                                          var cParAddress: OleVariant; 
                                          var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                          var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                          var DOCS_Comment: OleVariant; 
                                          var DOCS_RespComment: OleVariant; 
                                          var DOCS_LocationPaper: OleVariant; 
                                          var DOCS_VersionFile: OleVariant; 
                                          var DOCS_SystemMessage: OleVariant; 
                                          var DOCS_Viewed: OleVariant; var DOCS_News: OleVariant; 
                                          var DOCS_CreateRespComment: OleVariant): OleVariant;
    function InsertCommentTypeImage(var cParCommentType: OleVariant; 
                                    var cParSpecialInfo: OleVariant; var cParAddress: OleVariant; 
                                    var DOCS_Contact: OleVariant; var USER_EMail: OleVariant; 
                                    var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                    var DOCS_Comment: OleVariant; var DOCS_RespComment: OleVariant; 
                                    var DOCS_LocationPaper: OleVariant; 
                                    var DOCS_VersionFile: OleVariant; 
                                    var DOCS_SystemMessage: OleVariant; 
                                    var DOCS_Viewed: OleVariant; var DOCS_PushToGet: OleVariant; 
                                    var DOCS_MSWordExcelOnServer: OleVariant): OleVariant;
    function GetNewUserIDsInList(var sNotificationListForListToReconcileBefore: OleVariant; 
                                 var sNotificationListForListToReconcileAfter: OleVariant; 
                                 var IsRefused: OleVariant): OleVariant;
    function GetNextUserIDInList(var sList: OleVariant; var iPos: OleVariant): OleVariant;
    function GetNotificationListForListToReconcile1(var S_ListToReconcile: OleVariant; 
                                                    var S_ListReconciled: OleVariant; 
                                                    var S_NameApproved: OleVariant; 
                                                    var S_NameAproval: OleVariant; 
                                                    var bRefused: OleVariant): OleVariant;
    function GetNotificationListForListToReconcile(var S_ListToReconcile: OleVariant; 
                                                   var S_ListReconciled: OleVariant; 
                                                   var S_NameApproved: OleVariant; 
                                                   var bRefused: OleVariant): OleVariant;
    function GetNotificationListForDocActivation(var dsDoc: OleVariant): OleVariant;
    procedure MakeDocActiveOrInactiveInList(var bActiveTask: OleVariant; var dsDoc1: OleVariant; 
                                            var bPutMes: OleVariant; 
                                            var VAR_ActiveTask: OleVariant; 
                                            var VAR_InActiveTask: OleVariant; 
                                            var VAR_BeginOfTimes: OleVariant; 
                                            var DOCS_NOTFOUND: OleVariant; 
                                            var DOCS_DocID: OleVariant; 
                                            var DOCS_DateActivation: OleVariant; 
                                            var DOCS_DateCompletion: OleVariant; 
                                            var DOCS_Name: OleVariant; 
                                            var DOCS_PartnerName: OleVariant; 
                                            var DOCS_ACT: OleVariant; 
                                            var DOCS_Description: OleVariant; 
                                            var DOCS_Author: OleVariant; 
                                            var DOCS_Correspondent: OleVariant; 
                                            var DOCS_Resolution: OleVariant; 
                                            var DOCS_NotificationSentTo: OleVariant; 
                                            var DOCS_SendNotification: OleVariant; 
                                            var DOCS_UsersNotFound: OleVariant; 
                                            var DOCS_NotificationDoc: OleVariant; 
                                            var USER_NOEMail: OleVariant; 
                                            var DOCS_NoAccess: OleVariant; 
                                            var DOCS_EXPIREDSEC: OleVariant; 
                                            var DOCS_STATUSHOLD: OleVariant; 
                                            var VAR_StatusActiveUser: OleVariant; 
                                            var DOCS_ErrorSMTP: OleVariant; 
                                            var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                            var DOCS_NoReadAccess: OleVariant; 
                                            var USER_Department: OleVariant; 
                                            var VAR_ExtInt: OleVariant; 
                                            var VAR_AdminSecLevel: OleVariant; 
                                            var DOCS_FROM1: OleVariant; 
                                            var DOCS_Reconciliation: OleVariant; 
                                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                            var MailTexts: OleVariant; 
                                            var Var_nDaysToReconcile: OleVariant);
    function GetUserNotificationList(var sNotificationList: OleVariant; var dsDoc: OleVariant): OleVariant;
    procedure MakeDocActiveOrInactive(var sNotificationList: OleVariant; var DOCS_All: OleVariant; 
                                      var DOCS_NoWriteAccess: OleVariant; 
                                      var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; 
                                      var VAR_InActiveTask: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_UnderDevelopment: OleVariant; 
                                      var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                      var VAR_StatusCompletion: OleVariant; 
                                      var VAR_StatusCancelled: OleVariant; 
                                      var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                      var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                      var DOCS_Approving: OleVariant; 
                                      var DOCS_Approved: OleVariant; 
                                      var DOCS_RefusedApp: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant; 
                                      var Var_nDaysToReconcile: OleVariant);
    procedure CreateReconciliationComment(var dsDoc: OleVariant; var nDaysToReconcile: OleVariant; 
                                          var DOCS_Reconciliation: OleVariant);
    procedure DeleteReconciliationComments(var sDocID: OleVariant);
    procedure DeleteReconciliationCommentsCanceled(var dsDoc: OleVariant);
    procedure UpdateReconciliationComments(var sDocID: OleVariant; var sMessage: OleVariant; 
                                           var sStatus: OleVariant; 
                                           var VAR_BeginOfTimes: OleVariant; 
                                           var DOCS_DateDiff1: OleVariant);
    procedure ModifyPaymentStatus(var sNotificationList: OleVariant; 
                                  var DOCS_StatusPaymentNotPaid: OleVariant; 
                                  var DOCS_StatusPaymentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentToPay: OleVariant; 
                                  var DOCS_StatusPaymentPaid: OleVariant; 
                                  var DOCS_StatusExistsButNotDefined: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var VAR_ActiveTask: OleVariant; var VAR_InActiveTask: OleVariant; 
                                  var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                  var VAR_StatusCompletion: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                  var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                                  var DOCS_RefusedApp: OleVariant; 
                                  var VAR_StatusActiveUser: OleVariant; var DOCS_DocID: OleVariant; 
                                  var DOCS_DateActivation: OleVariant; 
                                  var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                  var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                  var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                  var DOCS_Correspondent: OleVariant; 
                                  var DOCS_Resolution: OleVariant; 
                                  var DOCS_NotificationSentTo: OleVariant; 
                                  var DOCS_SendNotification: OleVariant; 
                                  var DOCS_UsersNotFound: OleVariant; 
                                  var DOCS_NotificationDoc: OleVariant; 
                                  var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                  var DOCS_STATUSHOLD: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                  var DOCS_Sender: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_StatusAlreadyChanged: OleVariant; 
                                  var DOCS_StatusCancel: OleVariant; var DOCS_FROM1: OleVariant; 
                                  var DOCS_Reconciliation: OleVariant; 
                                  var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                  var DOCS_StatusPaymentCancel: OleVariant; 
                                  var MailTexts: OleVariant);
    procedure CreateAutoCommentPayment(var sDocID: OleVariant; var sComment: OleVariant; 
                                       var sStatus: OleVariant; var sAmountPart: OleVariant; 
                                       var sAmountPart2: OleVariant; var rAmountPart: OleVariant; 
                                       var sAccount: OleVariant; var sAccount2: OleVariant; 
                                       var bIncoming: OleVariant);
    procedure ModifyAccountBalance(sAccount: OleVariant; rAmount: OleVariant; var bErr: OleVariant);
    procedure MakeCanceled(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                           var VAR_StatusCancelled: OleVariant; var DOCS_Cancelled: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                           var bUpdated: OleVariant);
    procedure MakeCompleted(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var VAR_StatusCompletion: OleVariant; 
                            var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var USER_NOEMail: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                            var bUpdated: OleVariant);
    procedure MakeRefuseCompletion(var sNotificationList: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_WrongDate: OleVariant; 
                                   var VAR_StatusCompletion: OleVariant; 
                                   var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant; var But_RefuseCompletion: OleVariant);
    procedure MakeSigned(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                         var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var VAR_StatusCompletion: OleVariant; var DOCS_Signed: OleVariant; 
                         var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                         var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                         var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_SendNotification: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                         var DOCS_DateActivation: OleVariant; var DOCS_DateSigned: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                         var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                         var DOCS_Author: OleVariant; var DOCS_FROM1: OleVariant; 
                         var DOCS_Reconciliation: OleVariant; 
                         var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant);
    procedure AutoFill(var DOCS_NORight: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                       var Var_StandardWorkHours: OleVariant; var DOCS_All: OleVariant; 
                       var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                       var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                       var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                       var CMonths: OleVariant; var CDays: OleVariant);
    procedure ModifyPercent(var DOCS_PercentCompletion: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_WrongAmount: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_PercentValueWarning: OleVariant);
    function IsResponsibleOnly(var S_NameAproval: OleVariant; var S_NameCreation: OleVariant; 
                               var S_ListToEdit: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var S_NameResponsible: OleVariant): OleVariant;
    procedure CreateAutoCommentListToEdit(var dsDocListToEdit: OleVariant; 
                                          var RequestListToEdit: OleVariant; 
                                          var sDocID: OleVariant; var DOCS_Changed: OleVariant; 
                                          var DOCS_ListToEdit: OleVariant; 
                                          var DOCS_Added: OleVariant; var DOCS_Deleted: OleVariant);
    function IsDocIDExist(var sDocID: OleVariant): OleVariant;
    procedure ChangeDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_StatusCompletion: OleVariant; 
                             var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant);
    procedure ChangeOneDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; 
                                var VAR_StatusCompletion: OleVariant; 
                                var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant);
    procedure AddListCorrespondentRet(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                      var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_InfoAlreadyExists: OleVariant; 
                                      var DOCS_InformationNotUpdated: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var MailTexts: OleVariant);
    procedure MakeArchival(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_Archival: OleVariant; 
                           var DOCS_Operative: OleVariant; var VAR_StatusArchiv: OleVariant; 
                           var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                           var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                           var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant);
    procedure MakeDelivery(var DOCS_StatusDelivery: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_NORight: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_Records: OleVariant; var DOCS_Sent: OleVariant; 
                           var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                           var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                           var DOCS_WaitingToBeSent: OleVariant; var DOCS_ReturnedToFile: OleVariant);
    procedure ChangeHardCopyLocation(var bIsRedirect: OleVariant; 
                                     var sNewHardCopyLocation: OleVariant; var sDocID: OleVariant; 
                                     var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                     var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                     var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                     var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant);
    procedure ChangePaperFileName(var bIsRedirect: OleVariant; var sPaperFileName: OleVariant; 
                                  var sDocID: OleVariant; var DOCS_PaperFile: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant);
    function GetCurrentUserFullName: OleVariant;
    procedure MakeRegisteredRet(var DOCS_DeliveryMethod: OleVariant; 
                                var DOCS_PaperFile: OleVariant; var DOCS_TypeDoc: OleVariant; 
                                var DOCS_RegLog: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_DocIDIncoming: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Description: OleVariant; 
                                var DOCS_NameResponsible: OleVariant; 
                                var DOCS_Resolution: OleVariant; var DOCS_Registered: OleVariant; 
                                var DOCS_InformationUpdated: OleVariant; 
                                var DOCS_InformationNotUpdated: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                                var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                                var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                                var DOCS_ReturnedFromFile: OleVariant; 
                                var DOCS_Comment: OleVariant; var DOCS_PostType: OleVariant; 
                                var DOCS_PostID: OleVariant; var DOCS_Recipient: OleVariant; 
                                var DOCS_PostAddress: OleVariant; var DOCS_DateSent: OleVariant; 
                                var DOCS_StatusDelivery: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                var DOCS_DateArrive: OleVariant; var DOCS_NameAproval: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateTime: OleVariant; var AddFieldName1: OleVariant; 
                                var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                                var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                                var AddFieldName6: OleVariant);
    procedure CopyDoc(var DOCS_Copied: OleVariant);
    procedure ClearDocBuffer(var DOCS_BufferCleared: OleVariant);
    procedure ItemMove;
    function ShortID(var cPar: OleVariant): OleVariant;
    function SBigger(var cPar1: OleVariant; var cPar2: OleVariant): OleVariant;
    procedure Shift(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                    var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                    var VAR_ExtInt: OleVariant; var DOCS_NORight: OleVariant; 
                    var DOCS_NOTFOUND: OleVariant; var DOCS_LOGIN: OleVariant; 
                    var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                    var Var_StandardWorkHours: OleVariant; var CMonths: OleVariant; 
                    var CDays: OleVariant);
    procedure DeleteDoc(var DOCS_NOTFOUND: OleVariant; var DOCS_All: OleVariant; 
                        var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                        var VAR_ExtInt: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                        var DOCS_NORight: OleVariant; var DOCS_HASDEPENDANT: OleVariant; 
                        var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                        var DOCS_ActionDeleteDependantDoc: OleVariant; 
                        var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                        var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant);
    procedure GetSelectRecordset(var S_ClassDoc: OleVariant; var sDataSourceName: OleVariant; 
                                 var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                 var sFieldNames: OleVariant);
    procedure GetRecordsetDetailsClassDoc(S_ClassDoc: OleVariant; var nDataSources: OleVariant; 
                                          var sDataSourceName: OleVariant; 
                                          var sDataSource: OleVariant; 
                                          var sSelectRecordset: OleVariant; 
                                          var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                          var sStatementInsert: OleVariant; 
                                          var sStatementUpdate: OleVariant; 
                                          var sStatementDelete: OleVariant; var sGUID: OleVariant);
    procedure GetRecordsetDetails(var S_GUID: OleVariant; var sDataSourceName: OleVariant; 
                                  var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                  var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                  var sStatementInsert: OleVariant; 
                                  var sStatementUpdate: OleVariant; 
                                  var sStatementDelete: OleVariant; var sComments: OleVariant; 
                                  var sGUID: OleVariant);
    procedure DeleteExtData(var nRec: OleVariant; var sStatementDelete: OleVariant; 
                            var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                            var sSelectRecordset: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; var DOCS_DeletedExt: OleVariant; 
                            var DOCS_DeletedExt1: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var DOCS_NORight: OleVariant; 
                            var DOCS_HASDEPENDANT: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_ActionDeleteDependantDoc: OleVariant; 
                            var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant);
    procedure GetExtRecordsetOld(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                 var sMessage: OleVariant; var sDataSource: OleVariant; 
                                 sSelectRecordset: OleVariant; 
                                 var DOCS_ErrorDataSource: OleVariant; 
                                 var DOCS_ErrorSelectRecordset: OleVariant; 
                                 var DOCS_ErrorInsertPars: OleVariant; 
                                 var DOCS_ErrorSelectNotDefined: OleVariant);
    procedure GetExtRecordsetArch(var ds: OleVariant; var dsDoc: OleVariant; var bErr: OleVariant; 
                                  var sMessage: OleVariant; var sDataSource: OleVariant; 
                                  var sSelectRecordset: OleVariant; 
                                  var DOCS_ErrorDataSource: OleVariant; 
                                  var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                                  var DOCS_ErrorInsertPars: OleVariant; 
                                  var DOCS_ErrorSelectNotDefined: OleVariant);
    procedure GetExtRecordset(bArch: OleVariant; var ds: OleVariant; var bErr: OleVariant; 
                              var sMessage: OleVariant; sDataSource: OleVariant; 
                              sSelectRecordset: OleVariant; sGUID: OleVariant; 
                              var DOCS_ErrorDataSource: OleVariant; 
                              var DOCS_ErrorSelectRecordset: OleVariant; 
                              var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                              var DOCS_ErrorInsertPars: OleVariant; 
                              var DOCS_ErrorSelectNotDefined: OleVariant);
    procedure ChangeExtData(var nRec: OleVariant; var sDataSourceName: OleVariant; 
                            var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                            var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                            var sStatement: OleVariant; var bCheckOK: OleVariant; 
                            var bErr: OleVariant; var ds: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                            var DOCS_ErrorDataEdit: OleVariant; var DOCS_Error: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Changed1: OleVariant; 
                            var DOCS_Created: OleVariant; var DOCS_Created1: OleVariant; 
                            var DOCS_ErrorDataSource: OleVariant; 
                            var DOCS_ErrorInsertPars: OleVariant; 
                            var DOCS_ErrorSelectRecordset: OleVariant; 
                            var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                            var DOCS_Field: OleVariant; var DOCS_WrongField: OleVariant; 
                            var DOCS_NoUpdate: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_Records: OleVariant);
    function InsertPars(sSelect: OleVariant; var dsDoc: OleVariant; var sErr: OleVariant): OleVariant;
    function InsertParsEval(sSelect: OleVariant; dsDoc: OleVariant; var bErr: OleVariant): OleVariant;
    function GetNextFieldName(var sSelect: OleVariant): OleVariant;
    function NotViewedList(var sUserList: OleVariant): OleVariant;
    function NotAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant;
    function NotYetAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant;
    function GetFullUserFromList(var sList: OleVariant; var sUserID: OleVariant): OleVariant;
    function GetUserIDFromList(var sList: OleVariant; var i1: OleVariant): OleVariant;
    procedure Visa(var bRedirect: OleVariant; var sNotificationList: OleVariant; 
                   var sDocID: OleVariant; var sRefuse: OleVariant; var sapp: OleVariant; 
                   var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                   var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                   var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                   var DOCS_Refused: OleVariant; var DOCS_RefusedApp: OleVariant; 
                   var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                   var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                   var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                   var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                   var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                   var DOCS_NotificationSentTo: OleVariant; var DOCS_SendNotification: OleVariant; 
                   var DOCS_UsersNotFound: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                   var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                   var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                   var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                   var DOCS_Sender: OleVariant; var DOCS_APROVAL: OleVariant; 
                   var DOCS_Visa: OleVariant; var DOCS_View: OleVariant; 
                   var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                   var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant; 
                   var Var_nDaysToReconcile: OleVariant; var DOCS_DateDiff1: OleVariant);
    procedure VisaCancel(var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                         var DOCS_Cancelled: OleVariant; var DOCS_Refused: OleVariant; 
                         var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                         var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                         var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_NotificationSentTo: OleVariant; 
                         var DOCS_SendNotification: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                         var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                         var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                         var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                         var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                         var DOCS_APROVAL: OleVariant; var DOCS_Visa: OleVariant; 
                         var DOCS_View: OleVariant);
    procedure ReconciliationCancel(var Var_nDaysToReconcile: OleVariant; 
                                   var DOCS_AGREECancelled: OleVariant; var DOCS_Visa: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                   var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant);
    procedure ShowDoc(var dsDoc: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant);
    function FSpec(var SxSy: OleVariant): OleVariant;
    procedure CopySpec(var Name1: OleVariant; var Name2: OleVariant; var Conn: OleVariant; 
                       var DOC_ComplexUnits: OleVariant; var DOCS_Copied: OleVariant);
    procedure CopySpecComponents(var Name1: OleVariant; var Name2: OleVariant; 
                                 var Conn: OleVariant; var DOCS_Copied: OleVariant; 
                                 var DOC_ComplexUnits: OleVariant);
    procedure CreateNotice(var DOCS_Notices: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                           var DOCS_SecurityLevel2: OleVariant; 
                           var DOCS_SecurityLevel3: OleVariant; 
                           var DOCS_SecurityLevel4: OleVariant; 
                           var DOCS_SecurityLevelS: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_WrongAmount: OleVariant; var DOCS_WrongQuantity: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                           var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                           var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                           var DOCS_RefusedApp: OleVariant; var DOCS_Created: OleVariant);
    procedure DeleteAct(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant);
    procedure DeleteFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant);
    procedure DeleteUserPhoto(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_ActionDeleteFile: OleVariant);
    procedure DeletePartnerFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant);
    procedure DeleteDepartmentFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                   var DOCS_ActionDeleteFile: OleVariant);
    procedure DeleteTypeDocFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant);
    procedure DeletePrintFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant);
    procedure DeleteMailListFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant);
    function IsClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant;
    function DocIDParentFromClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant;
    function NoPars(var cPar: OleVariant): OleVariant;
    procedure FormingSQL(var dsDoc: OleVariant; var sClassDocParent: OleVariant; 
                         var sPartnerNameParent: OleVariant; 
                         var sNameResponsibleParent: OleVariant; var Specs: OleVariant; 
                         var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                         var bSpec: OleVariant; var bDateActivation: OleVariant; 
                         var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                         var sDetailes: OleVariant; var S_OrderBy1: OleVariant; 
                         var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                         var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                         var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                         var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant; 
                         var sDateOrder: OleVariant; var sDateOrder2: OleVariant; 
                         var sDateOrder3: OleVariant; var VAR_StatusArchiv: OleVariant; 
                         var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                         var DOCS_ListToReconcile: OleVariant; 
                         var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                         var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                         var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                         var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                         var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                         var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                         var DOCS_PartnerName: OleVariant; var Consts: OleVariant; 
                         var Periods: OleVariant; var Statuses: OleVariant; 
                         var VAR_StatusExpired: OleVariant; var DOCS_IsExactly: OleVariant; 
                         var DOCS_BeginsWith: OleVariant; var DOCS_Sent: OleVariant; 
                         var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                         var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                         var DOCS_WaitingToBeSent: OleVariant; var DOCS_ClassDocParent: OleVariant);
    procedure GetSQLDate(var sSQLDate: OleVariant; var sDetailesDate: OleVariant; 
                         var sYear: OleVariant; var sDate: OleVariant; var sField: OleVariant; 
                         var sFieldName: OleVariant; var Periods: OleVariant);
    procedure RequestCompleted(var dsDoc: OleVariant; var sDocIDpar: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_StatusRequestCompletion: OleVariant; 
                               var DOCS_RequestedCompleted: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var VAR_ExtInt: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                               var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant);
    function IsDateInMonitorRange(var dPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    procedure CheckLicense(var sCompany: OleVariant; var bOK: OleVariant; 
                           var DOCS_DEMO_MODE: OleVariant; var DOCS_CopyrightWarning: OleVariant; 
                           var DOCS_Error: OleVariant);
    procedure ListRegLogDocs(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                             var DOCS_PERIOD_THISM: OleVariant; var DOCS_PERIOD_PREVM: OleVariant; 
                             var DOCS_PERIOD_1QUARTER: OleVariant; 
                             var DOCS_PERIOD_2QUARTER: OleVariant; 
                             var DOCS_PERIOD_3QUARTER: OleVariant; 
                             var DOCS_PERIOD_4QUARTER: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                             var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                             var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                             var DOCS_PERIOD_JUN: OleVariant; var OCS_PERIOD_JUL: OleVariant; 
                             var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                             var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                             var DOCS_PERIOD_DEC: OleVariant; var DOCS_PERIOD_THISY: OleVariant; 
                             var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                             var DOCS_PERIOD_YEAR: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                             var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                             var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                             var VAR_DocsMaxRecords: OleVariant);
    procedure ListPaperFileRegistry(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                                    var DOCS_PERIOD_THISM: OleVariant; 
                                    var DOCS_PERIOD_PREVM: OleVariant; 
                                    var DOCS_PERIOD_1QUARTER: OleVariant; 
                                    var DOCS_PERIOD_2QUARTER: OleVariant; 
                                    var DOCS_PERIOD_3QUARTER: OleVariant; 
                                    var DOCS_PERIOD_4QUARTER: OleVariant; 
                                    var DOCS_PERIOD_JAN: OleVariant; 
                                    var DOCS_PERIOD_FEB: OleVariant; 
                                    var DOCS_PERIOD_MAR: OleVariant; 
                                    var DOCS_PERIOD_APR: OleVariant; 
                                    var DOCS_PERIOD_MAY: OleVariant; 
                                    var DOCS_PERIOD_JUN: OleVariant; 
                                    var OCS_PERIOD_JUL: OleVariant; 
                                    var DOCS_PERIOD_AUG: OleVariant; 
                                    var DOCS_PERIOD_SEP: OleVariant; 
                                    var DOCS_PERIOD_OCT: OleVariant; 
                                    var DOCS_PERIOD_NOV: OleVariant; 
                                    var DOCS_PERIOD_DEC: OleVariant; 
                                    var DOCS_PERIOD_THISY: OleVariant; 
                                    var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                                    var DOCS_PERIOD_YEAR: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_WrongDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                                    var DOCS_TO_Date: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                                    var VAR_DocsMaxRecords: OleVariant);
    procedure ClearSearch;
    procedure ListDoc(var sCommand: OleVariant; var S_Title: OleVariant; var sSQL: OleVariant; 
                      var S_TitleSearchCriteria: OleVariant; var DOCS_Contacts: OleVariant; 
                      var DOCS_Comments: OleVariant; var DOCS_ContextContaining: OleVariant; 
                      var DOCS_DOCUMENTRECORDS: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var DOCS_WrongDate: OleVariant; var Periods: OleVariant; 
                      var DOCS_CATEGORY: OleVariant; var DOCS_EXPIRED1: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; var DOCS_OUTSTANDING: OleVariant; 
                      var DOCS_Status: OleVariant; var DOCS_Incoming: OleVariant; 
                      var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                      var DOCS_Department: OleVariant; var DOCS_USER: OleVariant; 
                      var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                      var DOCS_MYDOCS: OleVariant; var DOCS_News: OleVariant; 
                      var DOCS_FromDocs: OleVariant; var VAR_DateNewDocs: OleVariant; 
                      var DOCS_DateFormat: OleVariant; var DOCS_UNAPPROVED: OleVariant; 
                      var DOCS_EXPIRED: OleVariant; var DOCS_UnderControl: OleVariant; 
                      var DOCS_Cancelled1: OleVariant; var VAR_StatusCancelled: OleVariant; 
                      var DOCS_Completed1: OleVariant; var USER_Department: OleVariant; 
                      var DOCS_Inactives1: OleVariant; var VAR_InActiveTask: OleVariant; 
                      var DOCS_Approved1: OleVariant; var DOCS_ApprovedNot1: OleVariant; 
                      var DOCS_Refused1: OleVariant; var DOCS_NOTCOMPLETED: OleVariant; 
                      var DOCS_YouAreResponsible: OleVariant; var DOCS_YouAreCreator: OleVariant; 
                      var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                      var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                      var DOCS_ReturnedFromFile: OleVariant; var DOCS_WaitingToBeSent: OleVariant; 
                      var DOCS_PaymentOutgoingIncompleted: OleVariant; 
                      var DOCS_PaymentIncomingIncompleted: OleVariant; 
                      var DOCS_StatusRequireToBePaid: OleVariant; 
                      var DOCS_GoToPaperFileDocList: OleVariant; 
                      var DOCS_NoUsersExceeded: OleVariant; var DOCS_LOGGEDOUT: OleVariant; 
                      var DOCS_ActionLogOut: OleVariant; var DOCS_SysUser: OleVariant; 
                      var DOCS_ViewedStatusDocs: OleVariant; var Texts: OleVariant);
    procedure InOutOfOffice(var VAR_BeginOfTimes: OleVariant);
    function AmountByWords(var summa: OleVariant; var unit_: OleVariant): OleVariant;
    procedure GetDoc(var sFileOut: OleVariant; var sError: OleVariant; 
                     var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                     var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                     var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                     var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                     var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                     var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                     var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                     var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                     var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                     var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                     var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                     var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                     var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                     var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                     var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                     var VAR_NamesListDelimiter1: OleVariant; 
                     var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                     var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                     var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure SetDoc(obj: OleVariant; var doc: OleVariant; sFileOut: OleVariant);
    procedure GetDoc1(var sFileOut: OleVariant; var sError: OleVariant; 
                      var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                      var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                      var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                      var DOCS_FileDoesNotExist: OleVariant; var DOCS_ActionShowFile: OleVariant; 
                      var DOCS_MoneyUnit: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var VAR_QNewSpec: OleVariant; var sQTY1: OleVariant; var sQTY2: OleVariant; 
                      var sQTY3: OleVariant; var sQTY4: OleVariant; var sQTY5: OleVariant; 
                      var sQTY6: OleVariant; var sQTY7: OleVariant; var sQTY8: OleVariant; 
                      var sQTY9: OleVariant; var sQTY10: OleVariant; var sQTY11: OleVariant; 
                      var sQTY12: OleVariant; var sQTY13: OleVariant; var sQTY14: OleVariant; 
                      var sQTY15: OleVariant; var DOCS_Sunday: OleVariant; 
                      var DOCS_Monday: OleVariant; var DOCS_Tuesday: OleVariant; 
                      var DOCS_Wednesday: OleVariant; var DOCS_Thursday: OleVariant; 
                      var DOCS_Friday: OleVariant; var DOCS_Saturday: OleVariant; 
                      var nCDates: OleVariant; var CMonths: OleVariant; var CDays: OleVariant; 
                      var VAR_NamesListDelimiter1: OleVariant; 
                      var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                      var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                      var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                      var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                      var DOCS_Internal: OleVariant);
    procedure InsertBookmarkTable(var cField: OleVariant; var cBookmark: OleVariant);
    procedure InsertRangeTable(var rVal: OleVariant; var mRange: OleVariant);
    procedure InsertRangeText(var rVal: OleVariant; var mRange: OleVariant);
    procedure InsertRangeCurrency(var cPar: OleVariant);
    procedure InsertRange(var cPar: OleVariant);
    procedure InsertRangeDate(var cPar: OleVariant);
    procedure InsertRowXLS;
    procedure InsertRow;
    procedure InsertRowExt(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                           var doc: OleVariant; var obj: OleVariant);
    procedure InsertRowExt1(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                            var doc: OleVariant; var obj: OleVariant);
    procedure InsertRowExt2(var iTable: OleVariant; var doc: OleVariant; var obj: OleVariant; 
                            var bErr: OleVariant);
    procedure AddBookmarksToTable(var Bookmarks: OleVariant; var iTable: OleVariant; 
                                  var iRow: OleVariant; var iColStart: OleVariant; 
                                  var doc: OleVariant; var obj: OleVariant; var bError: OleVariant);
    procedure MoveBookmarks(var Bookmarks: OleVariant; var iTable: OleVariant; var doc: OleVariant; 
                            var obj: OleVariant);
    function NoIDs(var cPar: OleVariant): OleVariant;
    procedure InsertBookmark(var cPar: OleVariant);
    procedure InsertBookmarkComments(var cPar: OleVariant);
    procedure InsertBookmarkComments1(var sCommentType: OleVariant; var sBookmark: OleVariant; 
                                      var bError: OleVariant);
    procedure InsertBookmarkCurrency(var cPar: OleVariant);
    procedure InsertBookmarkDate(var cPar: OleVariant);
    procedure InsertBookmarkSum(var rVal: OleVariant; var mBookmark: OleVariant);
    procedure InsertBookmarkText(var rVal: OleVariant; var mBookmark: OleVariant);
    procedure InsertBookmarkTextDoc(var doc: OleVariant; var rVal: OleVariant; 
                                    var mBookmark: OleVariant);
    procedure InsertBookmarkHyperlink(var cField: OleVariant; var cBookmark: OleVariant);
    procedure ShowSpecSummary(var VAR_QNewSpec: OleVariant);
    procedure ShowSpecSummaryXLS(var VAR_QNewSpec: OleVariant);
    procedure SpecMove;
    procedure SpecIDChange(var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_SPECIDWrong: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NoChangeSpecID: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant);
    procedure RestoreDoc(var DOCS_ActionRestoredDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NoAccess: OleVariant; var DOCS_AmountDoc: OleVariant; 
                         var DOCS_QuantityDoc: OleVariant; var DOCS_ErrorDataSource: OleVariant; 
                         var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                         var DOCS_ErrorSelectRecordset: OleVariant; 
                         var DOCS_ErrorInsertPars: OleVariant; 
                         var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant);
    procedure ReCalcSpec(var DOCS_ReCalculated: OleVariant; var DOCS_Records: OleVariant; 
                         var DOCS_Values: OleVariant; var DOCS_WrongNumber: OleVariant; 
                         var DOCS_WrongDate: OleVariant; var DOC_Calculator: OleVariant; 
                         var DOCS_Error: OleVariant; var VAR_QNewSpec: OleVariant; 
                         var VAR_TypeVal_String: OleVariant; var VAR_TypeVal_DateTime: OleVariant; 
                         var VAR_TypeVal_NumericMoney: OleVariant; 
                         var DOCS_SpecFieldName: OleVariant; var DOCS_SpecFieldFormula: OleVariant);
    function Percent(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
    function PercentAdd(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
    function PercentAddRev(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
    function Y1(var Number: OleVariant): OleVariant;
    function FQ: OleVariant;
    function FS: OleVariant;
    function FS1: OleVariant;
    function FS2: OleVariant;
    function F1: OleVariant;
    function F2: OleVariant;
    function F3: OleVariant;
    function F4: OleVariant;
    function F5: OleVariant;
    function F6: OleVariant;
    function F7: OleVariant;
    function F8: OleVariant;
    function F9: OleVariant;
    function F10: OleVariant;
    function F11: OleVariant;
    function F12: OleVariant;
    function F13: OleVariant;
    function F14: OleVariant;
    function F15: OleVariant;
    function F16: OleVariant;
    function F17: OleVariant;
    function F18: OleVariant;
    function F19: OleVariant;
    function F20: OleVariant;
    function F21: OleVariant;
    function F22: OleVariant;
    function F23: OleVariant;
    function F24: OleVariant;
    function F25: OleVariant;
    function F26: OleVariant;
    function F27: OleVariant;
    function F28: OleVariant;
    function F29: OleVariant;
    function F30: OleVariant;
    function F31: OleVariant;
    function F32: OleVariant;
    function F33: OleVariant;
    function F34: OleVariant;
    function F35: OleVariant;
    function F36: OleVariant;
    function F37: OleVariant;
    function F38: OleVariant;
    function F39: OleVariant;
    function F40: OleVariant;
    procedure CheckError;
    function CheckErrorF: OleVariant;
    procedure GoError(var Description: OleVariant);
    procedure PasteSpec(var DOCS_SpecNotPermitted: OleVariant; var DOCS_Inserted: OleVariant; 
                        var DOCS_InsertedCompatibleSpec: OleVariant);
    procedure PasteComponentsSpec(var DOC_ComplexUnits: OleVariant; 
                                  var DOCS_QuantityDoc: OleVariant; var DOCS_Inserted: OleVariant; 
                                  var DOCS_Total: OleVariant; var DOCS_ComplexItems: OleVariant);
    procedure DeleteType(var DOCS_NoDeleteType: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant);
    procedure DeleteSpecItem(var DOCS_SPECElement: OleVariant; var DOCS_Deleted: OleVariant);
    function GetDataNameAll(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
    function GetDataName(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
    function GetDataWidth(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
    function IsFieldEditArea(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
    function IsNoDir(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
    function IsRUS(var cPar: OleVariant): OleVariant;
    procedure Archive(var DOC_ArchiveExit: OleVariant; var DOC_ArchiveEnter: OleVariant; 
                      var VAR_AdminSecLevel: OleVariant; var VAR_StatusArchiv: OleVariant; 
                      var VAR_StatusCompletion: OleVariant; 
                      var Var_ArchiveMoveAllCompletedDocsYears: OleVariant; 
                      var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                      var DOC_Moved: OleVariant; var DOC_Total: OleVariant; 
                      var DOCS_DateActivation: OleVariant; var DOCS_Completed: OleVariant; 
                      var DOCS_Archiv: OleVariant; var DOC_Move: OleVariant; 
                      var DOCS_MakeChoice: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                      var Var_ArchiveMoveAllOldDocsYears: OleVariant; 
                      var DOCS_ErrorDataSource: OleVariant; 
                      var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                      var DOCS_ErrorSelectRecordset: OleVariant; 
                      var DOCS_ErrorInsertPars: OleVariant; 
                      var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant);
    procedure DeleteAuditing(var DOCS_ActionDeleteLog: OleVariant; var DOCS_NORight: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; 
                             var VAR_DateOldAuditing: OleVariant; var DOCS_SysLog: OleVariant; 
                             var DOCS_Records: OleVariant);
    procedure DeleteComment(var DOCS_ActionDeleteComment: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_ActionDeleteFile: OleVariant; var DOCS_Version: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant);
    procedure DeleteDepartment(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                               var DOCS_Deleted: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteInventory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteMeasure(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeletePartner(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeletePosition(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteUserDirectory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_NoDeleteDir: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var USER_Department: OleVariant; var sDepartment: OleVariant);
    procedure DeleteUserDirectoryValues(var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant);
    procedure DeleteDirectoryValues(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteRegLog(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteRequest(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_NORightToDelete: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteScorecard(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                              var DOCS_NORightToDelete: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var USER_Department: OleVariant);
    procedure DeleteSpec(var DOCS_SysUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOCS_Spec: OleVariant; 
                         var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                         var DOCS_NoDeleteSpec: OleVariant);
    procedure DeleteTransaction(var DOCS_Deleted: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure DeleteUser(var DOCS_NOTFOUND: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                         var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant);
    function GetMonitorURL(var sPar: OleVariant; var sval: OleVariant; var cbm: OleVariant; 
                           var DOCS_News: OleVariant): OleVariant;
    procedure SetMonitorSound;
    function GetMonitorSound(var DOCS_MonitorSoundN: OleVariant; var DOCS_MonitorNoSound: OleVariant): OleVariant;
    procedure ChangeMonitorSound(var Var_nMonitorSoundFiles: OleVariant);
    procedure ShowListMonitorUsers(var S_PartnerID: OleVariant; var S_PartnerName: OleVariant; 
                                   var DOCS_News: OleVariant; 
                                   var DOCS_SendPersonalMessage: OleVariant; 
                                   var DOCS_SendPersonalMessageYourself: OleVariant; 
                                   var Var_nMonitorRefreshSeconds: OleVariant);
    procedure AddUserToMonitor(var DOCS_Created: OleVariant);
    procedure ClearMonitorList;
    procedure DeleteUserFromMonitor(var DOCS_Deleted: OleVariant);
    function UserInMonitor(var sUserID: OleVariant): OleVariant;
    procedure ChangeMeasure(var S_Measure: OleVariant; var S_Code: OleVariant; 
                            var S_UnitName: OleVariant; var S_Name: OleVariant; 
                            var S_USLNAT: OleVariant; var S_USLINTER: OleVariant; 
                            var S_ALFNAT: OleVariant; var S_ALFINTER: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                            var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                            var VAR_BeginOfTimes: OleVariant);
    procedure ChangePartner(var S_Companies: OleVariant; var S_Partner: OleVariant; 
                            var S_ShortName: OleVariant; var S_Address: OleVariant; 
                            var S_Address1: OleVariant; var S_Address2: OleVariant; 
                            var S_Phone: OleVariant; var S_Fax: OleVariant; 
                            var S_ContactName: OleVariant; var S_EMail: OleVariant; 
                            var S_WebLink: OleVariant; var S_BankDetails: OleVariant; 
                            var S_TaxID: OleVariant; var S_RegCode: OleVariant; 
                            var S_RegCode1: OleVariant; var S_Country: OleVariant; 
                            var S_Area: OleVariant; var S_City: OleVariant; 
                            var S_Industry: OleVariant; var S_ManagerName: OleVariant; 
                            var S_ManagerPosition: OleVariant; var S_ManagerPhoneNo: OleVariant; 
                            var S_AccountingManagerName: OleVariant; 
                            var S_AccountingManagerPhoneNo: OleVariant; 
                            var S_SalesManagerName: OleVariant; 
                            var S_SalesManagerPosition: OleVariant; 
                            var S_SalesManagerPhoneNo: OleVariant; var S_AddInfo: OleVariant; 
                            var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                            var S_NameLastModification: OleVariant; 
                            var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                            var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                            var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant);
    procedure ChangePosition(var S_Position: OleVariant; var S_NameCreation: OleVariant; 
                             var S_DateCreation: OleVariant; 
                             var S_NameLastModification: OleVariant; 
                             var S_DateLastModification: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                             var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant);
    function CanModifyDirectory(var WriteSecurityLevel: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                var NameCreation: OleVariant; var USER_Department: OleVariant; 
                                var sDepartment: OleVariant): OleVariant;
    function CanModifyDirectoryGUID(var sDirGUID: OleVariant; var sGUID: OleVariant; 
                                    var WriteSecurityLevel: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                    var USER_Department: OleVariant; var sDepartment: OleVariant): OleVariant;
    procedure ChangeUserDirectory(var S_Name: OleVariant; var S_DocField: OleVariant; 
                                  var S_FieldName1: OleVariant; var S_FieldName2: OleVariant; 
                                  var S_FieldName3: OleVariant; var S_FieldName4: OleVariant; 
                                  var S_FieldName5: OleVariant; var S_FieldName6: OleVariant; 
                                  var S_CompanyDoc: OleVariant; var S_NameCreation: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                                  var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_All: OleVariant; var USER_Department: OleVariant; 
                                  var sDepartment: OleVariant);
    function GetGUID: WideString;
    function GetGUID1: WideString;
    function GetGUIDFromKeyField(var cPar: OleVariant): OleVariant;
    function GUID2ByteArray(const strGUID: WideString): PSafeArray;
    procedure ChangeUserDirectoryValues(var S_GUID: OleVariant; var S_KeyField: OleVariant; 
                                        var S_Field1: OleVariant; var S_Field2: OleVariant; 
                                        var S_Field3: OleVariant; var S_Field4: OleVariant; 
                                        var S_Field5: OleVariant; var S_Field6: OleVariant; 
                                        var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_ALREADYEXISTS: OleVariant; 
                                        var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var DOCS_NORight: OleVariant; 
                                        var VAR_BeginOfTimes: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant);
    procedure ChangeDirectoryValues(var dsDoc: OleVariant; var S_Name: OleVariant; 
                                    var S_Code: OleVariant; var S_Code2: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; 
                                    var DOCS_ALREADYEXISTS: OleVariant; 
                                    var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_ErrorGUID: OleVariant);
    procedure ChangeRegLog(var S_Name: OleVariant; var S_Users: OleVariant; 
                           var S_Owners: OleVariant; var S_ClassDocs: OleVariant; 
                           var S_RegLogID: OleVariant; var S_VisibleFields: OleVariant; 
                           var S_DocType: OleVariant; var S_NameCreation: OleVariant; 
                           var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                           var S_DateLastModification: OleVariant; var AddFieldName1: OleVariant; 
                           var AddFieldName2: OleVariant; var AddFieldName3: OleVariant; 
                           var AddFieldName4: OleVariant; var AddFieldName5: OleVariant; 
                           var AddFieldName6: OleVariant; var AddFieldFormula1: OleVariant; 
                           var AddFieldFormula2: OleVariant; var AddFieldFormula3: OleVariant; 
                           var AddFieldFormula4: OleVariant; var AddFieldFormula5: OleVariant; 
                           var AddFieldFormula6: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                           var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_All: OleVariant);
    procedure GetOrderPars(var dsDoc: OleVariant; var S_OrderBy1: OleVariant; 
                           var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                           var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                           var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                           var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant);
    procedure ChangeRequest(var RequestPars: OleVariant; var dsDoc: OleVariant; 
                            var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                            var bSpec: OleVariant; var bDateActivation: OleVariant; 
                            var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                            var sDetailes: OleVariant; var VAR_StatusArchiv: OleVariant; 
                            var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                            var DOCS_ListToReconcile: OleVariant; 
                            var DOCS_NameResponsible: OleVariant; var DOCS_NameAproval: OleVariant; 
                            var USER_Name: OleVariant; var DOCS_Department: OleVariant; 
                            var DOCS_Name: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_History: OleVariant; var VAR_ExtInt: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_InventoryUnit: OleVariant; 
                            var DOCS_PaymentMethod: OleVariant; var DOCS_AmountDoc: OleVariant; 
                            var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_StatusCompletion: OleVariant; 
                            var DOCS_OUTSTANDING: OleVariant; var DOCS_Completed1: OleVariant; 
                            var VAR_StatusCompletion: OleVariant; 
                            var VAR_StatusCancelled: OleVariant; var DOCS_Completed: OleVariant; 
                            var DOCS_Actual: OleVariant; var DOCS_Cancelled: OleVariant; 
                            var DOCS_Cancelled1: OleVariant; var DOCS_Incoming: OleVariant; 
                            var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                            var DOCS_TypeDoc: OleVariant; var DOCS_ClassDoc: OleVariant; 
                            var DOCS_StatusDevelopment: OleVariant; 
                            var DOCS_NameUserFieldDate: OleVariant; var DOCS_FROM_Date: OleVariant; 
                            var DOCS_TO_Date: OleVariant; var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; 
                            var DOCS_RequestAddSQL: OleVariant; var Statuses: OleVariant; 
                            var Periods: OleVariant; var TextConsts: OleVariant; 
                            var Consts: OleVariant; var sRequestSQL: OleVariant; 
                            var DOCS_All: OleVariant);
    procedure ChangeTransaction(var S_Transaction: OleVariant; var S_Account: OleVariant; 
                                var S_SubAccount1: OleVariant; var S_SubAccount2: OleVariant; 
                                var S_SubAccount3: OleVariant; var S_NameCreation: OleVariant; 
                                var S_DateCreation: OleVariant; 
                                var S_NameLastModification: OleVariant; 
                                var S_DateLastModification: OleVariant; 
                                var DOCS_ALREADYEXISTS: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant);
    procedure ChangeType(var S_Type: OleVariant; var S_Template: OleVariant; 
                         var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                         var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var UserInstructions: OleVariant; 
                         var BusinessProcessSteps: OleVariant; var BusinessProcessType: OleVariant; 
                         var StandardNameTexts: OleVariant; var NameUserFieldText1: OleVariant; 
                         var NameUserFieldText2: OleVariant; var NameUserFieldText3: OleVariant; 
                         var NameUserFieldText4: OleVariant; var NameUserFieldText5: OleVariant; 
                         var NameUserFieldText6: OleVariant; var NameUserFieldText7: OleVariant; 
                         var NameUserFieldText8: OleVariant; var NameUserFieldMoney1: OleVariant; 
                         var NameUserFieldMoney2: OleVariant; var NameUserFieldDate1: OleVariant; 
                         var NameUserFieldDate2: OleVariant; var NameSpecIDs: OleVariant; 
                         var bVar: OleVariant; var S_FormulaQuantity: OleVariant; 
                         var S_FormulaAmount: OleVariant; var TextConsts: OleVariant; 
                         var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                         var sSelectRecordset: OleVariant; var sFieldNames: OleVariant);
    function CanAccessRecord(var SecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Users: OleVariant): OleVariant;
    function CanViewRecord(var ReadSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var UserID: OleVariant; var sDepartment: OleVariant; 
                           var USER_Department: OleVariant; var Viewers: OleVariant): OleVariant;
    function CanModifyRecord(var WriteSecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var UserID: OleVariant; var sDepartment: OleVariant; 
                             var USER_Department: OleVariant; var Editors: OleVariant): OleVariant;
    procedure ChangeScorecard(var S_GUID: OleVariant; var S_KeyWords: OleVariant; 
                              var S_Name: OleVariant; var S_Description: OleVariant; 
                              var S_PeriodType: OleVariant; var S_FirstPeriod: OleVariant; 
                              var N_PeriodsPerScreen: OleVariant; var N_ScreenWidth: OleVariant; 
                              var N_MinScorecardValue: OleVariant; 
                              var N_MaxScorecardValue: OleVariant; var S_DataSource: OleVariant; 
                              var S_DataSourcePars: OleVariant; var S_SelectRecordset: OleVariant; 
                              var S_SelectRecordsetPars: OleVariant; var S_ColorNormal: OleVariant; 
                              var S_ColorWarning: OleVariant; var S_ColorCritical: OleVariant; 
                              var S_ConditionWarning: OleVariant; 
                              var S_ConditionCritical: OleVariant; var S_SignWarning: OleVariant; 
                              var S_SignCritical: OleVariant; var S_NameFormula: OleVariant; 
                              var S_NameFormulaPars: OleVariant; var S_ValueFormula: OleVariant; 
                              var S_ValueFormat: OleVariant; 
                              var S_ScorecardDownLevelGUID: OleVariant; 
                              var S_ScorecardDownLevelFormulaLink: OleVariant; 
                              var S_Editors: OleVariant; var S_Viewers: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; var DOCS_NORight: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var USER_Department: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant);
    procedure ChangeUser(var S_UserID: OleVariant; var S_Password: OleVariant; 
                         var S_Name: OleVariant; var S_Phone: OleVariant; 
                         var S_PhoneCell: OleVariant; var S_IDentification: OleVariant; 
                         var S_IDNo: OleVariant; var S_IDIssuedBy: OleVariant; 
                         var S_IDIssueDate: OleVariant; var S_IDExpDate: OleVariant; 
                         var S_BirthDate: OleVariant; var S_CorporateIDNo: OleVariant; 
                         var S_AddInfo: OleVariant; var S_Comment: OleVariant; 
                         var S_EMail: OleVariant; var S_PostAddress: OleVariant; 
                         var S_ICQ: OleVariant; var S_Department: OleVariant; 
                         var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                         var S_ClassDoc: OleVariant; var S_Reporttype: OleVariant; 
                         var S_CompanyDoc: OleVariant; var S_Position: OleVariant; 
                         var S_Role: OleVariant; var S_PossibleRoles: OleVariant; 
                         var S_ReadSecurityLevel: OleVariant; var S_WriteSecurityLevel: OleVariant; 
                         var S_ExtIntSecurityLevel: OleVariant; 
                         var S_DateExpirationSecurity: OleVariant; var S_StatusActive: OleVariant; 
                         var S_Permitions: OleVariant; var S_NameCreation: OleVariant; 
                         var S_DateCreation: OleVariant; var S_NameLastModification: OleVariant; 
                         var S_DateLastModification: OleVariant; var sNewRole: OleVariant; 
                         var VARS: OleVariant);
    function GenNewMSAccessReplicationID: OleVariant;
    procedure ChangeSpecItem(var dsDoc: OleVariant; var S_ItemID: OleVariant; 
                             var S_NameSpec: OleVariant; var DOCS_Error: OleVariant; 
                             var UPC_NotFound: OleVariant; var VAR_TypeVal_String: OleVariant; 
                             var VAR_TypeVal_NumericMoney: OleVariant; 
                             var VAR_TypeVal_DateTime: OleVariant; 
                             var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                             var DOCS_WrongNumber: OleVariant; var DOCS_Created: OleVariant; 
                             var DOCS_Changed: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var S_InventoryUnitField: OleVariant; var Var_InventoryCode: OleVariant);
    procedure ChangeSpec(var dsDoc: OleVariant; var S_NameSpec: OleVariant; 
                         var VAR_QNewSpec: OleVariant; var DOCS_ErrSpecEmptyName: OleVariant; 
                         var DOCS_Created: OleVariant; var DOCS_Changed: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant);
    procedure ChangeReporttype(var S_Reporttype: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant);
    procedure ChangeInventory(var S_Inventory: OleVariant; var S_Code: OleVariant; 
                              var S_UnitName: OleVariant; var S_CodeInternal: OleVariant; 
                              var S_CodeInternal2: OleVariant; var S_Quantity: OleVariant; 
                              var S_PriceIn: OleVariant; var S_PriceOut: OleVariant; 
                              var S_Comment: OleVariant; var S_Comment2: OleVariant; 
                              var S_PictureURL: OleVariant; var S_Category: OleVariant; 
                              var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                              var S_NameLastModification: OleVariant; 
                              var S_DateLastModification: OleVariant; 
                              var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                              var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                              var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                              var VAR_BeginOfTimes: OleVariant);
    procedure ChangeDepartment(var S_Department: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
    procedure ChangeDocIdInDepandants(var sDocIDold: OleVariant; var sDocIDnew: OleVariant);
    procedure GetExtDataRecordsets(var dsDoc: OleVariant; var nDataSources: OleVariant; 
                                   var bErr: OleVariant; var sMessage: OleVariant; 
                                   var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                   var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                   var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                   var sStatementUpdate: OleVariant; 
                                   var sStatementDelete: OleVariant; var sGUID: OleVariant);
    procedure GetExtDataDescriptions(var sClassDoc: OleVariant; var nDataSources: OleVariant; 
                                     var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                     var sSelectRecordset: OleVariant; var sFieldNames: OleVariant; 
                                     var sKeyWords: OleVariant; var sStatementInsert: OleVariant; 
                                     var sStatementUpdate: OleVariant; 
                                     var sStatementDelete: OleVariant; var sGUID: OleVariant);
    procedure ChangeDocIDInExtData(var sDocIDold: OleVariant; var sDocIDnew: OleVariant; 
                                   var dsDoc: OleVariant; var S_ClassDoc: OleVariant);
    procedure PutsChanges(var cDoc: OleVariant; var cRequest: OleVariant);
    procedure PutsChangesNewUsers(var sNewUsers: OleVariant; var cDoc: OleVariant; 
                                  var cRequest: OleVariant);
    procedure PutsChanges1(var cDoc: OleVariant; var cRequest: OleVariant);
    function IsRightCurrency(var cPar: OleVariant; var Var_MainSystemCurrency: OleVariant): OleVariant;
    procedure ChangeDoc(var S_DocID: OleVariant; var S_DocIDAdd: OleVariant; 
                        var S_DocIDParent: OleVariant; var S_DocIDPrevious: OleVariant; 
                        var S_DocIDIncoming: OleVariant; var S_Department: OleVariant; 
                        var S_Author: OleVariant; var S_Correspondent: OleVariant; 
                        var S_Resolution: OleVariant; var S_History: OleVariant; 
                        var S_Result: OleVariant; var S_ExtPassword: OleVariant; 
                        var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                        var S_Name: OleVariant; var S_Description: OleVariant; 
                        var S_Content: OleVariant; var S_LocationPaper: OleVariant; 
                        var S_Currency: OleVariant; var S_CurrencyRate: OleVariant; 
                        var S_Rank: OleVariant; var S_LocationPath: OleVariant; 
                        var S_ExtInt: OleVariant; var S_PartnerName: OleVariant; 
                        var S_StatusDevelopment: OleVariant; var S_StatusArchiv: OleVariant; 
                        var S_StatusCompletion: OleVariant; var S_PaymentMethod: OleVariant; 
                        var S_StatusPayment: OleVariant; var S_InventoryUnit: OleVariant; 
                        var S_AmountDoc: OleVariant; var S_AmountDocPart: OleVariant; 
                        var S_QuantityDoc: OleVariant; var S_SecurityLevel: OleVariant; 
                        var S_DateCreation: OleVariant; var S_DateCompletion: OleVariant; 
                        var S_DateExpiration: OleVariant; var S_DateActivation: OleVariant; 
                        var S_DateSigned: OleVariant; var S_NameCreation: OleVariant; 
                        var S_NameAproval: OleVariant; var S_NameControl: OleVariant; 
                        var S_NameApproved: OleVariant; var S_ListToView: OleVariant; 
                        var S_ListToEdit: OleVariant; var S_ListToReconcile: OleVariant; 
                        var S_ListReconciled: OleVariant; var S_NameResponsible: OleVariant; 
                        var S_NameLastModification: OleVariant; 
                        var S_DateLastModification: OleVariant; var S_TypeDoc: OleVariant; 
                        var S_StandardNameTexts: OleVariant; var S_ClassDoc: OleVariant; 
                        var S_BusinessProcessStep: OleVariant; var S_IsActive: OleVariant; 
                        var HasNoSub: OleVariant; var S_UserFields: OleVariant; 
                        var TextConsts: OleVariant; var MailTexts: OleVariant);
    function Mult(var cPar: OleVariant): OleVariant;
    procedure ChangeAct(var S_Type: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_Changed: OleVariant; 
                        var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
    procedure CopyCompany(var DOCS_Copied1: OleVariant; var DOCS_ALREADYEXISTS: OleVariant);
    function LeadSymbolN(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant;
    function LeadSymbolN1(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant;
    procedure BusinessProcessInit(sBusinessProcessSteps: OleVariant);
    procedure BPSetResultFinal(var sResultText: OleVariant);
    function BPResultFinal: OleVariant;
    function BPStepName(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPStepNumber(sBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIsInactive(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIsActive(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIsActiveCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIsCompleted(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIsCanceled(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPSetSeparator(nBPStep: OleVariant; var sTitle: OleVariant; var sError: OleVariant): OleVariant;
    function BPSetComment(nBPStep: OleVariant; var sComment: OleVariant; var sError: OleVariant; 
                          var sPict: OleVariant): OleVariant;
    function BPSeparator(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPComment(nBPStep: OleVariant; var sError: OleVariant; var sPict: OleVariant): OleVariant;
    function BPResult(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPResultNumber(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPSetResults(nBPStep: OleVariant; var sResultSet: OleVariant; var sError: OleVariant): OleVariant;
    function BPResultSet(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPSetResult(nBPStep: OleVariant; var nResult: OleVariant; var sError: OleVariant): OleVariant;
    function BPSetResultString(nBPStep: OleVariant; var sResult: OleVariant; var sError: OleVariant): OleVariant;
    function BPCancel(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPComplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPIncomplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPDeactivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPActivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function BPActivateCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
    function IsWrongNBPStep(var nBPStep: OleVariant): OleVariant;
    function BoardOrderValue(var dDate: OleVariant; var sKey: OleVariant; var dDateEvent: OleVariant): OleVariant;
    function BoardOrderValueSQL: OleVariant;
    procedure CheckOut(var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                       var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                       var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var DOCS_CheckedOut: OleVariant; 
                       var DOCS_Version: OleVariant; var DOCS_CheckedOutAlready: OleVariant);
    procedure CreateComment(var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                            var VAR_CommentDescription: OleVariant; var VAR_Subject: OleVariant; 
                            var DOCS_News: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_WrongDate: OleVariant; var DOCS_DateFormat: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                            var DOCS_DateActivation: OleVariant; 
                            var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                            var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                            var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                            var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                            var DOCS_NotificationSentTo: OleVariant; 
                            var DOCS_SendNotification: OleVariant; 
                            var DOCS_UsersNotFound: OleVariant; 
                            var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                            var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                            var DOCS_STATUSHOLD: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                            var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                            var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                            var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                            var DOCS_Reconciliation: OleVariant; 
                            var DOCS_NotificationNotCompletedDoc: OleVariant; 
                            var MailTexts: OleVariant);
    procedure CreateCommentEMailClient(var sUserID: OleVariant; var sUserName: OleVariant; 
                                       var sDocID: OleVariant; var sCommentType: OleVariant; 
                                       var sSubject: OleVariant; var sComment: OleVariant; 
                                       var sMessage: OleVariant; var DOCS_CommentCreated: OleVariant);
    procedure CreateViewed(var ds: OleVariant; var sDocIDpar: OleVariant; 
                           var DOCS_Viewed: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant);
    procedure UploadDescriptionXMLRet(var sMessage: OleVariant; var DocFields: OleVariant; 
                                      var nFields: OleVariant; var ReportFields: OleVariant; 
                                      var nReportFields: OleVariant; 
                                      var DOCS_ALREADYEXISTS: OleVariant; 
                                      var DOCS_FileUploaded: OleVariant; 
                                      var DOCS_DocID: OleVariant; var DOCS_Name: OleVariant);
    function IsFieldExist(var rs: OleVariant; var sFieldName: OleVariant): OleVariant;
    procedure UploadPartnerRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant);
    procedure UploadDepartmentRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_FileNotUploaded: OleVariant; 
                                  var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                  var DOCS_FileName: OleVariant; 
                                  var DOCS_VersionFileChanged: OleVariant; 
                                  var DOCS_NoModiFile1: OleVariant; 
                                  var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant);
    procedure UploadTypeDocRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant);
    procedure UploadUserPhotoRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                 var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                 var DOCS_NOTFOUND: OleVariant; 
                                 var DOCS_FileNotUploaded: OleVariant; 
                                 var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                 var DOCS_FileName: OleVariant; 
                                 var DOCS_VersionFileChanged: OleVariant; 
                                 var DOCS_NoModiFile1: OleVariant; 
                                 var DOCS_NoModiFile2: OleVariant; var VAR_BeginOfTimes: OleVariant);
    function PostcardFilePrefix: OleVariant;
    function PostcardFile(var sExt: OleVariant): OleVariant;
    function PostcardFileNoPath(var sExt: OleVariant): OleVariant;
    function PostcardFileURL(var sExt: OleVariant): OleVariant;
    function IsPostcardFile(sFile: OleVariant): OleVariant;
    procedure UploadPostcardPicRet(var sMessage: OleVariant; var sFile: OleVariant; 
                                   var sFileURL: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                   var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_FileNotUploaded: OleVariant; 
                                   var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                   var DOCS_FileName: OleVariant; 
                                   var DOCS_VersionFileChanged: OleVariant; 
                                   var DOCS_NoModiFile1: OleVariant; 
                                   var DOCS_NoModiFile2: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_MaxFileSizeExceeded1: OleVariant);
    procedure LoadDBCheck(var bMain: OleVariant; var DOCS_Table: OleVariant; 
                          var DOCS_TableContainsData: OleVariant; 
                          var DOCS_TableContainsDataNot: OleVariant; var bOKAny: OleVariant);
    procedure LoadDB(var DOCS_TableContainsData: OleVariant; 
                     var DOCS_TableSourceNoData: OleVariant; var DOCS_Records: OleVariant; 
                     var VAR_AdminSecLevel: OleVariant; var DOCS_LoadDB1: OleVariant; 
                     var DOCS_Error: OleVariant; var DOCS_Table: OleVariant; 
                     var DOCS_Field: OleVariant; var DOCS_FieldValue: OleVariant; 
                     var DOCS_FieldTypeFrom: OleVariant; var DOCS_FieldTypeTo: OleVariant; 
                     var DOCS_LoadDBEnd: OleVariant; var DOCS_TableSourceRecordCount: OleVariant; 
                     var DOCS_TableTargetRecordCount: OleVariant);
    procedure UploadRetNew(sNotificationList: OleVariant; var sMessage: OleVariant; 
                           var sKeyField: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                           var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                           var DOCS_FileName: OleVariant; var DOCS_VersionFileChanged: OleVariant; 
                           var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                           var VAR_BeginOfTimes: OleVariant; var DOCS_NORight: OleVariant; 
                           var DOCS_CheckInUsePictogram: OleVariant; 
                           var DOCS_VersionFileUploaded: OleVariant; 
                           var DOCS_CheckedIn: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; 
                           var DOCS_RecListUsersUpload: OleVariant; 
                           var DOCS_AccessDenied: OleVariant; var DOCS_DocID: OleVariant; 
                           var DOCS_DateActivation: OleVariant; 
                           var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                           var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                           var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                           var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                           var DOCS_NotificationSentTo: OleVariant; 
                           var DOCS_SendNotification: OleVariant; 
                           var DOCS_UsersNotFound: OleVariant; 
                           var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                           var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                           var VAR_StatusActiveUser: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                           var DOCS_Sender: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                           var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                           var DOCS_NotificationNotCompletedDoc: OleVariant; 
                           var MailTexts: OleVariant);
    function GetRandomSeq(var nSeq: OleVariant): OleVariant;
    procedure ListPartners(var dsDoc: OleVariant; var sSQL: OleVariant; 
                           var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                           var VAR_DocsMaxRecords: OleVariant; var par_searchsearch: OleVariant; 
                           var par_C_Search: OleVariant; var par_SearchComments: OleVariant; 
                           var par_Companies: OleVariant);
    procedure ListUserDirectories(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                                  var VAR_DocsMaxRecords: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant);
    procedure ListReportRequests(var sSQL: OleVariant; var USER_Department: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant);
    procedure ListUserDirectoryValues(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                      var KeyField: OleVariant);
    procedure ListDirectoryValues(var sSQL: OleVariant);
    procedure ListUsers(var dsDoc: OleVariant; var sSQL: OleVariant; 
                        var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                        var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant; 
                        var par_Companies: OleVariant; var par_searchPartner: OleVariant; 
                        var par_searchDepartment: OleVariant; var par_searchsearch: OleVariant; 
                        var par_C_Search: OleVariant; var par_searchPosition: OleVariant);
    procedure ListDirectories(var dsDoc: OleVariant; var sCurDir: OleVariant; 
                              var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant);
    procedure ListInventory(var dsDoc: OleVariant; var sSQL: OleVariant; 
                            var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_FOUND: OleVariant);
    procedure ListMeasure(var dsDoc: OleVariant; var sSQL: OleVariant; 
                          var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                          var DOCS_FOUND: OleVariant);
    procedure ShowListNotices(var S_DocID: OleVariant; var dsDoc1: OleVariant; 
                              var sBusinessProcessSteps: OleVariant; var DOCS_Notices: OleVariant);
    function CommentsOrder: OleVariant;
    procedure ShowListComments(var S_DocID: OleVariant; var dsDoc1: OleVariant);
    procedure ShowListCommentsTransactions(var S_GUID: OleVariant; var dsDoc1: OleVariant);
    procedure ShowListCommentsPartner(var S_PartnerID: OleVariant; var S_Partner: OleVariant; 
                                      var dsDoc1: OleVariant);
    procedure ShowListCommentsUser(var S_UserID: OleVariant; var dsDoc1: OleVariant);
    procedure ShowListSpecUnits(var S_DocID: OleVariant; var ds: OleVariant; 
                                var sSpecIDs: OleVariant);
    procedure ShowDocSpecItems(var S_DocID: OleVariant; var dsDoc1: OleVariant);
    function ShowContext(var cPar: OleVariant): OleVariant;
    function ShowContextHTMLEncode(var cPar: OleVariant): OleVariant;
    function GetExt(var fName: OleVariant): OleVariant;
    function GetWithoutExt(var fName: OleVariant): OleVariant;
    function AddLogM(var sLog: OleVariant): OleVariant;
    function MailListOLD(var DOCS_MailListNotFound: OleVariant; var DOCS_MailList: OleVariant; 
                         var DOCS_MailsSent: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
    procedure GetMailListFilesAndMessages(var Files: OleVariant; var iMsgs: OleVariant);
    procedure GetPrintFiles(var Files: OleVariant);
    procedure MailList(var rs: OleVariant; var sDataName: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var USER_NOEMail: OleVariant; 
                       var USER_BADEMail: OleVariant; var DOCS_MailListMarkFile: OleVariant; 
                       var DOCS_MessageSent: OleVariant; var DOCS_MailListMarkExtData: OleVariant; 
                       var DOCS_DBEOF: OleVariant; var DOCS_MailList: OleVariant; 
                       var VAR_BeginOfTimes: OleVariant; var DOCS_MailsSent: OleVariant; 
                       var DOCS_DataSourceRecords: OleVariant; var DOCS_LISTUSERS: OleVariant; 
                       var DOCS_LISTCONTACTNAMES: OleVariant; var DOCS_Source: OleVariant; 
                       var DOCS_FileName: OleVariant; var DOCS_MailListERROR1: OleVariant; 
                       var DOCS_ErrorDataSource: OleVariant; 
                       var DOCS_ErrorSelectRecordset: OleVariant; 
                       var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                       var DOCS_ErrorInsertPars: OleVariant; 
                       var DOCS_ErrorSelectNotDefined: OleVariant; 
                       var DOCS_MailListERRORTO: OleVariant; 
                       var DOCS_MailListERRORFIELD: OleVariant; 
                       var DOCS_MailListRunning: OleVariant; var DOCS_MailListERROR2: OleVariant; 
                       var DOCS_DemoMaximumMails: OleVariant; var DOCS_MailListERROR3: OleVariant; 
                       var nDelay: OleVariant);
    function CheckRSField(var rs: OleVariant; var sToField: OleVariant): OleVariant;
    procedure GetKeyFromString(var sPar: OleVariant; var sLeft: OleVariant; var sRight: OleVariant; 
                               var iStart: OleVariant; var sKey: OleVariant; var nPoz: OleVariant; 
                               var nLen: OleVariant);
    procedure InsertEMailListPars(var sText: OleVariant; sType: OleVariant; sData: OleVariant; 
                                  var rs: OleVariant);
    function InsertParsFromRS(var bErr: OleVariant; var rs: OleVariant; sSourceText: OleVariant; 
                              sFieldArray: OleVariant; nPozArray: OleVariant; 
                              nLenArray: OleVariant; nSize: OleVariant; 
                              VAR_BeginOfTimes: OleVariant; var DOCS_MailListERROR3: OleVariant): OleVariant;
    function IsLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant): OleVariant;
    function PutLogFieldInUseNumber: OleVariant;
    procedure PutLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant);
    function MoneyFormat(var Amount: Currency): WideString;
    function MakeHTMLSafe(var sText: WideString): WideString;
    function Unescape(var s: WideString): OleVariant;
    function FindExtraHeader(var key: WideString): WideString;
    function myMethod(const myString: WideString): WideString;
    function RoundMoney(pAmount: Currency): Currency;
    function RightAmount(const pAmount: WideString): Currency;
    function myPowerMethod: OleVariant;
    procedure SendContent(var s: WideString);
    function RUS: OleVariant;
    function RUZone: OleVariant;
    function LPar: OleVariant;
    function LPar1: OleVariant;
    procedure MainCommon;
    procedure doSetKey(var txtKey: WideString);
    property DefaultInterface: _Common read GetDefaultInterface;
    property Conn: _Connection read Get_Conn write _Set_Conn;
    property dsDocTemp: _Recordset read Get_dsDocTemp write _Set_dsDocTemp;
    property SetSelector: WideString write Set_SetSelector;
    property myPowerProperty: WideString read Get_myPowerProperty;
    property myProperty: WideString read Get_myProperty write Set_myProperty;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCommonProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCommon
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCommonProperties = class(TPersistent)
  private
    FServer:    TCommon;
    function    GetDefaultInterface: _Common;
    constructor Create(AServer: TCommon);
  protected
    function Get_obj: OleVariant;
    procedure Set_obj(var obj: OleVariant);
    procedure _Set_obj(var obj: OleVariant);
    function Get_doc: OleVariant;
    procedure Set_doc(var doc: OleVariant);
    procedure _Set_doc(var doc: OleVariant);
    function Get_oXL: OleVariant;
    procedure Set_oXL(var oXL: OleVariant);
    procedure _Set_oXL(var oXL: OleVariant);
    function Get_oWB: OleVariant;
    procedure Set_oWB(var oWB: OleVariant);
    procedure _Set_oWB(var oWB: OleVariant);
    function Get_oSheet: OleVariant;
    procedure Set_oSheet(var oSheet: OleVariant);
    procedure _Set_oSheet(var oSheet: OleVariant);
    function Get_oRng: OleVariant;
    procedure Set_oRng(var oRng: OleVariant);
    procedure _Set_oRng(var oRng: OleVariant);
    function Get_Conn: _Connection;
    procedure _Set_Conn(const Conn: _Connection);
    function Get_ds: OleVariant;
    procedure Set_ds(var ds: OleVariant);
    procedure _Set_ds(var ds: OleVariant);
    function Get_dsDoc: OleVariant;
    procedure Set_dsDoc(var dsDoc: OleVariant);
    procedure _Set_dsDoc(var dsDoc: OleVariant);
    function Get_dsDoc1: OleVariant;
    procedure Set_dsDoc1(var dsDoc1: OleVariant);
    procedure _Set_dsDoc1(var dsDoc1: OleVariant);
    function Get_dsDoc2: OleVariant;
    procedure Set_dsDoc2(var dsDoc2: OleVariant);
    procedure _Set_dsDoc2(var dsDoc2: OleVariant);
    function Get_dsDoc3: OleVariant;
    procedure Set_dsDoc3(var dsDoc3: OleVariant);
    procedure _Set_dsDoc3(var dsDoc3: OleVariant);
    function Get_dsDocTemp: _Recordset;
    procedure _Set_dsDocTemp(const dsDocTemp: _Recordset);
    function Get_myProperty: WideString;
    procedure Set_myProperty(const Param1: WideString);
    procedure Set_SetSelector(const Param1: WideString);
    function Get_myPowerProperty: WideString;
  public
    property DefaultInterface: _Common read GetDefaultInterface;
  published
    property myProperty: WideString read Get_myProperty write Set_myProperty;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoForm provides a Create and CreateRemote method to          
// create instances of the default interface _Form exposed by              
// the CoClass Form. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoForm = class
    class function Create: _Form;
    class function CreateRemote(const MachineName: string): _Form;
  end;

// *********************************************************************//
// The Class CoFormItem provides a Create and CreateRemote method to          
// create instances of the default interface _FormItem exposed by              
// the CoClass FormItem. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFormItem = class
    class function Create: _FormItem;
    class function CreateRemote(const MachineName: string): _FormItem;
  end;

// *********************************************************************//
// The Class CoProperties provides a Create and CreateRemote method to          
// create instances of the default interface _Properties exposed by              
// the CoClass Properties. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProperties = class
    class function Create: _Properties;
    class function CreateRemote(const MachineName: string): _Properties;
  end;

// *********************************************************************//
// The Class CoProperty_ provides a Create and CreateRemote method to          
// create instances of the default interface _Property exposed by              
// the CoClass Property_. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProperty_ = class
    class function Create: _Property;
    class function CreateRemote(const MachineName: string): _Property;
  end;

// *********************************************************************//
// The Class CoUpload provides a Create and CreateRemote method to          
// create instances of the default interface _Upload exposed by              
// the CoClass Upload. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUpload = class
    class function Create: _Upload;
    class function CreateRemote(const MachineName: string): _Upload;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TUpload
// Help String      : 
// Default Interface: _Upload
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TUploadProperties= class;
{$ENDIF}
  TUpload = class(TOleServer)
  private
    FIntf:        _Upload;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TUploadProperties;
    function      GetServerProperties: TUploadProperties;
{$ENDIF}
    function      GetDefaultInterface: _Upload;
  protected
    procedure InitServerData; override;
    function Get_Form: _Form;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Upload);
    procedure Disconnect; override;
    procedure AddLogD(var cPar: OleVariant);
    function doUploadOLD: Integer;
    function doUpload: Integer;
    function Download(const Path: WideString; const FileName: WideString): E_DOWNLOAD_RETURNVALUE;
    property DefaultInterface: _Upload read GetDefaultInterface;
    property Form: _Form read Get_Form;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TUploadProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TUpload
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TUploadProperties = class(TPersistent)
  private
    FServer:    TUpload;
    function    GetDefaultInterface: _Upload;
    constructor Create(AServer: TUpload);
  protected
    function Get_Form: _Form;
  public
    property DefaultInterface: _Upload read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoConnect1C provides a Create and CreateRemote method to          
// create instances of the default interface _Connect1C exposed by              
// the CoClass Connect1C. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoConnect1C = class
    class function Create: _Connect1C;
    class function CreateRemote(const MachineName: string): _Connect1C;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TConnect1C
// Help String      : 
// Default Interface: _Connect1C
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TConnect1CProperties= class;
{$ENDIF}
  TConnect1C = class(TOleServer)
  private
    FIntf:        _Connect1C;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TConnect1CProperties;
    function      GetServerProperties: TConnect1CProperties;
{$ENDIF}
    function      GetDefaultInterface: _Connect1C;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Connect1C);
    procedure Disconnect; override;
    procedure SFIn(const ComputerName: WideString; const BasePath: WideString; 
                   const AppType: WideString; const UserID: WideString; const Pass: WideString);
    procedure SFOut(const ComputerName: WideString; const BasePath: WideString; 
                    const AppType: WideString; const UserID: WideString; const Pass: WideString);
    property DefaultInterface: _Connect1C read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TConnect1CProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TConnect1C
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TConnect1CProperties = class(TPersistent)
  private
    FServer:    TConnect1C;
    function    GetDefaultInterface: _Connect1C;
    constructor Create(AServer: TConnect1C);
  protected
  public
    property DefaultInterface: _Connect1C read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoVB5Power provides a Create and CreateRemote method to          
// create instances of the default interface _VB5Power exposed by              
// the CoClass VB5Power. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVB5Power = class
    class function Create: _VB5Power;
    class function CreateRemote(const MachineName: string): _VB5Power;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TVB5Power
// Help String      : 
// Default Interface: _VB5Power
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TVB5PowerProperties= class;
{$ENDIF}
  TVB5Power = class(TOleServer)
  private
    FIntf:        _VB5Power;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TVB5PowerProperties;
    function      GetServerProperties: TVB5PowerProperties;
{$ENDIF}
    function      GetDefaultInterface: _VB5Power;
  protected
    procedure InitServerData; override;
    function Get_myProperty: WideString;
    procedure Set_myProperty(const Param1: WideString);
    function Get_myPowerProperty: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _VB5Power);
    procedure Disconnect; override;
    function myMethod(const myString: WideString): WideString;
    function OnStartPage(var myScriptingContext: IScriptingContext): OleVariant;
    function OnEndPage: OleVariant;
    function myPowerMethod: OleVariant;
    property DefaultInterface: _VB5Power read GetDefaultInterface;
    property myPowerProperty: WideString read Get_myPowerProperty;
    property myProperty: WideString read Get_myProperty write Set_myProperty;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TVB5PowerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TVB5Power
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TVB5PowerProperties = class(TPersistent)
  private
    FServer:    TVB5Power;
    function    GetDefaultInterface: _VB5Power;
    constructor Create(AServer: TVB5Power);
  protected
    function Get_myProperty: WideString;
    procedure Set_myProperty(const Param1: WideString);
    function Get_myPowerProperty: WideString;
  public
    property DefaultInterface: _VB5Power read GetDefaultInterface;
  published
    property myProperty: WideString read Get_myProperty write Set_myProperty;
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoCommon.Create: _Common;
begin
  Result := CreateComObject(CLASS_Common) as _Common;
end;

class function CoCommon.CreateRemote(const MachineName: string): _Common;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Common) as _Common;
end;

procedure TCommon.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{34AF9B5D-0636-4DC3-BF58-F14EF166A531}';
    IntfIID:   '{10C2B7B5-5BE2-48F7-B487-D0154AA85861}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCommon.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Common;
  end;
end;

procedure TCommon.ConnectTo(svrIntf: _Common);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCommon.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCommon.GetDefaultInterface: _Common;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCommon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCommonProperties.Create(Self);
{$ENDIF}
end;

destructor TCommon.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCommon.GetServerProperties: TCommonProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TCommon.Get_obj: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.obj;
end;

procedure TCommon.Set_obj(var obj: OleVariant);
  { Warning: The property obj has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.obj := obj;
end;

procedure TCommon._Set_obj(var obj: OleVariant);
  { Warning: The property obj has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.obj := obj;
end;

function TCommon.Get_doc: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.doc;
end;

procedure TCommon.Set_doc(var doc: OleVariant);
  { Warning: The property doc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.doc := doc;
end;

procedure TCommon._Set_doc(var doc: OleVariant);
  { Warning: The property doc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.doc := doc;
end;

function TCommon.Get_oXL: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oXL;
end;

procedure TCommon.Set_oXL(var oXL: OleVariant);
  { Warning: The property oXL has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oXL := oXL;
end;

procedure TCommon._Set_oXL(var oXL: OleVariant);
  { Warning: The property oXL has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oXL := oXL;
end;

function TCommon.Get_oWB: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oWB;
end;

procedure TCommon.Set_oWB(var oWB: OleVariant);
  { Warning: The property oWB has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oWB := oWB;
end;

procedure TCommon._Set_oWB(var oWB: OleVariant);
  { Warning: The property oWB has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oWB := oWB;
end;

function TCommon.Get_oSheet: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oSheet;
end;

procedure TCommon.Set_oSheet(var oSheet: OleVariant);
  { Warning: The property oSheet has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oSheet := oSheet;
end;

procedure TCommon._Set_oSheet(var oSheet: OleVariant);
  { Warning: The property oSheet has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oSheet := oSheet;
end;

function TCommon.Get_oRng: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oRng;
end;

procedure TCommon.Set_oRng(var oRng: OleVariant);
  { Warning: The property oRng has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oRng := oRng;
end;

procedure TCommon._Set_oRng(var oRng: OleVariant);
  { Warning: The property oRng has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oRng := oRng;
end;

function TCommon.Get_Conn: _Connection;
begin
    Result := DefaultInterface.Conn;
end;

procedure TCommon._Set_Conn(const Conn: _Connection);
  { Warning: The property Conn has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Conn := Conn;
end;

function TCommon.Get_ds: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ds;
end;

procedure TCommon.Set_ds(var ds: OleVariant);
  { Warning: The property ds has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ds := ds;
end;

procedure TCommon._Set_ds(var ds: OleVariant);
  { Warning: The property ds has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ds := ds;
end;

function TCommon.Get_dsDoc: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc;
end;

procedure TCommon.Set_dsDoc(var dsDoc: OleVariant);
  { Warning: The property dsDoc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc := dsDoc;
end;

procedure TCommon._Set_dsDoc(var dsDoc: OleVariant);
  { Warning: The property dsDoc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc := dsDoc;
end;

function TCommon.Get_dsDoc1: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc1;
end;

procedure TCommon.Set_dsDoc1(var dsDoc1: OleVariant);
  { Warning: The property dsDoc1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc1 := dsDoc1;
end;

procedure TCommon._Set_dsDoc1(var dsDoc1: OleVariant);
  { Warning: The property dsDoc1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc1 := dsDoc1;
end;

function TCommon.Get_dsDoc2: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc2;
end;

procedure TCommon.Set_dsDoc2(var dsDoc2: OleVariant);
  { Warning: The property dsDoc2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc2 := dsDoc2;
end;

procedure TCommon._Set_dsDoc2(var dsDoc2: OleVariant);
  { Warning: The property dsDoc2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc2 := dsDoc2;
end;

function TCommon.Get_dsDoc3: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc3;
end;

procedure TCommon.Set_dsDoc3(var dsDoc3: OleVariant);
  { Warning: The property dsDoc3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc3 := dsDoc3;
end;

procedure TCommon._Set_dsDoc3(var dsDoc3: OleVariant);
  { Warning: The property dsDoc3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc3 := dsDoc3;
end;

function TCommon.Get_dsDocTemp: _Recordset;
begin
    Result := DefaultInterface.dsDocTemp;
end;

procedure TCommon._Set_dsDocTemp(const dsDocTemp: _Recordset);
  { Warning: The property dsDocTemp has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDocTemp := dsDocTemp;
end;

function TCommon.Get_myProperty: WideString;
begin
    Result := DefaultInterface.myProperty;
end;

procedure TCommon.Set_myProperty(const Param1: WideString);
  { Warning: The property myProperty has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.myProperty := Param1;
end;

procedure TCommon.Set_SetSelector(const Param1: WideString);
  { Warning: The property SetSelector has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SetSelector := Param1;
end;

function TCommon.Get_myPowerProperty: WideString;
begin
    Result := DefaultInterface.myPowerProperty;
end;

function TCommon.OnStartPage(var myScriptingContext: IScriptingContext): OleVariant;
begin
  Result := DefaultInterface.OnStartPage(myScriptingContext);
end;

function TCommon.GetMDBName: OleVariant;
begin
  Result := DefaultInterface.GetMDBName;
end;

function TCommon.CheckNotForDemo: OleVariant;
begin
  Result := DefaultInterface.CheckNotForDemo;
end;

function TCommon.Random(var lowerbound: OleVariant; var upperbound: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Random(lowerbound, upperbound);
end;

function TCommon.ReadBinFile(const bfilename: WideString): OleVariant;
begin
  Result := DefaultInterface.ReadBinFile(bfilename);
end;

function TCommon.TransText(const myString: WideString): WideString;
begin
  Result := DefaultInterface.TransText(myString);
end;

function TCommon.LicCheck: OleVariant;
begin
  Result := DefaultInterface.LicCheck;
end;

function TCommon.GoProcess(const myString: WideString): WideString;
begin
  Result := DefaultInterface.GoProcess(myString);
end;

function TCommon.test(const myString: WideString): WideString;
begin
  Result := DefaultInterface.test(myString);
end;

function TCommon.OnEndPage: OleVariant;
begin
  Result := DefaultInterface.OnEndPage;
end;

procedure TCommon.ActiveX_Main;
begin
  DefaultInterface.ActiveX_Main;
end;

procedure TCommon.DoGet;
begin
  DefaultInterface.DoGet;
end;

procedure TCommon.DoPost;
begin
  DefaultInterface.DoPost;
end;

function TCommon.ToALLuni(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ToALLuni(cPar, DOCS_All);
end;

function TCommon.ToALLlocal(var cPar: OleVariant; var DOCS_All: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ToALLlocal(cPar, DOCS_All);
end;

function TCommon.GetSessionID: OleVariant;
begin
  Result := DefaultInterface.GetSessionID;
end;

procedure TCommon.Login(var VAR_StatusActiveUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                        var VAR_ExtInt: OleVariant; var DOCS_All: OleVariant; 
                        var DOCS_LOGGEDIN: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                        var DOCS_STATUSHOLD: OleVariant; var USER_Role: OleVariant; 
                        var DOCS_WRONGLOGIN: OleVariant; var DOCS_SysUser: OleVariant; 
                        var DOCS_ActionLoggedIn: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                        var DOCS_NoUsersExceeded: OleVariant; var DOCS_NoPassword: OleVariant; 
                        var USER_StatusActiveEMail: OleVariant);
begin
  DefaultInterface.Login(VAR_StatusActiveUser, VAR_AdminSecLevel, VAR_ExtInt, DOCS_All, 
                         DOCS_LOGGEDIN, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, USER_Role, 
                         DOCS_WRONGLOGIN, DOCS_SysUser, DOCS_ActionLoggedIn, VAR_BeginOfTimes, 
                         DOCS_NoUsersExceeded, DOCS_NoPassword, USER_StatusActiveEMail);
end;

procedure TCommon.GetCurrentUsers(var sUsers: OleVariant; var sTimes: OleVariant; 
                                  var sAddresses: OleVariant; var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.GetCurrentUsers(sUsers, sTimes, sAddresses, VAR_BeginOfTimes);
end;

procedure TCommon.Logout(var DOCS_LOGGEDOUT: OleVariant; var DOCS_ActionLogOut: OleVariant; 
                         var DOCS_SysUser: OleVariant);
begin
  DefaultInterface.Logout(DOCS_LOGGEDOUT, DOCS_ActionLogOut, DOCS_SysUser);
end;

function TCommon.MyInt(var dVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyInt(dVal);
end;

function TCommon.MyCStr(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyCStr(cPar);
end;

procedure TCommon.Delay(var nTicks: OleVariant);
begin
  DefaultInterface.Delay(nTicks);
end;

procedure TCommon.SendSMS(var cPhone: OleVariant; var cMessage: OleVariant; 
                          var DOCS_NOTFOUND: OleVariant; var DOCS_NOPHONECELL: OleVariant; 
                          var DOCS_WRONGPHONECELL: OleVariant; 
                          var DOCS_SMSMessagingOFF: OleVariant; 
                          var DOCS_SMSMessagingERROR: OleVariant);
begin
  DefaultInterface.SendSMS(cPhone, cMessage, DOCS_NOTFOUND, DOCS_NOPHONECELL, DOCS_WRONGPHONECELL, 
                           DOCS_SMSMessagingOFF, DOCS_SMSMessagingERROR);
end;

procedure TCommon.ShowTimes(var sMes: OleVariant; var bShowTimes: OleVariant);
begin
  DefaultInterface.ShowTimes(sMes, bShowTimes);
end;

procedure TCommon.SendSMSMessage(var bErr: OleVariant; var sMessage: OleVariant; 
                                 sPhoneNumber: OleVariant; const msg: WideString; 
                                 var nPort: OleVariant; var DOCS_SMSError: OleVariant; 
                                 var DOCS_GSMModemBusy: OleVariant; 
                                 var DOCS_WRONGPHONECELL: OleVariant; 
                                 var DOCS_GSMModemError1: OleVariant; var nDelay: OleVariant; 
                                 var nTimes: OleVariant; var nDelayTimes: OleVariant; 
                                 var bShowTimes: OleVariant);
begin
  DefaultInterface.SendSMSMessage(bErr, sMessage, sPhoneNumber, msg, nPort, DOCS_SMSError, 
                                  DOCS_GSMModemBusy, DOCS_WRONGPHONECELL, DOCS_GSMModemError1, 
                                  nDelay, nTimes, nDelayTimes, bShowTimes);
end;

function TCommon.GetCompanyName(var sDept: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetCompanyName(sDept);
end;

function TCommon.ShowStatusExtInt(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var DOCS_Int: OleVariant; var DOCS_Ext: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusExtInt(cPar, VAR_ExtInt, DOCS_Int, DOCS_Ext);
end;

function TCommon.ShowStatusArchiv(var cPar: OleVariant; var VAR_StatusArchiv: OleVariant; 
                                  var DOCS_Archiv: OleVariant; var DOCS_Current: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusArchiv(cPar, VAR_StatusArchiv, DOCS_Archiv, DOCS_Current);
end;

function TCommon.ShowStatusCompletion(var cPar: OleVariant; var VAR_StatusCompletion: OleVariant; 
                                      var VAR_StatusCancelled: OleVariant; 
                                      var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                      var DOCS_Cancelled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusCompletion(cPar, VAR_StatusCompletion, VAR_StatusCancelled, 
                                                  DOCS_Completed, DOCS_Actual, DOCS_Cancelled);
end;

function TCommon.ShowStatusPaymentDirection(var cPar: OleVariant; 
                                            var DOCS_PaymentOutgoing: OleVariant; 
                                            var DOCS_PaymentIncoming: OleVariant; 
                                            var DOCS_NotPaymentDoc: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusPaymentDirection(cPar, DOCS_PaymentOutgoing, 
                                                        DOCS_PaymentIncoming, DOCS_NotPaymentDoc);
end;

function TCommon.ShowStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                                   var DOCS_StatusPaymentToBePaid: OleVariant; 
                                   var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                   var DOCS_StatusPaymentToPay: OleVariant; 
                                   var DOCS_StatusPaymentPaid: OleVariant; 
                                   var DOCS_StatusExistsButNotDefined: OleVariant; 
                                   var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                                   var DOCS_StatusPaymentToPayPart: OleVariant; 
                                   var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                                   var DOCS_StatusPaymentPaidPart: OleVariant; 
                                   var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusPayment(cPar, DOCS_StatusPaymentNotPaid, 
                                               DOCS_StatusPaymentToBePaid, 
                                               DOCS_StatusPaymentSentToBePaid, 
                                               DOCS_StatusPaymentToPay, DOCS_StatusPaymentPaid, 
                                               DOCS_StatusExistsButNotDefined, 
                                               DOCS_StatusPaymentToBePaidPart, 
                                               DOCS_StatusPaymentToPayPart, 
                                               DOCS_StatusPaymentToPayPartRest, 
                                               DOCS_StatusPaymentPaidPart, 
                                               DOCS_StatusPaymentToPayPartPart);
end;

function TCommon.GetStatusPayment(var cPar: OleVariant; var DOCS_StatusPaymentNotPaid: OleVariant; 
                                  var DOCS_StatusPaymentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                  var DOCS_StatusPaymentToPay: OleVariant; 
                                  var DOCS_StatusPaymentPaid: OleVariant; 
                                  var DOCS_StatusExistsButNotDefined: OleVariant; 
                                  var DOCS_StatusPaymentToBePaidPart: OleVariant; 
                                  var DOCS_StatusPaymentToPayPart: OleVariant; 
                                  var DOCS_StatusPaymentToPayPartRest: OleVariant; 
                                  var DOCS_StatusPaymentPaidPart: OleVariant; 
                                  var DOCS_StatusPaymentToPayPartPart: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusPayment(cPar, DOCS_StatusPaymentNotPaid, 
                                              DOCS_StatusPaymentToBePaid, 
                                              DOCS_StatusPaymentSentToBePaid, 
                                              DOCS_StatusPaymentToPay, DOCS_StatusPaymentPaid, 
                                              DOCS_StatusExistsButNotDefined, 
                                              DOCS_StatusPaymentToBePaidPart, 
                                              DOCS_StatusPaymentToPayPart, 
                                              DOCS_StatusPaymentToPayPartRest, 
                                              DOCS_StatusPaymentPaidPart, 
                                              DOCS_StatusPaymentToPayPartPart);
end;

function TCommon.ShowBPtype(var cPar: OleVariant; var DOCS_BPTypeDaily: OleVariant; 
                            var DOCS_BPTypeWeekly: OleVariant; var DOCS_BPTypeMonthly: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowBPtype(cPar, DOCS_BPTypeDaily, DOCS_BPTypeWeekly, 
                                        DOCS_BPTypeMonthly);
end;

function TCommon.ShowStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                                   var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusTypeDoc(cPar, DOCS_Incoming, DOCS_Outgoing, DOCS_Internal);
end;

function TCommon.GetStatusTypeDoc(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                                  var DOCS_Outgoing: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusTypeDoc(cPar, DOCS_Incoming, DOCS_Outgoing);
end;

function TCommon.ShowStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                       var DOCS_Signing: OleVariant; 
                                       var DOCS_Approving: OleVariant; 
                                       var DOCS_Approved: OleVariant; 
                                       var DOCS_RefusedApp: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusDevelopment(cPar, DOCS_UnderDevelopment, DOCS_Signing, 
                                                   DOCS_Approving, DOCS_Approved, DOCS_RefusedApp);
end;

function TCommon.GetStatusDevelopment(var cPar: OleVariant; var DOCS_UnderDevelopment: OleVariant; 
                                      var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                      var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusDevelopment(cPar, DOCS_UnderDevelopment, DOCS_Signing, 
                                                  DOCS_Approving, DOCS_Approved, DOCS_RefusedApp);
end;

function TCommon.GetStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                                   var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                   var DOCS_Returned: OleVariant; 
                                   var DOCS_ReturnedFromFile: OleVariant; 
                                   var DOCS_WaitingToBeSent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusDelivery(cPar, DOCS_Sent, DOCS_Delivered, DOCS_Filed, 
                                               DOCS_Returned, DOCS_ReturnedFromFile, 
                                               DOCS_WaitingToBeSent);
end;

function TCommon.GetStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                                  var DOCS_IsExactly: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusContext(cPar, DOCS_BeginsWith, DOCS_IsExactly);
end;

function TCommon.ShowStatusContext(var cPar: OleVariant; var DOCS_BeginsWith: OleVariant; 
                                   var DOCS_IsExactly: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusContext(cPar, DOCS_BeginsWith, DOCS_IsExactly);
end;

function TCommon.ShowStatusDelivery(var cPar: OleVariant; var DOCS_Sent: OleVariant; 
                                    var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                    var DOCS_Returned: OleVariant; 
                                    var DOCS_ReturnedFromFile: OleVariant; 
                                    var DOCS_WaitingToBeSent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusDelivery(cPar, DOCS_Sent, DOCS_Delivered, DOCS_Filed, 
                                                DOCS_Returned, DOCS_ReturnedFromFile, 
                                                DOCS_WaitingToBeSent);
end;

function TCommon.ShowStatusActive(var cPar: OleVariant; var VAR_StatusActiveUser: OleVariant; 
                                  var VAR_StatusActiveUserEMail: OleVariant; 
                                  var DOCS_Yes: OleVariant; var DOCS_No: OleVariant; 
                                  var DOCS_Yes_EMail: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusActive(cPar, VAR_StatusActiveUser, 
                                              VAR_StatusActiveUserEMail, DOCS_Yes, DOCS_No, 
                                              DOCS_Yes_EMail);
end;

function TCommon.ShowStatusExtIntUser(var cPar: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var DOCS_Yes: OleVariant; var DOCS_No: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusExtIntUser(cPar, VAR_ExtInt, DOCS_Yes, DOCS_No);
end;

function TCommon.ShowStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                         var DOCS_SecurityLevel2: OleVariant; 
                                         var DOCS_SecurityLevel3: OleVariant; 
                                         var DOCS_SecurityLevel4: OleVariant; 
                                         var DOCS_SecurityLevelS: OleVariant; 
                                         var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowStatusSecurityLevel(cPar, DOCS_SecurityLevel1, 
                                                     DOCS_SecurityLevel2, DOCS_SecurityLevel3, 
                                                     DOCS_SecurityLevel4, DOCS_SecurityLevelS, 
                                                     VAR_AdminSecLevel);
end;

function TCommon.ShowSpecType(var cPar: OleVariant; var VAR_TypeVal_String: OleVariant; 
                              var VAR_TypeVal_DateTime: OleVariant; 
                              var VAR_TypeVal_NumericMoney: OleVariant; 
                              var DOCS_SpecFieldTypeString: OleVariant; 
                              var DOCS_SpecFieldTypeDate: OleVariant; 
                              var DOCS_SpecFieldTypeNumeric: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowSpecType(cPar, VAR_TypeVal_String, VAR_TypeVal_DateTime, 
                                          VAR_TypeVal_NumericMoney, DOCS_SpecFieldTypeString, 
                                          DOCS_SpecFieldTypeDate, DOCS_SpecFieldTypeNumeric);
end;

function TCommon.GetStatusSecurityLevel(var cPar: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                                        var DOCS_SecurityLevel2: OleVariant; 
                                        var DOCS_SecurityLevel3: OleVariant; 
                                        var DOCS_SecurityLevel4: OleVariant; 
                                        var DOCS_SecurityLevelS: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetStatusSecurityLevel(cPar, DOCS_SecurityLevel1, DOCS_SecurityLevel2, 
                                                    DOCS_SecurityLevel3, DOCS_SecurityLevel4, 
                                                    DOCS_SecurityLevelS, VAR_AdminSecLevel);
end;

function TCommon.MakeSQLSafe(var strInput: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MakeSQLSafe(strInput);
end;

function TCommon.FixLen(var cPar: OleVariant; var iLen: OleVariant; var sSymbol: OleVariant): OleVariant;
begin
  Result := DefaultInterface.FixLen(cPar, iLen, sSymbol);
end;

function TCommon.RightValue(var strInput: OleVariant): OleVariant;
begin
  Result := DefaultInterface.RightValue(strInput);
end;

procedure TCommon.PutMessage;
begin
  DefaultInterface.PutMessage;
end;

procedure TCommon.PutMessage1;
begin
  DefaultInterface.PutMessage1;
end;

function TCommon.NoLastBr(cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoLastBr(cPar);
end;

function TCommon.PutDirNRec(cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PutDirNRec(cPar);
end;

procedure TCommon.RedirHome;
begin
  DefaultInterface.RedirHome;
end;

procedure TCommon.RedirMessage;
begin
  DefaultInterface.RedirMessage;
end;

procedure TCommon.RedirMessage1(var cPar: OleVariant);
begin
  DefaultInterface.RedirMessage1(cPar);
end;

procedure TCommon.RedirMessage2;
begin
  DefaultInterface.RedirMessage2;
end;

procedure TCommon.RedirStopped;
begin
  DefaultInterface.RedirStopped;
end;

procedure TCommon.RedirShowDoc(var cPar: OleVariant);
begin
  DefaultInterface.RedirShowDoc(cPar);
end;

procedure TCommon.CheckReg;
begin
  DefaultInterface.CheckReg;
end;

function TCommon.CheckRegF: OleVariant;
begin
  Result := DefaultInterface.CheckRegF;
end;

procedure TCommon.CheckAdmin(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
begin
  DefaultInterface.CheckAdmin(VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.CheckIfDocIDIncomingExists(var sDocIDIncoming: OleVariant; var ds: OleVariant);
begin
  DefaultInterface.CheckIfDocIDIncomingExists(sDocIDIncoming, ds);
end;

procedure TCommon.SetIndexSearch(var rs: OleVariant; var sCATALOG: OleVariant; 
                                 var DOCS_IndexError: OleVariant; var VAR_DocsMaxRecords: OleVariant);
begin
  DefaultInterface.SetIndexSearch(rs, sCATALOG, DOCS_IndexError, VAR_DocsMaxRecords);
end;

function TCommon.CheckAdminF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckAdminF(VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.CheckAdminOrUser(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_NORight: OleVariant);
begin
  DefaultInterface.CheckAdminOrUser(dsDoc, VAR_AdminSecLevel, DOCS_NORight);
end;

function TCommon.CheckAdminOrUserF(var dsDoc: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_NORight: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckAdminOrUserF(dsDoc, VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.CheckAdminOrUser1(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
begin
  DefaultInterface.CheckAdminOrUser1(VAR_AdminSecLevel, DOCS_NORight);
end;

function TCommon.CheckAdminOrUser1F(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckAdminOrUser1F(VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.CheckAdminRead(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
begin
  DefaultInterface.CheckAdminRead(VAR_AdminSecLevel, DOCS_NORight);
end;

function TCommon.CheckAdminReadF(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckAdminReadF(VAR_AdminSecLevel, DOCS_NORight);
end;

function TCommon.GetURL(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetURL(cpage, cPar1, cvalue1);
end;

function TCommon.GetUserNFromList(var clist: OleVariant; var cnumber: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserNFromList(clist, cnumber);
end;

function TCommon.GetUserID(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserID(cPar);
end;

function TCommon.GetUserEMail(var cparUserID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserEMail(cparUserID);
end;

function TCommon.GetURL2(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                         var cPar2: OleVariant; var cvalue2: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetURL2(cpage, cPar1, cvalue1, cPar2, cvalue2);
end;

function TCommon.GetURL3(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                         var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                         var cvalue3: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetURL3(cpage, cPar1, cvalue1, cPar2, cvalue2, cpar3, cvalue3);
end;

function TCommon.GetURL4(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                         var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                         var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetURL4(cpage, cPar1, cvalue1, cPar2, cvalue2, cpar3, cvalue3, cpar4, 
                                     cvalue4);
end;

function TCommon.GetURL5(var cpage: OleVariant; var cPar1: OleVariant; var cvalue1: OleVariant; 
                         var cPar2: OleVariant; var cvalue2: OleVariant; var cpar3: OleVariant; 
                         var cvalue3: OleVariant; var cpar4: OleVariant; var cvalue4: OleVariant; 
                         var cpar5: OleVariant; var cvalue5: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetURL5(cpage, cPar1, cvalue1, cPar2, cvalue2, cpar3, cvalue3, cpar4, 
                                     cvalue4, cpar5, cvalue5);
end;

procedure TCommon.CheckReadAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                  var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.CheckReadAccess(rsTemp, DOCS_All, VAR_ExtInt, DOCS_NoReadAccess, DOCS_NoAccess, 
                                   USER_Department, VAR_AdminSecLevel);
end;

function TCommon.CheckReadAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                  var VAR_ExtInt: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckReadAccessF(rsTemp, DOCS_All, VAR_ExtInt, DOCS_NoReadAccess, 
                                              DOCS_NoAccess, USER_Department, VAR_AdminSecLevel);
end;

procedure TCommon.CheckWriteAccess(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.CheckWriteAccess(rsTemp, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                                    DOCS_LOGIN, USER_Department, VAR_ExtInt, VAR_AdminSecLevel);
end;

function TCommon.CheckWriteAccessF(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckWriteAccessF(rsTemp, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                                               DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                               VAR_AdminSecLevel);
end;

function TCommon.IsWriteAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsWriteAccess(dsDoc, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                                           DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                           VAR_AdminSecLevel);
end;

function TCommon.IsReadAccess(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                              var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                              var VAR_ExtInt: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsReadAccess(dsDoc, DOCS_All, DOCS_NoReadAccess, DOCS_NoAccess, 
                                          VAR_ExtInt);
end;

function TCommon.IsReadAccessDocID(var sDocID: OleVariant; var DOCS_All: OleVariant; 
                                   var DOCS_NoReadAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                                   var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsReadAccessDocID(sDocID, DOCS_All, DOCS_NoReadAccess, DOCS_NoAccess, 
                                               USER_Department, VAR_ExtInt, VAR_AdminSecLevel);
end;

function TCommon.IsReadAccessRS(var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsReadAccessRS(rsTemp, DOCS_All, DOCS_NoReadAccess, DOCS_NoAccess, 
                                            USER_Department, VAR_ExtInt, VAR_AdminSecLevel);
end;

function TCommon.IsReadAccessUser(var sUserID: OleVariant; var sMessage: OleVariant; 
                                  var rsTemp: OleVariant; var DOCS_All: OleVariant; 
                                  var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                                  var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; 
                                  var VAR_StatusActiveUser: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsReadAccessUser(sUserID, sMessage, rsTemp, DOCS_All, 
                                              DOCS_NoReadAccess, DOCS_NoAccess, USER_Department, 
                                              VAR_ExtInt, VAR_AdminSecLevel, VAR_StatusActiveUser);
end;

procedure TCommon.NoAccessReport(var cPar: OleVariant);
begin
  DefaultInterface.NoAccessReport(cPar);
end;

procedure TCommon.AddLog(var sDocID: OleVariant; var sAction: OleVariant; var sDocName: OleVariant);
begin
  DefaultInterface.AddLog(sDocID, sAction, sDocName);
end;

function TCommon.SafeSQL(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.SafeSQL(cPar);
end;

procedure TCommon.AddLogAmountQuantity(var sAmountDocOld: OleVariant; 
                                       var sAmountDocNew: OleVariant; 
                                       var sQuantityDocOld: OleVariant; 
                                       var sQuantityDocNew: OleVariant; var sDocID: OleVariant; 
                                       var sDocIDParent: OleVariant; var sName: OleVariant; 
                                       var DOCS_ActionChangeDocShort: OleVariant; 
                                       var DOCS_ActionChangeDoc: OleVariant; 
                                       var DOCS_ActionChangeDependantDoc: OleVariant);
begin
  DefaultInterface.AddLogAmountQuantity(sAmountDocOld, sAmountDocNew, sQuantityDocOld, 
                                        sQuantityDocNew, sDocID, sDocIDParent, sName, 
                                        DOCS_ActionChangeDocShort, DOCS_ActionChangeDoc, 
                                        DOCS_ActionChangeDependantDoc);
end;

procedure TCommon.AddLogD(var cPar: OleVariant);
begin
  DefaultInterface.AddLogD(cPar);
end;

procedure TCommon.AddLogPostcard(var cPar: OleVariant);
begin
  DefaultInterface.AddLogPostcard(cPar);
end;

procedure TCommon.AddLogDocAndParent(var sDocID: OleVariant; var sDocIDParent: OleVariant; 
                                     var sName: OleVariant; var sAmount: OleVariant; 
                                     var sQuantity: OleVariant; var sAction: OleVariant; 
                                     var DOCS_AmountDoc: OleVariant; 
                                     var DOCS_QuantityDoc: OleVariant);
begin
  DefaultInterface.AddLogDocAndParent(sDocID, sDocIDParent, sName, sAmount, sQuantity, sAction, 
                                      DOCS_AmountDoc, DOCS_QuantityDoc);
end;

function TCommon.CheckPermit(var sSource: OleVariant; var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckPermit(sSource, cPar);
end;

procedure TCommon.GetPermit(var sSource: OleVariant; var cPar: OleVariant);
begin
  DefaultInterface.GetPermit(sSource, cPar);
end;

procedure TCommon.DeletePermit(var sSource: OleVariant; var cPar: OleVariant);
begin
  DefaultInterface.DeletePermit(sSource, cPar);
end;

function TCommon.GetMiddleUniqueIdentifier(var UI1: OleVariant; var UI2: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetMiddleUniqueIdentifier(UI1, UI2);
end;

function TCommon.CorrectUniqueIdentifier(var UI: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CorrectUniqueIdentifier(UI);
end;

function TCommon.MyFormatCurrency(var rVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyFormatCurrency(rVal);
end;

function TCommon.MyFormatRate(var rVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyFormatRate(rVal);
end;

function TCommon.FormatCommon(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.FormatCommon(cPar, VAR_BeginOfTimes);
end;

function TCommon.FormatNumberShort(var rVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.FormatNumberShort(rVal);
end;

function TCommon.MyTableVal(var xVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyTableVal(xVal);
end;

function TCommon.IsTime(var dVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsTime(dVal);
end;

function TCommon.MyDateLong(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                            var DOCS_PERIOD_JAN1: OleVariant; var DOCS_PERIOD_FEB1: OleVariant; 
                            var DOCS_PERIOD_MAR1: OleVariant; var DOCS_PERIOD_APR1: OleVariant; 
                            var DOCS_PERIOD_MAY1: OleVariant; var DOCS_PERIOD_JUN1: OleVariant; 
                            var DOCS_PERIOD_JUL1: OleVariant; var DOCS_PERIOD_AUG1: OleVariant; 
                            var DOCS_PERIOD_SEP1: OleVariant; var DOCS_PERIOD_OCT1: OleVariant; 
                            var DOCS_PERIOD_NOV1: OleVariant; var DOCS_PERIOD_DEC1: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDateLong(dVal, VAR_BeginOfTimes, DOCS_PERIOD_JAN1, DOCS_PERIOD_FEB1, 
                                        DOCS_PERIOD_MAR1, DOCS_PERIOD_APR1, DOCS_PERIOD_MAY1, 
                                        DOCS_PERIOD_JUN1, DOCS_PERIOD_JUL1, DOCS_PERIOD_AUG1, 
                                        DOCS_PERIOD_SEP1, DOCS_PERIOD_OCT1, DOCS_PERIOD_NOV1, 
                                        DOCS_PERIOD_DEC1);
end;

function TCommon.MyDate(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDate(dVal, VAR_BeginOfTimes);
end;

function TCommon.MyDateTime(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDateTime(dVal, VAR_BeginOfTimes);
end;

function TCommon.MyDateShort(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDateShort(dVal, VAR_BeginOfTimes);
end;

function TCommon.MyChar(var dVal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyChar(dVal);
end;

function TCommon.MyDateBr(var dVal: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDateBr(dVal, VAR_BeginOfTimes);
end;

function TCommon.NoNull(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoNull(cPar);
end;

function TCommon.NoZeroFormat(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoZeroFormat(cPar);
end;

function TCommon.DocsDate(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.DocsDate(cPar);
end;

function TCommon.EuroDateTime(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.EuroDateTime(cPar);
end;

function TCommon.DateName(var dDate: OleVariant): OleVariant;
begin
  Result := DefaultInterface.DateName(dDate);
end;

function TCommon.UniDate(var dDate: OleVariant): OleVariant;
begin
  Result := DefaultInterface.UniDate(dDate);
end;

function TCommon.LeadZero(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.LeadZero(cPar);
end;

function TCommon.ConvertToDateOLD(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                  var DOCS_WrongDate: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ConvertToDateOLD(cPar, VAR_BeginOfTimes, DOCS_WrongDate);
end;

function TCommon.ConvertToDate(cPar: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                               var DOCS_WrongDate: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ConvertToDate(cPar, VAR_BeginOfTimes, DOCS_WrongDate);
end;

function TCommon.IsFormula(var dsDoc: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsFormula(dsDoc);
end;

function TCommon.IsAprovalRequired(dsDoc: OleVariant; var sUserID: OleVariant; 
                                   var Var_ApprovalPermitted: OleVariant; 
                                   var VAR_InActiveTask: OleVariant; 
                                   var VAR_StatusCancelled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsAprovalRequired(dsDoc, sUserID, Var_ApprovalPermitted, 
                                               VAR_InActiveTask, VAR_StatusCancelled);
end;

procedure TCommon.GetCalendarDocs(nDocs: OleVariant; var sDocs: OleVariant; nYear: OleVariant; 
                                  nMonth: OleVariant; sUserID: OleVariant; 
                                  var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                  var DOCS_NoAccess: OleVariant; var USER_Department: OleVariant; 
                                  var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_PERIOD_Date: OleVariant; 
                                  var DOCS_DocID: OleVariant; var DOCS_DocIDAdd: OleVariant; 
                                  var DOCS_DocIDParent: OleVariant; var DOCS_AmountDoc: OleVariant; 
                                  var DOCS_QuantityDoc: OleVariant; 
                                  var DOCS_PartnerName: OleVariant; 
                                  var DOCS_NameResponsible: OleVariant; 
                                  var DOCS_NameControl: OleVariant; 
                                  var DOCS_NameAproval: OleVariant; 
                                  var DOCS_ListToView: OleVariant; var DOCS_ListToEdit: OleVariant; 
                                  var DOCS_ListToReconcile: OleVariant; 
                                  var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                                  var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                                  var DOCS_NameCreation: OleVariant; 
                                  var VAR_BeginOfTimes: OleVariant; var DOCS_Incoming: OleVariant; 
                                  var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                                  var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant; 
                                  var DOCS_ListReconciled: OleVariant; 
                                  var DOCS_UnderDevelopment: OleVariant; 
                                  var DOCS_Signing: OleVariant; var DOCS_Approving: OleVariant; 
                                  var DOCS_DateCreation: OleVariant; 
                                  var DOCS_DocIDIncoming: OleVariant; 
                                  var DOCS_DateCompletion: OleVariant; 
                                  var DOCS_DateActivation: OleVariant; 
                                  var StyleCalendar: OleVariant; 
                                  var VAR_StatusCancelled: OleVariant; 
                                  var VAR_StatusCompletion: OleVariant; 
                                  var DOCS_EXPIRED2: OleVariant; var DOCS_Completed: OleVariant; 
                                  var DOCS_Cancelled2: OleVariant; var DOCS_Actual: OleVariant; 
                                  var DOCS_Cancelled: OleVariant; var VAR_InActiveTask: OleVariant; 
                                  var DOCS_Inactive: OleVariant; var DOCS_ClassDoc: OleVariant; 
                                  var Var_ApprovalPermitted: OleVariant; 
                                  var DOCS_APROVALREQUIRED: OleVariant; 
                                  var DOCS_StatusPaymentPaid: OleVariant);
begin
  DefaultInterface.GetCalendarDocs(nDocs, sDocs, nYear, nMonth, sUserID, DOCS_All, 
                                   DOCS_NoReadAccess, DOCS_NoAccess, USER_Department, VAR_ExtInt, 
                                   VAR_AdminSecLevel, DOCS_NOTFOUND, DOCS_PERIOD_Date, DOCS_DocID, 
                                   DOCS_DocIDAdd, DOCS_DocIDParent, DOCS_AmountDoc, 
                                   DOCS_QuantityDoc, DOCS_PartnerName, DOCS_NameResponsible, 
                                   DOCS_NameControl, DOCS_NameAproval, DOCS_ListToView, 
                                   DOCS_ListToEdit, DOCS_ListToReconcile, DOCS_Author, 
                                   DOCS_Correspondent, DOCS_Resolution, DOCS_History, 
                                   DOCS_NameCreation, VAR_BeginOfTimes, DOCS_Incoming, 
                                   DOCS_Outgoing, DOCS_Internal, DOCS_Approved, DOCS_RefusedApp, 
                                   DOCS_ListReconciled, DOCS_UnderDevelopment, DOCS_Signing, 
                                   DOCS_Approving, DOCS_DateCreation, DOCS_DocIDIncoming, 
                                   DOCS_DateCompletion, DOCS_DateActivation, StyleCalendar, 
                                   VAR_StatusCancelled, VAR_StatusCompletion, DOCS_EXPIRED2, 
                                   DOCS_Completed, DOCS_Cancelled2, DOCS_Actual, DOCS_Cancelled, 
                                   VAR_InActiveTask, DOCS_Inactive, DOCS_ClassDoc, 
                                   Var_ApprovalPermitted, DOCS_APROVALREQUIRED, 
                                   DOCS_StatusPaymentPaid);
end;

procedure TCommon.GetCalendarEvents(var sDocs: OleVariant; nYear: OleVariant; nMonth: OleVariant; 
                                    sUserID: OleVariant; var BGColorLight: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_DateTime: OleVariant; 
                                    var DOCS_DateTimeEnd: OleVariant; 
                                    var StyleCalendar: OleVariant; sWidth: OleVariant);
begin
  DefaultInterface.GetCalendarEvents(sDocs, nYear, nMonth, sUserID, BGColorLight, VAR_BeginOfTimes, 
                                     DOCS_DateTime, DOCS_DateTimeEnd, StyleCalendar, sWidth);
end;

function TCommon.PutEvent(iCase: OleVariant; cInfo: OleVariant; sLink: OleVariant; 
                          BGColorLight: OleVariant; StyleCalendar: OleVariant; sWidth: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PutEvent(iCase, cInfo, sLink, BGColorLight, StyleCalendar, sWidth);
end;

function TCommon.PutInfoPicture(var cInfo: OleVariant; var cPic: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PutInfoPicture(cInfo, cPic);
end;

function TCommon.GetName(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetName(cPar);
end;

function TCommon.GetFullName(var cParName: OleVariant; var cParID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetFullName(cParName, cParID);
end;

function TCommon.GetPosition(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetPosition(cPar);
end;

procedure TCommon.GetUserDetails(var cPar: OleVariant; var sName: OleVariant; 
                                 var sPhone: OleVariant; var sEMail: OleVariant; 
                                 var sICQ: OleVariant; var sDepartment: OleVariant; 
                                 var sPartnerName: OleVariant; var sPosition: OleVariant; 
                                 var sIDentification: OleVariant; var sIDNo: OleVariant; 
                                 var sIDIssuedBy: OleVariant; var dIDIssueDate: OleVariant; 
                                 var dIDExpDate: OleVariant; var dBirthDate: OleVariant; 
                                 var sCorporateIDNo: OleVariant; var sAddInfo: OleVariant; 
                                 var sComment: OleVariant);
begin
  DefaultInterface.GetUserDetails(cPar, sName, sPhone, sEMail, sICQ, sDepartment, sPartnerName, 
                                  sPosition, sIDentification, sIDNo, sIDIssuedBy, dIDIssueDate, 
                                  dIDExpDate, dBirthDate, sCorporateIDNo, sAddInfo, sComment);
end;

function TCommon.GetPositionsNames(var cPar: OleVariant; var cDel1: OleVariant; 
                                   var cDel2: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetPositionsNames(cPar, cDel1, cDel2);
end;

function TCommon.GetSuffix(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetSuffix(cPar);
end;

function TCommon.RightName(cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.RightName(cPar);
end;

function TCommon.ToEng(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ToEng(cPar);
end;

function TCommon.ToEngSMS(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ToEngSMS(cPar);
end;

function TCommon.ToTheseSymbolsOnly(var sSymbols: OleVariant; var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ToTheseSymbolsOnly(sSymbols, cPar);
end;

function TCommon.PutInString(var cPar: OleVariant; var nPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PutInString(cPar, nPar);
end;

function TCommon.GetNameAsLink(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNameAsLink(cPar);
end;

function TCommon.GetNameAsLinkGN(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNameAsLinkGN(cPar);
end;

function TCommon.GetLogin(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetLogin(cPar);
end;

function TCommon.NamesIn2ndForm(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NamesIn2ndForm(cPar);
end;

function TCommon.NamesIn3rdForm(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NamesIn3rdForm(cPar);
end;

function TCommon.NamesIn3ndForm(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NamesIn3ndForm(cPar);
end;

procedure TCommon.CreateAutoCommentGUID(var sDocID: OleVariant; var sComment: OleVariant; 
                                        var sCommentType: OleVariant; var sGUID: OleVariant);
begin
  DefaultInterface.CreateAutoCommentGUID(sDocID, sComment, sCommentType, sGUID);
end;

procedure TCommon.CreateAutoComment(var sDocID: OleVariant; var sComment: OleVariant);
begin
  DefaultInterface.CreateAutoComment(sDocID, sComment);
end;

procedure TCommon.CreateAutoCommentType(var sDocID: OleVariant; var sComment: OleVariant; 
                                        var sCommentType: OleVariant);
begin
  DefaultInterface.CreateAutoCommentType(sDocID, sComment, sCommentType);
end;

procedure TCommon.ConfirmNotification;
begin
  DefaultInterface.ConfirmNotification;
end;

function TCommon.GetCompatibleSpec(var sSpecIDs: OleVariant; var sItemNameP: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetCompatibleSpec(sSpecIDs, sItemNameP);
end;

function TCommon.ShowSpecName(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowSpecName(cPar);
end;

function TCommon.GetBusinessProcessSteps(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetBusinessProcessSteps(cPar);
end;

function TCommon.GenNewDocID(var cParDocIDOld: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GenNewDocID(cParDocIDOld);
end;

function TCommon.GenNewDocIDIncrement(var iD: OleVariant; var Var_MaxLong: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GenNewDocIDIncrement(iD, Var_MaxLong);
end;

function TCommon.NoVbCrLf(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoVbCrLf(cPar);
end;

function TCommon.GetDocDetails(var cPar: OleVariant; var bIsShowLinks: OleVariant; 
                               var cRS: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                               var DOCS_PERIOD_Date: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DocIDAdd: OleVariant; var DOCS_DocIDParent: OleVariant; 
                               var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                               var DOCS_PartnerName: OleVariant; 
                               var DOCS_NameResponsible: OleVariant; 
                               var DOCS_NameControl: OleVariant; var DOCS_NameAproval: OleVariant; 
                               var DOCS_ListToView: OleVariant; var DOCS_ListToEdit: OleVariant; 
                               var DOCS_ListToReconcile: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_History: OleVariant; var DOCS_NameCreation: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_Incoming: OleVariant; 
                               var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                               var DOCS_Approved: OleVariant; var DOCS_RefusedApp: OleVariant; 
                               var DOCS_ListReconciled: OleVariant; 
                               var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                               var DOCS_Approving: OleVariant; var DOCS_DateCreation: OleVariant; 
                               var DOCS_DocIDIncoming: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; 
                               var VAR_InActiveTask: OleVariant; var DOCS_Inactive: OleVariant; 
                               var DOCS_ClassDoc: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDocDetails(cPar, bIsShowLinks, cRS, DOCS_NOTFOUND, 
                                           DOCS_PERIOD_Date, DOCS_DocID, DOCS_DocIDAdd, 
                                           DOCS_DocIDParent, DOCS_AmountDoc, DOCS_QuantityDoc, 
                                           DOCS_PartnerName, DOCS_NameResponsible, 
                                           DOCS_NameControl, DOCS_NameAproval, DOCS_ListToView, 
                                           DOCS_ListToEdit, DOCS_ListToReconcile, DOCS_Author, 
                                           DOCS_Correspondent, DOCS_Resolution, DOCS_History, 
                                           DOCS_NameCreation, VAR_BeginOfTimes, DOCS_Incoming, 
                                           DOCS_Outgoing, DOCS_Internal, DOCS_Approved, 
                                           DOCS_RefusedApp, DOCS_ListReconciled, 
                                           DOCS_UnderDevelopment, DOCS_Signing, DOCS_Approving, 
                                           DOCS_DateCreation, DOCS_DocIDIncoming, 
                                           DOCS_DateCompletion, VAR_InActiveTask, DOCS_Inactive, 
                                           DOCS_ClassDoc);
end;

function TCommon.GetDocAmount(var cPar: OleVariant; var DOCS_Incoming: OleVariant; 
                              var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDocAmount(cPar, DOCS_Incoming, DOCS_Outgoing, DOCS_Internal);
end;

function TCommon.GetDocDateActivation(var cPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDocDateActivation(cPar, VAR_BeginOfTimes);
end;

function TCommon.GetDocName(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDocName(cPar);
end;

function TCommon.GetUserDepartment(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserDepartment(cPar);
end;

function TCommon.IsNamesCompatible(sName1: OleVariant; sName2: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsNamesCompatible(sName1, sName2);
end;

function TCommon.IsWorkingDay(var nDay: OleVariant; var nStaffTableMonth: OleVariant; 
                              var nStaffTableYear: OleVariant; var CMonths: OleVariant; 
                              var CDays: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsWorkingDay(nDay, nStaffTableMonth, nStaffTableYear, CMonths, CDays);
end;

function TCommon.ShowWeekday(var sItemName: OleVariant; var nStaffTableMonth: OleVariant; 
                             var nStaffTableYear: OleVariant; var IsHTML: OleVariant; 
                             var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                             var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                             var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                             var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                             var CMonths: OleVariant; var CDays: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowWeekday(sItemName, nStaffTableMonth, nStaffTableYear, IsHTML, 
                                         DOCS_Sunday, DOCS_Monday, DOCS_Tuesday, DOCS_Wednesday, 
                                         DOCS_Thursday, DOCS_Friday, DOCS_Saturday, nCDates, 
                                         CMonths, CDays);
end;

procedure TCommon.Out(var cPar: OleVariant);
begin
  DefaultInterface.Out(cPar);
end;

procedure TCommon.Out1(var cPar: OleVariant);
begin
  DefaultInterface.Out1(cPar);
end;

procedure TCommon.SendNotification(var cParRS: OleVariant; var cParDocID: OleVariant; 
                                   var cRecipient: OleVariant; var cSubject: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                   var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                   var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                   var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.SendNotification(cParRS, cParDocID, cRecipient, cSubject, DOCS_NOTFOUND, 
                                    DOCS_DocID, DOCS_DateActivation, DOCS_DateCompletion, 
                                    DOCS_Name, DOCS_PartnerName, DOCS_ACT, DOCS_Description, 
                                    DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                    DOCS_NotificationSentTo, DOCS_SendNotification, 
                                    DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                    DOCS_NoAccess, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                                    VAR_StatusActiveUser, VAR_BeginOfTimes, DOCS_ErrorSMTP, 
                                    DOCS_Sender, DOCS_All, DOCS_NoReadAccess, USER_Department, 
                                    VAR_ExtInt, VAR_AdminSecLevel);
end;

procedure TCommon.SendNotification1(var cParRS: OleVariant; var cParDocID: OleVariant; 
                                    var cRecipient: OleVariant; var cSubject: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                    var DOCS_DateActivation: OleVariant; 
                                    var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                    var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                    var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                    var DOCS_Correspondent: OleVariant; 
                                    var DOCS_Resolution: OleVariant; 
                                    var DOCS_NotificationSentTo: OleVariant; 
                                    var DOCS_SendNotification: OleVariant; 
                                    var DOCS_UsersNotFound: OleVariant; 
                                    var DOCS_NotificationDoc: OleVariant; 
                                    var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                    var DOCS_EXPIREDSEC: OleVariant; 
                                    var DOCS_STATUSHOLD: OleVariant; 
                                    var VAR_StatusActiveUser: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                    var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                    var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                    var DOCS_Reconciliation: OleVariant; 
                                    var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                    var MailTexts: OleVariant);
begin
  DefaultInterface.SendNotification1(cParRS, cParDocID, cRecipient, cSubject, DOCS_NOTFOUND, 
                                     DOCS_DocID, DOCS_DateActivation, DOCS_DateCompletion, 
                                     DOCS_Name, DOCS_PartnerName, DOCS_ACT, DOCS_Description, 
                                     DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                     DOCS_NotificationSentTo, DOCS_SendNotification, 
                                     DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                     DOCS_NoAccess, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                                     VAR_StatusActiveUser, VAR_BeginOfTimes, DOCS_ErrorSMTP, 
                                     DOCS_Sender, DOCS_All, DOCS_NoReadAccess, USER_Department, 
                                     VAR_ExtInt, VAR_AdminSecLevel, DOCS_FROM1, 
                                     DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                                     MailTexts);
end;

procedure TCommon.SendNotification2(var sMessageBody: OleVariant; var cParRS: OleVariant; 
                                    var cParDocID: OleVariant; var cRecipient: OleVariant; 
                                    var cSubject: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                    var DOCS_DocID: OleVariant; 
                                    var DOCS_DateActivation: OleVariant; 
                                    var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                    var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                    var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                    var DOCS_Correspondent: OleVariant; 
                                    var DOCS_Resolution: OleVariant; 
                                    var DOCS_NotificationSentTo: OleVariant; 
                                    var DOCS_SendNotification: OleVariant; 
                                    var DOCS_UsersNotFound: OleVariant; 
                                    var DOCS_NotificationDoc: OleVariant; 
                                    var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                    var DOCS_EXPIREDSEC: OleVariant; 
                                    var DOCS_STATUSHOLD: OleVariant; 
                                    var VAR_StatusActiveUser: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                    var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                    var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                    var DOCS_Reconciliation: OleVariant; 
                                    var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                    var MailTexts: OleVariant);
begin
  DefaultInterface.SendNotification2(sMessageBody, cParRS, cParDocID, cRecipient, cSubject, 
                                     DOCS_NOTFOUND, DOCS_DocID, DOCS_DateActivation, 
                                     DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                     DOCS_Description, DOCS_Author, DOCS_Correspondent, 
                                     DOCS_Resolution, DOCS_NotificationSentTo, 
                                     DOCS_SendNotification, DOCS_UsersNotFound, 
                                     DOCS_NotificationDoc, USER_NOEMail, DOCS_NoAccess, 
                                     DOCS_EXPIREDSEC, DOCS_STATUSHOLD, VAR_StatusActiveUser, 
                                     VAR_BeginOfTimes, DOCS_ErrorSMTP, DOCS_Sender, DOCS_All, 
                                     DOCS_NoReadAccess, USER_Department, VAR_ExtInt, 
                                     VAR_AdminSecLevel, DOCS_FROM1, DOCS_Reconciliation, 
                                     DOCS_NotificationNotCompletedDoc, MailTexts);
end;

function TCommon.SurnameGN(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.SurnameGN(cPar);
end;

function TCommon.IsOutNotif(var bPrint: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsOutNotif(bPrint);
end;

procedure TCommon.QueueDirectoryFiles(var sQueueDirectory: OleVariant; var Files: OleVariant);
begin
  DefaultInterface.QueueDirectoryFiles(sQueueDirectory, Files);
end;

procedure TCommon.EMailPatch1(var objMail: OleVariant);
begin
  DefaultInterface.EMailPatch1(objMail);
end;

procedure TCommon.SendNotificationCore(var sMessageBody: OleVariant; var dsTemp: OleVariant; 
                                       var sS_Description: OleVariant; var S_UserList: OleVariant; 
                                       var S_MessageSubject: OleVariant; 
                                       var S_MessageBody: OleVariant; var S_DocID: OleVariant; 
                                       var S_SecurityLevel: OleVariant; var sSend: OleVariant; 
                                       var USER_Department: OleVariant; 
                                       var DOCS_NOTFOUND: OleVariant; var DOCS_DocID: OleVariant; 
                                       var DOCS_DateActivation: OleVariant; 
                                       var DOCS_DateCompletion: OleVariant; 
                                       var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                       var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                       var DOCS_Author: OleVariant; 
                                       var DOCS_Correspondent: OleVariant; 
                                       var DOCS_Resolution: OleVariant; 
                                       var DOCS_NotificationSentTo: OleVariant; 
                                       var DOCS_SendNotification: OleVariant; 
                                       var DOCS_UsersNotFound: OleVariant; 
                                       var DOCS_NotificationDoc: OleVariant; 
                                       var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                       var DOCS_EXPIREDSEC: OleVariant; 
                                       var DOCS_STATUSHOLD: OleVariant; 
                                       var VAR_StatusActiveUser: OleVariant; 
                                       var VAR_BeginOfTimes: OleVariant; 
                                       var VAR_ExtInt: OleVariant; var DOCS_FROM1: OleVariant; 
                                       var DOCS_Reconciliation: OleVariant; 
                                       var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                       var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                       var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                       var VAR_AdminSecLevel: OleVariant; var bPrint: OleVariant; 
                                       var MailTexts: OleVariant);
begin
  DefaultInterface.SendNotificationCore(sMessageBody, dsTemp, sS_Description, S_UserList, 
                                        S_MessageSubject, S_MessageBody, S_DocID, S_SecurityLevel, 
                                        sSend, USER_Department, DOCS_NOTFOUND, DOCS_DocID, 
                                        DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                        DOCS_PartnerName, DOCS_ACT, DOCS_Description, DOCS_Author, 
                                        DOCS_Correspondent, DOCS_Resolution, 
                                        DOCS_NotificationSentTo, DOCS_SendNotification, 
                                        DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                        DOCS_NoAccess, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                                        VAR_StatusActiveUser, VAR_BeginOfTimes, VAR_ExtInt, 
                                        DOCS_FROM1, DOCS_Reconciliation, 
                                        DOCS_NotificationNotCompletedDoc, DOCS_ErrorSMTP, 
                                        DOCS_Sender, DOCS_All, DOCS_NoReadAccess, 
                                        VAR_AdminSecLevel, bPrint, MailTexts);
end;

function TCommon.GetAuthenticode(var sDocID: OleVariant; var sDateCreation: OleVariant; 
                                 var sUserID: OleVariant; var sAction: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetAuthenticode(sDocID, sDateCreation, sUserID, sAction);
end;

function TCommon.CheckAuthenticode(const sAuthenticode: WideString): OleVariant;
begin
  Result := DefaultInterface.CheckAuthenticode(sAuthenticode);
end;

function TCommon.ClickEMailOld(var cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailOld(cURL, cTitle, cButton);
end;

function TCommon.ClickEMail(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                            var cSendAction: OleVariant; var sWarning: OleVariant; 
                            var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMail(cURL, cTitle, cButton, cSendAction, sWarning, cCommand, 
                                        cAuthenticode);
end;

function TCommon.ClickEMailNot(var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailNot(cTitle, cButton);
end;

function TCommon.ClickEMailComment(cURL: OleVariant; var cTitle: OleVariant; 
                                   var cButton: OleVariant; var cSendAction: OleVariant; 
                                   var sWarning: OleVariant; var cCommand: OleVariant; 
                                   var cAuthenticode: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailComment(cURL, cTitle, cButton, cSendAction, sWarning, 
                                               cCommand, cAuthenticode);
end;

function TCommon.ClickEMailFile(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                                var cSendAction: OleVariant; var sWarning: OleVariant; 
                                var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailFile(cURL, cTitle, cButton, cSendAction, sWarning, cCommand, 
                                            cAuthenticode);
end;

function TCommon.ClickEMailNoPic(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailNoPic(cURL, cTitle, cButton);
end;

function TCommon.ClickEMailBig1(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailBig1(cURL, cTitle, cButton);
end;

function TCommon.ClickEMailBig(cURL: OleVariant; var cTitle: OleVariant; var cButton: OleVariant; 
                               var cSendAction: OleVariant; var sWarning: OleVariant; 
                               var cCommand: OleVariant; var cAuthenticode: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailBig(cURL, cTitle, cButton, cSendAction, sWarning, cCommand, 
                                           cAuthenticode);
end;

function TCommon.Status(var cName: OleVariant; var cTitle: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Status(cName, cTitle);
end;

function TCommon.Sep(var cName: OleVariant; var cTitle: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Sep(cName, cTitle);
end;

procedure TCommon.AddLogA(var sLog: OleVariant);
begin
  DefaultInterface.AddLogA(sLog);
end;

function TCommon.DOUT(var sLog: OleVariant): OleVariant;
begin
  Result := DefaultInterface.DOUT(sLog);
end;

function TCommon.ExtractMessage(const iBp: IBodyPart): IMessage;
begin
  Result := DefaultInterface.ExtractMessage(iBp);
end;

procedure TCommon.ProcessEMail(var sFile: OleVariant; var sDocID: OleVariant; 
                               var strSubject: OleVariant; var strFrom: OleVariant; 
                               var bErr: OleVariant; var sMessage: OleVariant; 
                               var Texts: OleVariant; var MailTexts: OleVariant);
begin
  DefaultInterface.ProcessEMail(sFile, sDocID, strSubject, strFrom, bErr, sMessage, Texts, MailTexts);
end;

procedure TCommon.ProcessEMailClient(var Texts: OleVariant; var MailTexts: OleVariant);
begin
  DefaultInterface.ProcessEMailClient(Texts, MailTexts);
end;

procedure TCommon.ProcessEMailClientCommand(var bDeleteFile: OleVariant; var sFile: OleVariant; 
                                            var iMsg: OleVariant; var sContent1: OleVariant; 
                                            var sAuthenticode: OleVariant; 
                                            var sMessage: OleVariant; var sUserEMail: OleVariant; 
                                            var Texts: OleVariant; var MailTexts: OleVariant; 
                                            var Var_nDaysToReconcile: OleVariant);
begin
  DefaultInterface.ProcessEMailClientCommand(bDeleteFile, sFile, iMsg, sContent1, sAuthenticode, 
                                             sMessage, sUserEMail, Texts, MailTexts, 
                                             Var_nDaysToReconcile);
end;

function TCommon.ClickEMailDocID(var sDocID: OleVariant; var cSendAction: OleVariant; 
                                 var sWarning: OleVariant; var cCommand: OleVariant; 
                                 var cAuthenticode: OleVariant; var StyleDetailValues: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ClickEMailDocID(sDocID, cSendAction, sWarning, cCommand, 
                                             cAuthenticode, StyleDetailValues);
end;

function TCommon.NoEmpty(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoEmpty(cPar);
end;

function TCommon.NotSkipThisRecord(var sAction: OleVariant; var dsDoc: OleVariant; 
                                   var VAR_StatusCompletion: OleVariant; 
                                   var VAR_StatusCancelled: OleVariant; 
                                   var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                   var DOCS_Cancelled: OleVariant; var VAR_InActiveTask: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NotSkipThisRecord(sAction, dsDoc, VAR_StatusCompletion, 
                                               VAR_StatusCancelled, DOCS_Completed, DOCS_Actual, 
                                               DOCS_Cancelled, VAR_InActiveTask);
end;

function TCommon.GetEMailPar(var sContent: OleVariant; sCommand: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetEMailPar(sContent, sCommand);
end;

function TCommon.GetEMailParDelimiter(var sContent: OleVariant; sPar: OleVariant; 
                                      sDelimiter: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetEMailParDelimiter(sContent, sPar, sDelimiter);
end;

function TCommon.GetEMailParComment(var sCont: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetEMailParComment(sCont);
end;

function TCommon.Koi2Win(var StrKOI: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Koi2Win(StrKOI);
end;

function TCommon.ShowDocRow(var cTitle: OleVariant; var cValue: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowDocRow(cTitle, cValue);
end;

function TCommon.IsValidEMail(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsValidEMail(cPar);
end;

procedure TCommon.SendPostcard(var sFile: OleVariant; var sFileMuz: OleVariant; 
                               var DOCS_PostcardSent: OleVariant; var DOCS_EMailOff: OleVariant; 
                               var DOCS_TITLEFooter: OleVariant; var DOCS_Postcard: OleVariant; 
                               var DOCS_NOEMailSender: OleVariant; 
                               var DOCS_BADEMailSender: OleVariant);
begin
  DefaultInterface.SendPostcard(sFile, sFileMuz, DOCS_PostcardSent, DOCS_EMailOff, 
                                DOCS_TITLEFooter, DOCS_Postcard, DOCS_NOEMailSender, 
                                DOCS_BADEMailSender);
end;

procedure TCommon.RunGetDocSend(var cTo: OleVariant; var cFrom: OleVariant; var cBody: OleVariant; 
                                var cSubject: OleVariant; var cBodyFormat: OleVariant; 
                                var cFile: OleVariant; var DOCS_TITLEFooter: OleVariant; 
                                var DOCS_ErrorSMTP: OleVariant);
begin
  DefaultInterface.RunGetDocSend(cTo, cFrom, cBody, cSubject, cBodyFormat, cFile, DOCS_TITLEFooter, 
                                 DOCS_ErrorSMTP);
end;

function TCommon.GetFileName(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetFileName(cPar);
end;

function TCommon.HTMLEncode(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.HTMLEncode(cPar);
end;

function TCommon.HTMLEncodeNBSP(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.HTMLEncodeNBSP(cPar);
end;

function TCommon.CRtoBR(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CRtoBR(cPar);
end;

function TCommon.CRtoBRHTMLEncode(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CRtoBRHTMLEncode(cPar);
end;

function TCommon.CRtoSeparatorHTMLEncode(var cPar: OleVariant; var cSeparator: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CRtoSeparatorHTMLEncode(cPar, cSeparator);
end;

function TCommon.SeparatorToBR(var cPar: OleVariant; var cSep: OleVariant): OleVariant;
begin
  Result := DefaultInterface.SeparatorToBR(cPar, cSep);
end;

function TCommon.SeparatorToSymbols(var cPar: OleVariant; var cSep: OleVariant; 
                                    var cSymbols: OleVariant): OleVariant;
begin
  Result := DefaultInterface.SeparatorToSymbols(cPar, cSep, cSymbols);
end;

function TCommon.BoldContext(var cPar: OleVariant; var cCon: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BoldContext(cPar, cCon);
end;

function TCommon.ShowBoldCurrentUserName(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowBoldCurrentUserName(cPar);
end;

function TCommon.CR: OleVariant;
begin
  Result := DefaultInterface.CR;
end;

procedure TCommon.ShowContextMarks(var cPar: OleVariant; var cOnlyMarks: OleVariant);
begin
  DefaultInterface.ShowContextMarks(cPar, cOnlyMarks);
end;

function TCommon.MyNumericStr(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyNumericStr(cPar);
end;

function TCommon.IsVisaNow(var sUserID: OleVariant; var sListToReconcile: OleVariant; 
                           var sListReconciled: OleVariant; var sNameApproved: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsVisaNow(sUserID, sListToReconcile, sListReconciled, sNameApproved);
end;

function TCommon.IsVisaLast(var sUserID: OleVariant; var sListReconciled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsVisaLast(sUserID, sListReconciled);
end;

function TCommon.MyTrim(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyTrim(cPar);
end;

function TCommon.MyDayName(var cPar: OleVariant; var DOCS_PERIOD_SAN: OleVariant; 
                           var DOCS_PERIOD_MON: OleVariant; var DOCS_PERIOD_TUS: OleVariant; 
                           var DOCS_PERIOD_WED: OleVariant; var DOCS_PERIOD_THU: OleVariant; 
                           var DOCS_PERIOD_FRI: OleVariant; var DOCS_PERIOD_SAT: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyDayName(cPar, DOCS_PERIOD_SAN, DOCS_PERIOD_MON, DOCS_PERIOD_TUS, 
                                       DOCS_PERIOD_WED, DOCS_PERIOD_THU, DOCS_PERIOD_FRI, 
                                       DOCS_PERIOD_SAT);
end;

function TCommon.QuarterName(var dPar: OleVariant; var DOCS_PERIOD_Quarter: OleVariant): OleVariant;
begin
  Result := DefaultInterface.QuarterName(dPar, DOCS_PERIOD_Quarter);
end;

procedure TCommon.SCORE_GetDate(var dDATEFROM: OleVariant; var dDATETO: OleVariant; 
                                var S_FirstPeriod: OleVariant; var S_PeriodType: OleVariant; 
                                var iPeriod: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                var DOCS_WrongDate: OleVariant);
begin
  DefaultInterface.SCORE_GetDate(dDATEFROM, dDATETO, S_FirstPeriod, S_PeriodType, iPeriod, 
                                 VAR_BeginOfTimes, DOCS_WrongDate);
end;

function TCommon.MyMonthName(var cPar: OleVariant; var DOCS_PERIOD_JAN: OleVariant; 
                             var DOCS_PERIOD_FEB: OleVariant; var DOCS_PERIOD_MAR: OleVariant; 
                             var DOCS_PERIOD_APR: OleVariant; var DOCS_PERIOD_MAY: OleVariant; 
                             var DOCS_PERIOD_JUN: OleVariant; var DOCS_PERIOD_JUL: OleVariant; 
                             var DOCS_PERIOD_AUG: OleVariant; var DOCS_PERIOD_SEP: OleVariant; 
                             var DOCS_PERIOD_OCT: OleVariant; var DOCS_PERIOD_NOV: OleVariant; 
                             var DOCS_PERIOD_DEC: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MyMonthName(cPar, DOCS_PERIOD_JAN, DOCS_PERIOD_FEB, DOCS_PERIOD_MAR, 
                                         DOCS_PERIOD_APR, DOCS_PERIOD_MAY, DOCS_PERIOD_JUN, 
                                         DOCS_PERIOD_JUL, DOCS_PERIOD_AUG, DOCS_PERIOD_SEP, 
                                         DOCS_PERIOD_OCT, DOCS_PERIOD_NOV, DOCS_PERIOD_DEC);
end;

function TCommon.MonthNameEng(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MonthNameEng(cPar);
end;

function TCommon.IsReconciliationComplete(var S_ListToReconcile: OleVariant; 
                                          var S_ListReconciled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsReconciliationComplete(S_ListToReconcile, S_ListReconciled);
end;

function TCommon.MarkReconciledNames(var cPar: OleVariant; var cParReconciled: OleVariant; 
                                     var DOCS_NextStepToReconcile: OleVariant; 
                                     var DOCS_Reconciled: OleVariant; var DOCS_Refused: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MarkReconciledNames(cPar, cParReconciled, DOCS_NextStepToReconcile, 
                                                 DOCS_Reconciled, DOCS_Refused);
end;

function TCommon.PutInfo(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PutInfo(cPar);
end;

function TCommon.ShowCustomerName: OleVariant;
begin
  Result := DefaultInterface.ShowCustomerName;
end;

function TCommon.InsertCommentTypeImageAsLink(var sDocID: OleVariant; var sKeyField: OleVariant; 
                                              var sSubject: OleVariant; var sComment: OleVariant; 
                                              var cParCommentType: OleVariant; 
                                              var cParSpecialInfo: OleVariant; 
                                              var cParAddress: OleVariant; 
                                              var DOCS_Contact: OleVariant; 
                                              var USER_EMail: OleVariant; 
                                              var DOCS_Phone: OleVariant; var DOCS_Fax: OleVariant; 
                                              var DOCS_Comment: OleVariant; 
                                              var DOCS_RespComment: OleVariant; 
                                              var DOCS_LocationPaper: OleVariant; 
                                              var DOCS_VersionFile: OleVariant; 
                                              var DOCS_SystemMessage: OleVariant; 
                                              var DOCS_Viewed: OleVariant; 
                                              var DOCS_News: OleVariant; 
                                              var DOCS_CreateRespComment: OleVariant): OleVariant;
begin
  Result := DefaultInterface.InsertCommentTypeImageAsLink(sDocID, sKeyField, sSubject, sComment, 
                                                          cParCommentType, cParSpecialInfo, 
                                                          cParAddress, DOCS_Contact, USER_EMail, 
                                                          DOCS_Phone, DOCS_Fax, DOCS_Comment, 
                                                          DOCS_RespComment, DOCS_LocationPaper, 
                                                          DOCS_VersionFile, DOCS_SystemMessage, 
                                                          DOCS_Viewed, DOCS_News, 
                                                          DOCS_CreateRespComment);
end;

function TCommon.InsertCommentTypeImage(var cParCommentType: OleVariant; 
                                        var cParSpecialInfo: OleVariant; 
                                        var cParAddress: OleVariant; var DOCS_Contact: OleVariant; 
                                        var USER_EMail: OleVariant; var DOCS_Phone: OleVariant; 
                                        var DOCS_Fax: OleVariant; var DOCS_Comment: OleVariant; 
                                        var DOCS_RespComment: OleVariant; 
                                        var DOCS_LocationPaper: OleVariant; 
                                        var DOCS_VersionFile: OleVariant; 
                                        var DOCS_SystemMessage: OleVariant; 
                                        var DOCS_Viewed: OleVariant; 
                                        var DOCS_PushToGet: OleVariant; 
                                        var DOCS_MSWordExcelOnServer: OleVariant): OleVariant;
begin
  Result := DefaultInterface.InsertCommentTypeImage(cParCommentType, cParSpecialInfo, cParAddress, 
                                                    DOCS_Contact, USER_EMail, DOCS_Phone, DOCS_Fax, 
                                                    DOCS_Comment, DOCS_RespComment, 
                                                    DOCS_LocationPaper, DOCS_VersionFile, 
                                                    DOCS_SystemMessage, DOCS_Viewed, 
                                                    DOCS_PushToGet, DOCS_MSWordExcelOnServer);
end;

function TCommon.GetNewUserIDsInList(var sNotificationListForListToReconcileBefore: OleVariant; 
                                     var sNotificationListForListToReconcileAfter: OleVariant; 
                                     var IsRefused: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNewUserIDsInList(sNotificationListForListToReconcileBefore, 
                                                 sNotificationListForListToReconcileAfter, IsRefused);
end;

function TCommon.GetNextUserIDInList(var sList: OleVariant; var iPos: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNextUserIDInList(sList, iPos);
end;

function TCommon.GetNotificationListForListToReconcile1(var S_ListToReconcile: OleVariant; 
                                                        var S_ListReconciled: OleVariant; 
                                                        var S_NameApproved: OleVariant; 
                                                        var S_NameAproval: OleVariant; 
                                                        var bRefused: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNotificationListForListToReconcile1(S_ListToReconcile, 
                                                                    S_ListReconciled, 
                                                                    S_NameApproved, S_NameAproval, 
                                                                    bRefused);
end;

function TCommon.GetNotificationListForListToReconcile(var S_ListToReconcile: OleVariant; 
                                                       var S_ListReconciled: OleVariant; 
                                                       var S_NameApproved: OleVariant; 
                                                       var bRefused: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNotificationListForListToReconcile(S_ListToReconcile, 
                                                                   S_ListReconciled, 
                                                                   S_NameApproved, bRefused);
end;

function TCommon.GetNotificationListForDocActivation(var dsDoc: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNotificationListForDocActivation(dsDoc);
end;

procedure TCommon.MakeDocActiveOrInactiveInList(var bActiveTask: OleVariant; 
                                                var dsDoc1: OleVariant; var bPutMes: OleVariant; 
                                                var VAR_ActiveTask: OleVariant; 
                                                var VAR_InActiveTask: OleVariant; 
                                                var VAR_BeginOfTimes: OleVariant; 
                                                var DOCS_NOTFOUND: OleVariant; 
                                                var DOCS_DocID: OleVariant; 
                                                var DOCS_DateActivation: OleVariant; 
                                                var DOCS_DateCompletion: OleVariant; 
                                                var DOCS_Name: OleVariant; 
                                                var DOCS_PartnerName: OleVariant; 
                                                var DOCS_ACT: OleVariant; 
                                                var DOCS_Description: OleVariant; 
                                                var DOCS_Author: OleVariant; 
                                                var DOCS_Correspondent: OleVariant; 
                                                var DOCS_Resolution: OleVariant; 
                                                var DOCS_NotificationSentTo: OleVariant; 
                                                var DOCS_SendNotification: OleVariant; 
                                                var DOCS_UsersNotFound: OleVariant; 
                                                var DOCS_NotificationDoc: OleVariant; 
                                                var USER_NOEMail: OleVariant; 
                                                var DOCS_NoAccess: OleVariant; 
                                                var DOCS_EXPIREDSEC: OleVariant; 
                                                var DOCS_STATUSHOLD: OleVariant; 
                                                var VAR_StatusActiveUser: OleVariant; 
                                                var DOCS_ErrorSMTP: OleVariant; 
                                                var DOCS_Sender: OleVariant; 
                                                var DOCS_All: OleVariant; 
                                                var DOCS_NoReadAccess: OleVariant; 
                                                var USER_Department: OleVariant; 
                                                var VAR_ExtInt: OleVariant; 
                                                var VAR_AdminSecLevel: OleVariant; 
                                                var DOCS_FROM1: OleVariant; 
                                                var DOCS_Reconciliation: OleVariant; 
                                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                                var MailTexts: OleVariant; 
                                                var Var_nDaysToReconcile: OleVariant);
begin
  DefaultInterface.MakeDocActiveOrInactiveInList(bActiveTask, dsDoc1, bPutMes, VAR_ActiveTask, 
                                                 VAR_InActiveTask, VAR_BeginOfTimes, DOCS_NOTFOUND, 
                                                 DOCS_DocID, DOCS_DateActivation, 
                                                 DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, 
                                                 DOCS_ACT, DOCS_Description, DOCS_Author, 
                                                 DOCS_Correspondent, DOCS_Resolution, 
                                                 DOCS_NotificationSentTo, DOCS_SendNotification, 
                                                 DOCS_UsersNotFound, DOCS_NotificationDoc, 
                                                 USER_NOEMail, DOCS_NoAccess, DOCS_EXPIREDSEC, 
                                                 DOCS_STATUSHOLD, VAR_StatusActiveUser, 
                                                 DOCS_ErrorSMTP, DOCS_Sender, DOCS_All, 
                                                 DOCS_NoReadAccess, USER_Department, VAR_ExtInt, 
                                                 VAR_AdminSecLevel, DOCS_FROM1, 
                                                 DOCS_Reconciliation, 
                                                 DOCS_NotificationNotCompletedDoc, MailTexts, 
                                                 Var_nDaysToReconcile);
end;

function TCommon.GetUserNotificationList(var sNotificationList: OleVariant; var dsDoc: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserNotificationList(sNotificationList, dsDoc);
end;

procedure TCommon.MakeDocActiveOrInactive(var sNotificationList: OleVariant; 
                                          var DOCS_All: OleVariant; 
                                          var DOCS_NoWriteAccess: OleVariant; 
                                          var DOCS_NoAccess: OleVariant; 
                                          var VAR_ExtInt: OleVariant; 
                                          var DOCS_NOTFOUND: OleVariant; 
                                          var DOCS_NORight: OleVariant; 
                                          var VAR_ActiveTask: OleVariant; 
                                          var VAR_InActiveTask: OleVariant; 
                                          var VAR_BeginOfTimes: OleVariant; 
                                          var DOCS_UnderDevelopment: OleVariant; 
                                          var DOCS_Active: OleVariant; 
                                          var DOCS_Inactive: OleVariant; 
                                          var VAR_StatusCompletion: OleVariant; 
                                          var VAR_StatusCancelled: OleVariant; 
                                          var DOCS_Completed: OleVariant; 
                                          var DOCS_Actual: OleVariant; 
                                          var DOCS_Cancelled: OleVariant; 
                                          var DOCS_Signing: OleVariant; 
                                          var DOCS_Approving: OleVariant; 
                                          var DOCS_Approved: OleVariant; 
                                          var DOCS_RefusedApp: OleVariant; 
                                          var VAR_StatusActiveUser: OleVariant; 
                                          var DOCS_DocID: OleVariant; 
                                          var DOCS_DateActivation: OleVariant; 
                                          var DOCS_DateCompletion: OleVariant; 
                                          var DOCS_Name: OleVariant; 
                                          var DOCS_PartnerName: OleVariant; 
                                          var DOCS_ACT: OleVariant; 
                                          var DOCS_Description: OleVariant; 
                                          var DOCS_Author: OleVariant; 
                                          var DOCS_Correspondent: OleVariant; 
                                          var DOCS_Resolution: OleVariant; 
                                          var DOCS_NotificationSentTo: OleVariant; 
                                          var DOCS_SendNotification: OleVariant; 
                                          var DOCS_UsersNotFound: OleVariant; 
                                          var DOCS_NotificationDoc: OleVariant; 
                                          var USER_NOEMail: OleVariant; 
                                          var DOCS_EXPIREDSEC: OleVariant; 
                                          var DOCS_STATUSHOLD: OleVariant; 
                                          var DOCS_ErrorSMTP: OleVariant; 
                                          var DOCS_Sender: OleVariant; var DOCS_LOGIN: OleVariant; 
                                          var USER_Department: OleVariant; 
                                          var VAR_AdminSecLevel: OleVariant; 
                                          var DOCS_FROM1: OleVariant; 
                                          var DOCS_Reconciliation: OleVariant; 
                                          var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                          var MailTexts: OleVariant; 
                                          var Var_nDaysToReconcile: OleVariant);
begin
  DefaultInterface.MakeDocActiveOrInactive(sNotificationList, DOCS_All, DOCS_NoWriteAccess, 
                                           DOCS_NoAccess, VAR_ExtInt, DOCS_NOTFOUND, DOCS_NORight, 
                                           VAR_ActiveTask, VAR_InActiveTask, VAR_BeginOfTimes, 
                                           DOCS_UnderDevelopment, DOCS_Active, DOCS_Inactive, 
                                           VAR_StatusCompletion, VAR_StatusCancelled, 
                                           DOCS_Completed, DOCS_Actual, DOCS_Cancelled, 
                                           DOCS_Signing, DOCS_Approving, DOCS_Approved, 
                                           DOCS_RefusedApp, VAR_StatusActiveUser, DOCS_DocID, 
                                           DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                           DOCS_PartnerName, DOCS_ACT, DOCS_Description, 
                                           DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                           DOCS_NotificationSentTo, DOCS_SendNotification, 
                                           DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                           DOCS_EXPIREDSEC, DOCS_STATUSHOLD, DOCS_ErrorSMTP, 
                                           DOCS_Sender, DOCS_LOGIN, USER_Department, 
                                           VAR_AdminSecLevel, DOCS_FROM1, DOCS_Reconciliation, 
                                           DOCS_NotificationNotCompletedDoc, MailTexts, 
                                           Var_nDaysToReconcile);
end;

procedure TCommon.CreateReconciliationComment(var dsDoc: OleVariant; 
                                              var nDaysToReconcile: OleVariant; 
                                              var DOCS_Reconciliation: OleVariant);
begin
  DefaultInterface.CreateReconciliationComment(dsDoc, nDaysToReconcile, DOCS_Reconciliation);
end;

procedure TCommon.DeleteReconciliationComments(var sDocID: OleVariant);
begin
  DefaultInterface.DeleteReconciliationComments(sDocID);
end;

procedure TCommon.DeleteReconciliationCommentsCanceled(var dsDoc: OleVariant);
begin
  DefaultInterface.DeleteReconciliationCommentsCanceled(dsDoc);
end;

procedure TCommon.UpdateReconciliationComments(var sDocID: OleVariant; var sMessage: OleVariant; 
                                               var sStatus: OleVariant; 
                                               var VAR_BeginOfTimes: OleVariant; 
                                               var DOCS_DateDiff1: OleVariant);
begin
  DefaultInterface.UpdateReconciliationComments(sDocID, sMessage, sStatus, VAR_BeginOfTimes, 
                                                DOCS_DateDiff1);
end;

procedure TCommon.ModifyPaymentStatus(var sNotificationList: OleVariant; 
                                      var DOCS_StatusPaymentNotPaid: OleVariant; 
                                      var DOCS_StatusPaymentToBePaid: OleVariant; 
                                      var DOCS_StatusPaymentSentToBePaid: OleVariant; 
                                      var DOCS_StatusPaymentToPay: OleVariant; 
                                      var DOCS_StatusPaymentPaid: OleVariant; 
                                      var DOCS_StatusExistsButNotDefined: OleVariant; 
                                      var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                      var DOCS_NoWriteAccess: OleVariant; 
                                      var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var VAR_ActiveTask: OleVariant; 
                                      var VAR_InActiveTask: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; 
                                      var DOCS_UnderDevelopment: OleVariant; 
                                      var DOCS_Active: OleVariant; var DOCS_Inactive: OleVariant; 
                                      var VAR_StatusCompletion: OleVariant; 
                                      var VAR_StatusCancelled: OleVariant; 
                                      var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                      var DOCS_Cancelled: OleVariant; var DOCS_Signing: OleVariant; 
                                      var DOCS_Approving: OleVariant; 
                                      var DOCS_Approved: OleVariant; 
                                      var DOCS_RefusedApp: OleVariant; 
                                      var VAR_StatusActiveUser: OleVariant; 
                                      var DOCS_DocID: OleVariant; 
                                      var DOCS_DateActivation: OleVariant; 
                                      var DOCS_DateCompletion: OleVariant; 
                                      var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                      var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                      var DOCS_Author: OleVariant; 
                                      var DOCS_Correspondent: OleVariant; 
                                      var DOCS_Resolution: OleVariant; 
                                      var DOCS_NotificationSentTo: OleVariant; 
                                      var DOCS_SendNotification: OleVariant; 
                                      var DOCS_UsersNotFound: OleVariant; 
                                      var DOCS_NotificationDoc: OleVariant; 
                                      var USER_NOEMail: OleVariant; 
                                      var DOCS_EXPIREDSEC: OleVariant; 
                                      var DOCS_STATUSHOLD: OleVariant; 
                                      var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                      var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_StatusAlreadyChanged: OleVariant; 
                                      var DOCS_StatusCancel: OleVariant; 
                                      var DOCS_FROM1: OleVariant; 
                                      var DOCS_Reconciliation: OleVariant; 
                                      var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                      var DOCS_StatusPaymentCancel: OleVariant; 
                                      var MailTexts: OleVariant);
begin
  DefaultInterface.ModifyPaymentStatus(sNotificationList, DOCS_StatusPaymentNotPaid, 
                                       DOCS_StatusPaymentToBePaid, DOCS_StatusPaymentSentToBePaid, 
                                       DOCS_StatusPaymentToPay, DOCS_StatusPaymentPaid, 
                                       DOCS_StatusExistsButNotDefined, DOCS_All, DOCS_NoReadAccess, 
                                       DOCS_NoWriteAccess, DOCS_NoAccess, VAR_ExtInt, 
                                       DOCS_NOTFOUND, DOCS_NORight, VAR_ActiveTask, 
                                       VAR_InActiveTask, VAR_BeginOfTimes, DOCS_UnderDevelopment, 
                                       DOCS_Active, DOCS_Inactive, VAR_StatusCompletion, 
                                       VAR_StatusCancelled, DOCS_Completed, DOCS_Actual, 
                                       DOCS_Cancelled, DOCS_Signing, DOCS_Approving, DOCS_Approved, 
                                       DOCS_RefusedApp, VAR_StatusActiveUser, DOCS_DocID, 
                                       DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                       DOCS_PartnerName, DOCS_ACT, DOCS_Description, DOCS_Author, 
                                       DOCS_Correspondent, DOCS_Resolution, 
                                       DOCS_NotificationSentTo, DOCS_SendNotification, 
                                       DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                       DOCS_EXPIREDSEC, DOCS_STATUSHOLD, DOCS_ErrorSMTP, 
                                       DOCS_Sender, DOCS_LOGIN, USER_Department, VAR_AdminSecLevel, 
                                       DOCS_StatusAlreadyChanged, DOCS_StatusCancel, DOCS_FROM1, 
                                       DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                                       DOCS_StatusPaymentCancel, MailTexts);
end;

procedure TCommon.CreateAutoCommentPayment(var sDocID: OleVariant; var sComment: OleVariant; 
                                           var sStatus: OleVariant; var sAmountPart: OleVariant; 
                                           var sAmountPart2: OleVariant; 
                                           var rAmountPart: OleVariant; var sAccount: OleVariant; 
                                           var sAccount2: OleVariant; var bIncoming: OleVariant);
begin
  DefaultInterface.CreateAutoCommentPayment(sDocID, sComment, sStatus, sAmountPart, sAmountPart2, 
                                            rAmountPart, sAccount, sAccount2, bIncoming);
end;

procedure TCommon.ModifyAccountBalance(sAccount: OleVariant; rAmount: OleVariant; 
                                       var bErr: OleVariant);
begin
  DefaultInterface.ModifyAccountBalance(sAccount, rAmount, bErr);
end;

procedure TCommon.MakeCanceled(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                               var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                               var DOCS_WrongDate: OleVariant; 
                               var VAR_StatusCompletion: OleVariant; 
                               var VAR_StatusCancelled: OleVariant; var DOCS_Cancelled: OleVariant; 
                               var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                               var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                               var DOCS_ErrorSMTP: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var DOCS_STATUSHOLD: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                               var USER_NOEMail: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                               var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                               var bUpdated: OleVariant);
begin
  DefaultInterface.MakeCanceled(sNotificationList, DOCS_NOTFOUND, DOCS_NORight, VAR_BeginOfTimes, 
                                DOCS_WrongDate, VAR_StatusCompletion, VAR_StatusCancelled, 
                                DOCS_Cancelled, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                                DOCS_LOGIN, USER_Department, VAR_ExtInt, VAR_AdminSecLevel, 
                                DOCS_NoReadAccess, DOCS_Sender, DOCS_ErrorSMTP, 
                                VAR_StatusActiveUser, DOCS_STATUSHOLD, DOCS_EXPIREDSEC, 
                                USER_NOEMail, DOCS_NotificationDoc, DOCS_UsersNotFound, 
                                DOCS_SendNotification, DOCS_NotificationSentTo, DOCS_Resolution, 
                                DOCS_Correspondent, DOCS_DocID, DOCS_DateActivation, 
                                DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                DOCS_Description, DOCS_Author, DOCS_FROM1, DOCS_Reconciliation, 
                                DOCS_NotificationNotCompletedDoc, MailTexts, bNoReDir, bUpdated);
end;

procedure TCommon.MakeCompleted(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                var DOCS_WrongDate: OleVariant; 
                                var VAR_StatusCompletion: OleVariant; 
                                var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                                var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_NoReadAccess: OleVariant; var DOCS_Sender: OleVariant; 
                                var DOCS_ErrorSMTP: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var USER_NOEMail: OleVariant; var DOCS_NotificationDoc: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_Correspondent: OleVariant; var DOCS_DocID: OleVariant; 
                                var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant; var bNoReDir: OleVariant; 
                                var bUpdated: OleVariant);
begin
  DefaultInterface.MakeCompleted(sNotificationList, DOCS_NOTFOUND, DOCS_NORight, VAR_BeginOfTimes, 
                                 DOCS_WrongDate, VAR_StatusCompletion, DOCS_Completed, DOCS_All, 
                                 DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, USER_Department, 
                                 VAR_ExtInt, VAR_AdminSecLevel, DOCS_NoReadAccess, DOCS_Sender, 
                                 DOCS_ErrorSMTP, VAR_StatusActiveUser, DOCS_STATUSHOLD, 
                                 DOCS_EXPIREDSEC, USER_NOEMail, DOCS_NotificationDoc, 
                                 DOCS_UsersNotFound, DOCS_SendNotification, 
                                 DOCS_NotificationSentTo, DOCS_Resolution, DOCS_Correspondent, 
                                 DOCS_DocID, DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                 DOCS_PartnerName, DOCS_ACT, DOCS_Description, DOCS_Author, 
                                 DOCS_FROM1, DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                                 MailTexts, bNoReDir, bUpdated);
end;

procedure TCommon.MakeRefuseCompletion(var sNotificationList: OleVariant; 
                                       var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                       var VAR_BeginOfTimes: OleVariant; 
                                       var DOCS_WrongDate: OleVariant; 
                                       var VAR_StatusCompletion: OleVariant; 
                                       var DOCS_Completed: OleVariant; var DOCS_All: OleVariant; 
                                       var DOCS_NoWriteAccess: OleVariant; 
                                       var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                       var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                       var VAR_AdminSecLevel: OleVariant; 
                                       var DOCS_NoReadAccess: OleVariant; 
                                       var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                                       var VAR_StatusActiveUser: OleVariant; 
                                       var DOCS_STATUSHOLD: OleVariant; 
                                       var DOCS_EXPIREDSEC: OleVariant; 
                                       var USER_NOEMail: OleVariant; 
                                       var DOCS_NotificationDoc: OleVariant; 
                                       var DOCS_UsersNotFound: OleVariant; 
                                       var DOCS_SendNotification: OleVariant; 
                                       var DOCS_NotificationSentTo: OleVariant; 
                                       var DOCS_Resolution: OleVariant; 
                                       var DOCS_Correspondent: OleVariant; 
                                       var DOCS_DocID: OleVariant; 
                                       var DOCS_DateActivation: OleVariant; 
                                       var DOCS_DateCompletion: OleVariant; 
                                       var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                       var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                       var DOCS_Author: OleVariant; var DOCS_FROM1: OleVariant; 
                                       var DOCS_Reconciliation: OleVariant; 
                                       var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                       var MailTexts: OleVariant; 
                                       var But_RefuseCompletion: OleVariant);
begin
  DefaultInterface.MakeRefuseCompletion(sNotificationList, DOCS_NOTFOUND, DOCS_NORight, 
                                        VAR_BeginOfTimes, DOCS_WrongDate, VAR_StatusCompletion, 
                                        DOCS_Completed, DOCS_All, DOCS_NoWriteAccess, 
                                        DOCS_NoAccess, DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                        VAR_AdminSecLevel, DOCS_NoReadAccess, DOCS_Sender, 
                                        DOCS_ErrorSMTP, VAR_StatusActiveUser, DOCS_STATUSHOLD, 
                                        DOCS_EXPIREDSEC, USER_NOEMail, DOCS_NotificationDoc, 
                                        DOCS_UsersNotFound, DOCS_SendNotification, 
                                        DOCS_NotificationSentTo, DOCS_Resolution, 
                                        DOCS_Correspondent, DOCS_DocID, DOCS_DateActivation, 
                                        DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                        DOCS_Description, DOCS_Author, DOCS_FROM1, 
                                        DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                                        MailTexts, But_RefuseCompletion);
end;

procedure TCommon.MakeSigned(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                             var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                             var VAR_StatusCompletion: OleVariant; var DOCS_Signed: OleVariant; 
                             var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                             var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                             var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                             var DOCS_Sender: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                             var VAR_StatusActiveUser: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                             var DOCS_EXPIREDSEC: OleVariant; var USER_NOEMail: OleVariant; 
                             var DOCS_NotificationDoc: OleVariant; 
                             var DOCS_UsersNotFound: OleVariant; 
                             var DOCS_SendNotification: OleVariant; 
                             var DOCS_NotificationSentTo: OleVariant; 
                             var DOCS_Resolution: OleVariant; var DOCS_Correspondent: OleVariant; 
                             var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                             var DOCS_DateSigned: OleVariant; var DOCS_Name: OleVariant; 
                             var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                             var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                             var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                             var DOCS_NotificationNotCompletedDoc: OleVariant; 
                             var MailTexts: OleVariant);
begin
  DefaultInterface.MakeSigned(DOCS_NOTFOUND, DOCS_NORight, VAR_BeginOfTimes, DOCS_WrongDate, 
                              VAR_StatusCompletion, DOCS_Signed, DOCS_All, DOCS_NoWriteAccess, 
                              DOCS_NoAccess, DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                              VAR_AdminSecLevel, DOCS_NoReadAccess, DOCS_Sender, DOCS_ErrorSMTP, 
                              VAR_StatusActiveUser, DOCS_STATUSHOLD, DOCS_EXPIREDSEC, USER_NOEMail, 
                              DOCS_NotificationDoc, DOCS_UsersNotFound, DOCS_SendNotification, 
                              DOCS_NotificationSentTo, DOCS_Resolution, DOCS_Correspondent, 
                              DOCS_DocID, DOCS_DateActivation, DOCS_DateSigned, DOCS_Name, 
                              DOCS_PartnerName, DOCS_ACT, DOCS_Description, DOCS_Author, 
                              DOCS_FROM1, DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                              MailTexts);
end;

procedure TCommon.AutoFill(var DOCS_NORight: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                           var Var_StandardWorkHours: OleVariant; var DOCS_All: OleVariant; 
                           var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                           var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                           var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                           var CMonths: OleVariant; var CDays: OleVariant);
begin
  DefaultInterface.AutoFill(DOCS_NORight, DOCS_NOTFOUND, Var_StandardWorkHours, DOCS_All, 
                            DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, USER_Department, 
                            VAR_ExtInt, VAR_AdminSecLevel, CMonths, CDays);
end;

procedure TCommon.ModifyPercent(var DOCS_PercentCompletion: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_WrongAmount: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_PercentValueWarning: OleVariant);
begin
  DefaultInterface.ModifyPercent(DOCS_PercentCompletion, DOCS_NOTFOUND, DOCS_NORight, DOCS_Changed, 
                                 DOCS_WrongAmount, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                                 DOCS_LOGIN, USER_Department, VAR_ExtInt, VAR_AdminSecLevel, 
                                 DOCS_PercentValueWarning);
end;

function TCommon.IsResponsibleOnly(var S_NameAproval: OleVariant; var S_NameCreation: OleVariant; 
                                   var S_ListToEdit: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                   var S_NameResponsible: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsResponsibleOnly(S_NameAproval, S_NameCreation, S_ListToEdit, 
                                               VAR_AdminSecLevel, S_NameResponsible);
end;

procedure TCommon.CreateAutoCommentListToEdit(var dsDocListToEdit: OleVariant; 
                                              var RequestListToEdit: OleVariant; 
                                              var sDocID: OleVariant; var DOCS_Changed: OleVariant; 
                                              var DOCS_ListToEdit: OleVariant; 
                                              var DOCS_Added: OleVariant; 
                                              var DOCS_Deleted: OleVariant);
begin
  DefaultInterface.CreateAutoCommentListToEdit(dsDocListToEdit, RequestListToEdit, sDocID, 
                                               DOCS_Changed, DOCS_ListToEdit, DOCS_Added, 
                                               DOCS_Deleted);
end;

function TCommon.IsDocIDExist(var sDocID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsDocIDExist(sDocID);
end;

procedure TCommon.ChangeDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; 
                                 var VAR_StatusCompletion: OleVariant; 
                                 var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant);
begin
  DefaultInterface.ChangeDocField(TextConsts, VAR_ExtInt, VAR_AdminSecLevel, VAR_StatusCompletion, 
                                  VAR_StatusCancelled, MailTexts);
end;

procedure TCommon.ChangeOneDocField(var TextConsts: OleVariant; var VAR_ExtInt: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var VAR_StatusCompletion: OleVariant; 
                                    var VAR_StatusCancelled: OleVariant; var MailTexts: OleVariant);
begin
  DefaultInterface.ChangeOneDocField(TextConsts, VAR_ExtInt, VAR_AdminSecLevel, 
                                     VAR_StatusCompletion, VAR_StatusCancelled, MailTexts);
end;

procedure TCommon.AddListCorrespondentRet(var DOCS_NOTFOUND: OleVariant; 
                                          var DOCS_NORight: OleVariant; 
                                          var DOCS_Changed: OleVariant; var DOCS_DocID: OleVariant; 
                                          var DOCS_DateActivation: OleVariant; 
                                          var DOCS_DateCompletion: OleVariant; 
                                          var DOCS_Name: OleVariant; 
                                          var DOCS_PartnerName: OleVariant; 
                                          var DOCS_ACT: OleVariant; 
                                          var DOCS_Description: OleVariant; 
                                          var DOCS_Author: OleVariant; 
                                          var DOCS_Correspondent: OleVariant; 
                                          var DOCS_Resolution: OleVariant; 
                                          var DOCS_NotificationSentTo: OleVariant; 
                                          var DOCS_SendNotification: OleVariant; 
                                          var DOCS_UsersNotFound: OleVariant; 
                                          var DOCS_NotificationDoc: OleVariant; 
                                          var USER_NOEMail: OleVariant; 
                                          var DOCS_NoAccess: OleVariant; 
                                          var DOCS_EXPIREDSEC: OleVariant; 
                                          var DOCS_STATUSHOLD: OleVariant; 
                                          var VAR_StatusActiveUser: OleVariant; 
                                          var VAR_BeginOfTimes: OleVariant; 
                                          var DOCS_ErrorSMTP: OleVariant; 
                                          var DOCS_Sender: OleVariant; var DOCS_All: OleVariant; 
                                          var DOCS_NoReadAccess: OleVariant; 
                                          var USER_Department: OleVariant; 
                                          var VAR_ExtInt: OleVariant; 
                                          var VAR_AdminSecLevel: OleVariant; 
                                          var DOCS_InfoAlreadyExists: OleVariant; 
                                          var DOCS_InformationNotUpdated: OleVariant; 
                                          var VAR_ActiveTask: OleVariant; 
                                          var DOCS_FROM1: OleVariant; 
                                          var DOCS_Reconciliation: OleVariant; 
                                          var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                          var MailTexts: OleVariant);
begin
  DefaultInterface.AddListCorrespondentRet(DOCS_NOTFOUND, DOCS_NORight, DOCS_Changed, DOCS_DocID, 
                                           DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                           DOCS_PartnerName, DOCS_ACT, DOCS_Description, 
                                           DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                           DOCS_NotificationSentTo, DOCS_SendNotification, 
                                           DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                           DOCS_NoAccess, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                                           VAR_StatusActiveUser, VAR_BeginOfTimes, DOCS_ErrorSMTP, 
                                           DOCS_Sender, DOCS_All, DOCS_NoReadAccess, 
                                           USER_Department, VAR_ExtInt, VAR_AdminSecLevel, 
                                           DOCS_InfoAlreadyExists, DOCS_InformationNotUpdated, 
                                           VAR_ActiveTask, DOCS_FROM1, DOCS_Reconciliation, 
                                           DOCS_NotificationNotCompletedDoc, MailTexts);
end;

procedure TCommon.MakeArchival(var sNotificationList: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_Archival: OleVariant; 
                               var DOCS_Operative: OleVariant; var VAR_StatusArchiv: OleVariant; 
                               var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                               var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant; 
                               var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                               var DOCS_Sender: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                               var DOCS_FROM1: OleVariant; var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant);
begin
  DefaultInterface.MakeArchival(sNotificationList, DOCS_NOTFOUND, DOCS_NORight, DOCS_Archival, 
                                DOCS_Operative, VAR_StatusArchiv, DOCS_All, DOCS_NoWriteAccess, 
                                DOCS_NoAccess, DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                VAR_AdminSecLevel, DOCS_Records, DOCS_DocID, DOCS_DateActivation, 
                                DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                DOCS_Description, DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                DOCS_NotificationSentTo, DOCS_SendNotification, DOCS_UsersNotFound, 
                                DOCS_NotificationDoc, USER_NOEMail, DOCS_EXPIREDSEC, 
                                DOCS_STATUSHOLD, VAR_StatusActiveUser, VAR_BeginOfTimes, 
                                DOCS_ErrorSMTP, DOCS_Sender, DOCS_NoReadAccess, DOCS_FROM1, 
                                DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, MailTexts);
end;

procedure TCommon.MakeDelivery(var DOCS_StatusDelivery: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                               var DOCS_NORight: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                               var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_Records: OleVariant; var DOCS_Sent: OleVariant; 
                               var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                               var DOCS_Returned: OleVariant; 
                               var DOCS_ReturnedFromFile: OleVariant; 
                               var DOCS_WaitingToBeSent: OleVariant; 
                               var DOCS_ReturnedToFile: OleVariant);
begin
  DefaultInterface.MakeDelivery(DOCS_StatusDelivery, DOCS_NOTFOUND, DOCS_NORight, DOCS_All, 
                                DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, USER_Department, 
                                VAR_ExtInt, VAR_AdminSecLevel, DOCS_Records, DOCS_Sent, 
                                DOCS_Delivered, DOCS_Filed, DOCS_Returned, DOCS_ReturnedFromFile, 
                                DOCS_WaitingToBeSent, DOCS_ReturnedToFile);
end;

procedure TCommon.ChangeHardCopyLocation(var bIsRedirect: OleVariant; 
                                         var sNewHardCopyLocation: OleVariant; 
                                         var sDocID: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                         var DOCS_NORight: OleVariant; var DOCS_All: OleVariant; 
                                         var DOCS_NoWriteAccess: OleVariant; 
                                         var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                         var USER_Department: OleVariant; 
                                         var VAR_ExtInt: OleVariant; 
                                         var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.ChangeHardCopyLocation(bIsRedirect, sNewHardCopyLocation, sDocID, DOCS_NOTFOUND, 
                                          DOCS_NORight, DOCS_All, DOCS_NoWriteAccess, 
                                          DOCS_NoAccess, DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                          VAR_AdminSecLevel);
end;

procedure TCommon.ChangePaperFileName(var bIsRedirect: OleVariant; var sPaperFileName: OleVariant; 
                                      var sDocID: OleVariant; var DOCS_PaperFile: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                      var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                      var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                      var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.ChangePaperFileName(bIsRedirect, sPaperFileName, sDocID, DOCS_PaperFile, 
                                       DOCS_NOTFOUND, DOCS_NORight, DOCS_All, DOCS_NoWriteAccess, 
                                       DOCS_NoAccess, DOCS_LOGIN, USER_Department, VAR_ExtInt, 
                                       VAR_AdminSecLevel);
end;

function TCommon.GetCurrentUserFullName: OleVariant;
begin
  Result := DefaultInterface.GetCurrentUserFullName;
end;

procedure TCommon.MakeRegisteredRet(var DOCS_DeliveryMethod: OleVariant; 
                                    var DOCS_PaperFile: OleVariant; var DOCS_TypeDoc: OleVariant; 
                                    var DOCS_RegLog: OleVariant; var DOCS_Author: OleVariant; 
                                    var DOCS_DocIDIncoming: OleVariant; 
                                    var DOCS_Correspondent: OleVariant; 
                                    var DOCS_Description: OleVariant; 
                                    var DOCS_NameResponsible: OleVariant; 
                                    var DOCS_Resolution: OleVariant; 
                                    var DOCS_Registered: OleVariant; 
                                    var DOCS_InformationUpdated: OleVariant; 
                                    var DOCS_InformationNotUpdated: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                    var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                    var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                    var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var DOCS_Records: OleVariant; var DOCS_Sent: OleVariant; 
                                    var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                                    var DOCS_Returned: OleVariant; 
                                    var DOCS_ReturnedFromFile: OleVariant; 
                                    var DOCS_Comment: OleVariant; var DOCS_PostType: OleVariant; 
                                    var DOCS_PostID: OleVariant; var DOCS_Recipient: OleVariant; 
                                    var DOCS_PostAddress: OleVariant; 
                                    var DOCS_DateSent: OleVariant; 
                                    var DOCS_StatusDelivery: OleVariant; 
                                    var VAR_BeginOfTimes: OleVariant; 
                                    var DOCS_WrongDate: OleVariant; 
                                    var DOCS_DateArrive: OleVariant; 
                                    var DOCS_NameAproval: OleVariant; var DOCS_Changed: OleVariant; 
                                    var DOCS_DocID: OleVariant; var DOCS_DateTime: OleVariant; 
                                    var AddFieldName1: OleVariant; var AddFieldName2: OleVariant; 
                                    var AddFieldName3: OleVariant; var AddFieldName4: OleVariant; 
                                    var AddFieldName5: OleVariant; var AddFieldName6: OleVariant);
begin
  DefaultInterface.MakeRegisteredRet(DOCS_DeliveryMethod, DOCS_PaperFile, DOCS_TypeDoc, 
                                     DOCS_RegLog, DOCS_Author, DOCS_DocIDIncoming, 
                                     DOCS_Correspondent, DOCS_Description, DOCS_NameResponsible, 
                                     DOCS_Resolution, DOCS_Registered, DOCS_InformationUpdated, 
                                     DOCS_InformationNotUpdated, DOCS_NOTFOUND, DOCS_NORight, 
                                     DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, 
                                     USER_Department, VAR_ExtInt, VAR_AdminSecLevel, DOCS_Records, 
                                     DOCS_Sent, DOCS_Delivered, DOCS_Filed, DOCS_Returned, 
                                     DOCS_ReturnedFromFile, DOCS_Comment, DOCS_PostType, 
                                     DOCS_PostID, DOCS_Recipient, DOCS_PostAddress, DOCS_DateSent, 
                                     DOCS_StatusDelivery, VAR_BeginOfTimes, DOCS_WrongDate, 
                                     DOCS_DateArrive, DOCS_NameAproval, DOCS_Changed, DOCS_DocID, 
                                     DOCS_DateTime, AddFieldName1, AddFieldName2, AddFieldName3, 
                                     AddFieldName4, AddFieldName5, AddFieldName6);
end;

procedure TCommon.CopyDoc(var DOCS_Copied: OleVariant);
begin
  DefaultInterface.CopyDoc(DOCS_Copied);
end;

procedure TCommon.ClearDocBuffer(var DOCS_BufferCleared: OleVariant);
begin
  DefaultInterface.ClearDocBuffer(DOCS_BufferCleared);
end;

procedure TCommon.ItemMove;
begin
  DefaultInterface.ItemMove;
end;

function TCommon.ShortID(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShortID(cPar);
end;

function TCommon.SBigger(var cPar1: OleVariant; var cPar2: OleVariant): OleVariant;
begin
  Result := DefaultInterface.SBigger(cPar1, cPar2);
end;

procedure TCommon.Shift(var dsDoc: OleVariant; var DOCS_All: OleVariant; 
                        var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                        var VAR_ExtInt: OleVariant; var DOCS_NORight: OleVariant; 
                        var DOCS_NOTFOUND: OleVariant; var DOCS_LOGIN: OleVariant; 
                        var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                        var Var_StandardWorkHours: OleVariant; var CMonths: OleVariant; 
                        var CDays: OleVariant);
begin
  DefaultInterface.Shift(dsDoc, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, VAR_ExtInt, 
                         DOCS_NORight, DOCS_NOTFOUND, DOCS_LOGIN, USER_Department, 
                         VAR_AdminSecLevel, Var_StandardWorkHours, CMonths, CDays);
end;

procedure TCommon.DeleteDoc(var DOCS_NOTFOUND: OleVariant; var DOCS_All: OleVariant; 
                            var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                            var VAR_ExtInt: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                            var DOCS_NORight: OleVariant; var DOCS_HASDEPENDANT: OleVariant; 
                            var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                            var DOCS_ActionDeleteDependantDoc: OleVariant; 
                            var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                            var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteDoc(DOCS_NOTFOUND, DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, 
                             VAR_ExtInt, DOCS_NORightToDelete, DOCS_NORight, DOCS_HASDEPENDANT, 
                             DOCS_AmountDoc, DOCS_QuantityDoc, DOCS_ActionDeleteDependantDoc, 
                             DOCS_ActionDeleteDoc, DOCS_Deleted, DOCS_LOGIN, USER_Department, 
                             VAR_AdminSecLevel);
end;

procedure TCommon.GetSelectRecordset(var S_ClassDoc: OleVariant; var sDataSourceName: OleVariant; 
                                     var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                     var sFieldNames: OleVariant);
begin
  DefaultInterface.GetSelectRecordset(S_ClassDoc, sDataSourceName, sDataSource, sSelectRecordset, 
                                      sFieldNames);
end;

procedure TCommon.GetRecordsetDetailsClassDoc(S_ClassDoc: OleVariant; var nDataSources: OleVariant; 
                                              var sDataSourceName: OleVariant; 
                                              var sDataSource: OleVariant; 
                                              var sSelectRecordset: OleVariant; 
                                              var sFieldNames: OleVariant; 
                                              var sKeyWords: OleVariant; 
                                              var sStatementInsert: OleVariant; 
                                              var sStatementUpdate: OleVariant; 
                                              var sStatementDelete: OleVariant; 
                                              var sGUID: OleVariant);
begin
  DefaultInterface.GetRecordsetDetailsClassDoc(S_ClassDoc, nDataSources, sDataSourceName, 
                                               sDataSource, sSelectRecordset, sFieldNames, 
                                               sKeyWords, sStatementInsert, sStatementUpdate, 
                                               sStatementDelete, sGUID);
end;

procedure TCommon.GetRecordsetDetails(var S_GUID: OleVariant; var sDataSourceName: OleVariant; 
                                      var sDataSource: OleVariant; 
                                      var sSelectRecordset: OleVariant; 
                                      var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                      var sStatementInsert: OleVariant; 
                                      var sStatementUpdate: OleVariant; 
                                      var sStatementDelete: OleVariant; var sComments: OleVariant; 
                                      var sGUID: OleVariant);
begin
  DefaultInterface.GetRecordsetDetails(S_GUID, sDataSourceName, sDataSource, sSelectRecordset, 
                                       sFieldNames, sKeyWords, sStatementInsert, sStatementUpdate, 
                                       sStatementDelete, sComments, sGUID);
end;

procedure TCommon.DeleteExtData(var nRec: OleVariant; var sStatementDelete: OleVariant; 
                                var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                                var sSelectRecordset: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                                var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                                var DOCS_ErrorDataSource: OleVariant; 
                                var DOCS_ErrorSelectRecordset: OleVariant; 
                                var DOCS_ErrorInsertPars: OleVariant; 
                                var DOCS_DeletedExt: OleVariant; var DOCS_DeletedExt1: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_All: OleVariant; 
                                var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                                var VAR_ExtInt: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                                var DOCS_NORight: OleVariant; var DOCS_HASDEPENDANT: OleVariant; 
                                var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                                var DOCS_ActionDeleteDependantDoc: OleVariant; 
                                var DOCS_ActionDeleteDoc: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_LOGIN: OleVariant; var USER_Department: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_Records: OleVariant);
begin
  DefaultInterface.DeleteExtData(nRec, sStatementDelete, sDataSourceName, sDataSource, 
                                 sSelectRecordset, VAR_BeginOfTimes, 
                                 DOCS_ErrorInUserDefinedStatement, DOCS_ErrorDataSource, 
                                 DOCS_ErrorSelectRecordset, DOCS_ErrorInsertPars, DOCS_DeletedExt, 
                                 DOCS_DeletedExt1, DOCS_NOTFOUND, DOCS_All, DOCS_NoWriteAccess, 
                                 DOCS_NoAccess, VAR_ExtInt, DOCS_NORightToDelete, DOCS_NORight, 
                                 DOCS_HASDEPENDANT, DOCS_AmountDoc, DOCS_QuantityDoc, 
                                 DOCS_ActionDeleteDependantDoc, DOCS_ActionDeleteDoc, DOCS_Deleted, 
                                 DOCS_LOGIN, USER_Department, VAR_AdminSecLevel, DOCS_Records);
end;

procedure TCommon.GetExtRecordsetOld(var ds: OleVariant; var dsDoc: OleVariant; 
                                     var bErr: OleVariant; var sMessage: OleVariant; 
                                     var sDataSource: OleVariant; sSelectRecordset: OleVariant; 
                                     var DOCS_ErrorDataSource: OleVariant; 
                                     var DOCS_ErrorSelectRecordset: OleVariant; 
                                     var DOCS_ErrorInsertPars: OleVariant; 
                                     var DOCS_ErrorSelectNotDefined: OleVariant);
begin
  DefaultInterface.GetExtRecordsetOld(ds, dsDoc, bErr, sMessage, sDataSource, sSelectRecordset, 
                                      DOCS_ErrorDataSource, DOCS_ErrorSelectRecordset, 
                                      DOCS_ErrorInsertPars, DOCS_ErrorSelectNotDefined);
end;

procedure TCommon.GetExtRecordsetArch(var ds: OleVariant; var dsDoc: OleVariant; 
                                      var bErr: OleVariant; var sMessage: OleVariant; 
                                      var sDataSource: OleVariant; 
                                      var sSelectRecordset: OleVariant; 
                                      var DOCS_ErrorDataSource: OleVariant; 
                                      var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                                      var DOCS_ErrorInsertPars: OleVariant; 
                                      var DOCS_ErrorSelectNotDefined: OleVariant);
begin
  DefaultInterface.GetExtRecordsetArch(ds, dsDoc, bErr, sMessage, sDataSource, sSelectRecordset, 
                                       DOCS_ErrorDataSource, DOCS_ErrorSelectRecordsetArch, 
                                       DOCS_ErrorInsertPars, DOCS_ErrorSelectNotDefined);
end;

procedure TCommon.GetExtRecordset(bArch: OleVariant; var ds: OleVariant; var bErr: OleVariant; 
                                  var sMessage: OleVariant; sDataSource: OleVariant; 
                                  sSelectRecordset: OleVariant; sGUID: OleVariant; 
                                  var DOCS_ErrorDataSource: OleVariant; 
                                  var DOCS_ErrorSelectRecordset: OleVariant; 
                                  var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                                  var DOCS_ErrorInsertPars: OleVariant; 
                                  var DOCS_ErrorSelectNotDefined: OleVariant);
begin
  DefaultInterface.GetExtRecordset(bArch, ds, bErr, sMessage, sDataSource, sSelectRecordset, sGUID, 
                                   DOCS_ErrorDataSource, DOCS_ErrorSelectRecordset, 
                                   DOCS_ErrorSelectRecordsetArch, DOCS_ErrorInsertPars, 
                                   DOCS_ErrorSelectNotDefined);
end;

procedure TCommon.ChangeExtData(var nRec: OleVariant; var sDataSourceName: OleVariant; 
                                var sDataSource: OleVariant; var sSelectRecordset: OleVariant; 
                                var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                var sStatement: OleVariant; var bCheckOK: OleVariant; 
                                var bErr: OleVariant; var ds: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                var DOCS_ErrorDataEdit: OleVariant; var DOCS_Error: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Changed1: OleVariant; 
                                var DOCS_Created: OleVariant; var DOCS_Created1: OleVariant; 
                                var DOCS_ErrorDataSource: OleVariant; 
                                var DOCS_ErrorInsertPars: OleVariant; 
                                var DOCS_ErrorSelectRecordset: OleVariant; 
                                var DOCS_ErrorInUserDefinedStatement: OleVariant; 
                                var DOCS_Field: OleVariant; var DOCS_WrongField: OleVariant; 
                                var DOCS_NoUpdate: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_Records: OleVariant);
begin
  DefaultInterface.ChangeExtData(nRec, sDataSourceName, sDataSource, sSelectRecordset, sFieldNames, 
                                 sKeyWords, sStatement, bCheckOK, bErr, ds, VAR_BeginOfTimes, 
                                 DOCS_WrongDate, DOCS_ErrorDataEdit, DOCS_Error, DOCS_Changed, 
                                 DOCS_Changed1, DOCS_Created, DOCS_Created1, DOCS_ErrorDataSource, 
                                 DOCS_ErrorInsertPars, DOCS_ErrorSelectRecordset, 
                                 DOCS_ErrorInUserDefinedStatement, DOCS_Field, DOCS_WrongField, 
                                 DOCS_NoUpdate, DOCS_NOTFOUND, DOCS_Records);
end;

function TCommon.InsertPars(sSelect: OleVariant; var dsDoc: OleVariant; var sErr: OleVariant): OleVariant;
begin
  Result := DefaultInterface.InsertPars(sSelect, dsDoc, sErr);
end;

function TCommon.InsertParsEval(sSelect: OleVariant; dsDoc: OleVariant; var bErr: OleVariant): OleVariant;
begin
  Result := DefaultInterface.InsertParsEval(sSelect, dsDoc, bErr);
end;

function TCommon.GetNextFieldName(var sSelect: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetNextFieldName(sSelect);
end;

function TCommon.NotViewedList(var sUserList: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NotViewedList(sUserList);
end;

function TCommon.NotAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NotAgreedList(sListToReconcile, sListReconciled);
end;

function TCommon.NotYetAgreedList(var sListToReconcile: OleVariant; var sListReconciled: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NotYetAgreedList(sListToReconcile, sListReconciled);
end;

function TCommon.GetFullUserFromList(var sList: OleVariant; var sUserID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetFullUserFromList(sList, sUserID);
end;

function TCommon.GetUserIDFromList(var sList: OleVariant; var i1: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetUserIDFromList(sList, i1);
end;

procedure TCommon.Visa(var bRedirect: OleVariant; var sNotificationList: OleVariant; 
                       var sDocID: OleVariant; var sRefuse: OleVariant; var sapp: OleVariant; 
                       var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                       var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                       var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                       var DOCS_Refused: OleVariant; var DOCS_RefusedApp: OleVariant; 
                       var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                       var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                       var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                       var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                       var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                       var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                       var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                       var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                       var DOCS_NotificationSentTo: OleVariant; 
                       var DOCS_SendNotification: OleVariant; var DOCS_UsersNotFound: OleVariant; 
                       var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                       var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                       var VAR_StatusActiveUser: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                       var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                       var DOCS_APROVAL: OleVariant; var DOCS_Visa: OleVariant; 
                       var DOCS_View: OleVariant; var DOCS_FROM1: OleVariant; 
                       var DOCS_Reconciliation: OleVariant; 
                       var DOCS_NotificationNotCompletedDoc: OleVariant; var MailTexts: OleVariant; 
                       var Var_nDaysToReconcile: OleVariant; var DOCS_DateDiff1: OleVariant);
begin
  DefaultInterface.Visa(bRedirect, sNotificationList, sDocID, sRefuse, sapp, DOCS_All, VAR_ExtInt, 
                        DOCS_NoReadAccess, DOCS_NoAccess, DOCS_NOTFOUND, DOCS_Reconciled, 
                        DOCS_Refused, DOCS_RefusedApp, DOCS_Approved, DOCS_Signing, DOCS_Approving, 
                        USER_Department, VAR_AdminSecLevel, DOCS_WrongDate, DOCS_DocID, 
                        DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, 
                        DOCS_ACT, DOCS_Description, DOCS_Author, DOCS_Correspondent, 
                        DOCS_Resolution, DOCS_NotificationSentTo, DOCS_SendNotification, 
                        DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, DOCS_EXPIREDSEC, 
                        DOCS_STATUSHOLD, VAR_StatusActiveUser, VAR_BeginOfTimes, DOCS_ErrorSMTP, 
                        DOCS_Sender, DOCS_APROVAL, DOCS_Visa, DOCS_View, DOCS_FROM1, 
                        DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, MailTexts, 
                        Var_nDaysToReconcile, DOCS_DateDiff1);
end;

procedure TCommon.VisaCancel(var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                             var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                             var DOCS_NOTFOUND: OleVariant; var DOCS_Reconciled: OleVariant; 
                             var DOCS_Cancelled: OleVariant; var DOCS_Refused: OleVariant; 
                             var DOCS_Approved: OleVariant; var DOCS_Signing: OleVariant; 
                             var DOCS_Approving: OleVariant; var USER_Department: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; var DOCS_WrongDate: OleVariant; 
                             var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                             var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                             var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                             var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                             var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                             var DOCS_NotificationSentTo: OleVariant; 
                             var DOCS_SendNotification: OleVariant; 
                             var DOCS_UsersNotFound: OleVariant; 
                             var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                             var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                             var VAR_StatusActiveUser: OleVariant; 
                             var VAR_BeginOfTimes: OleVariant; var DOCS_ErrorSMTP: OleVariant; 
                             var DOCS_Sender: OleVariant; var DOCS_APROVAL: OleVariant; 
                             var DOCS_Visa: OleVariant; var DOCS_View: OleVariant);
begin
  DefaultInterface.VisaCancel(DOCS_All, VAR_ExtInt, DOCS_NoReadAccess, DOCS_NoAccess, 
                              DOCS_NOTFOUND, DOCS_Reconciled, DOCS_Cancelled, DOCS_Refused, 
                              DOCS_Approved, DOCS_Signing, DOCS_Approving, USER_Department, 
                              VAR_AdminSecLevel, DOCS_WrongDate, DOCS_DocID, DOCS_DateActivation, 
                              DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                              DOCS_Description, DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                              DOCS_NotificationSentTo, DOCS_SendNotification, DOCS_UsersNotFound, 
                              DOCS_NotificationDoc, USER_NOEMail, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                              VAR_StatusActiveUser, VAR_BeginOfTimes, DOCS_ErrorSMTP, DOCS_Sender, 
                              DOCS_APROVAL, DOCS_Visa, DOCS_View);
end;

procedure TCommon.ReconciliationCancel(var Var_nDaysToReconcile: OleVariant; 
                                       var DOCS_AGREECancelled: OleVariant; 
                                       var DOCS_Visa: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                       var DOCS_DocID: OleVariant; 
                                       var DOCS_DateActivation: OleVariant; 
                                       var DOCS_DateCompletion: OleVariant; 
                                       var DOCS_Name: OleVariant; var DOCS_PartnerName: OleVariant; 
                                       var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                       var DOCS_Author: OleVariant; 
                                       var DOCS_Correspondent: OleVariant; 
                                       var DOCS_Resolution: OleVariant; 
                                       var DOCS_NotificationSentTo: OleVariant; 
                                       var DOCS_SendNotification: OleVariant; 
                                       var DOCS_UsersNotFound: OleVariant; 
                                       var DOCS_NotificationDoc: OleVariant; 
                                       var USER_NOEMail: OleVariant; var DOCS_NoAccess: OleVariant; 
                                       var DOCS_EXPIREDSEC: OleVariant; 
                                       var DOCS_STATUSHOLD: OleVariant; 
                                       var VAR_StatusActiveUser: OleVariant; 
                                       var VAR_BeginOfTimes: OleVariant; 
                                       var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                       var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                       var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                       var VAR_AdminSecLevel: OleVariant; 
                                       var DOCS_FROM1: OleVariant; 
                                       var DOCS_Reconciliation: OleVariant; 
                                       var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                       var MailTexts: OleVariant);
begin
  DefaultInterface.ReconciliationCancel(Var_nDaysToReconcile, DOCS_AGREECancelled, DOCS_Visa, 
                                        DOCS_NOTFOUND, DOCS_DocID, DOCS_DateActivation, 
                                        DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                        DOCS_Description, DOCS_Author, DOCS_Correspondent, 
                                        DOCS_Resolution, DOCS_NotificationSentTo, 
                                        DOCS_SendNotification, DOCS_UsersNotFound, 
                                        DOCS_NotificationDoc, USER_NOEMail, DOCS_NoAccess, 
                                        DOCS_EXPIREDSEC, DOCS_STATUSHOLD, VAR_StatusActiveUser, 
                                        VAR_BeginOfTimes, DOCS_ErrorSMTP, DOCS_Sender, DOCS_All, 
                                        DOCS_NoReadAccess, USER_Department, VAR_ExtInt, 
                                        VAR_AdminSecLevel, DOCS_FROM1, DOCS_Reconciliation, 
                                        DOCS_NotificationNotCompletedDoc, MailTexts);
end;

procedure TCommon.ShowDoc(var dsDoc: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                          var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                          var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                          var USER_Department: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.ShowDoc(dsDoc, DOCS_NOTFOUND, DOCS_All, VAR_ExtInt, DOCS_NoReadAccess, 
                           DOCS_NoAccess, USER_Department, VAR_AdminSecLevel);
end;

function TCommon.FSpec(var SxSy: OleVariant): OleVariant;
begin
  Result := DefaultInterface.FSpec(SxSy);
end;

procedure TCommon.CopySpec(var Name1: OleVariant; var Name2: OleVariant; var Conn: OleVariant; 
                           var DOC_ComplexUnits: OleVariant; var DOCS_Copied: OleVariant);
begin
  DefaultInterface.CopySpec(Name1, Name2, Conn, DOC_ComplexUnits, DOCS_Copied);
end;

procedure TCommon.CopySpecComponents(var Name1: OleVariant; var Name2: OleVariant; 
                                     var Conn: OleVariant; var DOCS_Copied: OleVariant; 
                                     var DOC_ComplexUnits: OleVariant);
begin
  DefaultInterface.CopySpecComponents(Name1, Name2, Conn, DOCS_Copied, DOC_ComplexUnits);
end;

procedure TCommon.CreateNotice(var DOCS_Notices: OleVariant; var DOCS_SecurityLevel1: OleVariant; 
                               var DOCS_SecurityLevel2: OleVariant; 
                               var DOCS_SecurityLevel3: OleVariant; 
                               var DOCS_SecurityLevel4: OleVariant; 
                               var DOCS_SecurityLevelS: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_WrongAmount: OleVariant; 
                               var DOCS_WrongQuantity: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                               var DOCS_UnderDevelopment: OleVariant; var DOCS_Signing: OleVariant; 
                               var DOCS_Approving: OleVariant; var DOCS_Approved: OleVariant; 
                               var DOCS_RefusedApp: OleVariant; var DOCS_Created: OleVariant);
begin
  DefaultInterface.CreateNotice(DOCS_Notices, DOCS_SecurityLevel1, DOCS_SecurityLevel2, 
                                DOCS_SecurityLevel3, DOCS_SecurityLevel4, DOCS_SecurityLevelS, 
                                VAR_AdminSecLevel, DOCS_WrongAmount, DOCS_WrongQuantity, 
                                VAR_BeginOfTimes, DOCS_WrongDate, DOCS_UnderDevelopment, 
                                DOCS_Signing, DOCS_Approving, DOCS_Approved, DOCS_RefusedApp, 
                                DOCS_Created);
end;

procedure TCommon.DeleteAct(var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant);
begin
  DefaultInterface.DeleteAct(VAR_AdminSecLevel, DOCS_NORight, DOCS_NOTFOUND, DOCS_Deleted);
end;

procedure TCommon.DeleteFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var DOCS_Deleted: OleVariant; var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeleteFile(DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, DOCS_ActionDeleteFile);
end;

procedure TCommon.DeleteUserPhoto(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeleteUserPhoto(DOCS_NORight, DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, 
                                   DOCS_ActionDeleteFile);
end;

procedure TCommon.DeletePartnerFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                    var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeletePartnerFile(DOCS_NORight, DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, 
                                     DOCS_ActionDeleteFile);
end;

procedure TCommon.DeleteDepartmentFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                       var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                       var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeleteDepartmentFile(DOCS_NORight, DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, 
                                        DOCS_ActionDeleteFile);
end;

procedure TCommon.DeleteTypeDocFile(var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                    var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeleteTypeDocFile(DOCS_NORight, DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, 
                                     DOCS_ActionDeleteFile);
end;

procedure TCommon.DeletePrintFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_Deleted: OleVariant; 
                                  var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeletePrintFile(DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, DOCS_ActionDeleteFile);
end;

procedure TCommon.DeleteMailListFile(var DOCS_LOGIN: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                     var DOCS_Deleted: OleVariant; 
                                     var DOCS_ActionDeleteFile: OleVariant);
begin
  DefaultInterface.DeleteMailListFile(DOCS_LOGIN, DOCS_NOTFOUND, DOCS_Deleted, DOCS_ActionDeleteFile);
end;

function TCommon.IsClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsClassDocIDParent(S_DocIDParent);
end;

function TCommon.DocIDParentFromClassDocIDParent(var S_DocIDParent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.DocIDParentFromClassDocIDParent(S_DocIDParent);
end;

function TCommon.NoPars(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoPars(cPar);
end;

procedure TCommon.FormingSQL(var dsDoc: OleVariant; var sClassDocParent: OleVariant; 
                             var sPartnerNameParent: OleVariant; 
                             var sNameResponsibleParent: OleVariant; var Specs: OleVariant; 
                             var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                             var bSpec: OleVariant; var bDateActivation: OleVariant; 
                             var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                             var sDetailes: OleVariant; var S_OrderBy1: OleVariant; 
                             var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                             var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                             var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                             var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant; 
                             var sDateOrder: OleVariant; var sDateOrder2: OleVariant; 
                             var sDateOrder3: OleVariant; var VAR_StatusArchiv: OleVariant; 
                             var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                             var DOCS_ListToReconcile: OleVariant; 
                             var DOCS_NameResponsible: OleVariant; 
                             var DOCS_NameAproval: OleVariant; var USER_Name: OleVariant; 
                             var DOCS_Department: OleVariant; var DOCS_Name: OleVariant; 
                             var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                             var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                             var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                             var VAR_ExtInt: OleVariant; var DOCS_PartnerName: OleVariant; 
                             var Consts: OleVariant; var Periods: OleVariant; 
                             var Statuses: OleVariant; var VAR_StatusExpired: OleVariant; 
                             var DOCS_IsExactly: OleVariant; var DOCS_BeginsWith: OleVariant; 
                             var DOCS_Sent: OleVariant; var DOCS_Delivered: OleVariant; 
                             var DOCS_Filed: OleVariant; var DOCS_Returned: OleVariant; 
                             var DOCS_ReturnedFromFile: OleVariant; 
                             var DOCS_WaitingToBeSent: OleVariant; 
                             var DOCS_ClassDocParent: OleVariant);
begin
  DefaultInterface.FormingSQL(dsDoc, sClassDocParent, sPartnerNameParent, sNameResponsibleParent, 
                              Specs, sSQL, sSQL_IncomingSaldo, bSpec, bDateActivation, 
                              bIncomingSaldo, bDetailed, sDetailes, S_OrderBy1, S_OrderBy2, 
                              S_OrderBy3, S_OrderBy1Sort, S_OrderBy2Sort, S_OrderBy3Sort, 
                              S_OrderBy1Ch, S_OrderBy2Ch, S_OrderBy3Ch, sDateOrder, sDateOrder2, 
                              sDateOrder3, VAR_StatusArchiv, DOCS_DocID, DOCS_DocIDParent, 
                              DOCS_ListToReconcile, DOCS_NameResponsible, DOCS_NameAproval, 
                              USER_Name, DOCS_Department, DOCS_Name, DOCS_ACT, DOCS_Description, 
                              DOCS_Author, DOCS_Correspondent, DOCS_Resolution, DOCS_History, 
                              VAR_ExtInt, DOCS_PartnerName, Consts, Periods, Statuses, 
                              VAR_StatusExpired, DOCS_IsExactly, DOCS_BeginsWith, DOCS_Sent, 
                              DOCS_Delivered, DOCS_Filed, DOCS_Returned, DOCS_ReturnedFromFile, 
                              DOCS_WaitingToBeSent, DOCS_ClassDocParent);
end;

procedure TCommon.GetSQLDate(var sSQLDate: OleVariant; var sDetailesDate: OleVariant; 
                             var sYear: OleVariant; var sDate: OleVariant; var sField: OleVariant; 
                             var sFieldName: OleVariant; var Periods: OleVariant);
begin
  DefaultInterface.GetSQLDate(sSQLDate, sDetailesDate, sYear, sDate, sField, sFieldName, Periods);
end;

procedure TCommon.RequestCompleted(var dsDoc: OleVariant; var sDocIDpar: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                   var VAR_StatusRequestCompletion: OleVariant; 
                                   var DOCS_RequestedCompleted: OleVariant; 
                                   var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                   var DOCS_NoAccess: OleVariant; var VAR_ExtInt: OleVariant; 
                                   var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                                   var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                   var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                   var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                   var DOCS_Correspondent: OleVariant; 
                                   var DOCS_Resolution: OleVariant; 
                                   var DOCS_NotificationSentTo: OleVariant; 
                                   var DOCS_SendNotification: OleVariant; 
                                   var DOCS_UsersNotFound: OleVariant; 
                                   var DOCS_NotificationDoc: OleVariant; 
                                   var USER_NOEMail: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                   var DOCS_STATUSHOLD: OleVariant; 
                                   var VAR_StatusActiveUser: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var USER_Department: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; 
                                   var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                   var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                                   var DOCS_Reconciliation: OleVariant; 
                                   var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                   var MailTexts: OleVariant);
begin
  DefaultInterface.RequestCompleted(dsDoc, sDocIDpar, DOCS_NOTFOUND, DOCS_NORight, 
                                    VAR_StatusRequestCompletion, DOCS_RequestedCompleted, DOCS_All, 
                                    DOCS_NoWriteAccess, DOCS_NoAccess, VAR_ExtInt, DOCS_DocID, 
                                    DOCS_DateActivation, DOCS_DateCompletion, DOCS_Name, 
                                    DOCS_PartnerName, DOCS_ACT, DOCS_Description, DOCS_Author, 
                                    DOCS_Correspondent, DOCS_Resolution, DOCS_NotificationSentTo, 
                                    DOCS_SendNotification, DOCS_UsersNotFound, 
                                    DOCS_NotificationDoc, USER_NOEMail, DOCS_EXPIREDSEC, 
                                    DOCS_STATUSHOLD, VAR_StatusActiveUser, VAR_BeginOfTimes, 
                                    DOCS_LOGIN, USER_Department, VAR_AdminSecLevel, DOCS_ErrorSMTP, 
                                    DOCS_Sender, DOCS_NoReadAccess, DOCS_FROM1, 
                                    DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, MailTexts);
end;

function TCommon.IsDateInMonitorRange(var dPar: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsDateInMonitorRange(dPar, VAR_BeginOfTimes);
end;

procedure TCommon.CheckLicense(var sCompany: OleVariant; var bOK: OleVariant; 
                               var DOCS_DEMO_MODE: OleVariant; 
                               var DOCS_CopyrightWarning: OleVariant; var DOCS_Error: OleVariant);
begin
  DefaultInterface.CheckLicense(sCompany, bOK, DOCS_DEMO_MODE, DOCS_CopyrightWarning, DOCS_Error);
end;

procedure TCommon.ListRegLogDocs(var sSQL: OleVariant; var S_TitleSearchCriteria: OleVariant; 
                                 var DOCS_PERIOD_THISM: OleVariant; 
                                 var DOCS_PERIOD_PREVM: OleVariant; 
                                 var DOCS_PERIOD_1QUARTER: OleVariant; 
                                 var DOCS_PERIOD_2QUARTER: OleVariant; 
                                 var DOCS_PERIOD_3QUARTER: OleVariant; 
                                 var DOCS_PERIOD_4QUARTER: OleVariant; 
                                 var DOCS_PERIOD_JAN: OleVariant; var DOCS_PERIOD_FEB: OleVariant; 
                                 var DOCS_PERIOD_MAR: OleVariant; var DOCS_PERIOD_APR: OleVariant; 
                                 var DOCS_PERIOD_MAY: OleVariant; var DOCS_PERIOD_JUN: OleVariant; 
                                 var OCS_PERIOD_JUL: OleVariant; var DOCS_PERIOD_AUG: OleVariant; 
                                 var DOCS_PERIOD_SEP: OleVariant; var DOCS_PERIOD_OCT: OleVariant; 
                                 var DOCS_PERIOD_NOV: OleVariant; var DOCS_PERIOD_DEC: OleVariant; 
                                 var DOCS_PERIOD_THISY: OleVariant; 
                                 var DOCS_PERIOD_PREVY: OleVariant; var DOCS_PERIOD: OleVariant; 
                                 var DOCS_PERIOD_YEAR: OleVariant; 
                                 var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                 var DOCS_FROM_Date: OleVariant; var DOCS_TO_Date: OleVariant; 
                                 var DOCS_PERIOD_Date: OleVariant; 
                                 var VAR_DocsMaxRecords: OleVariant);
begin
  DefaultInterface.ListRegLogDocs(sSQL, S_TitleSearchCriteria, DOCS_PERIOD_THISM, 
                                  DOCS_PERIOD_PREVM, DOCS_PERIOD_1QUARTER, DOCS_PERIOD_2QUARTER, 
                                  DOCS_PERIOD_3QUARTER, DOCS_PERIOD_4QUARTER, DOCS_PERIOD_JAN, 
                                  DOCS_PERIOD_FEB, DOCS_PERIOD_MAR, DOCS_PERIOD_APR, 
                                  DOCS_PERIOD_MAY, DOCS_PERIOD_JUN, OCS_PERIOD_JUL, 
                                  DOCS_PERIOD_AUG, DOCS_PERIOD_SEP, DOCS_PERIOD_OCT, 
                                  DOCS_PERIOD_NOV, DOCS_PERIOD_DEC, DOCS_PERIOD_THISY, 
                                  DOCS_PERIOD_PREVY, DOCS_PERIOD, DOCS_PERIOD_YEAR, 
                                  VAR_BeginOfTimes, DOCS_WrongDate, DOCS_FROM_Date, DOCS_TO_Date, 
                                  DOCS_PERIOD_Date, VAR_DocsMaxRecords);
end;

procedure TCommon.ListPaperFileRegistry(var sSQL: OleVariant; 
                                        var S_TitleSearchCriteria: OleVariant; 
                                        var DOCS_PERIOD_THISM: OleVariant; 
                                        var DOCS_PERIOD_PREVM: OleVariant; 
                                        var DOCS_PERIOD_1QUARTER: OleVariant; 
                                        var DOCS_PERIOD_2QUARTER: OleVariant; 
                                        var DOCS_PERIOD_3QUARTER: OleVariant; 
                                        var DOCS_PERIOD_4QUARTER: OleVariant; 
                                        var DOCS_PERIOD_JAN: OleVariant; 
                                        var DOCS_PERIOD_FEB: OleVariant; 
                                        var DOCS_PERIOD_MAR: OleVariant; 
                                        var DOCS_PERIOD_APR: OleVariant; 
                                        var DOCS_PERIOD_MAY: OleVariant; 
                                        var DOCS_PERIOD_JUN: OleVariant; 
                                        var OCS_PERIOD_JUL: OleVariant; 
                                        var DOCS_PERIOD_AUG: OleVariant; 
                                        var DOCS_PERIOD_SEP: OleVariant; 
                                        var DOCS_PERIOD_OCT: OleVariant; 
                                        var DOCS_PERIOD_NOV: OleVariant; 
                                        var DOCS_PERIOD_DEC: OleVariant; 
                                        var DOCS_PERIOD_THISY: OleVariant; 
                                        var DOCS_PERIOD_PREVY: OleVariant; 
                                        var DOCS_PERIOD: OleVariant; 
                                        var DOCS_PERIOD_YEAR: OleVariant; 
                                        var VAR_BeginOfTimes: OleVariant; 
                                        var DOCS_WrongDate: OleVariant; 
                                        var DOCS_FROM_Date: OleVariant; 
                                        var DOCS_TO_Date: OleVariant; 
                                        var DOCS_PERIOD_Date: OleVariant; 
                                        var VAR_DocsMaxRecords: OleVariant);
begin
  DefaultInterface.ListPaperFileRegistry(sSQL, S_TitleSearchCriteria, DOCS_PERIOD_THISM, 
                                         DOCS_PERIOD_PREVM, DOCS_PERIOD_1QUARTER, 
                                         DOCS_PERIOD_2QUARTER, DOCS_PERIOD_3QUARTER, 
                                         DOCS_PERIOD_4QUARTER, DOCS_PERIOD_JAN, DOCS_PERIOD_FEB, 
                                         DOCS_PERIOD_MAR, DOCS_PERIOD_APR, DOCS_PERIOD_MAY, 
                                         DOCS_PERIOD_JUN, OCS_PERIOD_JUL, DOCS_PERIOD_AUG, 
                                         DOCS_PERIOD_SEP, DOCS_PERIOD_OCT, DOCS_PERIOD_NOV, 
                                         DOCS_PERIOD_DEC, DOCS_PERIOD_THISY, DOCS_PERIOD_PREVY, 
                                         DOCS_PERIOD, DOCS_PERIOD_YEAR, VAR_BeginOfTimes, 
                                         DOCS_WrongDate, DOCS_FROM_Date, DOCS_TO_Date, 
                                         DOCS_PERIOD_Date, VAR_DocsMaxRecords);
end;

procedure TCommon.ClearSearch;
begin
  DefaultInterface.ClearSearch;
end;

procedure TCommon.ListDoc(var sCommand: OleVariant; var S_Title: OleVariant; var sSQL: OleVariant; 
                          var S_TitleSearchCriteria: OleVariant; var DOCS_Contacts: OleVariant; 
                          var DOCS_Comments: OleVariant; var DOCS_ContextContaining: OleVariant; 
                          var DOCS_DOCUMENTRECORDS: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                          var DOCS_WrongDate: OleVariant; var Periods: OleVariant; 
                          var DOCS_CATEGORY: OleVariant; var DOCS_EXPIRED1: OleVariant; 
                          var VAR_StatusCompletion: OleVariant; var DOCS_OUTSTANDING: OleVariant; 
                          var DOCS_Status: OleVariant; var DOCS_Incoming: OleVariant; 
                          var DOCS_Outgoing: OleVariant; var DOCS_Internal: OleVariant; 
                          var DOCS_Department: OleVariant; var DOCS_USER: OleVariant; 
                          var DOCS_All: OleVariant; var VAR_ExtInt: OleVariant; 
                          var DOCS_MYDOCS: OleVariant; var DOCS_News: OleVariant; 
                          var DOCS_FromDocs: OleVariant; var VAR_DateNewDocs: OleVariant; 
                          var DOCS_DateFormat: OleVariant; var DOCS_UNAPPROVED: OleVariant; 
                          var DOCS_EXPIRED: OleVariant; var DOCS_UnderControl: OleVariant; 
                          var DOCS_Cancelled1: OleVariant; var VAR_StatusCancelled: OleVariant; 
                          var DOCS_Completed1: OleVariant; var USER_Department: OleVariant; 
                          var DOCS_Inactives1: OleVariant; var VAR_InActiveTask: OleVariant; 
                          var DOCS_Approved1: OleVariant; var DOCS_ApprovedNot1: OleVariant; 
                          var DOCS_Refused1: OleVariant; var DOCS_NOTCOMPLETED: OleVariant; 
                          var DOCS_YouAreResponsible: OleVariant; 
                          var DOCS_YouAreCreator: OleVariant; var DOCS_Sent: OleVariant; 
                          var DOCS_Delivered: OleVariant; var DOCS_Filed: OleVariant; 
                          var DOCS_Returned: OleVariant; var DOCS_ReturnedFromFile: OleVariant; 
                          var DOCS_WaitingToBeSent: OleVariant; 
                          var DOCS_PaymentOutgoingIncompleted: OleVariant; 
                          var DOCS_PaymentIncomingIncompleted: OleVariant; 
                          var DOCS_StatusRequireToBePaid: OleVariant; 
                          var DOCS_GoToPaperFileDocList: OleVariant; 
                          var DOCS_NoUsersExceeded: OleVariant; var DOCS_LOGGEDOUT: OleVariant; 
                          var DOCS_ActionLogOut: OleVariant; var DOCS_SysUser: OleVariant; 
                          var DOCS_ViewedStatusDocs: OleVariant; var Texts: OleVariant);
begin
  DefaultInterface.ListDoc(sCommand, S_Title, sSQL, S_TitleSearchCriteria, DOCS_Contacts, 
                           DOCS_Comments, DOCS_ContextContaining, DOCS_DOCUMENTRECORDS, 
                           VAR_BeginOfTimes, DOCS_WrongDate, Periods, DOCS_CATEGORY, DOCS_EXPIRED1, 
                           VAR_StatusCompletion, DOCS_OUTSTANDING, DOCS_Status, DOCS_Incoming, 
                           DOCS_Outgoing, DOCS_Internal, DOCS_Department, DOCS_USER, DOCS_All, 
                           VAR_ExtInt, DOCS_MYDOCS, DOCS_News, DOCS_FromDocs, VAR_DateNewDocs, 
                           DOCS_DateFormat, DOCS_UNAPPROVED, DOCS_EXPIRED, DOCS_UnderControl, 
                           DOCS_Cancelled1, VAR_StatusCancelled, DOCS_Completed1, USER_Department, 
                           DOCS_Inactives1, VAR_InActiveTask, DOCS_Approved1, DOCS_ApprovedNot1, 
                           DOCS_Refused1, DOCS_NOTCOMPLETED, DOCS_YouAreResponsible, 
                           DOCS_YouAreCreator, DOCS_Sent, DOCS_Delivered, DOCS_Filed, 
                           DOCS_Returned, DOCS_ReturnedFromFile, DOCS_WaitingToBeSent, 
                           DOCS_PaymentOutgoingIncompleted, DOCS_PaymentIncomingIncompleted, 
                           DOCS_StatusRequireToBePaid, DOCS_GoToPaperFileDocList, 
                           DOCS_NoUsersExceeded, DOCS_LOGGEDOUT, DOCS_ActionLogOut, DOCS_SysUser, 
                           DOCS_ViewedStatusDocs, Texts);
end;

procedure TCommon.InOutOfOffice(var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.InOutOfOffice(VAR_BeginOfTimes);
end;

function TCommon.AmountByWords(var summa: OleVariant; var unit_: OleVariant): OleVariant;
begin
  Result := DefaultInterface.AmountByWords(summa, unit_);
end;

procedure TCommon.GetDoc(var sFileOut: OleVariant; var sError: OleVariant; 
                         var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                         var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                         var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                         var DOCS_FileDoesNotExist: OleVariant; 
                         var DOCS_ActionShowFile: OleVariant; var DOCS_MoneyUnit: OleVariant; 
                         var VAR_BeginOfTimes: OleVariant; var VAR_QNewSpec: OleVariant; 
                         var sQTY1: OleVariant; var sQTY2: OleVariant; var sQTY3: OleVariant; 
                         var sQTY4: OleVariant; var sQTY5: OleVariant; var sQTY6: OleVariant; 
                         var sQTY7: OleVariant; var sQTY8: OleVariant; var sQTY9: OleVariant; 
                         var sQTY10: OleVariant; var sQTY11: OleVariant; var sQTY12: OleVariant; 
                         var sQTY13: OleVariant; var sQTY14: OleVariant; var sQTY15: OleVariant; 
                         var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                         var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                         var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                         var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                         var CMonths: OleVariant; var CDays: OleVariant; 
                         var VAR_NamesListDelimiter1: OleVariant; 
                         var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                         var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                         var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.GetDoc(sFileOut, sError, DOCS_ErrorMSWordRun, DOCS_ErrorMSWord, DOCS_LOGIN, 
                          DOCS_NoAccess, DOCS_NOTFOUND, DOC_StaffTable, DOCS_FileDoesNotExist, 
                          DOCS_ActionShowFile, DOCS_MoneyUnit, VAR_BeginOfTimes, VAR_QNewSpec, 
                          sQTY1, sQTY2, sQTY3, sQTY4, sQTY5, sQTY6, sQTY7, sQTY8, sQTY9, sQTY10, 
                          sQTY11, sQTY12, sQTY13, sQTY14, sQTY15, DOCS_Sunday, DOCS_Monday, 
                          DOCS_Tuesday, DOCS_Wednesday, DOCS_Thursday, DOCS_Friday, DOCS_Saturday, 
                          nCDates, CMonths, CDays, VAR_NamesListDelimiter1, 
                          VAR_NamesListDelimiter2, DOCS_All, DOCS_NoReadAccess, USER_Department, 
                          VAR_ExtInt, VAR_AdminSecLevel);
end;

procedure TCommon.SetDoc(obj: OleVariant; var doc: OleVariant; sFileOut: OleVariant);
begin
  DefaultInterface.SetDoc(obj, doc, sFileOut);
end;

procedure TCommon.GetDoc1(var sFileOut: OleVariant; var sError: OleVariant; 
                          var DOCS_ErrorMSWordRun: OleVariant; var DOCS_ErrorMSWord: OleVariant; 
                          var DOCS_LOGIN: OleVariant; var DOCS_NoAccess: OleVariant; 
                          var DOCS_NOTFOUND: OleVariant; var DOC_StaffTable: OleVariant; 
                          var DOCS_FileDoesNotExist: OleVariant; 
                          var DOCS_ActionShowFile: OleVariant; var DOCS_MoneyUnit: OleVariant; 
                          var VAR_BeginOfTimes: OleVariant; var VAR_QNewSpec: OleVariant; 
                          var sQTY1: OleVariant; var sQTY2: OleVariant; var sQTY3: OleVariant; 
                          var sQTY4: OleVariant; var sQTY5: OleVariant; var sQTY6: OleVariant; 
                          var sQTY7: OleVariant; var sQTY8: OleVariant; var sQTY9: OleVariant; 
                          var sQTY10: OleVariant; var sQTY11: OleVariant; var sQTY12: OleVariant; 
                          var sQTY13: OleVariant; var sQTY14: OleVariant; var sQTY15: OleVariant; 
                          var DOCS_Sunday: OleVariant; var DOCS_Monday: OleVariant; 
                          var DOCS_Tuesday: OleVariant; var DOCS_Wednesday: OleVariant; 
                          var DOCS_Thursday: OleVariant; var DOCS_Friday: OleVariant; 
                          var DOCS_Saturday: OleVariant; var nCDates: OleVariant; 
                          var CMonths: OleVariant; var CDays: OleVariant; 
                          var VAR_NamesListDelimiter1: OleVariant; 
                          var VAR_NamesListDelimiter2: OleVariant; var DOCS_All: OleVariant; 
                          var DOCS_NoReadAccess: OleVariant; var USER_Department: OleVariant; 
                          var VAR_ExtInt: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                          var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                          var DOCS_Internal: OleVariant);
begin
  DefaultInterface.GetDoc1(sFileOut, sError, DOCS_ErrorMSWordRun, DOCS_ErrorMSWord, DOCS_LOGIN, 
                           DOCS_NoAccess, DOCS_NOTFOUND, DOC_StaffTable, DOCS_FileDoesNotExist, 
                           DOCS_ActionShowFile, DOCS_MoneyUnit, VAR_BeginOfTimes, VAR_QNewSpec, 
                           sQTY1, sQTY2, sQTY3, sQTY4, sQTY5, sQTY6, sQTY7, sQTY8, sQTY9, sQTY10, 
                           sQTY11, sQTY12, sQTY13, sQTY14, sQTY15, DOCS_Sunday, DOCS_Monday, 
                           DOCS_Tuesday, DOCS_Wednesday, DOCS_Thursday, DOCS_Friday, DOCS_Saturday, 
                           nCDates, CMonths, CDays, VAR_NamesListDelimiter1, 
                           VAR_NamesListDelimiter2, DOCS_All, DOCS_NoReadAccess, USER_Department, 
                           VAR_ExtInt, VAR_AdminSecLevel, DOCS_Incoming, DOCS_Outgoing, 
                           DOCS_Internal);
end;

procedure TCommon.InsertBookmarkTable(var cField: OleVariant; var cBookmark: OleVariant);
begin
  DefaultInterface.InsertBookmarkTable(cField, cBookmark);
end;

procedure TCommon.InsertRangeTable(var rVal: OleVariant; var mRange: OleVariant);
begin
  DefaultInterface.InsertRangeTable(rVal, mRange);
end;

procedure TCommon.InsertRangeText(var rVal: OleVariant; var mRange: OleVariant);
begin
  DefaultInterface.InsertRangeText(rVal, mRange);
end;

procedure TCommon.InsertRangeCurrency(var cPar: OleVariant);
begin
  DefaultInterface.InsertRangeCurrency(cPar);
end;

procedure TCommon.InsertRange(var cPar: OleVariant);
begin
  DefaultInterface.InsertRange(cPar);
end;

procedure TCommon.InsertRangeDate(var cPar: OleVariant);
begin
  DefaultInterface.InsertRangeDate(cPar);
end;

procedure TCommon.InsertRowXLS;
begin
  DefaultInterface.InsertRowXLS;
end;

procedure TCommon.InsertRow;
begin
  DefaultInterface.InsertRow;
end;

procedure TCommon.InsertRowExt(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                               var doc: OleVariant; var obj: OleVariant);
begin
  DefaultInterface.InsertRowExt(ExtBookmarks, iTable, doc, obj);
end;

procedure TCommon.InsertRowExt1(var ExtBookmarks: OleVariant; var iTable: OleVariant; 
                                var doc: OleVariant; var obj: OleVariant);
begin
  DefaultInterface.InsertRowExt1(ExtBookmarks, iTable, doc, obj);
end;

procedure TCommon.InsertRowExt2(var iTable: OleVariant; var doc: OleVariant; var obj: OleVariant; 
                                var bErr: OleVariant);
begin
  DefaultInterface.InsertRowExt2(iTable, doc, obj, bErr);
end;

procedure TCommon.AddBookmarksToTable(var Bookmarks: OleVariant; var iTable: OleVariant; 
                                      var iRow: OleVariant; var iColStart: OleVariant; 
                                      var doc: OleVariant; var obj: OleVariant; 
                                      var bError: OleVariant);
begin
  DefaultInterface.AddBookmarksToTable(Bookmarks, iTable, iRow, iColStart, doc, obj, bError);
end;

procedure TCommon.MoveBookmarks(var Bookmarks: OleVariant; var iTable: OleVariant; 
                                var doc: OleVariant; var obj: OleVariant);
begin
  DefaultInterface.MoveBookmarks(Bookmarks, iTable, doc, obj);
end;

function TCommon.NoIDs(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.NoIDs(cPar);
end;

procedure TCommon.InsertBookmark(var cPar: OleVariant);
begin
  DefaultInterface.InsertBookmark(cPar);
end;

procedure TCommon.InsertBookmarkComments(var cPar: OleVariant);
begin
  DefaultInterface.InsertBookmarkComments(cPar);
end;

procedure TCommon.InsertBookmarkComments1(var sCommentType: OleVariant; var sBookmark: OleVariant; 
                                          var bError: OleVariant);
begin
  DefaultInterface.InsertBookmarkComments1(sCommentType, sBookmark, bError);
end;

procedure TCommon.InsertBookmarkCurrency(var cPar: OleVariant);
begin
  DefaultInterface.InsertBookmarkCurrency(cPar);
end;

procedure TCommon.InsertBookmarkDate(var cPar: OleVariant);
begin
  DefaultInterface.InsertBookmarkDate(cPar);
end;

procedure TCommon.InsertBookmarkSum(var rVal: OleVariant; var mBookmark: OleVariant);
begin
  DefaultInterface.InsertBookmarkSum(rVal, mBookmark);
end;

procedure TCommon.InsertBookmarkText(var rVal: OleVariant; var mBookmark: OleVariant);
begin
  DefaultInterface.InsertBookmarkText(rVal, mBookmark);
end;

procedure TCommon.InsertBookmarkTextDoc(var doc: OleVariant; var rVal: OleVariant; 
                                        var mBookmark: OleVariant);
begin
  DefaultInterface.InsertBookmarkTextDoc(doc, rVal, mBookmark);
end;

procedure TCommon.InsertBookmarkHyperlink(var cField: OleVariant; var cBookmark: OleVariant);
begin
  DefaultInterface.InsertBookmarkHyperlink(cField, cBookmark);
end;

procedure TCommon.ShowSpecSummary(var VAR_QNewSpec: OleVariant);
begin
  DefaultInterface.ShowSpecSummary(VAR_QNewSpec);
end;

procedure TCommon.ShowSpecSummaryXLS(var VAR_QNewSpec: OleVariant);
begin
  DefaultInterface.ShowSpecSummaryXLS(VAR_QNewSpec);
end;

procedure TCommon.SpecMove;
begin
  DefaultInterface.SpecMove;
end;

procedure TCommon.SpecIDChange(var DOCS_NORight: OleVariant; var DOCS_Changed: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_SPECIDWrong: OleVariant; 
                               var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_NoChangeSpecID: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.SpecIDChange(DOCS_NORight, DOCS_Changed, DOCS_NOTFOUND, DOCS_SPECIDWrong, 
                                DOCS_ALREADYEXISTS, DOCS_NoChangeSpecID, VAR_AdminSecLevel);
end;

procedure TCommon.RestoreDoc(var DOCS_ActionRestoredDoc: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant; var DOCS_NoAccess: OleVariant; 
                             var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                             var DOCS_ErrorDataSource: OleVariant; 
                             var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                             var DOCS_ErrorSelectRecordset: OleVariant; 
                             var DOCS_ErrorInsertPars: OleVariant; 
                             var DOCS_ErrorSelectNotDefined: OleVariant; 
                             var DOCS_Skipped: OleVariant);
begin
  DefaultInterface.RestoreDoc(DOCS_ActionRestoredDoc, VAR_AdminSecLevel, DOCS_NoAccess, 
                              DOCS_AmountDoc, DOCS_QuantityDoc, DOCS_ErrorDataSource, 
                              DOCS_ErrorSelectRecordsetArch, DOCS_ErrorSelectRecordset, 
                              DOCS_ErrorInsertPars, DOCS_ErrorSelectNotDefined, DOCS_Skipped);
end;

procedure TCommon.ReCalcSpec(var DOCS_ReCalculated: OleVariant; var DOCS_Records: OleVariant; 
                             var DOCS_Values: OleVariant; var DOCS_WrongNumber: OleVariant; 
                             var DOCS_WrongDate: OleVariant; var DOC_Calculator: OleVariant; 
                             var DOCS_Error: OleVariant; var VAR_QNewSpec: OleVariant; 
                             var VAR_TypeVal_String: OleVariant; 
                             var VAR_TypeVal_DateTime: OleVariant; 
                             var VAR_TypeVal_NumericMoney: OleVariant; 
                             var DOCS_SpecFieldName: OleVariant; 
                             var DOCS_SpecFieldFormula: OleVariant);
begin
  DefaultInterface.ReCalcSpec(DOCS_ReCalculated, DOCS_Records, DOCS_Values, DOCS_WrongNumber, 
                              DOCS_WrongDate, DOC_Calculator, DOCS_Error, VAR_QNewSpec, 
                              VAR_TypeVal_String, VAR_TypeVal_DateTime, VAR_TypeVal_NumericMoney, 
                              DOCS_SpecFieldName, DOCS_SpecFieldFormula);
end;

function TCommon.Percent(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Percent(rAmount, rPercent);
end;

function TCommon.PercentAdd(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PercentAdd(rAmount, rPercent);
end;

function TCommon.PercentAddRev(var rAmount: OleVariant; var rPercent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PercentAddRev(rAmount, rPercent);
end;

function TCommon.Y1(var Number: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Y1(Number);
end;

function TCommon.FQ: OleVariant;
begin
  Result := DefaultInterface.FQ;
end;

function TCommon.FS: OleVariant;
begin
  Result := DefaultInterface.FS;
end;

function TCommon.FS1: OleVariant;
begin
  Result := DefaultInterface.FS1;
end;

function TCommon.FS2: OleVariant;
begin
  Result := DefaultInterface.FS2;
end;

function TCommon.F1: OleVariant;
begin
  Result := DefaultInterface.F1;
end;

function TCommon.F2: OleVariant;
begin
  Result := DefaultInterface.F2;
end;

function TCommon.F3: OleVariant;
begin
  Result := DefaultInterface.F3;
end;

function TCommon.F4: OleVariant;
begin
  Result := DefaultInterface.F4;
end;

function TCommon.F5: OleVariant;
begin
  Result := DefaultInterface.F5;
end;

function TCommon.F6: OleVariant;
begin
  Result := DefaultInterface.F6;
end;

function TCommon.F7: OleVariant;
begin
  Result := DefaultInterface.F7;
end;

function TCommon.F8: OleVariant;
begin
  Result := DefaultInterface.F8;
end;

function TCommon.F9: OleVariant;
begin
  Result := DefaultInterface.F9;
end;

function TCommon.F10: OleVariant;
begin
  Result := DefaultInterface.F10;
end;

function TCommon.F11: OleVariant;
begin
  Result := DefaultInterface.F11;
end;

function TCommon.F12: OleVariant;
begin
  Result := DefaultInterface.F12;
end;

function TCommon.F13: OleVariant;
begin
  Result := DefaultInterface.F13;
end;

function TCommon.F14: OleVariant;
begin
  Result := DefaultInterface.F14;
end;

function TCommon.F15: OleVariant;
begin
  Result := DefaultInterface.F15;
end;

function TCommon.F16: OleVariant;
begin
  Result := DefaultInterface.F16;
end;

function TCommon.F17: OleVariant;
begin
  Result := DefaultInterface.F17;
end;

function TCommon.F18: OleVariant;
begin
  Result := DefaultInterface.F18;
end;

function TCommon.F19: OleVariant;
begin
  Result := DefaultInterface.F19;
end;

function TCommon.F20: OleVariant;
begin
  Result := DefaultInterface.F20;
end;

function TCommon.F21: OleVariant;
begin
  Result := DefaultInterface.F21;
end;

function TCommon.F22: OleVariant;
begin
  Result := DefaultInterface.F22;
end;

function TCommon.F23: OleVariant;
begin
  Result := DefaultInterface.F23;
end;

function TCommon.F24: OleVariant;
begin
  Result := DefaultInterface.F24;
end;

function TCommon.F25: OleVariant;
begin
  Result := DefaultInterface.F25;
end;

function TCommon.F26: OleVariant;
begin
  Result := DefaultInterface.F26;
end;

function TCommon.F27: OleVariant;
begin
  Result := DefaultInterface.F27;
end;

function TCommon.F28: OleVariant;
begin
  Result := DefaultInterface.F28;
end;

function TCommon.F29: OleVariant;
begin
  Result := DefaultInterface.F29;
end;

function TCommon.F30: OleVariant;
begin
  Result := DefaultInterface.F30;
end;

function TCommon.F31: OleVariant;
begin
  Result := DefaultInterface.F31;
end;

function TCommon.F32: OleVariant;
begin
  Result := DefaultInterface.F32;
end;

function TCommon.F33: OleVariant;
begin
  Result := DefaultInterface.F33;
end;

function TCommon.F34: OleVariant;
begin
  Result := DefaultInterface.F34;
end;

function TCommon.F35: OleVariant;
begin
  Result := DefaultInterface.F35;
end;

function TCommon.F36: OleVariant;
begin
  Result := DefaultInterface.F36;
end;

function TCommon.F37: OleVariant;
begin
  Result := DefaultInterface.F37;
end;

function TCommon.F38: OleVariant;
begin
  Result := DefaultInterface.F38;
end;

function TCommon.F39: OleVariant;
begin
  Result := DefaultInterface.F39;
end;

function TCommon.F40: OleVariant;
begin
  Result := DefaultInterface.F40;
end;

procedure TCommon.CheckError;
begin
  DefaultInterface.CheckError;
end;

function TCommon.CheckErrorF: OleVariant;
begin
  Result := DefaultInterface.CheckErrorF;
end;

procedure TCommon.GoError(var Description: OleVariant);
begin
  DefaultInterface.GoError(Description);
end;

procedure TCommon.PasteSpec(var DOCS_SpecNotPermitted: OleVariant; var DOCS_Inserted: OleVariant; 
                            var DOCS_InsertedCompatibleSpec: OleVariant);
begin
  DefaultInterface.PasteSpec(DOCS_SpecNotPermitted, DOCS_Inserted, DOCS_InsertedCompatibleSpec);
end;

procedure TCommon.PasteComponentsSpec(var DOC_ComplexUnits: OleVariant; 
                                      var DOCS_QuantityDoc: OleVariant; 
                                      var DOCS_Inserted: OleVariant; var DOCS_Total: OleVariant; 
                                      var DOCS_ComplexItems: OleVariant);
begin
  DefaultInterface.PasteComponentsSpec(DOC_ComplexUnits, DOCS_QuantityDoc, DOCS_Inserted, 
                                       DOCS_Total, DOCS_ComplexItems);
end;

procedure TCommon.DeleteType(var DOCS_NoDeleteType: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                             var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteType(DOCS_NoDeleteType, DOCS_NOTFOUND, DOCS_NORight, DOCS_Deleted, 
                              VAR_AdminSecLevel);
end;

procedure TCommon.DeleteSpecItem(var DOCS_SPECElement: OleVariant; var DOCS_Deleted: OleVariant);
begin
  DefaultInterface.DeleteSpecItem(DOCS_SPECElement, DOCS_Deleted);
end;

function TCommon.GetDataNameAll(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDataNameAll(cPar, sFieldNames);
end;

function TCommon.GetDataName(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDataName(cPar, sFieldNames);
end;

function TCommon.GetDataWidth(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetDataWidth(cPar, sFieldNames);
end;

function TCommon.IsFieldEditArea(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsFieldEditArea(cPar, sFieldNames);
end;

function TCommon.IsNoDir(var cPar: OleVariant; var sFieldNames: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsNoDir(cPar, sFieldNames);
end;

function TCommon.IsRUS(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsRUS(cPar);
end;

procedure TCommon.Archive(var DOC_ArchiveExit: OleVariant; var DOC_ArchiveEnter: OleVariant; 
                          var VAR_AdminSecLevel: OleVariant; var VAR_StatusArchiv: OleVariant; 
                          var VAR_StatusCompletion: OleVariant; 
                          var Var_ArchiveMoveAllCompletedDocsYears: OleVariant; 
                          var DOCS_AmountDoc: OleVariant; var DOCS_QuantityDoc: OleVariant; 
                          var DOC_Moved: OleVariant; var DOC_Total: OleVariant; 
                          var DOCS_DateActivation: OleVariant; var DOCS_Completed: OleVariant; 
                          var DOCS_Archiv: OleVariant; var DOC_Move: OleVariant; 
                          var DOCS_MakeChoice: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                          var Var_ArchiveMoveAllOldDocsYears: OleVariant; 
                          var DOCS_ErrorDataSource: OleVariant; 
                          var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                          var DOCS_ErrorSelectRecordset: OleVariant; 
                          var DOCS_ErrorInsertPars: OleVariant; 
                          var DOCS_ErrorSelectNotDefined: OleVariant; var DOCS_Skipped: OleVariant);
begin
  DefaultInterface.Archive(DOC_ArchiveExit, DOC_ArchiveEnter, VAR_AdminSecLevel, VAR_StatusArchiv, 
                           VAR_StatusCompletion, Var_ArchiveMoveAllCompletedDocsYears, 
                           DOCS_AmountDoc, DOCS_QuantityDoc, DOC_Moved, DOC_Total, 
                           DOCS_DateActivation, DOCS_Completed, DOCS_Archiv, DOC_Move, 
                           DOCS_MakeChoice, VAR_BeginOfTimes, Var_ArchiveMoveAllOldDocsYears, 
                           DOCS_ErrorDataSource, DOCS_ErrorSelectRecordsetArch, 
                           DOCS_ErrorSelectRecordset, DOCS_ErrorInsertPars, 
                           DOCS_ErrorSelectNotDefined, DOCS_Skipped);
end;

procedure TCommon.DeleteAuditing(var DOCS_ActionDeleteLog: OleVariant; 
                                 var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                 var VAR_DateOldAuditing: OleVariant; var DOCS_SysLog: OleVariant; 
                                 var DOCS_Records: OleVariant);
begin
  DefaultInterface.DeleteAuditing(DOCS_ActionDeleteLog, DOCS_NORight, VAR_AdminSecLevel, 
                                  VAR_DateOldAuditing, DOCS_SysLog, DOCS_Records);
end;

procedure TCommon.DeleteComment(var DOCS_ActionDeleteComment: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var VAR_Subject: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; 
                                var DOCS_ActionDeleteFile: OleVariant; 
                                var DOCS_Version: OleVariant; var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.DeleteComment(DOCS_ActionDeleteComment, DOCS_NOTFOUND, VAR_Subject, DOCS_All, 
                                 DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, USER_Department, 
                                 VAR_ExtInt, VAR_AdminSecLevel, DOCS_ActionDeleteFile, 
                                 DOCS_Version, VAR_BeginOfTimes);
end;

procedure TCommon.DeleteDepartment(var DOCS_NOTFOUND: OleVariant; var DOCS_NORight: OleVariant; 
                                   var DOCS_Deleted: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteDepartment(DOCS_NOTFOUND, DOCS_NORight, DOCS_Deleted, VAR_AdminSecLevel);
end;

procedure TCommon.DeleteInventory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteInventory(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeleteMeasure(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteMeasure(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeletePartner(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeletePartner(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeletePosition(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                 var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeletePosition(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeleteUserDirectory(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                      var DOCS_NORight: OleVariant; 
                                      var DOCS_NoDeleteDir: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var USER_Department: OleVariant; var sDepartment: OleVariant);
begin
  DefaultInterface.DeleteUserDirectory(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, DOCS_NoDeleteDir, 
                                       VAR_AdminSecLevel, USER_Department, sDepartment);
end;

procedure TCommon.DeleteUserDirectoryValues(var DOCS_NOTFOUND: OleVariant; 
                                            var DOCS_Deleted: OleVariant; 
                                            var DOCS_NORight: OleVariant; 
                                            var VAR_AdminSecLevel: OleVariant; 
                                            var USER_Department: OleVariant; 
                                            var sDepartment: OleVariant);
begin
  DefaultInterface.DeleteUserDirectoryValues(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, 
                                             VAR_AdminSecLevel, USER_Department, sDepartment);
end;

procedure TCommon.DeleteDirectoryValues(var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteDirectoryValues(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, 
                                         VAR_AdminSecLevel);
end;

procedure TCommon.DeleteRegLog(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                               var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteRegLog(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeleteRequest(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                var DOCS_NORightToDelete: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteRequest(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORightToDelete, 
                                 VAR_AdminSecLevel);
end;

procedure TCommon.DeleteScorecard(var DOCS_NOTFOUND: OleVariant; var DOCS_Deleted: OleVariant; 
                                  var DOCS_NORightToDelete: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; var USER_Department: OleVariant);
begin
  DefaultInterface.DeleteScorecard(DOCS_NOTFOUND, DOCS_Deleted, DOCS_NORightToDelete, 
                                   VAR_AdminSecLevel, USER_Department);
end;

procedure TCommon.DeleteSpec(var DOCS_SysUser: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                             var DOCS_NOTFOUND: OleVariant; var DOCS_Spec: OleVariant; 
                             var DOCS_Deleted: OleVariant; var DOCS_NORight: OleVariant; 
                             var DOCS_NoDeleteSpec: OleVariant);
begin
  DefaultInterface.DeleteSpec(DOCS_SysUser, VAR_AdminSecLevel, DOCS_NOTFOUND, DOCS_Spec, 
                              DOCS_Deleted, DOCS_NORight, DOCS_NoDeleteSpec);
end;

procedure TCommon.DeleteTransaction(var DOCS_Deleted: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteTransaction(DOCS_Deleted, DOCS_NOTFOUND, DOCS_NORight, VAR_AdminSecLevel);
end;

procedure TCommon.DeleteUser(var DOCS_NOTFOUND: OleVariant; var DOCS_NORightToDelete: OleVariant; 
                             var DOCS_NORight: OleVariant; var DOCS_Deleted: OleVariant; 
                             var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.DeleteUser(DOCS_NOTFOUND, DOCS_NORightToDelete, DOCS_NORight, DOCS_Deleted, 
                              VAR_AdminSecLevel);
end;

function TCommon.GetMonitorURL(var sPar: OleVariant; var sval: OleVariant; var cbm: OleVariant; 
                               var DOCS_News: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetMonitorURL(sPar, sval, cbm, DOCS_News);
end;

procedure TCommon.SetMonitorSound;
begin
  DefaultInterface.SetMonitorSound;
end;

function TCommon.GetMonitorSound(var DOCS_MonitorSoundN: OleVariant; 
                                 var DOCS_MonitorNoSound: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetMonitorSound(DOCS_MonitorSoundN, DOCS_MonitorNoSound);
end;

procedure TCommon.ChangeMonitorSound(var Var_nMonitorSoundFiles: OleVariant);
begin
  DefaultInterface.ChangeMonitorSound(Var_nMonitorSoundFiles);
end;

procedure TCommon.ShowListMonitorUsers(var S_PartnerID: OleVariant; var S_PartnerName: OleVariant; 
                                       var DOCS_News: OleVariant; 
                                       var DOCS_SendPersonalMessage: OleVariant; 
                                       var DOCS_SendPersonalMessageYourself: OleVariant; 
                                       var Var_nMonitorRefreshSeconds: OleVariant);
begin
  DefaultInterface.ShowListMonitorUsers(S_PartnerID, S_PartnerName, DOCS_News, 
                                        DOCS_SendPersonalMessage, DOCS_SendPersonalMessageYourself, 
                                        Var_nMonitorRefreshSeconds);
end;

procedure TCommon.AddUserToMonitor(var DOCS_Created: OleVariant);
begin
  DefaultInterface.AddUserToMonitor(DOCS_Created);
end;

procedure TCommon.ClearMonitorList;
begin
  DefaultInterface.ClearMonitorList;
end;

procedure TCommon.DeleteUserFromMonitor(var DOCS_Deleted: OleVariant);
begin
  DefaultInterface.DeleteUserFromMonitor(DOCS_Deleted);
end;

function TCommon.UserInMonitor(var sUserID: OleVariant): OleVariant;
begin
  Result := DefaultInterface.UserInMonitor(sUserID);
end;

procedure TCommon.ChangeMeasure(var S_Measure: OleVariant; var S_Code: OleVariant; 
                                var S_UnitName: OleVariant; var S_Name: OleVariant; 
                                var S_USLNAT: OleVariant; var S_USLINTER: OleVariant; 
                                var S_ALFNAT: OleVariant; var S_ALFINTER: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangeMeasure(S_Measure, S_Code, S_UnitName, S_Name, S_USLNAT, S_USLINTER, 
                                 S_ALFNAT, S_ALFINTER, DOCS_NOTFOUND, DOCS_ALREADYEXISTS, 
                                 DOCS_Changed, DOCS_Created, VAR_AdminSecLevel, DOCS_NORight, 
                                 VAR_BeginOfTimes);
end;

procedure TCommon.ChangePartner(var S_Companies: OleVariant; var S_Partner: OleVariant; 
                                var S_ShortName: OleVariant; var S_Address: OleVariant; 
                                var S_Address1: OleVariant; var S_Address2: OleVariant; 
                                var S_Phone: OleVariant; var S_Fax: OleVariant; 
                                var S_ContactName: OleVariant; var S_EMail: OleVariant; 
                                var S_WebLink: OleVariant; var S_BankDetails: OleVariant; 
                                var S_TaxID: OleVariant; var S_RegCode: OleVariant; 
                                var S_RegCode1: OleVariant; var S_Country: OleVariant; 
                                var S_Area: OleVariant; var S_City: OleVariant; 
                                var S_Industry: OleVariant; var S_ManagerName: OleVariant; 
                                var S_ManagerPosition: OleVariant; 
                                var S_ManagerPhoneNo: OleVariant; 
                                var S_AccountingManagerName: OleVariant; 
                                var S_AccountingManagerPhoneNo: OleVariant; 
                                var S_SalesManagerName: OleVariant; 
                                var S_SalesManagerPosition: OleVariant; 
                                var S_SalesManagerPhoneNo: OleVariant; var S_AddInfo: OleVariant; 
                                var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                                var S_NameLastModification: OleVariant; 
                                var S_DateLastModification: OleVariant; 
                                var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                                var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangePartner(S_Companies, S_Partner, S_ShortName, S_Address, S_Address1, 
                                 S_Address2, S_Phone, S_Fax, S_ContactName, S_EMail, S_WebLink, 
                                 S_BankDetails, S_TaxID, S_RegCode, S_RegCode1, S_Country, S_Area, 
                                 S_City, S_Industry, S_ManagerName, S_ManagerPosition, 
                                 S_ManagerPhoneNo, S_AccountingManagerName, 
                                 S_AccountingManagerPhoneNo, S_SalesManagerName, 
                                 S_SalesManagerPosition, S_SalesManagerPhoneNo, S_AddInfo, 
                                 S_NameCreation, S_DateCreation, S_NameLastModification, 
                                 S_DateLastModification, DOCS_NOTFOUND, DOCS_ALREADYEXISTS, 
                                 DOCS_Changed, DOCS_Created, VAR_AdminSecLevel, DOCS_NORight, 
                                 VAR_BeginOfTimes);
end;

procedure TCommon.ChangePosition(var S_Position: OleVariant; var S_NameCreation: OleVariant; 
                                 var S_DateCreation: OleVariant; 
                                 var S_NameLastModification: OleVariant; 
                                 var S_DateLastModification: OleVariant; 
                                 var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                                 var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                 var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangePosition(S_Position, S_NameCreation, S_DateCreation, 
                                  S_NameLastModification, S_DateLastModification, DOCS_NOTFOUND, 
                                  DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                  VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes);
end;

function TCommon.CanModifyDirectory(var WriteSecurityLevel: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                    var NameCreation: OleVariant; var USER_Department: OleVariant; 
                                    var sDepartment: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CanModifyDirectory(WriteSecurityLevel, VAR_AdminSecLevel, UserID, 
                                                NameCreation, USER_Department, sDepartment);
end;

function TCommon.CanModifyDirectoryGUID(var sDirGUID: OleVariant; var sGUID: OleVariant; 
                                        var WriteSecurityLevel: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                        var USER_Department: OleVariant; var sDepartment: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CanModifyDirectoryGUID(sDirGUID, sGUID, WriteSecurityLevel, 
                                                    VAR_AdminSecLevel, UserID, USER_Department, 
                                                    sDepartment);
end;

procedure TCommon.ChangeUserDirectory(var S_Name: OleVariant; var S_DocField: OleVariant; 
                                      var S_FieldName1: OleVariant; var S_FieldName2: OleVariant; 
                                      var S_FieldName3: OleVariant; var S_FieldName4: OleVariant; 
                                      var S_FieldName5: OleVariant; var S_FieldName6: OleVariant; 
                                      var S_CompanyDoc: OleVariant; var S_NameCreation: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; 
                                      var DOCS_ALREADYEXISTS: OleVariant; 
                                      var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant; 
                                      var DOCS_NORight: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant; var DOCS_All: OleVariant; 
                                      var USER_Department: OleVariant; var sDepartment: OleVariant);
begin
  DefaultInterface.ChangeUserDirectory(S_Name, S_DocField, S_FieldName1, S_FieldName2, 
                                       S_FieldName3, S_FieldName4, S_FieldName5, S_FieldName6, 
                                       S_CompanyDoc, S_NameCreation, DOCS_NOTFOUND, 
                                       DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                       VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes, DOCS_All, 
                                       USER_Department, sDepartment);
end;

function TCommon.GetGUID: WideString;
begin
  Result := DefaultInterface.GetGUID;
end;

function TCommon.GetGUID1: WideString;
begin
  Result := DefaultInterface.GetGUID1;
end;

function TCommon.GetGUIDFromKeyField(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetGUIDFromKeyField(cPar);
end;

function TCommon.GUID2ByteArray(const strGUID: WideString): PSafeArray;
begin
  Result := DefaultInterface.GUID2ByteArray(strGUID);
end;

procedure TCommon.ChangeUserDirectoryValues(var S_GUID: OleVariant; var S_KeyField: OleVariant; 
                                            var S_Field1: OleVariant; var S_Field2: OleVariant; 
                                            var S_Field3: OleVariant; var S_Field4: OleVariant; 
                                            var S_Field5: OleVariant; var S_Field6: OleVariant; 
                                            var DOCS_NOTFOUND: OleVariant; 
                                            var DOCS_ALREADYEXISTS: OleVariant; 
                                            var DOCS_Changed: OleVariant; 
                                            var DOCS_Created: OleVariant; 
                                            var VAR_AdminSecLevel: OleVariant; 
                                            var DOCS_NORight: OleVariant; 
                                            var VAR_BeginOfTimes: OleVariant; 
                                            var USER_Department: OleVariant; 
                                            var sDepartment: OleVariant);
begin
  DefaultInterface.ChangeUserDirectoryValues(S_GUID, S_KeyField, S_Field1, S_Field2, S_Field3, 
                                             S_Field4, S_Field5, S_Field6, DOCS_NOTFOUND, 
                                             DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                             VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes, 
                                             USER_Department, sDepartment);
end;

procedure TCommon.ChangeDirectoryValues(var dsDoc: OleVariant; var S_Name: OleVariant; 
                                        var S_Code: OleVariant; var S_Code2: OleVariant; 
                                        var DOCS_NOTFOUND: OleVariant; 
                                        var DOCS_ALREADYEXISTS: OleVariant; 
                                        var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                        var VAR_AdminSecLevel: OleVariant; 
                                        var DOCS_NORight: OleVariant; 
                                        var VAR_BeginOfTimes: OleVariant; 
                                        var DOCS_ErrorGUID: OleVariant);
begin
  DefaultInterface.ChangeDirectoryValues(dsDoc, S_Name, S_Code, S_Code2, DOCS_NOTFOUND, 
                                         DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                         VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes, 
                                         DOCS_ErrorGUID);
end;

procedure TCommon.ChangeRegLog(var S_Name: OleVariant; var S_Users: OleVariant; 
                               var S_Owners: OleVariant; var S_ClassDocs: OleVariant; 
                               var S_RegLogID: OleVariant; var S_VisibleFields: OleVariant; 
                               var S_DocType: OleVariant; var S_NameCreation: OleVariant; 
                               var S_DateCreation: OleVariant; 
                               var S_NameLastModification: OleVariant; 
                               var S_DateLastModification: OleVariant; 
                               var AddFieldName1: OleVariant; var AddFieldName2: OleVariant; 
                               var AddFieldName3: OleVariant; var AddFieldName4: OleVariant; 
                               var AddFieldName5: OleVariant; var AddFieldName6: OleVariant; 
                               var AddFieldFormula1: OleVariant; var AddFieldFormula2: OleVariant; 
                               var AddFieldFormula3: OleVariant; var AddFieldFormula4: OleVariant; 
                               var AddFieldFormula5: OleVariant; var AddFieldFormula6: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                               var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_All: OleVariant);
begin
  DefaultInterface.ChangeRegLog(S_Name, S_Users, S_Owners, S_ClassDocs, S_RegLogID, 
                                S_VisibleFields, S_DocType, S_NameCreation, S_DateCreation, 
                                S_NameLastModification, S_DateLastModification, AddFieldName1, 
                                AddFieldName2, AddFieldName3, AddFieldName4, AddFieldName5, 
                                AddFieldName6, AddFieldFormula1, AddFieldFormula2, 
                                AddFieldFormula3, AddFieldFormula4, AddFieldFormula5, 
                                AddFieldFormula6, DOCS_NOTFOUND, DOCS_ALREADYEXISTS, DOCS_Changed, 
                                DOCS_Created, VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes, 
                                DOCS_All);
end;

procedure TCommon.GetOrderPars(var dsDoc: OleVariant; var S_OrderBy1: OleVariant; 
                               var S_OrderBy2: OleVariant; var S_OrderBy3: OleVariant; 
                               var S_OrderBy1Sort: OleVariant; var S_OrderBy2Sort: OleVariant; 
                               var S_OrderBy3Sort: OleVariant; var S_OrderBy1Ch: OleVariant; 
                               var S_OrderBy2Ch: OleVariant; var S_OrderBy3Ch: OleVariant);
begin
  DefaultInterface.GetOrderPars(dsDoc, S_OrderBy1, S_OrderBy2, S_OrderBy3, S_OrderBy1Sort, 
                                S_OrderBy2Sort, S_OrderBy3Sort, S_OrderBy1Ch, S_OrderBy2Ch, 
                                S_OrderBy3Ch);
end;

procedure TCommon.ChangeRequest(var RequestPars: OleVariant; var dsDoc: OleVariant; 
                                var sSQL: OleVariant; var sSQL_IncomingSaldo: OleVariant; 
                                var bSpec: OleVariant; var bDateActivation: OleVariant; 
                                var bIncomingSaldo: OleVariant; var bDetailed: OleVariant; 
                                var sDetailes: OleVariant; var VAR_StatusArchiv: OleVariant; 
                                var DOCS_DocID: OleVariant; var DOCS_DocIDParent: OleVariant; 
                                var DOCS_ListToReconcile: OleVariant; 
                                var DOCS_NameResponsible: OleVariant; 
                                var DOCS_NameAproval: OleVariant; var USER_Name: OleVariant; 
                                var DOCS_Department: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_ACT: OleVariant; var DOCS_Description: OleVariant; 
                                var DOCS_Author: OleVariant; var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; var DOCS_History: OleVariant; 
                                var VAR_ExtInt: OleVariant; var DOCS_PartnerName: OleVariant; 
                                var DOCS_InventoryUnit: OleVariant; 
                                var DOCS_PaymentMethod: OleVariant; var DOCS_AmountDoc: OleVariant; 
                                var DOCS_QuantityDoc: OleVariant; 
                                var DOCS_StatusCompletion: OleVariant; 
                                var DOCS_OUTSTANDING: OleVariant; var DOCS_Completed1: OleVariant; 
                                var VAR_StatusCompletion: OleVariant; 
                                var VAR_StatusCancelled: OleVariant; 
                                var DOCS_Completed: OleVariant; var DOCS_Actual: OleVariant; 
                                var DOCS_Cancelled: OleVariant; var DOCS_Cancelled1: OleVariant; 
                                var DOCS_Incoming: OleVariant; var DOCS_Outgoing: OleVariant; 
                                var DOCS_Internal: OleVariant; var DOCS_TypeDoc: OleVariant; 
                                var DOCS_ClassDoc: OleVariant; 
                                var DOCS_StatusDevelopment: OleVariant; 
                                var DOCS_NameUserFieldDate: OleVariant; 
                                var DOCS_FROM_Date: OleVariant; var DOCS_TO_Date: OleVariant; 
                                var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; 
                                var DOCS_RequestAddSQL: OleVariant; var Statuses: OleVariant; 
                                var Periods: OleVariant; var TextConsts: OleVariant; 
                                var Consts: OleVariant; var sRequestSQL: OleVariant; 
                                var DOCS_All: OleVariant);
begin
  DefaultInterface.ChangeRequest(RequestPars, dsDoc, sSQL, sSQL_IncomingSaldo, bSpec, 
                                 bDateActivation, bIncomingSaldo, bDetailed, sDetailes, 
                                 VAR_StatusArchiv, DOCS_DocID, DOCS_DocIDParent, 
                                 DOCS_ListToReconcile, DOCS_NameResponsible, DOCS_NameAproval, 
                                 USER_Name, DOCS_Department, DOCS_Name, DOCS_ACT, DOCS_Description, 
                                 DOCS_Author, DOCS_Correspondent, DOCS_Resolution, DOCS_History, 
                                 VAR_ExtInt, DOCS_PartnerName, DOCS_InventoryUnit, 
                                 DOCS_PaymentMethod, DOCS_AmountDoc, DOCS_QuantityDoc, 
                                 DOCS_StatusCompletion, DOCS_OUTSTANDING, DOCS_Completed1, 
                                 VAR_StatusCompletion, VAR_StatusCancelled, DOCS_Completed, 
                                 DOCS_Actual, DOCS_Cancelled, DOCS_Cancelled1, DOCS_Incoming, 
                                 DOCS_Outgoing, DOCS_Internal, DOCS_TypeDoc, DOCS_ClassDoc, 
                                 DOCS_StatusDevelopment, DOCS_NameUserFieldDate, DOCS_FROM_Date, 
                                 DOCS_TO_Date, DOCS_DateActivation, DOCS_DateCompletion, 
                                 DOCS_RequestAddSQL, Statuses, Periods, TextConsts, Consts, 
                                 sRequestSQL, DOCS_All);
end;

procedure TCommon.ChangeTransaction(var S_Transaction: OleVariant; var S_Account: OleVariant; 
                                    var S_SubAccount1: OleVariant; var S_SubAccount2: OleVariant; 
                                    var S_SubAccount3: OleVariant; var S_NameCreation: OleVariant; 
                                    var S_DateCreation: OleVariant; 
                                    var S_NameLastModification: OleVariant; 
                                    var S_DateLastModification: OleVariant; 
                                    var DOCS_ALREADYEXISTS: OleVariant; 
                                    var DOCS_NOTFOUND: OleVariant; var DOCS_Changed: OleVariant; 
                                    var DOCS_Created: OleVariant; 
                                    var VAR_AdminSecLevel: OleVariant; 
                                    var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangeTransaction(S_Transaction, S_Account, S_SubAccount1, S_SubAccount2, 
                                     S_SubAccount3, S_NameCreation, S_DateCreation, 
                                     S_NameLastModification, S_DateLastModification, 
                                     DOCS_ALREADYEXISTS, DOCS_NOTFOUND, DOCS_Changed, DOCS_Created, 
                                     VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes);
end;

procedure TCommon.ChangeType(var S_Type: OleVariant; var S_Template: OleVariant; 
                             var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                             var S_NameLastModification: OleVariant; 
                             var S_DateLastModification: OleVariant; 
                             var UserInstructions: OleVariant; 
                             var BusinessProcessSteps: OleVariant; 
                             var BusinessProcessType: OleVariant; 
                             var StandardNameTexts: OleVariant; var NameUserFieldText1: OleVariant; 
                             var NameUserFieldText2: OleVariant; 
                             var NameUserFieldText3: OleVariant; 
                             var NameUserFieldText4: OleVariant; 
                             var NameUserFieldText5: OleVariant; 
                             var NameUserFieldText6: OleVariant; 
                             var NameUserFieldText7: OleVariant; 
                             var NameUserFieldText8: OleVariant; 
                             var NameUserFieldMoney1: OleVariant; 
                             var NameUserFieldMoney2: OleVariant; 
                             var NameUserFieldDate1: OleVariant; 
                             var NameUserFieldDate2: OleVariant; var NameSpecIDs: OleVariant; 
                             var bVar: OleVariant; var S_FormulaQuantity: OleVariant; 
                             var S_FormulaAmount: OleVariant; var TextConsts: OleVariant; 
                             var sDataSourceName: OleVariant; var sDataSource: OleVariant; 
                             var sSelectRecordset: OleVariant; var sFieldNames: OleVariant);
begin
  DefaultInterface.ChangeType(S_Type, S_Template, S_NameCreation, S_DateCreation, 
                              S_NameLastModification, S_DateLastModification, UserInstructions, 
                              BusinessProcessSteps, BusinessProcessType, StandardNameTexts, 
                              NameUserFieldText1, NameUserFieldText2, NameUserFieldText3, 
                              NameUserFieldText4, NameUserFieldText5, NameUserFieldText6, 
                              NameUserFieldText7, NameUserFieldText8, NameUserFieldMoney1, 
                              NameUserFieldMoney2, NameUserFieldDate1, NameUserFieldDate2, 
                              NameSpecIDs, bVar, S_FormulaQuantity, S_FormulaAmount, TextConsts, 
                              sDataSourceName, sDataSource, sSelectRecordset, sFieldNames);
end;

function TCommon.CanAccessRecord(var SecurityLevel: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                 var UserID: OleVariant; var sDepartment: OleVariant; 
                                 var USER_Department: OleVariant; var Users: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CanAccessRecord(SecurityLevel, VAR_AdminSecLevel, UserID, sDepartment, 
                                             USER_Department, Users);
end;

function TCommon.CanViewRecord(var ReadSecurityLevel: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                               var sDepartment: OleVariant; var USER_Department: OleVariant; 
                               var Viewers: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CanViewRecord(ReadSecurityLevel, VAR_AdminSecLevel, UserID, 
                                           sDepartment, USER_Department, Viewers);
end;

function TCommon.CanModifyRecord(var WriteSecurityLevel: OleVariant; 
                                 var VAR_AdminSecLevel: OleVariant; var UserID: OleVariant; 
                                 var sDepartment: OleVariant; var USER_Department: OleVariant; 
                                 var Editors: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CanModifyRecord(WriteSecurityLevel, VAR_AdminSecLevel, UserID, 
                                             sDepartment, USER_Department, Editors);
end;

procedure TCommon.ChangeScorecard(var S_GUID: OleVariant; var S_KeyWords: OleVariant; 
                                  var S_Name: OleVariant; var S_Description: OleVariant; 
                                  var S_PeriodType: OleVariant; var S_FirstPeriod: OleVariant; 
                                  var N_PeriodsPerScreen: OleVariant; 
                                  var N_ScreenWidth: OleVariant; 
                                  var N_MinScorecardValue: OleVariant; 
                                  var N_MaxScorecardValue: OleVariant; 
                                  var S_DataSource: OleVariant; var S_DataSourcePars: OleVariant; 
                                  var S_SelectRecordset: OleVariant; 
                                  var S_SelectRecordsetPars: OleVariant; 
                                  var S_ColorNormal: OleVariant; var S_ColorWarning: OleVariant; 
                                  var S_ColorCritical: OleVariant; 
                                  var S_ConditionWarning: OleVariant; 
                                  var S_ConditionCritical: OleVariant; 
                                  var S_SignWarning: OleVariant; var S_SignCritical: OleVariant; 
                                  var S_NameFormula: OleVariant; var S_NameFormulaPars: OleVariant; 
                                  var S_ValueFormula: OleVariant; var S_ValueFormat: OleVariant; 
                                  var S_ScorecardDownLevelGUID: OleVariant; 
                                  var S_ScorecardDownLevelFormulaLink: OleVariant; 
                                  var S_Editors: OleVariant; var S_Viewers: OleVariant; 
                                  var S_NameLastModification: OleVariant; 
                                  var S_DateLastModification: OleVariant; 
                                  var DOCS_NORight: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                  var USER_Department: OleVariant; 
                                  var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant);
begin
  DefaultInterface.ChangeScorecard(S_GUID, S_KeyWords, S_Name, S_Description, S_PeriodType, 
                                   S_FirstPeriod, N_PeriodsPerScreen, N_ScreenWidth, 
                                   N_MinScorecardValue, N_MaxScorecardValue, S_DataSource, 
                                   S_DataSourcePars, S_SelectRecordset, S_SelectRecordsetPars, 
                                   S_ColorNormal, S_ColorWarning, S_ColorCritical, 
                                   S_ConditionWarning, S_ConditionCritical, S_SignWarning, 
                                   S_SignCritical, S_NameFormula, S_NameFormulaPars, 
                                   S_ValueFormula, S_ValueFormat, S_ScorecardDownLevelGUID, 
                                   S_ScorecardDownLevelFormulaLink, S_Editors, S_Viewers, 
                                   S_NameLastModification, S_DateLastModification, DOCS_NORight, 
                                   DOCS_NOTFOUND, USER_Department, VAR_AdminSecLevel, DOCS_All);
end;

procedure TCommon.ChangeUser(var S_UserID: OleVariant; var S_Password: OleVariant; 
                             var S_Name: OleVariant; var S_Phone: OleVariant; 
                             var S_PhoneCell: OleVariant; var S_IDentification: OleVariant; 
                             var S_IDNo: OleVariant; var S_IDIssuedBy: OleVariant; 
                             var S_IDIssueDate: OleVariant; var S_IDExpDate: OleVariant; 
                             var S_BirthDate: OleVariant; var S_CorporateIDNo: OleVariant; 
                             var S_AddInfo: OleVariant; var S_Comment: OleVariant; 
                             var S_EMail: OleVariant; var S_PostAddress: OleVariant; 
                             var S_ICQ: OleVariant; var S_Department: OleVariant; 
                             var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                             var S_ClassDoc: OleVariant; var S_Reporttype: OleVariant; 
                             var S_CompanyDoc: OleVariant; var S_Position: OleVariant; 
                             var S_Role: OleVariant; var S_PossibleRoles: OleVariant; 
                             var S_ReadSecurityLevel: OleVariant; 
                             var S_WriteSecurityLevel: OleVariant; 
                             var S_ExtIntSecurityLevel: OleVariant; 
                             var S_DateExpirationSecurity: OleVariant; 
                             var S_StatusActive: OleVariant; var S_Permitions: OleVariant; 
                             var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                             var S_NameLastModification: OleVariant; 
                             var S_DateLastModification: OleVariant; var sNewRole: OleVariant; 
                             var VARS: OleVariant);
begin
  DefaultInterface.ChangeUser(S_UserID, S_Password, S_Name, S_Phone, S_PhoneCell, S_IDentification, 
                              S_IDNo, S_IDIssuedBy, S_IDIssueDate, S_IDExpDate, S_BirthDate, 
                              S_CorporateIDNo, S_AddInfo, S_Comment, S_EMail, S_PostAddress, S_ICQ, 
                              S_Department, S_Company, S_ActDoc, S_ClassDoc, S_Reporttype, 
                              S_CompanyDoc, S_Position, S_Role, S_PossibleRoles, 
                              S_ReadSecurityLevel, S_WriteSecurityLevel, S_ExtIntSecurityLevel, 
                              S_DateExpirationSecurity, S_StatusActive, S_Permitions, 
                              S_NameCreation, S_DateCreation, S_NameLastModification, 
                              S_DateLastModification, sNewRole, VARS);
end;

function TCommon.GenNewMSAccessReplicationID: OleVariant;
begin
  Result := DefaultInterface.GenNewMSAccessReplicationID;
end;

procedure TCommon.ChangeSpecItem(var dsDoc: OleVariant; var S_ItemID: OleVariant; 
                                 var S_NameSpec: OleVariant; var DOCS_Error: OleVariant; 
                                 var UPC_NotFound: OleVariant; var VAR_TypeVal_String: OleVariant; 
                                 var VAR_TypeVal_NumericMoney: OleVariant; 
                                 var VAR_TypeVal_DateTime: OleVariant; 
                                 var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                 var DOCS_WrongNumber: OleVariant; var DOCS_Created: OleVariant; 
                                 var DOCS_Changed: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                 var S_InventoryUnitField: OleVariant; 
                                 var Var_InventoryCode: OleVariant);
begin
  DefaultInterface.ChangeSpecItem(dsDoc, S_ItemID, S_NameSpec, DOCS_Error, UPC_NotFound, 
                                  VAR_TypeVal_String, VAR_TypeVal_NumericMoney, 
                                  VAR_TypeVal_DateTime, VAR_BeginOfTimes, DOCS_WrongDate, 
                                  DOCS_WrongNumber, DOCS_Created, DOCS_Changed, DOCS_NOTFOUND, 
                                  S_InventoryUnitField, Var_InventoryCode);
end;

procedure TCommon.ChangeSpec(var dsDoc: OleVariant; var S_NameSpec: OleVariant; 
                             var VAR_QNewSpec: OleVariant; var DOCS_ErrSpecEmptyName: OleVariant; 
                             var DOCS_Created: OleVariant; var DOCS_Changed: OleVariant; 
                             var DOCS_NOTFOUND: OleVariant);
begin
  DefaultInterface.ChangeSpec(dsDoc, S_NameSpec, VAR_QNewSpec, DOCS_ErrSpecEmptyName, DOCS_Created, 
                              DOCS_Changed, DOCS_NOTFOUND);
end;

procedure TCommon.ChangeReporttype(var S_Reporttype: OleVariant; var S_NameCreation: OleVariant; 
                                   var S_DateCreation: OleVariant; 
                                   var S_NameLastModification: OleVariant; 
                                   var S_DateLastModification: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_ALREADYEXISTS: OleVariant; 
                                   var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangeReporttype(S_Reporttype, S_NameCreation, S_DateCreation, 
                                    S_NameLastModification, S_DateLastModification, DOCS_NOTFOUND, 
                                    DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                    VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes);
end;

procedure TCommon.ChangeInventory(var S_Inventory: OleVariant; var S_Code: OleVariant; 
                                  var S_UnitName: OleVariant; var S_CodeInternal: OleVariant; 
                                  var S_CodeInternal2: OleVariant; var S_Quantity: OleVariant; 
                                  var S_PriceIn: OleVariant; var S_PriceOut: OleVariant; 
                                  var S_Comment: OleVariant; var S_Comment2: OleVariant; 
                                  var S_PictureURL: OleVariant; var S_Category: OleVariant; 
                                  var S_NameCreation: OleVariant; var S_DateCreation: OleVariant; 
                                  var S_NameLastModification: OleVariant; 
                                  var S_DateLastModification: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; 
                                  var DOCS_ALREADYEXISTS: OleVariant; var DOCS_Changed: OleVariant; 
                                  var DOCS_Created: OleVariant; var VAR_AdminSecLevel: OleVariant; 
                                  var DOCS_NORight: OleVariant; var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.ChangeInventory(S_Inventory, S_Code, S_UnitName, S_CodeInternal, 
                                   S_CodeInternal2, S_Quantity, S_PriceIn, S_PriceOut, S_Comment, 
                                   S_Comment2, S_PictureURL, S_Category, S_NameCreation, 
                                   S_DateCreation, S_NameLastModification, S_DateLastModification, 
                                   DOCS_NOTFOUND, DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                   VAR_AdminSecLevel, DOCS_NORight, VAR_BeginOfTimes);
end;

procedure TCommon.ChangeDepartment(var S_Department: OleVariant; var S_NameCreation: OleVariant; 
                                   var S_DateCreation: OleVariant; 
                                   var S_NameLastModification: OleVariant; 
                                   var S_DateLastModification: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_ALREADYEXISTS: OleVariant; 
                                   var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                   var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
begin
  DefaultInterface.ChangeDepartment(S_Department, S_NameCreation, S_DateCreation, 
                                    S_NameLastModification, S_DateLastModification, DOCS_NOTFOUND, 
                                    DOCS_ALREADYEXISTS, DOCS_Changed, DOCS_Created, 
                                    VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.ChangeDocIdInDepandants(var sDocIDold: OleVariant; var sDocIDnew: OleVariant);
begin
  DefaultInterface.ChangeDocIdInDepandants(sDocIDold, sDocIDnew);
end;

procedure TCommon.GetExtDataRecordsets(var dsDoc: OleVariant; var nDataSources: OleVariant; 
                                       var bErr: OleVariant; var sMessage: OleVariant; 
                                       var sDataSourceName: OleVariant; 
                                       var sDataSource: OleVariant; 
                                       var sSelectRecordset: OleVariant; 
                                       var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                       var sStatementInsert: OleVariant; 
                                       var sStatementUpdate: OleVariant; 
                                       var sStatementDelete: OleVariant; var sGUID: OleVariant);
begin
  DefaultInterface.GetExtDataRecordsets(dsDoc, nDataSources, bErr, sMessage, sDataSourceName, 
                                        sDataSource, sSelectRecordset, sFieldNames, sKeyWords, 
                                        sStatementInsert, sStatementUpdate, sStatementDelete, sGUID);
end;

procedure TCommon.GetExtDataDescriptions(var sClassDoc: OleVariant; var nDataSources: OleVariant; 
                                         var sDataSourceName: OleVariant; 
                                         var sDataSource: OleVariant; 
                                         var sSelectRecordset: OleVariant; 
                                         var sFieldNames: OleVariant; var sKeyWords: OleVariant; 
                                         var sStatementInsert: OleVariant; 
                                         var sStatementUpdate: OleVariant; 
                                         var sStatementDelete: OleVariant; var sGUID: OleVariant);
begin
  DefaultInterface.GetExtDataDescriptions(sClassDoc, nDataSources, sDataSourceName, sDataSource, 
                                          sSelectRecordset, sFieldNames, sKeyWords, 
                                          sStatementInsert, sStatementUpdate, sStatementDelete, 
                                          sGUID);
end;

procedure TCommon.ChangeDocIDInExtData(var sDocIDold: OleVariant; var sDocIDnew: OleVariant; 
                                       var dsDoc: OleVariant; var S_ClassDoc: OleVariant);
begin
  DefaultInterface.ChangeDocIDInExtData(sDocIDold, sDocIDnew, dsDoc, S_ClassDoc);
end;

procedure TCommon.PutsChanges(var cDoc: OleVariant; var cRequest: OleVariant);
begin
  DefaultInterface.PutsChanges(cDoc, cRequest);
end;

procedure TCommon.PutsChangesNewUsers(var sNewUsers: OleVariant; var cDoc: OleVariant; 
                                      var cRequest: OleVariant);
begin
  DefaultInterface.PutsChangesNewUsers(sNewUsers, cDoc, cRequest);
end;

procedure TCommon.PutsChanges1(var cDoc: OleVariant; var cRequest: OleVariant);
begin
  DefaultInterface.PutsChanges1(cDoc, cRequest);
end;

function TCommon.IsRightCurrency(var cPar: OleVariant; var Var_MainSystemCurrency: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsRightCurrency(cPar, Var_MainSystemCurrency);
end;

procedure TCommon.ChangeDoc(var S_DocID: OleVariant; var S_DocIDAdd: OleVariant; 
                            var S_DocIDParent: OleVariant; var S_DocIDPrevious: OleVariant; 
                            var S_DocIDIncoming: OleVariant; var S_Department: OleVariant; 
                            var S_Author: OleVariant; var S_Correspondent: OleVariant; 
                            var S_Resolution: OleVariant; var S_History: OleVariant; 
                            var S_Result: OleVariant; var S_ExtPassword: OleVariant; 
                            var S_Company: OleVariant; var S_ActDoc: OleVariant; 
                            var S_Name: OleVariant; var S_Description: OleVariant; 
                            var S_Content: OleVariant; var S_LocationPaper: OleVariant; 
                            var S_Currency: OleVariant; var S_CurrencyRate: OleVariant; 
                            var S_Rank: OleVariant; var S_LocationPath: OleVariant; 
                            var S_ExtInt: OleVariant; var S_PartnerName: OleVariant; 
                            var S_StatusDevelopment: OleVariant; var S_StatusArchiv: OleVariant; 
                            var S_StatusCompletion: OleVariant; var S_PaymentMethod: OleVariant; 
                            var S_StatusPayment: OleVariant; var S_InventoryUnit: OleVariant; 
                            var S_AmountDoc: OleVariant; var S_AmountDocPart: OleVariant; 
                            var S_QuantityDoc: OleVariant; var S_SecurityLevel: OleVariant; 
                            var S_DateCreation: OleVariant; var S_DateCompletion: OleVariant; 
                            var S_DateExpiration: OleVariant; var S_DateActivation: OleVariant; 
                            var S_DateSigned: OleVariant; var S_NameCreation: OleVariant; 
                            var S_NameAproval: OleVariant; var S_NameControl: OleVariant; 
                            var S_NameApproved: OleVariant; var S_ListToView: OleVariant; 
                            var S_ListToEdit: OleVariant; var S_ListToReconcile: OleVariant; 
                            var S_ListReconciled: OleVariant; var S_NameResponsible: OleVariant; 
                            var S_NameLastModification: OleVariant; 
                            var S_DateLastModification: OleVariant; var S_TypeDoc: OleVariant; 
                            var S_StandardNameTexts: OleVariant; var S_ClassDoc: OleVariant; 
                            var S_BusinessProcessStep: OleVariant; var S_IsActive: OleVariant; 
                            var HasNoSub: OleVariant; var S_UserFields: OleVariant; 
                            var TextConsts: OleVariant; var MailTexts: OleVariant);
begin
  DefaultInterface.ChangeDoc(S_DocID, S_DocIDAdd, S_DocIDParent, S_DocIDPrevious, S_DocIDIncoming, 
                             S_Department, S_Author, S_Correspondent, S_Resolution, S_History, 
                             S_Result, S_ExtPassword, S_Company, S_ActDoc, S_Name, S_Description, 
                             S_Content, S_LocationPaper, S_Currency, S_CurrencyRate, S_Rank, 
                             S_LocationPath, S_ExtInt, S_PartnerName, S_StatusDevelopment, 
                             S_StatusArchiv, S_StatusCompletion, S_PaymentMethod, S_StatusPayment, 
                             S_InventoryUnit, S_AmountDoc, S_AmountDocPart, S_QuantityDoc, 
                             S_SecurityLevel, S_DateCreation, S_DateCompletion, S_DateExpiration, 
                             S_DateActivation, S_DateSigned, S_NameCreation, S_NameAproval, 
                             S_NameControl, S_NameApproved, S_ListToView, S_ListToEdit, 
                             S_ListToReconcile, S_ListReconciled, S_NameResponsible, 
                             S_NameLastModification, S_DateLastModification, S_TypeDoc, 
                             S_StandardNameTexts, S_ClassDoc, S_BusinessProcessStep, S_IsActive, 
                             HasNoSub, S_UserFields, TextConsts, MailTexts);
end;

function TCommon.Mult(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.Mult(cPar);
end;

procedure TCommon.ChangeAct(var S_Type: OleVariant; var DOCS_ALREADYEXISTS: OleVariant; 
                            var DOCS_NOTFOUND: OleVariant; var DOCS_Changed: OleVariant; 
                            var VAR_AdminSecLevel: OleVariant; var DOCS_NORight: OleVariant);
begin
  DefaultInterface.ChangeAct(S_Type, DOCS_ALREADYEXISTS, DOCS_NOTFOUND, DOCS_Changed, 
                             VAR_AdminSecLevel, DOCS_NORight);
end;

procedure TCommon.CopyCompany(var DOCS_Copied1: OleVariant; var DOCS_ALREADYEXISTS: OleVariant);
begin
  DefaultInterface.CopyCompany(DOCS_Copied1, DOCS_ALREADYEXISTS);
end;

function TCommon.LeadSymbolN(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant;
begin
  Result := DefaultInterface.LeadSymbolN(cPar, symbol, N);
end;

function TCommon.LeadSymbolN1(var cPar: OleVariant; var symbol: OleVariant; var N: OleVariant): OleVariant;
begin
  Result := DefaultInterface.LeadSymbolN1(cPar, symbol, N);
end;

procedure TCommon.BusinessProcessInit(sBusinessProcessSteps: OleVariant);
begin
  DefaultInterface.BusinessProcessInit(sBusinessProcessSteps);
end;

procedure TCommon.BPSetResultFinal(var sResultText: OleVariant);
begin
  DefaultInterface.BPSetResultFinal(sResultText);
end;

function TCommon.BPResultFinal: OleVariant;
begin
  Result := DefaultInterface.BPResultFinal;
end;

function TCommon.BPStepName(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPStepName(nBPStep, sError);
end;

function TCommon.BPStepNumber(sBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPStepNumber(sBPStep, sError);
end;

function TCommon.BPIsInactive(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIsInactive(nBPStep, sError);
end;

function TCommon.BPIsActive(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIsActive(nBPStep, sError);
end;

function TCommon.BPIsActiveCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIsActiveCurrent(nBPStep, sError);
end;

function TCommon.BPIsCompleted(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIsCompleted(nBPStep, sError);
end;

function TCommon.BPIsCanceled(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIsCanceled(nBPStep, sError);
end;

function TCommon.BPSetSeparator(nBPStep: OleVariant; var sTitle: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSetSeparator(nBPStep, sTitle, sError);
end;

function TCommon.BPSetComment(nBPStep: OleVariant; var sComment: OleVariant; 
                              var sError: OleVariant; var sPict: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSetComment(nBPStep, sComment, sError, sPict);
end;

function TCommon.BPSeparator(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSeparator(nBPStep, sError);
end;

function TCommon.BPComment(nBPStep: OleVariant; var sError: OleVariant; var sPict: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPComment(nBPStep, sError, sPict);
end;

function TCommon.BPResult(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPResult(nBPStep, sError);
end;

function TCommon.BPResultNumber(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPResultNumber(nBPStep, sError);
end;

function TCommon.BPSetResults(nBPStep: OleVariant; var sResultSet: OleVariant; 
                              var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSetResults(nBPStep, sResultSet, sError);
end;

function TCommon.BPResultSet(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPResultSet(nBPStep, sError);
end;

function TCommon.BPSetResult(nBPStep: OleVariant; var nResult: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSetResult(nBPStep, nResult, sError);
end;

function TCommon.BPSetResultString(nBPStep: OleVariant; var sResult: OleVariant; 
                                   var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPSetResultString(nBPStep, sResult, sError);
end;

function TCommon.BPCancel(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPCancel(nBPStep, sError);
end;

function TCommon.BPComplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPComplete(nBPStep, sError);
end;

function TCommon.BPIncomplete(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPIncomplete(nBPStep, sError);
end;

function TCommon.BPDeactivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPDeactivate(nBPStep, sError);
end;

function TCommon.BPActivate(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPActivate(nBPStep, sError);
end;

function TCommon.BPActivateCurrent(nBPStep: OleVariant; var sError: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BPActivateCurrent(nBPStep, sError);
end;

function TCommon.IsWrongNBPStep(var nBPStep: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsWrongNBPStep(nBPStep);
end;

function TCommon.BoardOrderValue(var dDate: OleVariant; var sKey: OleVariant; 
                                 var dDateEvent: OleVariant): OleVariant;
begin
  Result := DefaultInterface.BoardOrderValue(dDate, sKey, dDateEvent);
end;

function TCommon.BoardOrderValueSQL: OleVariant;
begin
  Result := DefaultInterface.BoardOrderValueSQL;
end;

procedure TCommon.CheckOut(var DOCS_All: OleVariant; var DOCS_NoWriteAccess: OleVariant; 
                           var DOCS_NoAccess: OleVariant; var DOCS_LOGIN: OleVariant; 
                           var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var DOCS_CheckedOut: OleVariant; 
                           var DOCS_Version: OleVariant; var DOCS_CheckedOutAlready: OleVariant);
begin
  DefaultInterface.CheckOut(DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, DOCS_LOGIN, 
                            USER_Department, VAR_ExtInt, VAR_AdminSecLevel, DOCS_CheckedOut, 
                            DOCS_Version, DOCS_CheckedOutAlready);
end;

procedure TCommon.CreateComment(var DOCS_Changed: OleVariant; var DOCS_Created: OleVariant; 
                                var VAR_CommentDescription: OleVariant; 
                                var VAR_Subject: OleVariant; var DOCS_News: OleVariant; 
                                var VAR_BeginOfTimes: OleVariant; var DOCS_WrongDate: OleVariant; 
                                var DOCS_DateFormat: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_DocID: OleVariant; var DOCS_DateActivation: OleVariant; 
                                var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                                var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                                var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                                var DOCS_Correspondent: OleVariant; 
                                var DOCS_Resolution: OleVariant; 
                                var DOCS_NotificationSentTo: OleVariant; 
                                var DOCS_SendNotification: OleVariant; 
                                var DOCS_UsersNotFound: OleVariant; 
                                var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                                var DOCS_NoAccess: OleVariant; var DOCS_EXPIREDSEC: OleVariant; 
                                var DOCS_STATUSHOLD: OleVariant; 
                                var VAR_StatusActiveUser: OleVariant; 
                                var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                                var DOCS_All: OleVariant; var DOCS_NoReadAccess: OleVariant; 
                                var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                                var VAR_AdminSecLevel: OleVariant; var DOCS_FROM1: OleVariant; 
                                var DOCS_Reconciliation: OleVariant; 
                                var DOCS_NotificationNotCompletedDoc: OleVariant; 
                                var MailTexts: OleVariant);
begin
  DefaultInterface.CreateComment(DOCS_Changed, DOCS_Created, VAR_CommentDescription, VAR_Subject, 
                                 DOCS_News, VAR_BeginOfTimes, DOCS_WrongDate, DOCS_DateFormat, 
                                 DOCS_NOTFOUND, DOCS_DocID, DOCS_DateActivation, 
                                 DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                 DOCS_Description, DOCS_Author, DOCS_Correspondent, 
                                 DOCS_Resolution, DOCS_NotificationSentTo, DOCS_SendNotification, 
                                 DOCS_UsersNotFound, DOCS_NotificationDoc, USER_NOEMail, 
                                 DOCS_NoAccess, DOCS_EXPIREDSEC, DOCS_STATUSHOLD, 
                                 VAR_StatusActiveUser, DOCS_ErrorSMTP, DOCS_Sender, DOCS_All, 
                                 DOCS_NoReadAccess, USER_Department, VAR_ExtInt, VAR_AdminSecLevel, 
                                 DOCS_FROM1, DOCS_Reconciliation, DOCS_NotificationNotCompletedDoc, 
                                 MailTexts);
end;

procedure TCommon.CreateCommentEMailClient(var sUserID: OleVariant; var sUserName: OleVariant; 
                                           var sDocID: OleVariant; var sCommentType: OleVariant; 
                                           var sSubject: OleVariant; var sComment: OleVariant; 
                                           var sMessage: OleVariant; 
                                           var DOCS_CommentCreated: OleVariant);
begin
  DefaultInterface.CreateCommentEMailClient(sUserID, sUserName, sDocID, sCommentType, sSubject, 
                                            sComment, sMessage, DOCS_CommentCreated);
end;

procedure TCommon.CreateViewed(var ds: OleVariant; var sDocIDpar: OleVariant; 
                               var DOCS_Viewed: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; var DOCS_NOTFOUND: OleVariant);
begin
  DefaultInterface.CreateViewed(ds, sDocIDpar, DOCS_Viewed, DOCS_All, DOCS_NoReadAccess, 
                                DOCS_NoAccess, USER_Department, VAR_ExtInt, VAR_AdminSecLevel, 
                                DOCS_NOTFOUND);
end;

procedure TCommon.UploadDescriptionXMLRet(var sMessage: OleVariant; var DocFields: OleVariant; 
                                          var nFields: OleVariant; var ReportFields: OleVariant; 
                                          var nReportFields: OleVariant; 
                                          var DOCS_ALREADYEXISTS: OleVariant; 
                                          var DOCS_FileUploaded: OleVariant; 
                                          var DOCS_DocID: OleVariant; var DOCS_Name: OleVariant);
begin
  DefaultInterface.UploadDescriptionXMLRet(sMessage, DocFields, nFields, ReportFields, 
                                           nReportFields, DOCS_ALREADYEXISTS, DOCS_FileUploaded, 
                                           DOCS_DocID, DOCS_Name);
end;

function TCommon.IsFieldExist(var rs: OleVariant; var sFieldName: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsFieldExist(rs, sFieldName);
end;

procedure TCommon.UploadPartnerRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                   var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_FileNotUploaded: OleVariant; 
                                   var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                   var DOCS_FileName: OleVariant; 
                                   var DOCS_VersionFileChanged: OleVariant; 
                                   var DOCS_NoModiFile1: OleVariant; 
                                   var DOCS_NoModiFile2: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.UploadPartnerRet(sMessage, DOCS_WRONFILEFORMAT, DOCS_NORight, DOCS_LOGIN, 
                                    DOCS_NOTFOUND, DOCS_FileNotUploaded, DOCS_FileUploaded, 
                                    DOCS_Version, DOCS_FileName, DOCS_VersionFileChanged, 
                                    DOCS_NoModiFile1, DOCS_NoModiFile2, VAR_BeginOfTimes);
end;

procedure TCommon.UploadDepartmentRet(var sMessage: OleVariant; 
                                      var DOCS_WRONFILEFORMAT: OleVariant; 
                                      var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; 
                                      var DOCS_FileNotUploaded: OleVariant; 
                                      var DOCS_FileUploaded: OleVariant; 
                                      var DOCS_Version: OleVariant; var DOCS_FileName: OleVariant; 
                                      var DOCS_VersionFileChanged: OleVariant; 
                                      var DOCS_NoModiFile1: OleVariant; 
                                      var DOCS_NoModiFile2: OleVariant; 
                                      var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.UploadDepartmentRet(sMessage, DOCS_WRONFILEFORMAT, DOCS_NORight, DOCS_LOGIN, 
                                       DOCS_NOTFOUND, DOCS_FileNotUploaded, DOCS_FileUploaded, 
                                       DOCS_Version, DOCS_FileName, DOCS_VersionFileChanged, 
                                       DOCS_NoModiFile1, DOCS_NoModiFile2, VAR_BeginOfTimes);
end;

procedure TCommon.UploadTypeDocRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                   var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                   var DOCS_NOTFOUND: OleVariant; 
                                   var DOCS_FileNotUploaded: OleVariant; 
                                   var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                                   var DOCS_FileName: OleVariant; 
                                   var DOCS_VersionFileChanged: OleVariant; 
                                   var DOCS_NoModiFile1: OleVariant; 
                                   var DOCS_NoModiFile2: OleVariant; 
                                   var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.UploadTypeDocRet(sMessage, DOCS_WRONFILEFORMAT, DOCS_NORight, DOCS_LOGIN, 
                                    DOCS_NOTFOUND, DOCS_FileNotUploaded, DOCS_FileUploaded, 
                                    DOCS_Version, DOCS_FileName, DOCS_VersionFileChanged, 
                                    DOCS_NoModiFile1, DOCS_NoModiFile2, VAR_BeginOfTimes);
end;

procedure TCommon.UploadUserPhotoRet(var sMessage: OleVariant; var DOCS_WRONFILEFORMAT: OleVariant; 
                                     var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                     var DOCS_NOTFOUND: OleVariant; 
                                     var DOCS_FileNotUploaded: OleVariant; 
                                     var DOCS_FileUploaded: OleVariant; 
                                     var DOCS_Version: OleVariant; var DOCS_FileName: OleVariant; 
                                     var DOCS_VersionFileChanged: OleVariant; 
                                     var DOCS_NoModiFile1: OleVariant; 
                                     var DOCS_NoModiFile2: OleVariant; 
                                     var VAR_BeginOfTimes: OleVariant);
begin
  DefaultInterface.UploadUserPhotoRet(sMessage, DOCS_WRONFILEFORMAT, DOCS_NORight, DOCS_LOGIN, 
                                      DOCS_NOTFOUND, DOCS_FileNotUploaded, DOCS_FileUploaded, 
                                      DOCS_Version, DOCS_FileName, DOCS_VersionFileChanged, 
                                      DOCS_NoModiFile1, DOCS_NoModiFile2, VAR_BeginOfTimes);
end;

function TCommon.PostcardFilePrefix: OleVariant;
begin
  Result := DefaultInterface.PostcardFilePrefix;
end;

function TCommon.PostcardFile(var sExt: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PostcardFile(sExt);
end;

function TCommon.PostcardFileNoPath(var sExt: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PostcardFileNoPath(sExt);
end;

function TCommon.PostcardFileURL(var sExt: OleVariant): OleVariant;
begin
  Result := DefaultInterface.PostcardFileURL(sExt);
end;

function TCommon.IsPostcardFile(sFile: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsPostcardFile(sFile);
end;

procedure TCommon.UploadPostcardPicRet(var sMessage: OleVariant; var sFile: OleVariant; 
                                       var sFileURL: OleVariant; 
                                       var DOCS_WRONFILEFORMAT: OleVariant; 
                                       var DOCS_NORight: OleVariant; var DOCS_LOGIN: OleVariant; 
                                       var DOCS_NOTFOUND: OleVariant; 
                                       var DOCS_FileNotUploaded: OleVariant; 
                                       var DOCS_FileUploaded: OleVariant; 
                                       var DOCS_Version: OleVariant; var DOCS_FileName: OleVariant; 
                                       var DOCS_VersionFileChanged: OleVariant; 
                                       var DOCS_NoModiFile1: OleVariant; 
                                       var DOCS_NoModiFile2: OleVariant; 
                                       var VAR_BeginOfTimes: OleVariant; 
                                       var DOCS_MaxFileSizeExceeded1: OleVariant);
begin
  DefaultInterface.UploadPostcardPicRet(sMessage, sFile, sFileURL, DOCS_WRONFILEFORMAT, 
                                        DOCS_NORight, DOCS_LOGIN, DOCS_NOTFOUND, 
                                        DOCS_FileNotUploaded, DOCS_FileUploaded, DOCS_Version, 
                                        DOCS_FileName, DOCS_VersionFileChanged, DOCS_NoModiFile1, 
                                        DOCS_NoModiFile2, VAR_BeginOfTimes, 
                                        DOCS_MaxFileSizeExceeded1);
end;

procedure TCommon.LoadDBCheck(var bMain: OleVariant; var DOCS_Table: OleVariant; 
                              var DOCS_TableContainsData: OleVariant; 
                              var DOCS_TableContainsDataNot: OleVariant; var bOKAny: OleVariant);
begin
  DefaultInterface.LoadDBCheck(bMain, DOCS_Table, DOCS_TableContainsData, 
                               DOCS_TableContainsDataNot, bOKAny);
end;

procedure TCommon.LoadDB(var DOCS_TableContainsData: OleVariant; 
                         var DOCS_TableSourceNoData: OleVariant; var DOCS_Records: OleVariant; 
                         var VAR_AdminSecLevel: OleVariant; var DOCS_LoadDB1: OleVariant; 
                         var DOCS_Error: OleVariant; var DOCS_Table: OleVariant; 
                         var DOCS_Field: OleVariant; var DOCS_FieldValue: OleVariant; 
                         var DOCS_FieldTypeFrom: OleVariant; var DOCS_FieldTypeTo: OleVariant; 
                         var DOCS_LoadDBEnd: OleVariant; 
                         var DOCS_TableSourceRecordCount: OleVariant; 
                         var DOCS_TableTargetRecordCount: OleVariant);
begin
  DefaultInterface.LoadDB(DOCS_TableContainsData, DOCS_TableSourceNoData, DOCS_Records, 
                          VAR_AdminSecLevel, DOCS_LoadDB1, DOCS_Error, DOCS_Table, DOCS_Field, 
                          DOCS_FieldValue, DOCS_FieldTypeFrom, DOCS_FieldTypeTo, DOCS_LoadDBEnd, 
                          DOCS_TableSourceRecordCount, DOCS_TableTargetRecordCount);
end;

procedure TCommon.UploadRetNew(sNotificationList: OleVariant; var sMessage: OleVariant; 
                               var sKeyField: OleVariant; var DOCS_LOGIN: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FileNotUploaded: OleVariant; 
                               var DOCS_FileUploaded: OleVariant; var DOCS_Version: OleVariant; 
                               var DOCS_FileName: OleVariant; 
                               var DOCS_VersionFileChanged: OleVariant; 
                               var DOCS_NoModiFile1: OleVariant; var DOCS_NoModiFile2: OleVariant; 
                               var VAR_BeginOfTimes: OleVariant; var DOCS_NORight: OleVariant; 
                               var DOCS_CheckInUsePictogram: OleVariant; 
                               var DOCS_VersionFileUploaded: OleVariant; 
                               var DOCS_CheckedIn: OleVariant; var DOCS_All: OleVariant; 
                               var DOCS_NoWriteAccess: OleVariant; var DOCS_NoAccess: OleVariant; 
                               var USER_Department: OleVariant; var VAR_ExtInt: OleVariant; 
                               var VAR_AdminSecLevel: OleVariant; 
                               var DOCS_RecListUsersUpload: OleVariant; 
                               var DOCS_AccessDenied: OleVariant; var DOCS_DocID: OleVariant; 
                               var DOCS_DateActivation: OleVariant; 
                               var DOCS_DateCompletion: OleVariant; var DOCS_Name: OleVariant; 
                               var DOCS_PartnerName: OleVariant; var DOCS_ACT: OleVariant; 
                               var DOCS_Description: OleVariant; var DOCS_Author: OleVariant; 
                               var DOCS_Correspondent: OleVariant; var DOCS_Resolution: OleVariant; 
                               var DOCS_NotificationSentTo: OleVariant; 
                               var DOCS_SendNotification: OleVariant; 
                               var DOCS_UsersNotFound: OleVariant; 
                               var DOCS_NotificationDoc: OleVariant; var USER_NOEMail: OleVariant; 
                               var DOCS_EXPIREDSEC: OleVariant; var DOCS_STATUSHOLD: OleVariant; 
                               var VAR_StatusActiveUser: OleVariant; 
                               var DOCS_ErrorSMTP: OleVariant; var DOCS_Sender: OleVariant; 
                               var DOCS_NoReadAccess: OleVariant; var DOCS_FROM1: OleVariant; 
                               var DOCS_Reconciliation: OleVariant; 
                               var DOCS_NotificationNotCompletedDoc: OleVariant; 
                               var MailTexts: OleVariant);
begin
  DefaultInterface.UploadRetNew(sNotificationList, sMessage, sKeyField, DOCS_LOGIN, DOCS_NOTFOUND, 
                                DOCS_FileNotUploaded, DOCS_FileUploaded, DOCS_Version, 
                                DOCS_FileName, DOCS_VersionFileChanged, DOCS_NoModiFile1, 
                                DOCS_NoModiFile2, VAR_BeginOfTimes, DOCS_NORight, 
                                DOCS_CheckInUsePictogram, DOCS_VersionFileUploaded, DOCS_CheckedIn, 
                                DOCS_All, DOCS_NoWriteAccess, DOCS_NoAccess, USER_Department, 
                                VAR_ExtInt, VAR_AdminSecLevel, DOCS_RecListUsersUpload, 
                                DOCS_AccessDenied, DOCS_DocID, DOCS_DateActivation, 
                                DOCS_DateCompletion, DOCS_Name, DOCS_PartnerName, DOCS_ACT, 
                                DOCS_Description, DOCS_Author, DOCS_Correspondent, DOCS_Resolution, 
                                DOCS_NotificationSentTo, DOCS_SendNotification, DOCS_UsersNotFound, 
                                DOCS_NotificationDoc, USER_NOEMail, DOCS_EXPIREDSEC, 
                                DOCS_STATUSHOLD, VAR_StatusActiveUser, DOCS_ErrorSMTP, DOCS_Sender, 
                                DOCS_NoReadAccess, DOCS_FROM1, DOCS_Reconciliation, 
                                DOCS_NotificationNotCompletedDoc, MailTexts);
end;

function TCommon.GetRandomSeq(var nSeq: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetRandomSeq(nSeq);
end;

procedure TCommon.ListPartners(var dsDoc: OleVariant; var sSQL: OleVariant; 
                               var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                               var VAR_DocsMaxRecords: OleVariant; 
                               var par_searchsearch: OleVariant; var par_C_Search: OleVariant; 
                               var par_SearchComments: OleVariant; var par_Companies: OleVariant);
begin
  DefaultInterface.ListPartners(dsDoc, sSQL, DOCS_NOTFOUND, DOCS_FOUND, VAR_DocsMaxRecords, 
                                par_searchsearch, par_C_Search, par_SearchComments, par_Companies);
end;

procedure TCommon.ListUserDirectories(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                      var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                                      var VAR_DocsMaxRecords: OleVariant; 
                                      var USER_Department: OleVariant; 
                                      var VAR_AdminSecLevel: OleVariant);
begin
  DefaultInterface.ListUserDirectories(dsDoc, sSQL, DOCS_NOTFOUND, DOCS_FOUND, VAR_DocsMaxRecords, 
                                       USER_Department, VAR_AdminSecLevel);
end;

procedure TCommon.ListReportRequests(var sSQL: OleVariant; var USER_Department: OleVariant; 
                                     var VAR_AdminSecLevel: OleVariant; var DOCS_All: OleVariant);
begin
  DefaultInterface.ListReportRequests(sSQL, USER_Department, VAR_AdminSecLevel, DOCS_All);
end;

procedure TCommon.ListUserDirectoryValues(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                          var KeyField: OleVariant);
begin
  DefaultInterface.ListUserDirectoryValues(dsDoc, sSQL, KeyField);
end;

procedure TCommon.ListDirectoryValues(var sSQL: OleVariant);
begin
  DefaultInterface.ListDirectoryValues(sSQL);
end;

procedure TCommon.ListUsers(var dsDoc: OleVariant; var sSQL: OleVariant; 
                            var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                            var DOCS_FOUND: OleVariant; var DOCS_Fired: OleVariant; 
                            var par_Companies: OleVariant; var par_searchPartner: OleVariant; 
                            var par_searchDepartment: OleVariant; var par_searchsearch: OleVariant; 
                            var par_C_Search: OleVariant; var par_searchPosition: OleVariant);
begin
  DefaultInterface.ListUsers(dsDoc, sSQL, VAR_DocsMaxRecords, DOCS_NOTFOUND, DOCS_FOUND, 
                             DOCS_Fired, par_Companies, par_searchPartner, par_searchDepartment, 
                             par_searchsearch, par_C_Search, par_searchPosition);
end;

procedure TCommon.ListDirectories(var dsDoc: OleVariant; var sCurDir: OleVariant; 
                                  var VAR_DocsMaxRecords: OleVariant; 
                                  var DOCS_NOTFOUND: OleVariant; var DOCS_FOUND: OleVariant; 
                                  var DOCS_Fired: OleVariant);
begin
  DefaultInterface.ListDirectories(dsDoc, sCurDir, VAR_DocsMaxRecords, DOCS_NOTFOUND, DOCS_FOUND, 
                                   DOCS_Fired);
end;

procedure TCommon.ListInventory(var dsDoc: OleVariant; var sSQL: OleVariant; 
                                var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                                var DOCS_FOUND: OleVariant);
begin
  DefaultInterface.ListInventory(dsDoc, sSQL, VAR_DocsMaxRecords, DOCS_NOTFOUND, DOCS_FOUND);
end;

procedure TCommon.ListMeasure(var dsDoc: OleVariant; var sSQL: OleVariant; 
                              var VAR_DocsMaxRecords: OleVariant; var DOCS_NOTFOUND: OleVariant; 
                              var DOCS_FOUND: OleVariant);
begin
  DefaultInterface.ListMeasure(dsDoc, sSQL, VAR_DocsMaxRecords, DOCS_NOTFOUND, DOCS_FOUND);
end;

procedure TCommon.ShowListNotices(var S_DocID: OleVariant; var dsDoc1: OleVariant; 
                                  var sBusinessProcessSteps: OleVariant; 
                                  var DOCS_Notices: OleVariant);
begin
  DefaultInterface.ShowListNotices(S_DocID, dsDoc1, sBusinessProcessSteps, DOCS_Notices);
end;

function TCommon.CommentsOrder: OleVariant;
begin
  Result := DefaultInterface.CommentsOrder;
end;

procedure TCommon.ShowListComments(var S_DocID: OleVariant; var dsDoc1: OleVariant);
begin
  DefaultInterface.ShowListComments(S_DocID, dsDoc1);
end;

procedure TCommon.ShowListCommentsTransactions(var S_GUID: OleVariant; var dsDoc1: OleVariant);
begin
  DefaultInterface.ShowListCommentsTransactions(S_GUID, dsDoc1);
end;

procedure TCommon.ShowListCommentsPartner(var S_PartnerID: OleVariant; var S_Partner: OleVariant; 
                                          var dsDoc1: OleVariant);
begin
  DefaultInterface.ShowListCommentsPartner(S_PartnerID, S_Partner, dsDoc1);
end;

procedure TCommon.ShowListCommentsUser(var S_UserID: OleVariant; var dsDoc1: OleVariant);
begin
  DefaultInterface.ShowListCommentsUser(S_UserID, dsDoc1);
end;

procedure TCommon.ShowListSpecUnits(var S_DocID: OleVariant; var ds: OleVariant; 
                                    var sSpecIDs: OleVariant);
begin
  DefaultInterface.ShowListSpecUnits(S_DocID, ds, sSpecIDs);
end;

procedure TCommon.ShowDocSpecItems(var S_DocID: OleVariant; var dsDoc1: OleVariant);
begin
  DefaultInterface.ShowDocSpecItems(S_DocID, dsDoc1);
end;

function TCommon.ShowContext(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowContext(cPar);
end;

function TCommon.ShowContextHTMLEncode(var cPar: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowContextHTMLEncode(cPar);
end;

function TCommon.GetExt(var fName: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetExt(fName);
end;

function TCommon.GetWithoutExt(var fName: OleVariant): OleVariant;
begin
  Result := DefaultInterface.GetWithoutExt(fName);
end;

function TCommon.AddLogM(var sLog: OleVariant): OleVariant;
begin
  Result := DefaultInterface.AddLogM(sLog);
end;

function TCommon.MailListOLD(var DOCS_MailListNotFound: OleVariant; var DOCS_MailList: OleVariant; 
                             var DOCS_MailsSent: OleVariant; var VAR_BeginOfTimes: OleVariant): OleVariant;
begin
  Result := DefaultInterface.MailListOLD(DOCS_MailListNotFound, DOCS_MailList, DOCS_MailsSent, 
                                         VAR_BeginOfTimes);
end;

procedure TCommon.GetMailListFilesAndMessages(var Files: OleVariant; var iMsgs: OleVariant);
begin
  DefaultInterface.GetMailListFilesAndMessages(Files, iMsgs);
end;

procedure TCommon.GetPrintFiles(var Files: OleVariant);
begin
  DefaultInterface.GetPrintFiles(Files);
end;

procedure TCommon.MailList(var rs: OleVariant; var sDataName: OleVariant; 
                           var VAR_AdminSecLevel: OleVariant; var USER_NOEMail: OleVariant; 
                           var USER_BADEMail: OleVariant; var DOCS_MailListMarkFile: OleVariant; 
                           var DOCS_MessageSent: OleVariant; 
                           var DOCS_MailListMarkExtData: OleVariant; var DOCS_DBEOF: OleVariant; 
                           var DOCS_MailList: OleVariant; var VAR_BeginOfTimes: OleVariant; 
                           var DOCS_MailsSent: OleVariant; var DOCS_DataSourceRecords: OleVariant; 
                           var DOCS_LISTUSERS: OleVariant; var DOCS_LISTCONTACTNAMES: OleVariant; 
                           var DOCS_Source: OleVariant; var DOCS_FileName: OleVariant; 
                           var DOCS_MailListERROR1: OleVariant; 
                           var DOCS_ErrorDataSource: OleVariant; 
                           var DOCS_ErrorSelectRecordset: OleVariant; 
                           var DOCS_ErrorSelectRecordsetArch: OleVariant; 
                           var DOCS_ErrorInsertPars: OleVariant; 
                           var DOCS_ErrorSelectNotDefined: OleVariant; 
                           var DOCS_MailListERRORTO: OleVariant; 
                           var DOCS_MailListERRORFIELD: OleVariant; 
                           var DOCS_MailListRunning: OleVariant; 
                           var DOCS_MailListERROR2: OleVariant; 
                           var DOCS_DemoMaximumMails: OleVariant; 
                           var DOCS_MailListERROR3: OleVariant; var nDelay: OleVariant);
begin
  DefaultInterface.MailList(rs, sDataName, VAR_AdminSecLevel, USER_NOEMail, USER_BADEMail, 
                            DOCS_MailListMarkFile, DOCS_MessageSent, DOCS_MailListMarkExtData, 
                            DOCS_DBEOF, DOCS_MailList, VAR_BeginOfTimes, DOCS_MailsSent, 
                            DOCS_DataSourceRecords, DOCS_LISTUSERS, DOCS_LISTCONTACTNAMES, 
                            DOCS_Source, DOCS_FileName, DOCS_MailListERROR1, DOCS_ErrorDataSource, 
                            DOCS_ErrorSelectRecordset, DOCS_ErrorSelectRecordsetArch, 
                            DOCS_ErrorInsertPars, DOCS_ErrorSelectNotDefined, DOCS_MailListERRORTO, 
                            DOCS_MailListERRORFIELD, DOCS_MailListRunning, DOCS_MailListERROR2, 
                            DOCS_DemoMaximumMails, DOCS_MailListERROR3, nDelay);
end;

function TCommon.CheckRSField(var rs: OleVariant; var sToField: OleVariant): OleVariant;
begin
  Result := DefaultInterface.CheckRSField(rs, sToField);
end;

procedure TCommon.GetKeyFromString(var sPar: OleVariant; var sLeft: OleVariant; 
                                   var sRight: OleVariant; var iStart: OleVariant; 
                                   var sKey: OleVariant; var nPoz: OleVariant; var nLen: OleVariant);
begin
  DefaultInterface.GetKeyFromString(sPar, sLeft, sRight, iStart, sKey, nPoz, nLen);
end;

procedure TCommon.InsertEMailListPars(var sText: OleVariant; sType: OleVariant; sData: OleVariant; 
                                      var rs: OleVariant);
begin
  DefaultInterface.InsertEMailListPars(sText, sType, sData, rs);
end;

function TCommon.InsertParsFromRS(var bErr: OleVariant; var rs: OleVariant; 
                                  sSourceText: OleVariant; sFieldArray: OleVariant; 
                                  nPozArray: OleVariant; nLenArray: OleVariant; nSize: OleVariant; 
                                  VAR_BeginOfTimes: OleVariant; var DOCS_MailListERROR3: OleVariant): OleVariant;
begin
  Result := DefaultInterface.InsertParsFromRS(bErr, rs, sSourceText, sFieldArray, nPozArray, 
                                              nLenArray, nSize, VAR_BeginOfTimes, 
                                              DOCS_MailListERROR3);
end;

function TCommon.IsLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant): OleVariant;
begin
  Result := DefaultInterface.IsLogFieldInUse(cPar, S_VisibleFields);
end;

function TCommon.PutLogFieldInUseNumber: OleVariant;
begin
  Result := DefaultInterface.PutLogFieldInUseNumber;
end;

procedure TCommon.PutLogFieldInUse(var cPar: OleVariant; var S_VisibleFields: OleVariant);
begin
  DefaultInterface.PutLogFieldInUse(cPar, S_VisibleFields);
end;

function TCommon.MoneyFormat(var Amount: Currency): WideString;
begin
  Result := DefaultInterface.MoneyFormat(Amount);
end;

function TCommon.MakeHTMLSafe(var sText: WideString): WideString;
begin
  Result := DefaultInterface.MakeHTMLSafe(sText);
end;

function TCommon.Unescape(var s: WideString): OleVariant;
begin
  Result := DefaultInterface.Unescape(s);
end;

function TCommon.FindExtraHeader(var key: WideString): WideString;
begin
  Result := DefaultInterface.FindExtraHeader(key);
end;

function TCommon.myMethod(const myString: WideString): WideString;
begin
  Result := DefaultInterface.myMethod(myString);
end;

function TCommon.RoundMoney(pAmount: Currency): Currency;
begin
  Result := DefaultInterface.RoundMoney(pAmount);
end;

function TCommon.RightAmount(const pAmount: WideString): Currency;
begin
  Result := DefaultInterface.RightAmount(pAmount);
end;

function TCommon.myPowerMethod: OleVariant;
begin
  Result := DefaultInterface.myPowerMethod;
end;

procedure TCommon.SendContent(var s: WideString);
begin
  DefaultInterface.SendContent(s);
end;

function TCommon.RUS: OleVariant;
begin
  Result := DefaultInterface.RUS;
end;

function TCommon.RUZone: OleVariant;
begin
  Result := DefaultInterface.RUZone;
end;

function TCommon.LPar: OleVariant;
begin
  Result := DefaultInterface.LPar;
end;

function TCommon.LPar1: OleVariant;
begin
  Result := DefaultInterface.LPar1;
end;

procedure TCommon.MainCommon;
begin
  DefaultInterface.MainCommon;
end;

procedure TCommon.doSetKey(var txtKey: WideString);
begin
  DefaultInterface.doSetKey(txtKey);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCommonProperties.Create(AServer: TCommon);
begin
  inherited Create;
  FServer := AServer;
end;

function TCommonProperties.GetDefaultInterface: _Common;
begin
  Result := FServer.DefaultInterface;
end;

function TCommonProperties.Get_obj: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.obj;
end;

procedure TCommonProperties.Set_obj(var obj: OleVariant);
  { Warning: The property obj has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.obj := obj;
end;

procedure TCommonProperties._Set_obj(var obj: OleVariant);
  { Warning: The property obj has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.obj := obj;
end;

function TCommonProperties.Get_doc: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.doc;
end;

procedure TCommonProperties.Set_doc(var doc: OleVariant);
  { Warning: The property doc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.doc := doc;
end;

procedure TCommonProperties._Set_doc(var doc: OleVariant);
  { Warning: The property doc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.doc := doc;
end;

function TCommonProperties.Get_oXL: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oXL;
end;

procedure TCommonProperties.Set_oXL(var oXL: OleVariant);
  { Warning: The property oXL has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oXL := oXL;
end;

procedure TCommonProperties._Set_oXL(var oXL: OleVariant);
  { Warning: The property oXL has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oXL := oXL;
end;

function TCommonProperties.Get_oWB: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oWB;
end;

procedure TCommonProperties.Set_oWB(var oWB: OleVariant);
  { Warning: The property oWB has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oWB := oWB;
end;

procedure TCommonProperties._Set_oWB(var oWB: OleVariant);
  { Warning: The property oWB has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oWB := oWB;
end;

function TCommonProperties.Get_oSheet: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oSheet;
end;

procedure TCommonProperties.Set_oSheet(var oSheet: OleVariant);
  { Warning: The property oSheet has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oSheet := oSheet;
end;

procedure TCommonProperties._Set_oSheet(var oSheet: OleVariant);
  { Warning: The property oSheet has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oSheet := oSheet;
end;

function TCommonProperties.Get_oRng: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.oRng;
end;

procedure TCommonProperties.Set_oRng(var oRng: OleVariant);
  { Warning: The property oRng has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oRng := oRng;
end;

procedure TCommonProperties._Set_oRng(var oRng: OleVariant);
  { Warning: The property oRng has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.oRng := oRng;
end;

function TCommonProperties.Get_Conn: _Connection;
begin
    Result := DefaultInterface.Conn;
end;

procedure TCommonProperties._Set_Conn(const Conn: _Connection);
  { Warning: The property Conn has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Conn := Conn;
end;

function TCommonProperties.Get_ds: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ds;
end;

procedure TCommonProperties.Set_ds(var ds: OleVariant);
  { Warning: The property ds has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ds := ds;
end;

procedure TCommonProperties._Set_ds(var ds: OleVariant);
  { Warning: The property ds has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.ds := ds;
end;

function TCommonProperties.Get_dsDoc: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc;
end;

procedure TCommonProperties.Set_dsDoc(var dsDoc: OleVariant);
  { Warning: The property dsDoc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc := dsDoc;
end;

procedure TCommonProperties._Set_dsDoc(var dsDoc: OleVariant);
  { Warning: The property dsDoc has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc := dsDoc;
end;

function TCommonProperties.Get_dsDoc1: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc1;
end;

procedure TCommonProperties.Set_dsDoc1(var dsDoc1: OleVariant);
  { Warning: The property dsDoc1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc1 := dsDoc1;
end;

procedure TCommonProperties._Set_dsDoc1(var dsDoc1: OleVariant);
  { Warning: The property dsDoc1 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc1 := dsDoc1;
end;

function TCommonProperties.Get_dsDoc2: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc2;
end;

procedure TCommonProperties.Set_dsDoc2(var dsDoc2: OleVariant);
  { Warning: The property dsDoc2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc2 := dsDoc2;
end;

procedure TCommonProperties._Set_dsDoc2(var dsDoc2: OleVariant);
  { Warning: The property dsDoc2 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc2 := dsDoc2;
end;

function TCommonProperties.Get_dsDoc3: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.dsDoc3;
end;

procedure TCommonProperties.Set_dsDoc3(var dsDoc3: OleVariant);
  { Warning: The property dsDoc3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc3 := dsDoc3;
end;

procedure TCommonProperties._Set_dsDoc3(var dsDoc3: OleVariant);
  { Warning: The property dsDoc3 has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDoc3 := dsDoc3;
end;

function TCommonProperties.Get_dsDocTemp: _Recordset;
begin
    Result := DefaultInterface.dsDocTemp;
end;

procedure TCommonProperties._Set_dsDocTemp(const dsDocTemp: _Recordset);
  { Warning: The property dsDocTemp has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.dsDocTemp := dsDocTemp;
end;

function TCommonProperties.Get_myProperty: WideString;
begin
    Result := DefaultInterface.myProperty;
end;

procedure TCommonProperties.Set_myProperty(const Param1: WideString);
  { Warning: The property myProperty has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.myProperty := Param1;
end;

procedure TCommonProperties.Set_SetSelector(const Param1: WideString);
  { Warning: The property SetSelector has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.SetSelector := Param1;
end;

function TCommonProperties.Get_myPowerProperty: WideString;
begin
    Result := DefaultInterface.myPowerProperty;
end;

{$ENDIF}

class function CoForm.Create: _Form;
begin
  Result := CreateComObject(CLASS_Form) as _Form;
end;

class function CoForm.CreateRemote(const MachineName: string): _Form;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Form) as _Form;
end;

class function CoFormItem.Create: _FormItem;
begin
  Result := CreateComObject(CLASS_FormItem) as _FormItem;
end;

class function CoFormItem.CreateRemote(const MachineName: string): _FormItem;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FormItem) as _FormItem;
end;

class function CoProperties.Create: _Properties;
begin
  Result := CreateComObject(CLASS_Properties) as _Properties;
end;

class function CoProperties.CreateRemote(const MachineName: string): _Properties;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Properties) as _Properties;
end;

class function CoProperty_.Create: _Property;
begin
  Result := CreateComObject(CLASS_Property_) as _Property;
end;

class function CoProperty_.CreateRemote(const MachineName: string): _Property;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Property_) as _Property;
end;

class function CoUpload.Create: _Upload;
begin
  Result := CreateComObject(CLASS_Upload) as _Upload;
end;

class function CoUpload.CreateRemote(const MachineName: string): _Upload;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Upload) as _Upload;
end;

procedure TUpload.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0A0F5AD2-7EAA-4DD7-B7FB-6254607CA504}';
    IntfIID:   '{753A1788-E813-4BD6-819D-72C8EB9DAB71}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TUpload.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Upload;
  end;
end;

procedure TUpload.ConnectTo(svrIntf: _Upload);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TUpload.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TUpload.GetDefaultInterface: _Upload;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TUpload.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TUploadProperties.Create(Self);
{$ENDIF}
end;

destructor TUpload.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TUpload.GetServerProperties: TUploadProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TUpload.Get_Form: _Form;
begin
    Result := DefaultInterface.Form;
end;

procedure TUpload.AddLogD(var cPar: OleVariant);
begin
  DefaultInterface.AddLogD(cPar);
end;

function TUpload.doUploadOLD: Integer;
begin
  Result := DefaultInterface.doUploadOLD;
end;

function TUpload.doUpload: Integer;
begin
  Result := DefaultInterface.doUpload;
end;

function TUpload.Download(const Path: WideString; const FileName: WideString): E_DOWNLOAD_RETURNVALUE;
begin
  Result := DefaultInterface.Download(Path, FileName);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TUploadProperties.Create(AServer: TUpload);
begin
  inherited Create;
  FServer := AServer;
end;

function TUploadProperties.GetDefaultInterface: _Upload;
begin
  Result := FServer.DefaultInterface;
end;

function TUploadProperties.Get_Form: _Form;
begin
    Result := DefaultInterface.Form;
end;

{$ENDIF}

class function CoConnect1C.Create: _Connect1C;
begin
  Result := CreateComObject(CLASS_Connect1C) as _Connect1C;
end;

class function CoConnect1C.CreateRemote(const MachineName: string): _Connect1C;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Connect1C) as _Connect1C;
end;

procedure TConnect1C.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2A9B48B8-081D-4C61-B12B-E4A43AE0E92F}';
    IntfIID:   '{E297D2EB-323A-4D37-B3FF-2B7B53B27287}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TConnect1C.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Connect1C;
  end;
end;

procedure TConnect1C.ConnectTo(svrIntf: _Connect1C);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TConnect1C.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TConnect1C.GetDefaultInterface: _Connect1C;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TConnect1C.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TConnect1CProperties.Create(Self);
{$ENDIF}
end;

destructor TConnect1C.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TConnect1C.GetServerProperties: TConnect1CProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TConnect1C.SFIn(const ComputerName: WideString; const BasePath: WideString; 
                          const AppType: WideString; const UserID: WideString; 
                          const Pass: WideString);
begin
  DefaultInterface.SFIn(ComputerName, BasePath, AppType, UserID, Pass);
end;

procedure TConnect1C.SFOut(const ComputerName: WideString; const BasePath: WideString; 
                           const AppType: WideString; const UserID: WideString; 
                           const Pass: WideString);
begin
  DefaultInterface.SFOut(ComputerName, BasePath, AppType, UserID, Pass);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TConnect1CProperties.Create(AServer: TConnect1C);
begin
  inherited Create;
  FServer := AServer;
end;

function TConnect1CProperties.GetDefaultInterface: _Connect1C;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoVB5Power.Create: _VB5Power;
begin
  Result := CreateComObject(CLASS_VB5Power) as _VB5Power;
end;

class function CoVB5Power.CreateRemote(const MachineName: string): _VB5Power;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VB5Power) as _VB5Power;
end;

procedure TVB5Power.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{50A1721E-CF78-42AD-9E84-1DC096F089D8}';
    IntfIID:   '{4AB5FC1C-A25B-4C6E-B40E-596D8F7D573A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TVB5Power.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _VB5Power;
  end;
end;

procedure TVB5Power.ConnectTo(svrIntf: _VB5Power);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TVB5Power.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TVB5Power.GetDefaultInterface: _VB5Power;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TVB5Power.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TVB5PowerProperties.Create(Self);
{$ENDIF}
end;

destructor TVB5Power.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TVB5Power.GetServerProperties: TVB5PowerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TVB5Power.Get_myProperty: WideString;
begin
    Result := DefaultInterface.myProperty;
end;

procedure TVB5Power.Set_myProperty(const Param1: WideString);
  { Warning: The property myProperty has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.myProperty := Param1;
end;

function TVB5Power.Get_myPowerProperty: WideString;
begin
    Result := DefaultInterface.myPowerProperty;
end;

function TVB5Power.myMethod(const myString: WideString): WideString;
begin
  Result := DefaultInterface.myMethod(myString);
end;

function TVB5Power.OnStartPage(var myScriptingContext: IScriptingContext): OleVariant;
begin
  Result := DefaultInterface.OnStartPage(myScriptingContext);
end;

function TVB5Power.OnEndPage: OleVariant;
begin
  Result := DefaultInterface.OnEndPage;
end;

function TVB5Power.myPowerMethod: OleVariant;
begin
  Result := DefaultInterface.myPowerMethod;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TVB5PowerProperties.Create(AServer: TVB5Power);
begin
  inherited Create;
  FServer := AServer;
end;

function TVB5PowerProperties.GetDefaultInterface: _VB5Power;
begin
  Result := FServer.DefaultInterface;
end;

function TVB5PowerProperties.Get_myProperty: WideString;
begin
    Result := DefaultInterface.myProperty;
end;

procedure TVB5PowerProperties.Set_myProperty(const Param1: WideString);
  { Warning: The property myProperty has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.myProperty := Param1;
end;

function TVB5PowerProperties.Get_myPowerProperty: WideString;
begin
    Result := DefaultInterface.myPowerProperty;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TCommon, TUpload, TConnect1C, TVB5Power]);
end;

end.
