object dmData: TdmData
  Encoding = esUtf8
  QueuedRequest = False
  Height = 301
  Width = 534
  PixelsPerInch = 96
  object events: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'status'
        EventName = 'status'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWServerEvents1EventsstatusReplyEvent
      end
      item
        Routes = [crPost]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sector'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovTime
            ParamName = 'time'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovDate
            ParamName = 'date'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovTime
            ParamName = 'duration'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'new'
        EventName = 'new'
        OnlyPreDefinedParams = False
        OnReplyEvent = eventsEventsnewReplyEvent
      end
      item
        Routes = [crPost]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'id'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'sector'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'date'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'time'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'duration'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'edit'
        EventName = 'edit'
        OnlyPreDefinedParams = False
        OnReplyEvent = eventsEventseditReplyEvent
      end
      item
        Routes = [crDelete]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'id'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'delete'
        EventName = 'delete'
        OnlyPreDefinedParams = False
        OnReplyEvent = eventsEventsdeleteReplyEvent
      end
      item
        Routes = [crGet]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'node'
        EventName = 'node'
        OnlyPreDefinedParams = False
        OnReplyEvent = eventsEventsnodeReplyEvent
      end>
    Left = 432
    Top = 144
  end
  object fdMainConnection: TFDConnection
    Params.Strings = (
      
        'Database=D:\Progama'#231#227'o\Projects\Delphi\MyGarden\database\mygarde' +
        'n.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    BeforeConnect = fdMainConnectionBeforeConnect
    Left = 448
    Top = 216
  end
  object mainQuery: TFDQuery
    Active = True
    Connection = fdMainConnection
    SQL.Strings = (
      'SELECT * FROM GARDEN')
    Left = 320
    Top = 216
  end
  object queryAux: TFDQuery
    Connection = fdMainConnection
    Left = 248
    Top = 216
  end
end
