<?php

function smarty_function_awmultilang( $params, &$smarty ) {
	global $oLang;
    $sIdent  = isset( $params['ident'] ) ? $params['ident'] : 'IDENT MISSING';

    $sTranslation = $oLang->translateString( $sIdent );

    return $sTranslation;
}
