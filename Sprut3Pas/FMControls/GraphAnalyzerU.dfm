inherited GraphAnalyzer: TGraphAnalyzer
  Left = 6
  Top = 277
  Caption = 'GraphAnalyzer'
  ClientHeight = 178
  ClientWidth = 804
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 217
    Top = 0
    Width = 8
    Height = 178
    Cursor = crHSplit
    AutoSnap = False
    MinSize = 50
  end
  object Splitter2: TSplitter
    Left = 609
    Top = 0
    Width = 7
    Height = 178
    Cursor = crHSplit
    AutoSnap = False
    MinSize = 50
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 178
    Align = alLeft
    TabOrder = 0
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 215
      Height = 88
      Align = alTop
      TabOrder = 0
      DesignSize = (
        215
        88)
      object lInV: TLabel
        Left = 200
        Top = 40
        Width = 6
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0'
      end
      object lRecalcInV: TLabel
        Left = 201
        Top = 59
        Width = 6
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0'
      end
      object btNext: TButton
        Left = 181
        Top = 7
        Width = 27
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '->'
        TabOrder = 0
        OnClick = btNextClick
      end
    end
    object lbInArcs: TListBox
      Left = 1
      Top = 89
      Width = 215
      Height = 88
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      OnClick = lbExtArcsClick
      OnDrawItem = lbInArcsDrawItem
    end
  end
  object Panel2: TPanel
    Left = 225
    Top = 0
    Width = 384
    Height = 178
    Align = alLeft
    TabOrder = 1
    object Splitter3: TSplitter
      Left = 1
      Top = 130
      Width = 382
      Height = 8
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 382
      Height = 88
      Align = alTop
      TabOrder = 0
      DesignSize = (
        382
        88)
      object lElement: TLabel
        Left = 1
        Top = 1
        Width = 152
        Height = 86
        Align = alLeft
        AutoSize = False
        Caption = #1069#1083#1077#1084#1077#1085#1090
        WordWrap = True
      end
      object lRecalcV: TLabel
        Left = 363
        Top = 59
        Width = 6
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0'
      end
      object lPathGraph: TLabel
        Left = 4
        Top = 16
        Width = 26
        Height = 13
        Caption = #1043#1088#1072#1092
      end
      object rgGraphType: TRadioGroup
        Left = 184
        Top = 0
        Width = 193
        Height = 57
        ItemIndex = 0
        Items.Strings = (
          #1042#1088#1077#1084#1103' '#1079#1072#1076#1077#1088#1078#1082#1080
          #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1086#1073#1085#1072#1088#1091#1078#1077#1085#1080#1103
          #1042#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1091#1089#1087#1077#1093#1072)
        TabOrder = 0
        OnClick = rgGraphTypeClick
      end
    end
    object lbArcs: TListBox
      Tag = 3
      Left = 1
      Top = 89
      Width = 382
      Height = 41
      Align = alTop
      ItemHeight = 13
      TabOrder = 1
      OnClick = lbArcsClick
    end
    object lbHistory: TListBox
      Tag = 2
      Left = 1
      Top = 138
      Width = 382
      Height = 39
      Align = alClient
      ItemHeight = 13
      TabOrder = 2
      OnClick = lbHistoryClick
    end
  end
  object Panel3: TPanel
    Left = 616
    Top = 0
    Width = 188
    Height = 178
    Align = alClient
    TabOrder = 2
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 186
      Height = 88
      Align = alTop
      TabOrder = 0
      object lOutV: TLabel
        Left = 8
        Top = 40
        Width = 6
        Height = 13
        Caption = '0'
      end
      object lRecalcOutV: TLabel
        Left = 153
        Top = 58
        Width = 6
        Height = 13
        Alignment = taRightJustify
        Caption = '0'
      end
      object btPrev: TButton
        Left = 7
        Top = 8
        Width = 27
        Height = 25
        Caption = '<-'
        TabOrder = 0
        OnClick = btPrevClick
      end
    end
    object lbOutArcs: TListBox
      Tag = 1
      Left = 1
      Top = 89
      Width = 186
      Height = 88
      Style = lbOwnerDrawFixed
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      OnClick = lbExtArcsClick
      OnDrawItem = lbInArcsDrawItem
    end
  end
end
