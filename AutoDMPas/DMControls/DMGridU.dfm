inherited DMGrid: TDMGrid
  Left = 55
  Top = 174
  Caption = 'CustomDMGrid'
  ClientHeight = 351
  ClientWidth = 804
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter0: TSplitter
    Left = 0
    Top = 0
    Width = 5
    Height = 351
    Cursor = crHSplit
    AutoSnap = False
    Color = clGray
    ParentColor = False
  end
  object TabControl1: TTabControl
    Left = 5
    Top = 0
    Width = 799
    Height = 351
    Align = alClient
    TabOrder = 0
    OnChange = TabControl1Change
    object PanelDetails: TPanel
      Left = 4
      Top = 6
      Width = 791
      Height = 341
      Align = alClient
      Color = clWindow
      TabOrder = 0
      object pTable: TPanel
        Left = 1
        Top = 1
        Width = 789
        Height = 339
        Align = alClient
        Color = clWindow
        TabOrder = 0
        DesignSize = (
          789
          339)
        object Header: THeaderControl
          Left = 1
          Top = 1
          Width = 787
          Height = 17
          DragReorder = False
          Sections = <
            item
              ImageIndex = -1
              Text = 'N'
              Width = 50
            end
            item
              AutoSize = True
              ImageIndex = -1
              Text = #1055#1072#1088#1072#1084#1077#1090#1088
              Width = 612
            end
            item
              ImageIndex = -1
              Text = #1047#1085#1072#1095#1077#1085#1080#1077
              Width = 125
            end>
          OnSectionClick = HeaderSectionClick
          OnSectionResize = HeaderSectionResize
          OnMouseMove = HeaderMouseMove
          OnResize = HeaderResize
        end
        object sgDetails: TStringGrid
          Left = 1
          Top = 18
          Width = 787
          Height = 320
          Align = alClient
          BorderStyle = bsNone
          ColCount = 3
          DefaultColWidth = 200
          DefaultRowHeight = 25
          FixedCols = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
          TabOrder = 1
          OnDblClick = sgDetailsDblClick
          OnDrawCell = sgDetailsDrawCell
          OnEnter = sgDetailsEnter
          OnKeyDown = sgDetailsKeyDown
          OnMouseMove = sgDetailsMouseMove
          OnSelectCell = sgDetailsSelectCell
          OnSetEditText = sgDetailsSetEditText
          OnTopLeftChanged = sgDetailsTopLeftChanged
          RowHeights = (
            23
            26
            25
            25
            25)
        end
        object cbCategories: TComboBox
          Left = 10
          Top = 62
          Width = 144
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          Visible = False
          OnChange = cbCategoriesChange
          OnEnter = cbCategoriesEnter
          OnExit = cbCategoriesExit
        end
        object cbParameter: TComboBox
          Left = 413
          Top = 20
          Width = 205
          Height = 21
          Style = csDropDownList
          Anchors = [akTop, akRight]
          ItemHeight = 13
          TabOrder = 3
          Visible = False
          OnChange = cbParameterChange
          OnEnter = cbParameterEnter
          OnKeyPress = ParameterKeyPress
        end
      end
    end
  end
end
