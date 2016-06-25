{foreach from=$oHistory item=history}
	<div class="row">
		<div class="col-sm-12">
			{$oUser->getUserName($history.awuser)} {awmultilang ident="MADECHANGES"} {$history.awdate}
		</div>
	</div>
	<div class="row">
		<div class="col-sm-2"><b>{awmultilang ident="FIELD"}</b></div>
		<div class="col-sm-5"><b>{awmultilang ident="ORIGINALVALUE"}</b></div>
		<div class="col-sm-5"><b>{awmultilang ident="NEWVALUE"}</b></div>
	</div>
	<div class="row">
		<div class="col-sm-2">
			{if $history.awfield == 'awworkflowpos'}
				{awmultilang ident="WORKFLOWPOSITION"}
			{elseif $history.awfield == 'awtitle'}
				{awmultilang ident="TITLE"}
			{elseif $history.awfield == 'awdescription'}
				{awmultilang ident="DESCRIPTION"}
			{elseif $history.awfield == 'awestimate'}
				{awmultilang ident="ESTIMATE"}
			{elseif $history.awfield == 'awdeadline'}
				{awmultilang ident="DEADLINE"}
			{elseif $history.awfield == 'awowner'}
				{awmultilang ident="OWNER"}
			{else}
				{awmultilang ident=$history.awfield|upper}
			{/if}
		</div>
		<div class="col-sm-5">
			{if $history.awfield == 'awworkflowpos'}
				{foreach from=$aWorkflowSteps item=workflowitem }
					{if $workflowitem.awid == $history.awpreval}{$workflowitem.awname}{/if}
				{/foreach}
			{elseif $history.awfield == 'awowner'}
				{if $oUser->getUserAvatar($history.awpreval)}
					<img src="media/profile/{$oUser->getUserAvatar($history.awpreval)}" class="img-circle user-image-small" alt="{$oUser->getUserName($history.awpreval)}">
				{/if}
				{$oUser->getUserName($history.awpreval)}
			{else}
				{$history.awpreval}
			{/if}
				
			
		</div>
		<div class="col-sm-5">
			{if $history.awfield == 'awworkflowpos'}
				{foreach from=$aWorkflowSteps item=workflowitem }
					{if $workflowitem.awid == $history.awafterval}{$workflowitem.awname}{/if}
				{/foreach}
			{elseif $history.awfield == 'awowner'}
				{if $oUser->getUserAvatar($history.awafterval)}
					<img src="media/profile/{$oUser->getUserAvatar($history.awafterval)}" class="img-circle user-image-small" alt="{$oUser->getUserName($history.awafterval)}">
				{/if}
				{$oUser->getUserName($history.awafterval)}
			{else}
				{$history.awafterval}
			{/if}
		</div>
		<div class="col-sm-12">
			<hr>
		</div>
	</div>
{/foreach}