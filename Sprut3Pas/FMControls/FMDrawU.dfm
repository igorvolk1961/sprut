inherited FMDraw: TFMDraw
  Left = 178
  Top = 145
  Caption = 'FMDraw'
  ClientHeight = 345
  ClientWidth = 536
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Left = 306
    Height = 320
  end
  inherited ControlBar1: TControlBar
    Width = 536
  end
  inherited PanelInfo: TPanel
    Left = 311
    Height = 320
    inherited PageControl: TPageControl
      Height = 318
      inherited tsLayers: TTabSheet
        inherited sgLayers: TStringGrid
          Height = 235
        end
      end
      inherited tsProperties: TTabSheet
        inherited pn_ParentParam: TPanel
          Height = 97
          inherited lb_Parents: TListBox
            Height = 69
          end
        end
      end
      inherited tsSection: TTabSheet
        inherited edDmax: TEdit
          Width = 76
          Height = 23
        end
        inherited edZmax: TEdit
          Width = 76
          Height = 23
        end
        inherited edDmin: TEdit
          Width = 76
          Height = 23
        end
        inherited edZmin: TEdit
          Width = 76
          Height = 23
        end
      end
      inherited tsHistory: TTabSheet
        inherited lsTransactions: TListBox
          Height = 278
        end
      end
    end
  end
  inherited Panel0: TPanel
    Width = 306
    Height = 320
    inherited Splitter2: TSplitter
      Top = 92
      Width = 304
    end
    inherited PanelVert: TPanel
      Top = 97
      Width = 304
      inherited PanelZ: TPanel
        Left = 289
      end
    end
    inherited PanelHoriz: TPanel
      Width = 304
      Height = 91
      inherited pnDRange: TPanel
        Height = 76
        inherited pnDmin: TPanel
          Top = 26
        end
      end
      inherited PanelX: TPanel
        Top = 77
        Width = 302
        inherited sb_ScrollX: TScrollBar
          Width = 289
        end
        inherited Panel4: TPanel
          Left = 289
        end
      end
      inherited PanelY: TPanel
        Left = 290
        Height = 76
        inherited sb_ScrollY: TScrollBar
          Height = 76
        end
      end
    end
  end
end
