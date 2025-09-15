(*
  **************************************************************************************************
  Project Delphi-OpenCV
  **************************************************************************************************
  Contributor:
  Laentir Valetov
  email:laex@bk.ru
  Mikhail Grigorev
  email:sleuthhound@gmail.com
  **************************************************************************************************
  You may retrieve the latest version of this file at the GitHub,
  located at git://github.com/Laex/Delphi-OpenCV.git
  **************************************************************************************************
  License:
  The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License");
  you may not use this file except in compliance with the License. You may obtain a copy of the
  License at http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF
  ANY KIND, either express or implied. See the License for the specific language governing rights
  and limitations under the License.

  Alternatively, the contents of this file may be used under the terms of the
  GNU Lesser General Public License (the  "LGPL License"), in which case the
  provisions of the LGPL License are applicable instead of those above.
  If you wish to allow use of your version of this file only under the terms
  of the LGPL License and not to allow others to use your version of this file
  under the MPL, indicate your decision by deleting  the provisions above and
  replace  them with the notice and other provisions required by the LGPL
  License.  If you do not delete the provisions above, a recipient may use
  your version of this file under either the MPL or the LGPL License.

  For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html
  **************************************************************************************************
  Warning: Using Delphi XE2 syntax!
  **************************************************************************************************
  The Initial Developer of the Original Code:
  OpenCV: open source computer vision library
  Homepage:    http://ocv.org
  Online docs: http://docs.ocv.org
  Q&A forum:   http://answers.ocv.org
  Dev zone:    http://code.ocv.org
  **************************************************************************************************
*)

{$I OpenCV.inc}
{$DEFINE USE_LOCK}
{ --- }
{$IFDEF USE_LOCK}
{ --- }{ .$DEFINE USE_CRITICALSECTION }
{ --- }{$DEFINE USE_SIMLOCK}
{ --- }{ .$DEFINE USE_MONITORLOCK }
{$ENDIF}
unit ocv.lock;

interface

{$IFDEF UNIX}
{$IF DEFINED(USE_CRITICALSECTION) OR DEFINED(USE_SIMLOCK)
uses
  SyncObjs
{$ENDIF}
{$ELSE}
uses
  Windows
{$IF DEFINED(USE_CRITICALSECTION) OR DEFINED(USE_SIMLOCK)}
    , SyncObjs
{$IFEND}
    ;
{$ENDIF}

Type

{$IFDEF USE_SIMLOCK}
  TSRWLock = class
  private
    FLock: Pointer;
  public
    constructor Create;
    procedure AcquireShared;
    procedure ReleaseShared;
    procedure AcquireExclusive;
    procedure ReleaseExclusive;
    function TryAcquireExclusive: Boolean;
    function TryAcquireShared: Boolean;
  end;
{$ENDIF}

  pOCVLock = ^TOCVLock;

  TOCVLock = class
  private
{$IFDEF USE_LOCK}
    FLock:
{$IFDEF USE_CRITICALSECTION}TCriticalSection{$ENDIF}
{$IFDEF USE_MONITORLOCK} TObject{$ENDIF}
{$IFDEF USE_SIMLOCK}TSRWLock{$ENDIF};
{$ENDIF}
{$IFDEF USE_LOCK}
{$IFDEF USE_SIMLOCK}
    FisLockRead: Boolean; {$ENDIF}
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure lock;
    procedure LockRead;
    procedure LockWrite;
    procedure UnLock;
    procedure Enter; inline;
    procedure Leave; inline;
  end;

// light-weight SRW is supported on Vista and above
// we detect by feature rather than OS Version
type
  SRWLOCK = Pointer;

  TTryAcquireSRWLockExclusive = function(Var P: SRWLOCK): Boolean stdcall;
  TTryAcquireSRWLockShared = function(Var P: SRWLOCK): Boolean stdcall;
  TAcquireSRWLockExclusive = procedure(var P: SRWLOCK) stdcall;
  TAcquireSRWLockShared = procedure(var P: SRWLOCK) stdcall;
  TInitializeSRWLock = procedure(var P: SRWLOCK) stdcall;
  TReleaseSRWLockExclusive = procedure(var P: SRWLOCK) stdcall;
  TReleaseSRWLockShared = procedure(var P: SRWLOCK) stdcall;

var
  TryAcquireSRWLockExclusive: TTryAcquireSRWLockExclusive;
  TryAcquireSRWLockShared: TTryAcquireSRWLockShared;
  AcquireSRWLockExclusive: TAcquireSRWLockExclusive;
  AcquireSRWLockShared: TAcquireSRWLockShared;
  InitializeSRWLock: TInitializeSRWLock;
  ReleaseSRWLockExclusive: TReleaseSRWLockExclusive;
  ReleaseSRWLockShared: TReleaseSRWLockShared;

function GetProcAddress(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const ProcName: string; const RaiseError: Boolean): Pointer;
procedure Initialize(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const RaiseError: Boolean);

const
  Kernel32LibName = 'kernel32.dll';
var
  Kernel32LibHandle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND};

implementation

uses
  {$IFDEF FPC}
  {$IFDEF UNIX}dynlibs, {$ENDIF}SysUtils, VersionUtils;
  {$ELSE}
  System.SysUtils, VersionUtils;
  {$ENDIF}

function GetProcAddress(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const ProcName: string; const RaiseError: Boolean): Pointer;
var
  S: string;
  Version: TVersion;
begin
  Result := {$IF Defined(FPC) AND Defined(UNIX)}dynlibs{$ELSE}{$IF NOT Defined(FPC)}Winapi.{$ENDIF}Windows{$ENDIF}.GetProcAddress(Handle, PChar(ProcName));
  if not Assigned(Result) and RaiseError then
  begin
    {$IF Defined(FPC) AND Defined(UNIX))}
    S := GetModuleFileName(Pointer(Handle));
    {$ELSE}
    SetLength(S, MAX_PATH + 1);
    SetLength(S, GetModuleFileName(Handle, PChar(S), MAX_PATH + 1));
    {$ENDIF}
    Version := GetFileVersion(S);
    raise Exception.CreateFmt('Error while loading %d.%d function: %s', [Version.H, Version.L, ProcName]);
  end;
end;

procedure Initialize(const Handle: {$IFDEF FPC}TLibHandle{$ELSE}THandle{$IFEND}; const RaiseError: Boolean);
begin
  TryAcquireSRWLockExclusive := GetProcAddress(Handle, 'TryAcquireSRWLockExclusive', RaiseError);
  TryAcquireSRWLockShared := GetProcAddress(Handle, 'TryAcquireSRWLockShared', RaiseError);
  AcquireSRWLockExclusive := GetProcAddress(Handle, 'AcquireSRWLockExclusive', RaiseError);
  AcquireSRWLockShared := GetProcAddress(Handle, 'AcquireSRWLockShared', RaiseError);
  InitializeSRWLock := GetProcAddress(Handle, 'InitializeSRWLock', RaiseError);
  ReleaseSRWLockExclusive := GetProcAddress(Handle, 'ReleaseSRWLockExclusive', RaiseError);
  ReleaseSRWLockShared := GetProcAddress(Handle, 'ReleaseSRWLockShared', RaiseError);
end;

{$IFDEF USE_SIMLOCK}
{$WARNINGS OFF}
(* procedure AcquireSRWLockShared(var P: SRWLOCK); stdcall; external 'kernel32.dll' name 'AcquireSRWLockShared'{$IFNDEF FPC} delayed{$ENDIF}; *)
(* procedure ReleaseSRWLockShared(var P: SRWLOCK); stdcall; external 'kernel32.dll' name 'ReleaseSRWLockShared' {$IFNDEF FPC} delayed{$ENDIF}; *)
(* procedure AcquireSRWLockExclusive(var P: SRWLOCK); stdcall; external 'kernel32.dll' name 'AcquireSRWLockExclusive' {$IFNDEF FPC} delayed{$ENDIF}; *)
(* procedure ReleaseSRWLockExclusive(var P: SRWLOCK); stdcall; external 'kernel32.dll' name 'ReleaseSRWLockExclusive' {$IFNDEF FPC} delayed{$ENDIF}; *)
(* procedure InitializeSRWLock(var P: SRWLOCK); stdcall; external 'kernel32.dll' name 'InitializeSRWLock' {$IFNDEF FPC} delayed{$ENDIF}; *)
(* function TryAcquireSRWLockExclusive(Var P: SRWLOCK): Boolean; stdcall; external 'kernel32.dll' name 'TryAcquireSRWLockExclusive' {$IFNDEF FPC} delayed{$ENDIF}; *)
(* function TryAcquireSRWLockShared(Var P: SRWLOCK): Boolean; stdcall; external 'kernel32.dll' name 'TryAcquireSRWLockShared' {$IFNDEF FPC} delayed{$ENDIF}; *)
{$WARNINGS ON}

{ TSRWLock }

function TSRWLock.TryAcquireShared: Boolean;
begin
  Result := TryAcquireSRWLockShared(FLock);
end;

function TSRWLock.TryAcquireExclusive: Boolean;
begin
  Result := TryAcquireSRWLockExclusive(FLock);
end;

procedure TSRWLock.AcquireShared;
begin
  AcquireSRWLockShared(FLock);
end;

constructor TSRWLock.Create;
begin
  InitializeSRWLock(FLock);
end;

procedure TSRWLock.ReleaseShared;
begin
  ReleaseSRWLockShared(FLock);
end;

procedure TSRWLock.AcquireExclusive;
begin
  AcquireSRWLockExclusive(FLock);
end;

procedure TSRWLock.ReleaseExclusive;
begin
  ReleaseSRWLockExclusive(FLock);
end;
{$ENDIF}

{ TLock }

constructor TOCVLock.Create;
begin
{$IFDEF USE_LOCK}
  FLock :=
{$IFDEF USE_CRITICALSECTION}TCriticalSection{$ENDIF}
{$IFDEF USE_MONITORLOCK}TObject{$ENDIF}
{$IFDEF USE_SIMLOCK}TSRWLock{$ENDIF}.Create;
{$ENDIF}
end;

destructor TOCVLock.Destroy;
begin
{$IFDEF USE_LOCK}
  FLock.Free;
{$ENDIF}
  inherited;
end;

procedure TOCVLock.Enter;
begin
  lock;
end;

procedure TOCVLock.Leave;
begin
  UnLock;
end;

procedure TOCVLock.lock;
begin
  LockWrite;
end;

procedure TOCVLock.LockRead;
begin
{$IFDEF USE_LOCK}
{$IFDEF USE_CRITICALSECTION}
  FLock.Enter;
{$ENDIF}
{$IFDEF USE_SIMLOCK}
  FLock.AcquireShared;
  FisLockRead := False;
{$ENDIF}
{$IFDEF USE_MONITORLOCK}
  TMonitor.Enter(FLock);
{$ENDIF}
{$ENDIF}
end;

procedure TOCVLock.LockWrite;
begin
{$IFDEF USE_LOCK}
{$IFDEF USE_CRITICALSECTION}
  FLock.Enter;
{$ENDIF}
{$IFDEF USE_SIMLOCK}
  FLock.AcquireExclusive;
  FisLockRead := False;
{$ENDIF}
{$IFDEF USE_MONITORLOCK}
  TMonitor.Enter(FLock);
{$ENDIF}
{$ENDIF}
end;

procedure TOCVLock.UnLock;
begin
{$IFDEF USE_LOCK}
{$IFDEF USE_CRITICALSECTION}
  FLock.Leave;
{$ENDIF}
{$IFDEF USE_SIMLOCK}
  if FisLockRead then
    FLock.ReleaseShared
  else
    FLock.ReleaseExclusive;
{$ENDIF}
{$IFDEF USE_MONITORLOCK}
  TMonitor.Exit(FLock);
{$ENDIF}
{$ENDIF}
end;

var
  Path: string;
initialization
  {$IFDEF USE_SIMLOCK}
  Path := GetCurrentDir;
  {$IFDEF UNIX}
  SetCurrentDir(ExtractFilePath(ParamStr(0)));
  {$ELSE}
  SetCurrentDir(ExtractFilePath(ParamStr(0)) + Kernel32LibName);
  {$ENDIF}
  Kernel32LibHandle := LoadLibrary(Kernel32LibName);
  SetCurrentDir(Path);
  if Kernel32LibHandle <> 0 then Initialize(Kernel32LibHandle, False);
  {$ENDIF}

finalization
  {$IFDEF USE_SIMLOCK}
  if Kernel32LibHandle <> 0 then
     FreeLibrary(Kernel32LibHandle);
  {$ENDIF}

end.
