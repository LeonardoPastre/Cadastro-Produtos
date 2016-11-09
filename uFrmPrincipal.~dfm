object FrmPrincipal: TFrmPrincipal
  Left = 321
  Top = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro'
  ClientHeight = 315
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 369
    Top = 12
    Width = 103
    Height = 84
    Shape = bsFrame
    Style = bsRaised
  end
  object ImgProdutos: TImage
    Left = 371
    Top = 14
    Width = 100
    Height = 81
    Stretch = True
  end
  object DbgProdutos: TDBGrid
    Left = 3
    Top = 102
    Width = 478
    Height = 192
    DataSource = DtsProdutos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CATEGORIA'
        Width = 120
        Visible = True
      end>
  end
  object BtnIncluir: TBitBtn
    Left = 6
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Incluir'
    TabOrder = 0
    OnClick = BtnIncluirClick
  end
  object BtnAlterar: TBitBtn
    Left = 84
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 1
    OnClick = BtnAlterarClick
  end
  object BtnExcluir: TBitBtn
    Left = 162
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 2
    OnClick = BtnExcluirClick
  end
  object CdsProdutos: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    AfterScroll = CdsProdutosAfterScroll
    Left = 368
    Top = 172
    Data = {
      A30000009619E0BD010000001800000005000000000003000000A30006434F44
      49474F04000100000000000944455343524943414F0100490000000100055749
      4454480200020032000556414C4F5208000400000000000943415445474F5249
      410100490000000100055749445448020002001E0006494D4147454D04004B00
      00000200075355425459504502004900070042696E6172790005574944544802
      000200D0070000}
    object CdsProdutosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object CdsProdutosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object CdsProdutosVALOR: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '0,.00'
      EditFormat = '0,.00'
    end
    object CdsProdutosCATEGORIA: TStringField
      DisplayLabel = 'Categoria'
      FieldName = 'CATEGORIA'
      Size = 30
    end
    object CdsProdutosIMAGEM: TBlobField
      FieldName = 'IMAGEM'
      Size = 2000
    end
  end
  object DtsProdutos: TDataSource
    DataSet = CdsProdutos
    Left = 314
    Top = 172
  end
end
