object Dm: TDm
  OldCreateOrder = False
  Left = 310
  Top = 209
  Height = 223
  Width = 248
  object AdoConexao: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 84
    Top = 12
  end
  object QryProdutos: TADOQuery
    Connection = AdoConexao
    Parameters = <>
    Left = 84
    Top = 66
    object QryProdutosCODIGO: TAutoIncField
      FieldName = 'CODIGO'
      ReadOnly = True
    end
    object QryProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object QryProdutosVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object QryProdutosCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Size = 30
    end
    object QryProdutosIMAGEM: TBlobField
      FieldName = 'IMAGEM'
    end
  end
end
