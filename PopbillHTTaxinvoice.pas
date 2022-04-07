(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* http://www.popbill.com
* Author : Jeong Yohan (code@linkhubcorp.com)
* Written : 2016-06-10
* Updated : 2022-04-07
* Thanks for your interest. 
*=================================================================================
*)
unit PopbillHTTaxinvoice;

interface

uses
        TypInfo,SysUtils,Classes,
        Popbill,
        Linkhub;
type

        EnumQueryType = (SELL,BUY,TRUSTEE);


        THometaxTIChargeInfo = class
        public
                unitCost        : string;
                chargeMethod    : string;
                rateSystem      : string;
        end;

        TGetXMLResponse = class
        public
                ResultCode      : Integer;
                Message         : String;
                retObject       : String;
        end;

        THometaxTIFlatRate = class
        public
                referenceID     : string;
                contractDt      : string;
                baseDate        : Integer;
                useEndDate      : string;
                state           : Integer;
                closeRequestYN  : boolean;
                useRestrictYN   : boolean;
                closeOnExpired  : boolean;
                unPaidYN        : boolean;
        end;

        THometaxTIJobInfo = class
        public
                jobID           : String;
                jobState        : Integer;
                queryType       : String;
                queryDateType   : String;
                queryStDate     : String;
                queryEnDate     : String;
                errorCode       : Integer;
                errorReason     : String;
                jobStartDT      : String;
                jobEndDT        : String;
                collectCount    : Integer;
                regDT           : String;

        end;

        THomeTaxTIJobInfoList = Array Of THomeTaxTIJobInfo;

        TTaxinvoiceSummary = class
        public
                count : Integer;
                supplyCostTotal : Integer;
                taxTotal : Integer;
                amountTotal : Integer;
        end; 

        THomeTaxTIAbbr = class
        public
                ntsconfirmNum   : string;
                writeDate       : String;
                issueDate       : string;
                sendDate        : string;
                taxType         : string;
                purposeType     : string;
                supplyCostTotal : string;
                taxTotal        : string;
                totalAmount     : string;
                remark1         : string;
                modifyYN        : boolean;
                orgNTSConfirmNum : string;

                purchaseDate    : string;
                itemName        : string;
                spec : string;
                qty : string;
                unitCost :string;
                supplyCost      : string;
                tax             : string;
                remark          : string;

                invoicerCorpNum : string;
                invoicerTaxRegID : string;
                invoicerCorpName        : string;
                invoicerCEOName : string;
                invoicerEmail   : string;

                invoiceeCorpNum : string;
                invoiceeType    : string;
                invoiceeTaxRegID : string;
                invoiceeCorpName        : string;
                invoiceeCEOName : string;
                invoiceeEmail1  : string;
                invoiceeEmail2 : string;

                trusteeCorpNum : string;
                trusteeTaxRegID : string;
                trusteeCorpName : string;
                trusteeCEOName : String;
                trusteeEmail : string;

                // ����/���� ���� �߰� - 2017/08/30
                invoiceType : string;

        end;

        THomeTaxTIAbbrList = Array Of THomeTaxTIAbbr;

        THomeTaxTISearchList = class
        public
                code            : Integer;
                total           : Integer;
                perPage         : Integer;
                pageNum         : Integer;
                pageCount       : Integer;
                message         : String;
                list            : THomeTaxTIAbbrList;
                destructor Destroy; override;
        end;



        THometaxTIDetail = class
        public
                serialNum       : Integer;
                purchaseDT      : String;
                itemName        : String;
                spec            : String;
                qty             : String;
                unitCost        : String;
                supplyCost      : String;
                tax             : String;
                remark          : String;
        end;
        THometaxTIDetailList = Array of THometaxTIDetail;


        THomeTaxTaxinvoice = class
        public
                writeDate       : String;
                issueDT         : String;
                invoiceType     : Integer;
                taxType         : String;
                taxTotal        : String;
                supplyCostTotal : String;
                totalAmount     : String;
                purposeType     : String;
                cash            : String;
                chkBill         : String;
                credit          : String;
                note            : String;
                remark1         : String;
                remark2         : String;
                remark3         : String;
                ntsconfirmNum   : String;
                modifyCode      : Integer;
                orgNTSConfirmNum        : String;

                invoicerCorpNum         : String;
                invoicerMgtKey          : String;
                invoicerTaxRegID        : String;
                invoicerCorpName        : String;
                invoicerCEOName         : String;
                invoicerAddr            : String;
                invoicerBizType         : String;
                invoicerBizClass        : String;
                invoicerContactName     : String;
                invoicerDeptName        : String;
                invoicerTEL             : String;
                invoicerEmail           : String;

                invoiceeCorpNum         : String;
                invoiceeType            : String;
                invoiceeMgtKey          : String;
                invoiceeTaxRegID        : String;
                invoiceeCorpName        : String;
                invoiceeCEOName         : String;
                invoiceeAddr            : String;
                invoiceeBizType         : String;
                invoiceeBizClass        : String;
                invoiceeContactName1    : String;
                invoiceeDeptName1       : String;
                invoiceeTEL1            : String;
                invoiceeEmail1          : String;
                invoiceeContactName2    : String;
                invoiceeDeptName2       : String;
                invoiceeTEL2            : String;
                invoiceeEmail2          : String;


                trusteeCorpNum          : String;
                trusteeMgtKey           : String;
                trusteeTaxRegID         : String;
                trusteeCorpName         : String;
                trusteeCEOName          : String;
                trusteeAddr             : String;
                trusteeBizType          : String;
                trusteeBizClass         : String;
                trusteeContactName      : String;
                trusteeDeptName         : String;
                trusteeTEL              : String;
                trusteeEmail            : String;

                detailList              : THometaxTIDetailList;
                destructor Destroy; override;


        end;


        THometaxTIService = class(TPopbillBaseService)
        private
                function jsonToTHometaxTIJobInfo(json : String) : THometaxTIJobInfo;
                function jsonToTHometaxTaxinvoice (json : String) : THomeTaxTaxinvoice;

        public
                constructor Create(LinkID : String; SecretKey : String);

                // ���� ���� Ȯ��
                function GetChargeInfo (CorpNum : string) : THometaxTIChargeInfo; overload;
                // ���� ���� Ȯ��
                function GetChargeInfo (CorpNum : string; UserID : String) : THometaxTIChargeInfo; overload;               

                // ���� ��û
                function RequestJob (CorpNum : string; queryType:EnumQueryType; DType: String; SDate: String; EDate :String) : string; overload;
                // ���� ��û
                function RequestJob (CorpNum : string; queryType:EnumQueryType; DType: String; SDate: String; EDate :String; UserID:String) : string; overload;

                // ���� ���� Ȯ��
                function GetJobState ( CorpNum : string; jobID : string) : THomeTaxTIJobInfo; overload;
                // ���� ���� Ȯ��
                function GetJobState ( CorpNum : string; jobID : string; UserID: string) : THomeTaxTIJobInfo; overload;

                // ���� ���� ��� Ȯ��
                function ListActiveState (CorpNum : string) : THomeTaxTIJobInfoList; overload;
                // ���� ���� ��� Ȯ��
                function ListActiveState (CorpNum : string; UserID: String) : THomeTaxTIJobInfoList; overload;

                function Search (CorpNum:string; JobID: String; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : String; TaxRegIDYN : String; Page: Integer; PerPage : Integer; Order: String; UserID: String = ''; SearchString : String = '') : THomeTaxTISearchList;

                // ������� ������� ��ȸ
                function Summary (CorpNum:string; JobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : String; TaxRegIDYN : String; UserID: String = ''; SearchString : String = '') : TTaxinvoiceSummary; overload;

                
                // ������ Ȯ�� - JSON
                function GetTaxinvoice (CorpNum:string; NTSConfirmNum:String) :THomeTaxTaxinvoice; overload;
                // ������ Ȯ�� - JSON
                function GetTaxinvoice (CorpNum:string; NTSConfirmNum:String; UserID:String) :THomeTaxTaxinvoice; overload;

                // ������ Ȯ�� - XML
                function GetXML (CorpNum : string; NTSConfirmNum:String ) : TGetXMLResponse; overload;
                // ������ Ȯ�� - XML
                function GetXML (CorpNum : string; NTSConfirmNum:String; UserID:String ) : TGetXMLResponse; overload;

                // ������ ��û URL
                function GetFlatRatePopUpURL(CorpNum: string; UserID : String = '') : string;

                // ������ ���� Ȯ��
                function GetFlatRateState (CorpNum : string ) : THometaxTIFlatRate; overload;
                // ������ ���� Ȯ��
                function GetFlatRateState (CorpNum : string; UserID: String ) : THometaxTIFlatRate; overload;

                // Ȩ�ý� ���������� ��� URL
                function GetCertificatePopUpURL(CorpNum: string; UserID : String = '') : string;

                // Ȩ�ý� ���������� �������� Ȯ��
                function GetCertificateExpireDate (CorpNum : string) : string; overload;
                // Ȩ�ý� ���������� �������� Ȯ��
                function GetCertificateExpireDate (CorpNum : string; UserID: String) : string; overload;

                // Ȩ�ý� ���ڼ��ݰ�꼭 ���� �˾� URL
                function GetPopUpURL(CorpNum : String; NTSConfirmNum : String; UserID : String = '') : String;

                // Ȩ�ý� ���ڼ��ݰ�꼭 �μ� �˾� URL
                function GetPrintURL(CorpNum : String; NTSConfirmNum : String; UserID : String = '') : String;                

                // Ȩ�ý� ���������� �α��� �׽�Ʈ
                function CheckCertValidation(CorpNum : String; UserID : String = '') : TResponse;

                // �μ������ �������
                function RegistDeptUser(CorpNum : String; DeptUserID : String; DeptUserPWD : String; UserID : String = '') : TResponse;

                // �μ������ ������� Ȯ��
                function CheckDeptUser(CorpNum : String; UserID : String = '') : TResponse;

                // �μ������ �α��� �׽�Ʈ
                function CheckLoginDeptUser(CorpNum : String; UserID : String = '') : TResponse;

                // �μ������ ������� ����
                function DeleteDeptUser(CorpNum : String; UserID : String = '') : TResponse;
        end;

implementation
destructor THomeTaxTISearchList.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(list)-1 do
    if Assigned(list[i]) then
      list[i].Free;
    SetLength(list, 0);
    inherited Destroy;
end;

destructor THomeTaxTaxinvoice.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(detailList)-1 do
    if Assigned(detailList[i]) then
      detailList[i].Free;
    SetLength(detailList, 0);
    inherited Destroy;
end;

constructor THometaxTIService.Create(LinkID : String; SecretKey : String);
begin
       inherited Create(LinkID,SecretKey);
       AddScope('111');
end;

function THometaxTIService.jsonToTHometaxTIJobInfo(json : String) : THometaxTIJobInfo;
begin
        result := THometaxTIJobInfo.Create;

        result.jobID := getJsonString(json, 'jobID');
        result.jobState := getJsonInteger(json, 'jobState');
        result.queryType := getJsonString(json, 'queryType');
        result.queryDateType := getJsonString(json, 'queryDateType');
        result.queryStDate := getJsonString(json, 'queryStDate');
        result.queryEnDate := getJsonString(json, 'queryEnDate');
        result.errorCode := getJsonInteger(json, 'errorCode');
        result.errorReason := getJsonString(json, 'errorReason');
        result.jobStartDT := getJsonString(json, 'jobStartDT');
        result.jobEndDT := getJsonString(json, 'jobEndDT');
        result.collectCount := getJsonInteger(json, 'collectCount');
        result.regDT := getJsonString(json, 'regDT');
end;


function THometaxTIService.jsonToTHometaxTaxinvoice(json : String) : THomeTaxTaxinvoice;
var
        jSons : ArrayOfString;
        i : Integer;
begin
        result := THomeTaxTaxinvoice.Create;

        result.writeDate        := getJSonString(json,'writeDate');
        result.issueDT          := getJsonString(json,'issueDT');
        result.invoiceType      := getJsonInteger(json, 'invoiceType');
        result.taxType          := getJsonString(json,'taxType');
        result.taxTotal          := getJsonString(json,'taxTotal');
        result.supplyCostTotal          := getJsonString(json,'supplyCostTotal');
        result.totalAmount          := getJsonString(json,'totalAmount');
        result.purposeType          := getJsonString(json,'purposeType');
        result.cash          := getJsonString(json,'cash');
        result.chkBill          := getJsonString(json,'chkBill');
        result.credit          := getJsonString(json,'credit');
        result.note          := getJsonString(json,'note');
        result.remark1          := getJsonString(json,'remark1');
        result.remark2          := getJsonString(json,'remark2');
        result.remark3          := getJsonString(json,'remark3');
        result.ntsconfirmNum          := getJsonString(json,'ntsconfirmNum');
        result.orgNTSConfirmNum          := getJsonString(json,'orgNTSConfirmNum');
        result.modifyCode      := getJsonInteger(json, 'modifyCode');

        result.invoicerCorpNum          := getJsonString(json,'invoicerCorpNum');
        result.invoicerMgtKey          := getJsonString(json,'invoicerMgtKey');
        result.invoicerTaxRegID          := getJsonString(json,'invoicerTaxRegID');
        result.invoicerCorpName          := getJsonString(json,'invoicerCorpName');
        result.invoicerCEOName          := getJsonString(json,'invoicerCEOName');
        result.invoicerAddr          := getJsonString(json,'invoicerAddr');
        result.invoicerBizType          := getJsonString(json,'invoicerBizType');
        result.invoicerBizClass          := getJsonString(json,'invoicerBizClass');
        result.invoicerContactName          := getJsonString(json,'invoicerContactName');
        result.invoicerDeptName          := getJsonString(json,'invoicerDeptName');
        result.invoicerTEL          := getJsonString(json,'invoicerTEL');
        result.invoicerEmail          := getJsonString(json,'invoicerEmail');

        result.invoiceeCorpNum          := getJsonString(json,'invoiceeCorpNum');
        result.invoiceeType          := getJsonString(json,'invoiceeType');
        result.invoiceeMgtKey          := getJsonString(json,'invoiceeMgtKey');
        result.invoiceeTaxRegID          := getJsonString(json,'invoiceeTaxRegID');
        result.invoiceeCorpName          := getJsonString(json,'invoiceeCorpName');
        result.invoiceeCEOName          := getJsonString(json,'invoiceeCEOName');
        result.invoiceeAddr          := getJsonString(json,'invoiceeAddr');
        result.invoiceeBizType          := getJsonString(json,'invoiceeBizType');
        result.invoiceeBizClass          := getJsonString(json,'invoiceeBizClass');
        result.invoiceeContactName1          := getJsonString(json,'invoiceeContactName1');
        result.invoiceeDeptName1          := getJsonString(json,'invoiceeDeptName1');
        result.invoiceeTEL1          := getJsonString(json,'invoiceeTEL1');
        result.invoiceeEmail1          := getJsonString(json,'invoiceeEmail1');
        result.invoiceeContactName2          := getJsonString(json,'invoiceeContactName2');
        result.invoiceeDeptName2          := getJsonString(json,'invoiceeDeptName2');
        result.invoiceeTEL2          := getJsonString(json,'invoiceeTEL2');
        result.invoiceeEmail2          := getJsonString(json,'invoiceeEmail2');

        result.trusteeCorpNum          := getJsonString(json,'trusteeCorpNum');
        result.trusteeMgtKey         := getJsonString(json,'trusteeMgtKey');
        result.trusteeTaxRegID          := getJsonString(json,'trusteeTaxRegID');
        result.trusteeCorpName          := getJsonString(json,'trusteeCorpName');
        result.trusteeCEOName          := getJsonString(json,'trusteeCEOName');
        result.trusteeAddr          := getJsonString(json,'trusteeAddr');
        result.trusteeBizType          := getJsonString(json,'trusteeBizType');
        result.trusteeBizClass          := getJsonString(json,'trusteeBizClass');
        result.trusteeContactName          := getJsonString(json,'trusteeContactName');
        result.trusteeDeptName            := getJsonString(json,'trusteeDeptName');
        result.trusteeTEL                 := getJsonString(json,'trusteeTEL');
        result.trusteeEmail               := getJsonString(json,'trusteeEmail');

        //details.
        try
                jSons :=  getJSonList(json,'detailList');
                SetLength(result.detailList ,Length(jSons));

                for i := 0 to Length(jSons)-1 do
                begin
                        result.detailList[i] := THometaxTIDetail.Create;

                        result.detailList[i].SerialNum             := getJSonInteger(jSons[i],'serialNum');
                        result.detailList[i].purchaseDT            := getJSonString(jSons[i],'purchaseDT');
                        result.detailList[i].ItemName              := getJSonString(jSons[i],'itemName');
                        result.detailList[i].spec                  := getJSonString(jSons[i],'spec');
                        result.detailList[i].qty                   := getJSonString(jSons[i],'qty');
                        result.detailList[i].unitCost              := getJSonString(jSons[i],'unitCost');
                        result.detailList[i].supplyCost            := getJSonString(jSons[i],'supplyCost');
                        result.detailList[i].tax                   := getJSonString(jSons[i],'tax');
                        result.detailList[i].remark                := getJSonString(jSons[i],'remark');
                end;

        except
                on E:Exception do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                exit;
                        end
                        else
                        begin
                                result := THomeTaxTaxinvoice.Create;
                                setLastErrCode(-99999999);
                                setLastErrMessage('���ó�� ����.[Malformed Json]');
                                exit;
                        end;
                end;
        end;
end;


function THometaxTIService.GetFlatRatePopUpURL(CorpNum: string; UserID : String = '') : string;
var
        responseJson : String;
begin

        try
                responseJson := httpget('/HomeTax/Taxinvoice?TG=CHRG',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;
end;


function THometaxTIService.GetCertificatePopUpURL(CorpNum: string; UserID : String = '') : string;
var
        responseJson : String;
begin

        try
                responseJson := httpget('/HomeTax/Taxinvoice?TG=CERT',CorpNum,UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;                
end;

function THometaxTIService.GetCertificateExpireDate(CorpNum: string) : string;
begin
        result := GetCertificateExpireDate(CorpNum, '');
end;

function THometaxTIService.GetCertificateExpireDate(CorpNum: string; UserID:String) : string;
var
        responseJson : String;
begin
        try
                responseJson := httpget('/HomeTax/Taxinvoice/CertInfo',CorpNum,UserID);
                result := getJSonString(responseJson,'certificateExpiration');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;                        
                end;
        end;
end;


function THometaxTIService.GetChargeInfo (CorpNum : string) : THometaxTIChargeInfo;

begin
        Result := GetChargeInfo(CorpNum, '');
end;


function THometaxTIService.GetChargeInfo (CorpNum : string; UserID:string) : THometaxTIChargeInfo;
var
        responseJson : String;
begin

        try
                responseJson := httpget('/HomeTax/Taxinvoice/ChargeInfo',CorpNum,UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin        
                try
                        result := THometaxTIChargeInfo.Create;
                        result.unitCost := getJSonString(responseJson, 'unitCost');
                        result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                        result.rateSystem := getJSonString(responseJson, 'rateSystem');
                except
                        on E:Exception do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        result := THometaxTIChargeInfo.Create();
                                        setLastErrCode(-99999999);
                                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                                        exit;
                                end;
                        end;
                end;
        end;
end;


function THometaxTIService.GetFlatRateState (CorpNum : string ) : THometaxTIFlatRate;
begin
        result := GetFlatRateState(CorpNum, '')
end;

function THometaxTIService.GetFlatRateState (CorpNum : string; UserID: string) : THometaxTIFlatRate;
var
        responseJson : String;
begin
        try
                responseJson := httpget('/HomeTax/Taxinvoice/Contract',CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;                
        end;
        
        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                try
                        result := THometaxTIFlatRate.Create;
                        result.referenceID := getJSonString(responseJson, 'referenceID');
                        result.contractDT := getJSonString(responseJson, 'contractDT');
                        result.baseDate := getJsonInteger(responseJson, 'baseDate');
                        result.useEndDate := getJSonString(responseJson, 'useEndDate');
                        result.state := getJsonInteger(responseJson, 'state');
                        result.closeRequestYN := getJsonBoolean(responseJson, 'closeRequestYN');
                        result.useRestrictYN := getJsonBoolean(responseJson, 'useRestrictYN');
                        result.closeOnExpired := getJsonBoolean(responseJson, 'closeOnExpired');
                        result.unPaidYN := getJsonBoolean(responseJson, 'unPaidYN');
                except
                        on E:Exception do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        result := THometaxTIFlatRate.Create;
                                        setLastErrCode(-99999999);
                                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                                end;
                        end;
                end;
        end;

end;


function THometaxTIService.GetJobState ( CorpNum : string; jobID : string) : THomeTaxTIJobInfo;
begin
        result := GetJobState(CorpNum, jobID, '')
end;

function THometaxTIService.GetJobState ( CorpNum : string; jobID : string; UserID :string) : THomeTaxTIJobInfo;
var
        responseJson : string;

begin
        if Not ( length ( jobID ) = 18 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := THomeTaxTIJobInfo.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/'+ jobID + '/State', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                result := jsonToTHometaxTIJobInfo ( responseJson ) ;
        end;
end;


function THometaxTIService.ListActiveState (CorpNum : string) : THomeTaxTIJobInfoList;
begin
        result := ListActiveState(CorpNum, '');
end;

function THometaxTIService.ListActiveState (CorpNum : string; UserID:string) : THomeTaxTIJobInfoList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin

        try
                responseJson := httpget('/HomeTax/Taxinvoice/JobList', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end
                        else
                        begin
                                setLength(result,0);
                                exit;
                        end;
                end;
        end;

        if responseJson = '[]' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '�۾� ��û ����� �������� �ʽ��ϴ�.');
                        exit;
                end
                else
                begin
                        setLength(result,0);
                        setLastErrCode(-99999999);
                        setLastErrMessage('�۾� ��û ����� �������� �ʽ��ϴ�.');
                        exit;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                try
                        jSons := ParseJsonList(responseJson);
                        SetLength(result,Length(jSons));

                        for i:= 0 to Length(jSons) -1 do
                        begin
                                result[i] := jsonToTHometaxTIJobInfo(jSons[i]);
                        end;
                except
                        on E:Exception do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        setLength(result,0);
                                        setLastErrCode(-99999999);
                                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                                        exit;
                                end;
                        end;
                end;
        end;
end;

function UrlEncodeUTF8(stInput : widestring) : string;
  const
    hex : array[0..255] of string = (
     '%00', '%01', '%02', '%03', '%04', '%05', '%06', '%07',
     '%08', '%09', '%0a', '%0b', '%0c', '%0d', '%0e', '%0f',
     '%10', '%11', '%12', '%13', '%14', '%15', '%16', '%17',
     '%18', '%19', '%1a', '%1b', '%1c', '%1d', '%1e', '%1f',
     '%20', '%21', '%22', '%23', '%24', '%25', '%26', '%27',
     '%28', '%29', '%2a', '%2b', '%2c', '%2d', '%2e', '%2f',
     '%30', '%31', '%32', '%33', '%34', '%35', '%36', '%37',
     '%38', '%39', '%3a', '%3b', '%3c', '%3d', '%3e', '%3f',
     '%40', '%41', '%42', '%43', '%44', '%45', '%46', '%47',
     '%48', '%49', '%4a', '%4b', '%4c', '%4d', '%4e', '%4f',
     '%50', '%51', '%52', '%53', '%54', '%55', '%56', '%57',
     '%58', '%59', '%5a', '%5b', '%5c', '%5d', '%5e', '%5f',
     '%60', '%61', '%62', '%63', '%64', '%65', '%66', '%67',
     '%68', '%69', '%6a', '%6b', '%6c', '%6d', '%6e', '%6f',
     '%70', '%71', '%72', '%73', '%74', '%75', '%76', '%77',
     '%78', '%79', '%7a', '%7b', '%7c', '%7d', '%7e', '%7f',
     '%80', '%81', '%82', '%83', '%84', '%85', '%86', '%87',
     '%88', '%89', '%8a', '%8b', '%8c', '%8d', '%8e', '%8f',
     '%90', '%91', '%92', '%93', '%94', '%95', '%96', '%97',
     '%98', '%99', '%9a', '%9b', '%9c', '%9d', '%9e', '%9f',
     '%a0', '%a1', '%a2', '%a3', '%a4', '%a5', '%a6', '%a7',
     '%a8', '%a9', '%aa', '%ab', '%ac', '%ad', '%ae', '%af',
     '%b0', '%b1', '%b2', '%b3', '%b4', '%b5', '%b6', '%b7',
     '%b8', '%b9', '%ba', '%bb', '%bc', '%bd', '%be', '%bf',
     '%c0', '%c1', '%c2', '%c3', '%c4', '%c5', '%c6', '%c7',
     '%c8', '%c9', '%ca', '%cb', '%cc', '%cd', '%ce', '%cf',
     '%d0', '%d1', '%d2', '%d3', '%d4', '%d5', '%d6', '%d7',
     '%d8', '%d9', '%da', '%db', '%dc', '%dd', '%de', '%df',
     '%e0', '%e1', '%e2', '%e3', '%e4', '%e5', '%e6', '%e7',
     '%e8', '%e9', '%ea', '%eb', '%ec', '%ed', '%ee', '%ef',
     '%f0', '%f1', '%f2', '%f3', '%f4', '%f5', '%f6', '%f7',
     '%f8', '%f9', '%fa', '%fb', '%fc', '%fd', '%fe', '%ff');
 var
   iLen,iIndex : integer;
   stEncoded : string;
   ch : widechar;
 begin
   iLen := Length(stInput);
   stEncoded := '';
   for iIndex := 1 to iLen do
   begin
     ch := stInput[iIndex];
     if (ch >= 'A') and (ch <= 'Z') then
       stEncoded := stEncoded + ch
     else if (ch >= 'a') and (ch <= 'z') then
       stEncoded := stEncoded + ch
     else if (ch >= '0') and (ch <= '9') then
       stEncoded := stEncoded + ch
     else if (ch = ' ') then
       stEncoded := stEncoded + '+'
     else if ((ch = '-') or (ch = '_') or (ch = '.') or (ch = '!') or (ch = '*')
       or (ch = '~') or (ch = '\')  or (ch = '(') or (ch = ')')) then
       stEncoded := stEncoded + ch
     else if (Ord(ch) <= $07F) then
       stEncoded := stEncoded + hex[Ord(ch)]
     else if (Ord(ch) <= $7FF) then
     begin
        stEncoded := stEncoded + hex[$c0 or (Ord(ch) shr 6)];
        stEncoded := stEncoded + hex[$80 or (Ord(ch) and $3F)];
     end
     else
     begin
        stEncoded := stEncoded + hex[$e0 or (Ord(ch) shr 12)];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch) shr 6) and ($3F))];
        stEncoded := stEncoded + hex[$80 or ((Ord(ch)) and ($3F))];
     end;
   end;
   result := (stEncoded);
 end;

function THometaxTIService.Search (CorpNum:string; jobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : String; TaxRegIDYN : string; Page: Integer; PerPage : Integer; Order: String; UserID: string=''; SearchString : String = '') : THomeTaxTISearchList;
var
        responseJson : string;
        uri : String;
        docTypeList : String;
        taxTypeList : String;
        purposeTypeList : String;
        i : integer;
        jSons : ArrayOfString;
begin
        if Not ( length ( jobID ) = 18 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := THomeTaxTISearchList.Create;
                        result.code := -99999999;
                        result.message := '�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.';
                        exit;
                end;

        end;

        for i := 0 to High ( DocType ) do
        begin
                if DocType[i] <> '' Then
                docTypeList := docTypeList + docType[i];

                if i <> High(DocType) then
                docTypeList := docTypeList + ','; 
        end;

        for i := 0 to High ( TaxType ) do
        begin
                if taxType[i] <> '' Then
                taxTypeList := taxTypeList + taxType[i];

                if i <> High(TaxType) then
                taxTypeList := taxTypeList + ',';
        end;

        for i := 0 to High ( PurposeType ) do
        begin
                if purposeType[i] <> '' then
                purposeTypeList := purposeTypeList + PurposeType[i];

                if i <> High(PurposeType) then
                purposeTypeList := purposeTypeList + ',';
        end;

                                          
        if Page < 1 then page := 1;
        if PerPage < 1 then PerPage := 500;

        uri := '/HomeTax/Taxinvoice/'+jobID;
        uri := uri + '?Type=' + docTypeList + '&&TaxType=' + taxTypeList;
        uri := uri + '&&PurposeType=' + purposeTypeList;


        uri := uri + '&&TaxRegIDType='+ TaxRegIDType;

        if TaxRegID <> '' then
        begin
                uri := uri + '&&TaxRegID='+TaxRegID;
        end;         

        if TaxRegIDYN <> '' then
        begin
               uri := uri + '&&TaxRegIDYN='+TaxRegIDYN;
        end;

        if SearchString <> '' then
        begin
                uri := uri + '&&SearchString='+ UrlEncodeUTF8(SearchString);
        end;

        
        uri := uri + '&&Page=' + IntToStr(Page) + '&&PerPage='+ IntToStr(PerPage);
        uri := uri + '&&Order=' + order;


        try
                responseJson := httpget(uri, CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := THomeTaxTISearchList.Create;
                                result.code := le.code;
                                result.message := le.message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result := THomeTaxTISearchList.Create;
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
        
                result := THomeTaxTiSearchList.Create;

                result.code := getJSonInteger(responseJson, 'code');
                result.total := getJSonInteger(responseJson, 'total');
                result.perPage := getJSonInteger(responseJson, 'perPage');
                result.pageNum := getJSonInteger(responseJson, 'pageNum');
                result.pageCount := getJSonInteger(responseJson, 'pageCount');
                result.message := getJSonString(responseJson, 'message');

                try
                        jSons := getJsonList(responseJson, 'list');
                        SetLength(result.list, Length(jSons));
                        for i:=0 to Length(jSons)-1 do
                        begin
                                result.list[i] := THomeTaxTIAbbr.Create;
                                result.list[i].ntsconfirmNum := getJsonString (jSons[i], 'ntsconfirmNum');
                                result.list[i].writeDate := getJsonString (jSons[i], 'writeDate');
                                result.list[i].issueDate := getJsonString (jSons[i], 'issueDate');
                                result.list[i].sendDate := getJsonString (jSons[i], 'sendDate');
                                result.list[i].taxType := getJsonString (jSons[i], 'taxType');
                                result.list[i].purposeType := getJsonString (jSons[i], 'purposeType');
                                result.list[i].supplyCostTotal := getJsonString (jSons[i], 'supplyCostTotal');
                                result.list[i].taxTotal := getJsonString (jSons[i], 'taxTotal');
                                result.list[i].totalAmount := getJsonString (jSons[i], 'totalAmount');
                                result.list[i].remark1 := getJsonString (jSons[i], 'remark1');
                                result.list[i].modifyYN := getJsonBoolean (jSons[i], 'modifyYN');
                                result.list[i].orgNTSConfirmNum := getJsonString (jSons[i], 'orgNTSConfirmNum');
                                result.list[i].invoiceType := getJsonString (jSons[i], 'invoiceType');

                                result.list[i].purchaseDate := getJsonString (jSons[i], 'purchaseDate');
                                result.list[i].itemName := getJsonString (jSons[i], 'itemName');
                                result.list[i].spec := getJsonString (jSons[i], 'spec');
                                result.list[i].qty := getJsonString (jSons[i], 'qty');
                                result.list[i].unitCost := getJsonString (jSons[i], 'unitCost');
                                result.list[i].supplyCost := getJsonString (jSons[i], 'supplyCost');
                                result.list[i].tax := getJsonString (jSons[i], 'tax');
                                result.list[i].remark := getJsonString (jSons[i], 'remark');

                                result.list[i].invoicerCorpNum := getJsonString (jSons[i], 'invoicerCorpNum');
                                result.list[i].invoicerTaxRegID := getJsonString (jSons[i], 'invoicerTaxRegID');
                                result.list[i].invoicerCorpName := getJsonString (jSons[i], 'invoicerCorpName');
                                result.list[i].invoicerCEOName := getJsonString (jSons[i], 'invoicerCEOName');
                                result.list[i].invoicerEmail := getJsonString (jSons[i], 'invoicerEmail');

                                result.list[i].invoiceeCorpNum := getJsonString (jSons[i], 'invoiceeCorpNum');
                                result.list[i].invoiceeType := getJsonString (jSons[i], 'invoiceeType');
                                result.list[i].invoiceeTaxRegID := getJsonString (jSons[i], 'invoiceeTaxRegID');
                                result.list[i].invoiceeCorpName := getJsonString (jSons[i], 'invoiceeCorpName');
                                result.list[i].invoiceeCEOName := getJsonString (jSons[i], 'invoiceeCEOName');
                                result.list[i].invoiceeEmail1 := getJsonString (jSons[i], 'invoiceeEmail1');
                                result.list[i].invoiceeEmail2 := getJsonString (jSons[i], 'invoiceeEmail2');

                                result.list[i].trusteeCorpNum := getJsonString (jSons[i], 'trusteeCorpNum');
                                result.list[i].trusteeTaxRegID := getJsonString (jSons[i], 'trusteeTaxRegID');
                                result.list[i].trusteeCorpName := getJsonString (jSons[i], 'trusteeCorpName');
                                result.list[i].trusteeCEOName := getJsonString (jSons[i], 'trusteeCEOName');
                                result.list[i].trusteeEmail := getJsonString (jSons[i], 'trusteeEmail');
                   
                        end;

                except
                        on E:Exception do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        result := THomeTaxTISearchList.Create;
                                        result.code := -99999999;
                                        result.message := '���ó�� ����.[Malformed Json]';
                                        exit;
                                end;

                        end;
                end;
        end;
end;

function THometaxTIService.RequestJob (CorpNum : string;  queryType:EnumQueryType; DType: String; SDate: String; EDate: String) : string;
begin
        result := RequestJob(CorpNum,queryType,DType,SDate,EDate,'');
end;


function THometaxTIService.RequestJob (CorpNum : string;  queryType:EnumQueryType; DType: String; SDate: String; EDate: String; UserID: String) : string;
var
        responseJson : string;

begin
        try        
                responseJson := httppost('/HomeTax/Taxinvoice/'+GetEnumName(TypeInfo(EnumQueryType),integer(queryType))+'?DType='+DType+'&&SDate='+SDate+'&&EDate='+EDate, CorpNum, UserID, '', '');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end
                        else
                        begin
                                result := '';
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result := '';
                exit;
        end
        else
        begin
                result := getJsonString(responseJson, 'jobID');
                exit;
        end;
end;

function THometaxTIService.Summary (CorpNum:string; jobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : String; TaxRegIDYN : string; UserID: string = ''; SearchString: string = '') : TTaxinvoiceSummary;
var
        responseJson : string;
        uri : String;
        docTypeList : String;
        taxTypeList : String;
        purposeTypeList : String;
        i : integer;
begin
        if Not ( length ( jobID ) = 18 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := TTaxinvoiceSummary.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('�۾����̵�(jobID)�� �ùٸ��� �ʽ��ϴ�.');
                        exit;
                end;

        end;

        for i := 0 to High ( DocType ) do
        begin
                if DocType[i] <> '' Then
                docTypeList := docTypeList + docType[i];

                if i <> High(DocType) then
                docTypeList := docTypeList + ','; 
        end;

        for i := 0 to High ( TaxType ) do
        begin
                if taxType[i] <> '' Then
                taxTypeList := taxTypeList + taxType[i];

                if i <> High(TaxType) then
                taxTypeList := taxTypeList + ',';
        end;

        for i := 0 to High ( PurposeType ) do
        begin
                if purposeType[i] <> '' then
                purposeTypeList := purposeTypeList + PurposeType[i];

                if i <> High(PurposeType) then
                purposeTypeList := purposeTypeList + ',';
        end;



        uri := '/HomeTax/Taxinvoice/'+jobID+'/Summary';
        uri := uri + '?Type=' + docTypeList + '&&TaxType=' + taxTypeList;
        uri := uri + '&&PurposeType=' + purposeTypeList + '&&TaxRegIDType='+ TaxRegIDType;
        
        if TaxRegID <> '' then
        begin
                uri := uri + '&&TaxRegID='+TaxRegID;
        end;         

        if TaxRegIDYN <> '' then
        begin
               uri := uri + '&&TaxRegIDYN='+TaxRegIDYN;
        end;

        if SearchString <> '' then
        begin
                uri := uri + '&&SearchString='+ UrlEncodeUTF8(SearchString);
        end;
                
        try
                responseJson := httpget(uri, CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;                
        end;

        if LastErrCode <> 0 then
        begin
                result := TTaxinvoiceSummary.Create;
                exit;
        end
        else
        begin        
                result := TTaxinvoiceSummary.Create;
                result.count := GetJSonInteger(responseJson, 'count');
                result.supplyCostTotal := GetJSonInteger(responseJson, 'supplyCostTotal');
                result.taxTotal := GetJSonInteger(responseJson, 'taxTotal');
                result.amountTotal := GetJSonInteger(responseJson, 'amountTotal');
        end;
end;


function THometaxTIService.GetTaxinvoice (CorpNum:string; NTSConfirmNum:String) :THomeTaxTaxinvoice;
begin
        result := GetTaxinvoice(CorpNum, NTSConfirmNum, '');
end;

function THometaxTIService.GetTaxinvoice (CorpNum:string; NTSConfirmNum:String; UserID:String) :THomeTaxTaxinvoice;
var
        responseJson : string;
begin
        if Not ( length ( NTSConfirmNum ) = 24 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := THomeTaxTaxinvoice.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        exit;        
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/'+NTSConfirmNum, CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code, le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin
                result := jsonToTHometaxTaxinvoice(responseJson);
                exit;
        end;
end;

function THometaxTIService.GetXML (CorpNum : String; NTSConfirmNum:String ) : TGetXMLResponse;
begin
        result := GetXML(CorpNum, NTSConfirmNUm, '');
end;

function THometaxTIService.GetXML (CorpNum : String; NTSConfirmNum:String; UserID:String ) : TGetXMLResponse;
var
        responseJson : String;
begin
        if  Not ( length ( NTSConfirmNum ) = 24 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := TGetXMLResponse.Create;
                        setLastErrCode(-99999999);
                        setLastErrMessage('����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        exit;
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/'+NTSConfirmNum+'?T=xml', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end
                        else
                        begin
                                result := TGetXMLResponse.Create;
                                setLastErrCode(le.code);
                                setLastErrMessage(le.message);
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                exit;
        end
        else
        begin        
                try
                        result := TGetXMLResponse.Create;
                        result.ResultCode := getJSonInteger(responseJson, 'ResultCode');
                        result.Message := getJSonString(responseJson, 'Message');
                        result.retObject := getJSonString(responseJson, 'retObject');
                except
                        on E:Exception do begin
                                if FIsThrowException then
                                begin
                                        raise EPopbillException.Create(-99999999,'���ó�� ����.[Malformed Json]');
                                        exit;
                                end
                                else
                                begin
                                        result := TGetXMLResponse.Create;
                                        setLastErrCode(-99999999);
                                        setLastErrMessage('���ó�� ����.[Malformed Json]');
                                        exit;
                                end;
                        end;
                end;
        end;

end;

function THometaxTIService.GetPopUpURL(CorpNum, NTSConfirmNum, UserID: String): String;
var
        responseJson : String;
begin
        if  Not ( length ( NTSConfirmNum ) = 24 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        exit;
                end;
        end;
       
        try
                responseJson := httpget('/HomeTax/Taxinvoice/' + NTSConfirmNum + '/PopUp', CorpNum, UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;
end;

function THometaxTIService.GetPrintURL(CorpNum, NTSConfirmNum, UserID: String): String;
var
        responseJson : String;
begin
        if  Not ( length ( NTSConfirmNum ) = 24 ) then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result := '';
                        setLastErrCode(-99999999);
                        setLastErrMessage('����û���ι�ȣ�� �ùٸ��� �ʽ��ϴ�.');
                        exit;
                end;
        end;
       
        try
                responseJson := httpget('/HomeTax/Taxinvoice/' + NTSConfirmNum + '/Print', CorpNum, UserID);
                result := getJSonString(responseJson,'url');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.message);
                                exit;
                        end;
                end;
        end;
end;

function THometaxTIService.CheckCertValidation(CorpNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if Trim(CorpNum) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;                       
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/CertCheck', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function THometaxTIService.RegistDeptUser(CorpNum, DeptUserID, DeptUserPWD, UserID: String): TResponse;
var
        requestJson, responseJson : String;
begin
        if Trim(CorpNum) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;

        end;
        
        if Trim(DeptUserID) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, 'Ȩ�ý� �μ������ ���� ���̵� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := 'Ȩ�ý� �μ������ ���� ���̵� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        if Trim(DeptUserPWD) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, 'Ȩ�ý� �μ������ ���� ��й�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := 'Ȩ�ý� �μ������ ���� ��й�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                requestJson := '{"id":"'+EscapeString(DeptUserID)+'","pwd":"'+EscapeString(DeptUserPWD)+'"}';
                responseJson := httppost('/HomeTax/Taxinvoice/DeptUser', CorpNum, UserID, requestJson, '');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
        end;
end;

function THometaxTIService.CheckDeptUser(CorpNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if Trim(CorpNum) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/DeptUser', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function THometaxTIService.CheckLoginDeptUser(CorpNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if Trim(CorpNum) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                responseJson := httpget('/HomeTax/Taxinvoice/DeptUser/Check', CorpNum, UserID);
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                                exit;
                        end
                        else
                        begin
                                result.code := le.code;
                                result.message := le.Message;
                                exit;                        
                        end;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
        end;
end;

function THometaxTIService.DeleteDeptUser(CorpNum, UserID: String): TResponse;
var
        responseJson : String;
begin
        if Trim(CorpNum) = '' then
        begin
                if FIsThrowException then
                begin
                        raise EPopbillException.Create(-99999999, '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.');
                        Exit;
                end
                else
                begin
                        result.code := -99999999;
                        result.message := '����ȸ�� ����ڹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.';
                        Exit;
                end;
        end;

        try
                responseJson := httppost('/HomeTax/Taxinvoice/DeptUser', CorpNum, UserID, '', 'DELETE');
        except
                on le : EPopbillException do begin
                        if FIsThrowException then
                        begin
                                raise EPopbillException.Create(le.code,le.Message);
                        end;
                        
                        result.code := le.code;
                        result.message := le.Message;
                end;
        end;

        if LastErrCode <> 0 then
        begin
                result.code := LastErrCode;
                result.message := LastErrMessage;
                exit;
        end
        else
        begin
                result.code := getJSonInteger(responseJson,'code');
                result.message := getJSonString(responseJson,'message');
                exit;
        end;       
end;

end.
