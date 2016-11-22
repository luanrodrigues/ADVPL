#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "TOPCONN.CH"

//LÊ ARQUIVO DA BASE DO PROTHEUS E RETORNA NO NAVEGADOR
 
WSRESTFUL pdf DESCRIPTION "Serviço REST - PDF Títulos a Receber"
  
WSMETHOD GET DESCRIPTION "Exemplo de retorno de entidade(s)" WSSYNTAX "/titulo/{pasta}/{arquivo}"
 
END WSRESTFUL
 
WSMETHOD GET WSRECEIVE startIndex, count, tipo WSSERVICE pdf
Local i
Local cFileName := ""
Local cPath		:= ""
Local cFile		:= ""
Local cBuffer	:= ""
Local nTamFile 	:= 0
Local nLast 	:= 0
Local nHdl		:= 0
Local oFile
Local nHandler
Local nSize    	:= 0
Local xBuffer  	:= ''

  If Len(::aURLParms) > 1
  	  
  	  cFileName := ::aURLParms[2] + ".pdf"
  	  cPath		:= "financeiro\workflow\" + ::aURLParms[1] + "\"
  	  
	  cFile := cPath + cFileName
	  conout(cFile)
	  If File( cFile )
	  		nHdl := fOpen( cFile )
	  		nTamFile := fSeek(nHdl,0,2)
	  		fSeek(nHdl,0,0)
	  		cBuffer  := Space(nTamFile)           
	    	fRead(nHdl,@cBuffer,nTamFile)
	    	::SetContentType( 'application/pdf' )
	    	::SetHeader( 'Content-Disposition', 'attachment; filename= ' + cFileName )
	    	::SetHeader( 'Pragma', 'no-cache' )
	  		::SetResponse( cBuffer )
	  Else
	  		::SetResponse('{')
	  		::SetResponse('"Erro":"Arquivo não encontrado"')
	  		::SetResponse('}')
	  EndIf
  Else
  		::SetResponse('{')
  		::SetResponse('"Erro":"Parâmetros Inválidos"')
  		::SetResponse('}')
  EndIf
  
 
Return .T.
