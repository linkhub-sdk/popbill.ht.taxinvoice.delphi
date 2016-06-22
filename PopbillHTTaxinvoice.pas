(*
*=================================================================================
* Unit for base module for Popbill API SDK. It include base functionality for
* RESTful web service request and parse json result. It uses Linkhub module
* to accomplish authentication APIs.
*
* http://www.popbill.com
* Author : Jeong Yohan (frenchofkiss@gmail.com)
* Written : 2016-06-10

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

        EnumMgtKeyType = (SELL,BUY,TRUSTEE);


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
                modifyYN        : boolean;

                invoicerCorpNum : string;
                invoicerCorpName        : string;
                invoicerCEOName : string;
                invoicerEmail   : string;

                invoiceeCorpNum : string;
                invoiceeType    : string;
                invoiceeCorpName        : string;
                invoiceeCEOName : string;
                invoiceeEmail1  : string;

                supplyCostTotal : string;
                taxTotal        : string;
                totalAmount     : string;
                
                purchaseDate    : string;
                itemName        : string;
                supplyCost      : string;
                tax             : string;
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

                // 과금 정보 확인
                function GetChargeInfo (CorpNum : string) : THometaxTIChargeInfo;
                
                // 수집 요청
                function RequestJob (CorpNum : string; MgtKeyType:EnumMgtKeyType; DType: String; SDate: String; EDate :String) : string;

                // 수집 상태 확인
                function GetJobState ( CorpNum : string; jobID : string) : THomeTaxTIJobInfo;

                // 수집 상태 목록 확인
                function ListActiveState (CorpNum : string) : THomeTaxTIJobInfoList;

                // 수집결과 조회
                function Search (CorpNum:string; JobID: String; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : Array Of String; TaxRegIDYN : Boolean; Page: Integer; PerPage : Integer; Order: String) : THomeTaxTISearchList;

                // 수집결과 요약정보 조회
                function Summary (CorpNum:string; JobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : Array Of String; TaxRegIDYN : Boolean) : TTaxinvoiceSummary;

                // 상세정보 확인 - JSON
                function GetTaxinvoice (CorpNum:string; NTSConfirmNum:String) :THomeTaxTaxinvoice;

                // 상세정보 확인 - XML
                function GetXML (CorpNum : string; NTSConfirmNum:String ) : TGetXMLResponse;

                // 정액제 신청 URL
                function GetFlatRatePopUpURL(CorpNum: string; UserID : String) : string;

                // 정액제 상태 확인
                function GetFlatRateState (CorpNum : string ) : THometaxTIFlatRate;

                // 홈택스 공인인증서 등록 URL
                function GetCertificatePopUpURL(CorpNum: string; UserID : String) : string;

                // 홈택스 공인인증서 만료일자 확인
                function GetCertificateExpireDate (CorpNum : string) : string;

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

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;


function THometaxTIService.GetFlatRatePopUpURL(CorpNum: string; UserID : String) : string;
var
        responseJson : String;
begin

        responseJson := httpget('/HomeTax/Taxinvoice?TG=CHRG',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;


function THometaxTIService.GetCertificatePopUpURL(CorpNum: string; UserID : String) : string;
var
        responseJson : String;
begin

        responseJson := httpget('/HomeTax/Taxinvoice?TG=CERT',CorpNum,UserID);

        result := getJSonString(responseJson,'url');
end;


function THometaxTIService.GetCertificateExpireDate(CorpNum: string) : string;
var
        responseJson : String;
begin

        responseJson := httpget('/HomeTax/Taxinvoice/CertInfo',CorpNum,'');

        result := getJSonString(responseJson,'certificateExpiration');
end;



function THometaxTIService.GetChargeInfo (CorpNum : string) : THometaxTIChargeInfo;
var
        responseJson : String;
begin
        responseJson := httpget('/HomeTax/Taxinvoice/ChargeInfo',CorpNum,'');

        try
                result := THometaxTIChargeInfo.Create;

                result.unitCost := getJSonString(responseJson, 'unitCost');
                result.chargeMethod := getJSonString(responseJson, 'chargeMethod');
                result.rateSystem := getJSonString(responseJson, 'rateSystem');

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;
end;
//End Of Unit.

function THometaxTIService.GetFlatRateState (CorpNum : string ) : THometaxTIFlatRate;
var
        responseJson : String;
begin
        responseJson := httpget('/HomeTax/Taxinvoice/Contract',CorpNum, '');
       
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
                            
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;

function THometaxTIService.GetJobState ( CorpNum : string; jobID : string) : THomeTaxTIJobInfo;
var
        responseJson : string;

begin
        if jobID = '' then
        begin
                raise EPopbillException.Create(-99999999, '작업아이디(jobID)가 입력되지 않았습니다.');
                exit;
        end;


        responseJson := httpget('/HomeTax/Taxinvoice/'+ jobID + '/State', CorpNum, '');

        result := jsonToTHometaxTIJobInfo ( responseJson ) ;
end;


function THometaxTIService.ListActiveState (CorpNum : string) : THomeTaxTIJobInfoList;
var
        responseJson : string;
        jSons : ArrayOfString;
        i : Integer;
begin

        responseJson := httpget('/HomeTax/Taxinvoice/JobList',CorpNum,'');

        if responseJson = '[]' then
        begin
                raise EPopbillException.Create(-99999999, '작업 요청 목록이 존재하지 않습니다.');
                exit;
        end;

        try
                jSons := ParseJsonList(responseJson);
                SetLength(result,Length(jSons));

                for i:= 0 to Length(jSons) -1 do
                begin
                        result[i] := jsonToTHometaxTIJobInfo(jSons[i]);
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,' 결과처리 실패.[Malformed Json]');
        end;
end;


function THometaxTIService.Search (CorpNum:string; jobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : Array Of String; TaxRegIDYN : Boolean; Page: Integer; PerPage : Integer; Order: String) : THomeTaxTISearchList;
var
        responseJson : string;
        uri : String;
        docTypeList : String;
        taxTypeList : String;
        purposeTypeList : String;
        taxRegIDList : String;
        i : integer;
        jSons : ArrayOfString;
begin
        if jobID = '' then
        begin
                raise EPopbillException.Create(-99999999, '작업아이디(jobID)가 입력되지 않았습니다.');
                exit;
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

        for i := 0 to High ( TaxRegID ) do
        begin
                if taxRegID[i] <> '' then
                taxRegIDList := taxRegIDList + TaxRegID[i];

                if i <> High(TaxRegID) then
                taxRegIDList := taxRegIDList + ',';
        end;                                                     

        if Page < 1 then page := 1;
        if PerPage < 1 then PerPage := 500;

        uri := '/HomeTax/Taxinvoice/'+jobID;
        uri := uri + '?Type=' + docTypeList + '&&TaxType=' + taxTypeList;
        uri := uri + '&&PurposeType=' + purposeTypeList + '&&TaxRegIDType='+ TaxRegIDType;
        uri := uri + '&&TaxRegID=' + taxRegIDList;

        if TaxRegIDYN then begin
                uri := uri + '&&TaxRegIDYN=1';
        end else begin
                uri := uri + '&&TaxRegIDYN=0';
        end;

        uri := uri + '&&Page=' + IntToStr(Page) + '&&PerPage='+ IntToStr(PerPage);
        uri := uri + '&&Order=' + order;

        responseJson := httpget(uri, CorpNum, '');
        
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
                        result.list[i].modifyYN := getJsonBoolean (jSons[i], 'modifyYN');

                        result.list[i].invoicerCorpName := getJsonString (jSons[i], 'invoicerCorpName');
                        result.list[i].invoicerCorpNum := getJsonString (jSons[i], 'invoicerCorpNum');
                        result.list[i].invoicerCEOName := getJsonString (jSons[i], 'invoicerCEOName');
                        result.list[i].invoicerEmail := getJsonString (jSons[i], 'invoicerEmail');
                        result.list[i].invoiceeCorpNum := getJsonString (jSons[i], 'invoiceeCorpNum');
                        result.list[i].invoiceeCorpName := getJsonString (jSons[i], 'invoiceeCorpName');
                        result.list[i].invoiceeCEOName := getJsonString (jSons[i], 'invoiceeCEOName');
                        result.list[i].invoiceeEmail1 := getJsonString (jSons[i], 'invoiceeEmail1');
                        result.list[i].supplyCostTotal := getJsonString (jSons[i], 'supplyCostTotal');
                        result.list[i].taxTotal := getJsonString (jSons[i], 'taxTotal');
                        result.list[i].totalAmount := getJsonString (jSons[i], 'totalAmount');
                        result.list[i].purchaseDate := getJsonString (jSons[i], 'purchaseDate');
                        result.list[i].itemName := getJsonString (jSons[i], 'itemName');
                        result.list[i].supplyCost := getJsonString (jSons[i], 'supplyCost');
                        result.list[i].tax := getJsonString (jSons[i], 'tax');

                    
                end;

        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;

end;

function THometaxTIService.RequestJob (CorpNum : string;  MgtKeyType:EnumMgtKeyType; DType: String; SDate: String; EDate: String) : string;
var
        responseJson : string;

begin
        responseJson := httppost('/HomeTax/Taxinvoice/'+GetEnumName(TypeInfo(EnumMgtKeyType),integer(MgtKeyType))+'?DType='+DType+'&&SDate='+SDate+'&&EDate='+EDate, CorpNum, '', '', '');
        result := getJsonString(responseJson, 'jobID');

end;



function THometaxTIService.Summary (CorpNum:string; jobID:string; DocType : Array Of String; TaxType : Array Of String; PurposeType : Array Of String; TaxRegIDType : String; TaxRegID : Array Of String; TaxRegIDYN : Boolean) : TTaxinvoiceSummary;
var
        responseJson : string;
        uri : String;
        docTypeList : String;
        taxTypeList : String;
        purposeTypeList : String;
        taxRegIDList : String;
        i : integer;
begin
        if jobID = '' then
        begin
                raise EPopbillException.Create(-99999999, '작업아이디(jobID)가 입력되지 않았습니다.');
                Exit;
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

        for i := 0 to High ( TaxRegID ) do
        begin
                if taxRegID[i] <> '' then
                taxRegIDList := taxRegIDList + TaxRegID[i];

                if i <> High(TaxRegID) then
                taxRegIDList := taxRegIDList + ',';
        end;                                                     

        uri := '/HomeTax/Taxinvoice/'+jobID+'/Summary';
        uri := uri + '?Type=' + docTypeList + '&&TaxType=' + taxTypeList;
        uri := uri + '&&PurposeType=' + purposeTypeList + '&&TaxRegIDType='+ TaxRegIDType;
        uri := uri + '&&TaxRegID=' + taxRegIDList;

        if TaxRegIDYN then begin
                uri := uri + '&&TaxRegIDYN=1';
        end else begin
                uri := uri + '&&TaxRegIDYN=0';
        end;
       
        responseJson := httpget(uri, CorpNum, '');
        
        result := TTaxinvoiceSummary.Create;

        result.count := GetJSonInteger(responseJson, 'count');
        result.supplyCostTotal := GetJSonInteger(responseJson, 'supplyCostTotal');
        result.taxTotal := GetJSonInteger(responseJson, 'taxTotal');
        result.amountTotal := GetJSonInteger(responseJson, 'amountTotal');
end;


function THometaxTIService.GetTaxinvoice (CorpNum:string; NTSConfirmNum:String) :THomeTaxTaxinvoice;
var
        responseJson : string;
begin
        if NTSConfirmNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '국세청 승인번호가 입력되지 않았습니다.');
                Exit;
        end;

        responseJson := httpget('/HomeTax/Taxinvoice/'+NTSConfirmNum, CorpNum, '');

        result := jsonToTHometaxTaxinvoice(responseJson);
end;

function THometaxTIService.GetXML (CorpNum : String; NTSConfirmNum:String ) : TGetXMLResponse;
var
        responseJson : String;
begin
        if NTSConfirmNum = '' then
        begin
                raise EPopbillException.Create(-99999999, '국세청 승인번호가 입력되지 않았습니다.');
                Exit;
        end;
        
        responseJson := httpget('/HomeTax/Taxinvoice/'+NTSConfirmNum+'?T=xml', CorpNum, '');
       
        try
                result := TGetXMLResponse.Create;
                result.ResultCode := getJSonInteger(responseJson, 'ResultCode');
                result.Message := getJSonString(responseJson, 'Message');
                result.retObject := getJSonString(responseJson, 'retObject');
                            
        except on E:Exception do
                raise EPopbillException.Create(-99999999,'결과처리 실패.[Malformed Json]');
        end;                                                                                             

end;





end.
