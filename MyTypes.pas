unit MyTypes;

interface

uses
  Windows, Classes;

type
  TvInfo = record
    Kurs            : Double;
    VersionTovars   : String;
  end;

  ClInfo = record
    Name            : string;
    PointMame       : String;
  end;

  exparr = array of string;

  PTreeData = ^TTreeData;
  TTreeData = record
    Name        : String;
    NameNS      : String;
    Code        : String;
    Ost         : String;
    CntInP      : String;
    TecDOC      : String;

    MinR        : Integer;
    BC          : string;

    Disc        : String;
    DiscDbl     : Double;

    OEMNum      : exparr;
    RefNum      : exparr;

    Cost1       : String;
    Cost2       : String;
//    Cost3       : String;
//    Cost4       : String;
//    Cost5       : String;
//    Cost6       : String;
//    Cost7       : String;
//    Cost8       : String;
//    Cost9       : String;
//    Cost10      : String;
//    Cost11      : String;
//    Cost12      : String;
//    Cost13      : String;
//    Cost14      : String;
//    Cost15      : String;

    Cost1Dbl    : Double;
    Cost2Dbl    : Double;

    Cost1DblOr  : Double;
    Cost2DblOr  : Double;
//    Cost3Dbl    : Double;
//    Cost4Dbl    : Double;
//    Cost5Dbl    : Double;
//    Cost6Dbl    : Double;
//    Cost7Dbl    : Double;
//    Cost8Dbl    : Double;
//    Cost9Dbl    : Double;
//    Cost10Dbl   : Double;
//    Cost11Dbl   : Double;
//    Cost12Dbl   : Double;
//    Cost13Dbl   : Double;
//    Cost14Dbl   : Double;
//    Cost15Dbl   : Double;

    ImageIndex  : integer;

    Status      : BOOL;

    DynOfPrices : Byte;

    Root        : bool;
  end;

  PSale = ^TSale;
  TSale = record
    Name    : string;
    Date    : string;
    Sum     : string;
    DateExp : string;
    Doc     : string;

    ImageIndex : integer;

    Root    : bool;
  end;

  TProgrammSettings = record
    ID              : String;
    Pass            : String;
    Name            : String;
    LName           : String;
    CName           : String;
    Tel             : String;
    Address         : String;
    Email           : String;
    ftp             : String;
    Port            : integer;
    PM              : bool;
    Dir             : String;
    SUSSName        : String;
    SUSSPass        : String;
    TvA             : bool;
    ReqA            : bool;
    ArA             : bool;
    SlA             : bool;
    URL             : String;
    Fax             : String;
    FSTR            : string;
  end;

  TVersions = record
    Exe     : string;
  end;

  TFileVersions = record
    SplashFile      : string;
    InfoFile        : string;
    TvFile          : string;
    ArrFile         : string;
    ClientsFile     : string;
    SalesFile       : string;
    TpSalesFile     : string;
    ExeFile         : string;
    Rest            : string;
    SDP             : string;
    Disc            : string;

    SplashFileSize  : integer;
    InfoFileSize    : integer;
    TvFileSize      : integer;
    ArrFileSize     : integer;
    ClientsFileSize : integer;
    SalesFileSize   : integer;
    TpSalesFileSize : integer;
    ExeFileSize     : integer;
    RestFileSize    : integer;
    SDPFileSize     : integer;
    DiscFileSize    : integer;
  end;

  TTypeSal = record
    ID      : Integer;
    Tp      : string;
  end;

  TOtGrIt = record
    Caption : string;
    Items   : Array of TStrings;
  end;

  TOtGr = array of TOtGrIt;

implementation

end.
