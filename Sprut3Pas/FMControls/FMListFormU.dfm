inherited FMListForm: TFMListForm
  Left = -18
  Top = 126
  Caption = 'FMListForm'
  ClientHeight = 606
  ClientWidth = 1284
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited pn_Client: TPanel
    Width = 1284
    Height = 606
    inherited Splitter1: TSplitter
      Height = 604
    end
    inherited Panel1: TPanel
      Height = 604
      inherited lbox_BackRefHolders: TListBox
        Height = 579
      end
    end
    inherited Panel3: TPanel
      Width = 963
      Height = 604
      inherited lbox_BackRef: TListBox
        Width = 961
        Height = 576
      end
      inherited Panel4: TPanel
        Width = 961
        object chbSelectParents: TCheckBox [3]
          Left = 592
          Top = 1
          Width = 197
          Height = 17
          Caption = #1042#1099#1076#1077#1083#1103#1090#1100' '#1088#1086#1076#1080#1090#1077#1083#1100#1089#1082#1080#1077' '#1086#1073#1098#1077#1082#1090#1099
          TabOrder = 3
        end
        inherited Button1: TButton
          TabOrder = 4
        end
      end
    end
  end
end
