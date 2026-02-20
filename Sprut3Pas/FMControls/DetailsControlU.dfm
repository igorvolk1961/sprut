inherited DetailsControl: TDetailsControl
  Left = 0
  Top = 126
  Caption = 'DetailsControl'
  ClientHeight = 421
  ClientWidth = 760
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 421
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 73
      Width = 758
      Height = 347
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      TabHeight = 1
      TabIndex = 0
      TabOrder = 0
      TabPosition = tpRight
      TabWidth = 1
      object TabSheet1: TTabSheet
        object Splitter1: TSplitter
          Left = 0
          Top = 227
          Width = 749
          Height = 7
          Cursor = crVSplit
          Align = alBottom
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 749
          Height = 24
          Align = alTop
          TabOrder = 0
          object chbTable: TComboBox
            Left = 0
            Top = 2
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = #1057#1087#1086#1089#1086#1073' '#1087#1088#1077#1086#1076#1086#1083#1077#1085#1080#1103
            OnChange = chbChange
            Items.Strings = (
              #1057#1087#1086#1089#1086#1073' '#1087#1088#1077#1086#1076#1086#1083#1077#1085#1080#1103
              #1058#1072#1082#1090#1080#1082#1072' '#1087#1088#1077#1086#1076#1086#1083#1077#1085#1080#1103
              #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1057#1060#1047
              #1043#1088#1091#1087#1087#1072)
          end
        end
        object sgData: TStringGrid
          Left = 0
          Top = 41
          Width = 749
          Height = 186
          Align = alClient
          ColCount = 9
          DefaultColWidth = 145
          FixedRows = 0
          TabOrder = 1
          OnExit = sgDataExit
          OnSelectCell = sgDataSelectCell
          OnTopLeftChanged = sgDataTopLeftChanged
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object Header: THeaderControl
          Left = 0
          Top = 24
          Width = 749
          Height = 17
          DragReorder = False
          Sections = <
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end
            item
              ImageIndex = -1
              Width = 50
            end>
          OnSectionResize = HeaderSectionResize
          ShowHint = True
          ParentShowHint = False
          OnMouseMove = HeaderMouseMove
        end
        object mComment: TMemo
          Left = 0
          Top = 234
          Width = 749
          Height = 105
          Align = alBottom
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 3
          Visible = False
        end
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 758
      Height = 72
      Align = alTop
      TabOrder = 1
      object lName: TLabel
        Left = 8
        Top = 6
        Width = 30
        Height = 13
        Caption = 'lName'
      end
      object lFacilityState: TLabel
        Left = 358
        Top = 32
        Width = 82
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1057#1060#1047
      end
      object lWarriorGroup: TLabel
        Left = 535
        Top = 32
        Width = 126
        Height = 13
        Caption = #1043#1088#1091#1087#1087#1072' / '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      end
      object Label4: TLabel
        Left = 711
        Top = 32
        Width = 57
        Height = 13
        Caption = #1069#1090#1072#1087' '#1072#1082#1094#1080#1080
      end
      object lTactic: TLabel
        Left = 181
        Top = 32
        Width = 117
        Height = 13
        Caption = #1058#1072#1082#1090#1080#1082#1072' '#1087#1088#1077#1086#1076#1086#1086#1083#1077#1085#1080#1103
      end
      object Label2: TLabel
        Left = 6
        Top = 32
        Width = 87
        Height = 13
        Caption = #1042#1072#1088#1080#1072#1085#1090' '#1072#1085#1072#1083#1080#1079#1072
      end
      object chbFacilityState: TComboBox
        Left = 357
        Top = 45
        Width = 174
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = chbFacilityStateChange
      end
      object chbWarriorGroup: TComboBox
        Left = 533
        Top = 45
        Width = 174
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = chbWarriorGroupChange
      end
      object chbWarriorPathStage: TComboBox
        Left = 709
        Top = 44
        Width = 108
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = #1050' '#1094#1077#1083#1080' '#1089#1082#1088#1099#1090#1085#1086
        OnChange = chbWarriorPathStageChange
        Items.Strings = (
          #1050' '#1094#1077#1083#1080' '#1089#1082#1088#1099#1090#1085#1086
          #1050' '#1094#1077#1083#1080' '#1073#1099#1089#1090#1088#1086
          #1054#1090' '#1094#1077#1083#1080' '#1089#1082#1088#1099#1090#1085#1086
          #1054#1090' '#1094#1077#1083#1080' '#1073#1099#1089#1090#1088#1086)
      end
      object chbTactic: TComboBox
        Left = 180
        Top = 45
        Width = 174
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = chbChange
      end
      object pAreas: TPanel
        Left = 245
        Top = 1
        Width = 553
        Height = 27
        BevelOuter = bvNone
        TabOrder = 4
        Visible = False
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 70
          Height = 13
          Caption = #1084#1077#1078#1076#1091' '#1090#1086#1095#1082#1086#1081
        end
        object lPoint: TLabel
          Left = 294
          Top = 7
          Width = 43
          Height = 13
          Caption = #1080' '#1090#1086#1095#1082#1086#1081
        end
        object cbFrom: TComboBox
          Left = 96
          Top = 3
          Width = 194
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbFromToChange
        end
        object cbTo: TComboBox
          Left = 354
          Top = 2
          Width = 194
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = cbFromToChange
        end
      end
      object chbAnalysisVariant: TComboBox
        Left = 4
        Top = 45
        Width = 174
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = chbAnalysisVariantChange
      end
    end
  end
end
