unit SpecialExits;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LevelDesign;

type
  TSpecialExitBase = class abstract(TInterfacedObject, ISpecialExit)
    protected
       _exitPosition : Direction;
       _isPassed : boolean;
    public
       constructor Create(exitPosition : Direction); overload;
       function GetExitPosition() : Direction; virtual;
       procedure SetExitPassed(); virtual;
       function GetExitPassed() : boolean; virtual;
  end;

type
  TPortalExit = class(TSpecialExitBase)
    private
      _targetRoom : TPoint;
    public
      constructor Create(exitPosition : Direction; targetRoom : TPoint); overload;
      property TargetRoomLocation: TPoint read _targetRoom;
  end;

type
  TLockedExit = class(TSpecialExitBase)
    private
      _objectiveId : string;
    public
      constructor Create(exitPosition : Direction; objectiveId : string); overload;
      property ObjectiveId: string read _objectiveId;
  end;

type
  TLockPickExit = class(TSpecialExitBase)
    private
       _bolts, _tries : integer;
    public
       procedure Create(exitPosition : Direction; boltsVal, triesVal : integer); overload;
       property Bolts: integer read _bolts write _bolts;
       property Tries: integer read _tries write _tries;
  end;

type
  TLevelCompletedExit = class(TSpecialExitBase)
  end;

type
  TNoExit = class(TSpecialExitBase)
  end;
implementation

//SpecialExitBase
constructor TSpecialExitBase.Create(exitPosition : Direction);
begin
    _exitPosition := exitPosition;
end;

function TSpecialExitBase.GetExitPosition() : Direction;
begin
   exit(_exitPosition);
end;

procedure TSpecialExitBase.SetExitPassed();
begin
   _isPassed := true;
end;

function TSpecialExitBase.GetExitPassed() : boolean;
begin
   exit(_isPassed);
end;

//Portal
constructor TPortalExit.Create(exitPosition : Direction; targetRoom : TPoint);
begin
    inherited Create(exitPosition);

    _targetRoom := targetRoom;
end;

//Locked
constructor TLockedExit.Create(exitPosition : Direction; objectiveId : string);
begin
    inherited Create(exitPosition);
    _objectiveId := objectiveId;
end;

//LockPick
procedure TLockPickExit.Create(exitPosition : Direction; boltsVal, triesVal : integer);
begin
    inherited Create(exitPosition);
   _bolts := boltsVal;
   _tries := triesVal;
end;

end.

