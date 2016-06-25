<ol class="breadcrumb">

	{if array_key_exists('base', $aBreadCrumb)}<li><a href="#"><i class="fa fa-dashboard"></i>{awmultilang ident=$aBreadCrumb.base|upper} 1</a></li>{/if}
	{if array_key_exists('project', $aBreadCrumb)}<li><a href="#"><i class="fa fa-dashboard"></i>{$aBreadCrumb.project}</a></li>{/if}
	{if array_key_exists('task', $aBreadCrumb)}<li><a href="#"><i class="fa fa-dashboard"></i>{$aBreadCrumb.task}</a></li>{/if}
	{if array_key_exists('fnc', $aBreadCrumb)}<li><a href="#"><i class="fa fa-dashboard"></i> {awmultilang ident=$aBreadCrumb.fnc|upper}</a></li>{/if}
	
</ol>
